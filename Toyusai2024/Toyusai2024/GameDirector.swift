//
//  Apps.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/16.
//

import UIKit
import Alamofire

protocol GameDirectorDelegate: AnyObject
{
	func gameDirectorDidChangeNextScript(gameDirector:GameDirector, script:String)
	func gameDirectorDidUpdate(gameDirector:GameDirector)
}

class GameDirector: NSObject, GameSceneDelegate
{
	static let shared = GameDirector()
	
	var delegate:GameDirectorDelegate?
	
	
	
	// 残り時間
	var remainGameTime = 900
	var gameTimer:Timer?

	// 現在のシーンクラス
	var currentScene:BaseScene?
	// ギミッククリアフラグ
	let gimmickFlags = [false, false, false, false]
	
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
		self.currentScene?.delegate = self
		self.currentScene?.start()
	}
	
	/* ----------------------------------------------------
	 * ゲームループ
	-----------------------------------------------------*/
	@objc func updateGameStatus(timer:Timer)
	{
		self.remainGameTime -= 1
				
		// サーバのフラグを確認する
		self.updateServerFlag()
		
		self.currentScene?.update()
		self.delegate?.gameDirectorDidUpdate(gameDirector: self)

		// 時間切れ
		if (self.remainGameTime <= 0)
		{
			self.gameTimer?.invalidate()
		}
	}
	
	func sendFlagToServer()
	{
		
	}
	
	func updateServerFlag()
	{
		
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
		self.currentScene?.stop()
		self.currentScene?.delegate = nil
		
		self.currentScene = scene
		self.currentScene?.delegate = self
		self.currentScene?.start()
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
