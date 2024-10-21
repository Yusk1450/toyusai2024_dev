//
//  ClearCursedWebScene.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/17.
//

import UIKit
import OSCKit

class ClearBuggyGameScene: BaseScene
{
	override init()
	{
		super.init()
		
		self.scenario = [
			"おかしいな、直しても直してもバグが出てくる"
		]
	}
	
	override func start(viewController: UIViewController?)
	{
		super.start(viewController: viewController)
		
		var client = OSCUdpClient(host: "192.168.0.201", port: 55555)
		if let message = try? OSCMessage(with: "/light_off", arguments: [])
		{
			if let _ = try? client.send(message)
			{
			}
		}
		
		client = OSCUdpClient(host: "192.168.0.205", port: 55555)
		if let message = try? OSCMessage(with: "/light_on", arguments: [])
		{
			if let _ = try? client.send(message)
			{
			}
		}
		
		Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { timer in

			let client = OSCUdpClient(host: "192.168.0.115", port: 55555)
			if let message = try? OSCMessage(with: "/start_movie", arguments: [])
			{
				if let _ = try? client.send(message)
				{
				}
			}

		}
		
		Timer.scheduledTimer(withTimeInterval: 25.0, repeats: false) { timer in
			
			GameDirector.shared.sendFlagToServer(flagIndex: 2)
			
		}
	}
	
	override func update(viewController: UIViewController?)
	{
		let director = GameDirector.shared
		
		// すりガラスクリアフラグを確認する
		if (director.gimmickFlags[2])
		{
			director.changeScene(scene: ClearGlassScene())
		}
	}

}
