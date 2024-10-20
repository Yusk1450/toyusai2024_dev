//
//  ClearMemberCardScene.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/17.
//

import UIKit
import OSCKit

class ClearMemberCardScene: BaseScene
{
	override init()
	{
		super.init()
		
		self.scenario = [
			"学生証、やっぱり教室に落ちてた",
			"廊下で皆の話が聞こえたけど、もしかして展示会にあんまり乗り気じゃないのかな",
			"はやく、展示するゲームも完成させないと"
		]
	}
	
	override func start(viewController: UIViewController?)
	{
		super.start(viewController: viewController)

		var client = OSCUdpClient(host: "192.168.0.200", port: 55555)
		if let message = try? OSCMessage(with: "/light_off", arguments: [])
		{
			if let _ = try? client.send(message)
			{
			}
		}
		
		client = OSCUdpClient(host: "192.168.0.201", port: 55555)
		if let message = try? OSCMessage(with: "/light_on", arguments: [])
		{
			if let _ = try? client.send(message)
			{
			}
		}
	}
	
	override func update(viewController: UIViewController?)
	{
		let director = GameDirector.shared
		
		// ゲームクリアフラグを確認する
		if (director.gimmickFlags[1])
		{
			director.changeScene(scene: ClearBuggyGameScene())
		}
	}
	
}
