//
//  ClearGlassScene.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/19.
//

import UIKit
import OSCKit

class ClearGlassScene: BaseScene
{
	override init()
	{
		super.init()
		
		self.scenario = [
			"感動したって言ってもらえる展示会を開くのが夢だったのに…",
			"もう、間に合わないのかな",
			"iPadをポスターに重ねたら、勝手にデザインが完成したら良いのに…"
		]
	}
	
	override func start(viewController: UIViewController?)
	{
		super.start(viewController: viewController)
		
		// デバッグ用
		Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { timer in
			GameDirector.shared.gimmickFlags[3] = true
		}
	}
	
	override func update(viewController: UIViewController?)
	{
		let director = GameDirector.shared
		
		// オクトランスクリアフラグを確認する
		if (director.gimmickFlags[3])
		{
			let client = OSCUdpClient(host: "192.168.0.205", port: 55555)
			if let message = try? OSCMessage(with: "/light_off", arguments: [])
			{
				if let _ = try? client.send(message)
				{
				}
			}
			
			viewController?.performSegue(withIdentifier: "toMessage", sender: nil)
		}
	}
}
