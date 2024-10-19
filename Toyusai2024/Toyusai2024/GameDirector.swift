//
//  Apps.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/16.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol GameDirectorDelegate: AnyObject
{
	func gameDirectorDidChangeNextScript(gameDirector:GameDirector, script:String)
	func gameDirectorDidUpdate(gameDirector:GameDirector)
}

class GameDirector: NSObject, GameSceneDelegate
{
	static let shared = GameDirector()
	
	var delegate:GameDirectorDelegate?
	
	let ip = "192.168.0.115"
//	let ip = "10.0.1.75"
	var url:String!
	
	// 残り時間
	var remainGameTime = 900
	var gameTimer:Timer?

	var currentViewController:UIViewController?
	
	// 現在のシーンクラス
	var currentScene:BaseScene?
	// ギミッククリアフラグ
	var gimmickFlags = [false, false, false, false]
	
	override init()
	{
		super.init()
		
		self.url = "http://\(self.ip):8888/WORKS/NBU/toyusai2024_dev/server"
	}
	
	/* ----------------------------------------------------
	 * ゲームを開始する
	-----------------------------------------------------*/
	func startGame()
	{
		self.remainGameTime = 900
		self.gameTimer = Timer.scheduledTimer(timeInterval: 1.0,
											  target: self,
											  selector: #selector(GameDirector.updateGameStatus(timer:)),
											  userInfo: nil,
											  repeats: true)
		
		self.currentScene = FirstScene()
//		self.currentScene = ClearMemberCardScene()
		self.currentScene?.delegate = self
		self.currentScene?.start(viewController: self.currentViewController)
	}
	
	/* ----------------------------------------------------
	 * ゲームループ
	-----------------------------------------------------*/
	@objc func updateGameStatus(timer:Timer)
	{
		self.remainGameTime -= 1
				
		// サーバのフラグを確認する
		self.updateServerFlag()
		
		self.currentScene?.update(viewController: self.currentViewController)
		self.delegate?.gameDirectorDidUpdate(gameDirector: self)

		// 時間切れ
		if (self.remainGameTime <= 0)
		{
			self.gameTimer?.invalidate()
		}
	}
	
	func sendFlagToServer(flagIndex:Int)
	{
		if let url = self.url
		{
			AF.request("\(url)/flag",
					   method: .post,
					   parameters: ["flag_id": flagIndex],
					   encoding: URLEncoding.default,
					   headers: nil
			)
				.responseJSON { res in
			}
		}
	}
	
	func updateServerFlag()
	{
		if let url = self.url
		{
			AF.request("\(url)/flag",
					   method: .get,
					   parameters: nil,
					   encoding: URLEncoding.default,
					   headers: nil
			)
				.responseJSON { res in
				
					print(res.data)
					
					if let data = res.data
					{
						let json = JSON(data)
						
						print(json)
						
						for i in stride(from: 0, to: self.gimmickFlags.count, by: 1)
						{
							self.gimmickFlags[i] = json[i].boolValue
						}
					}

			}
		}
	}
	
	/* ----------------------------------------------------
	 * ゲーム中かどうか
	-----------------------------------------------------*/
	func isGameStarting() -> Bool
	{
		return self.gameTimer != nil ? true : false
	}
	
	/* ----------------------------------------------------
	 * シーンの切り替え
	 ----------------------------------------------------*/
	func changeScene(scene:BaseScene)
	{
		self.currentScene?.stop(viewController: self.currentViewController)
		self.currentScene?.delegate = nil
		
		self.currentScene = scene
		self.currentScene?.delegate = self
		self.currentScene?.start(viewController: self.currentViewController)
	}
	
	/* ----------------------------------------------------
	 * シーンの開始時に呼び出される
	 ----------------------------------------------------*/
	func gameSceneDidStart(scene: BaseScene)
	{
		var timeInterval:TimeInterval = 1.0
		
		for txt in scene.scenario
		{
			Timer.scheduledTimer(withTimeInterval: timeInterval,
								 repeats: false) { [weak self] timer in
				
				guard let wself = self else { return }
				
				wself.delegate?.gameDirectorDidChangeNextScript(gameDirector: wself, script: txt)
			}
			
			timeInterval += 2.0
		}
	}
	
	/* ----------------------------------------------------
	 * ギミック番号を取得する
	 ----------------------------------------------------*/
	func getGimmickIndex() -> Int
	{
		var gimmickIdx = 0
		for i in stride(from: 0, to: self.gimmickFlags.count, by: 1)
		{
			if (!self.gimmickFlags[i])
			{
				break
			}
			gimmickIdx = i
		}
		
		return gimmickIdx
	}
	
}
