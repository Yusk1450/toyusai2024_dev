//
//  MemberCardScene.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/17.
//

import UIKit
import OSCKit

class MemberCardScene: BaseScene
{
	override init()
	{
		super.init()
		
		self.scenario = [
			"学生証なくした、多分教室にあると思うんだけど"
		]
	}
	
	override func start(viewController:UIViewController?)
	{
		super.start(viewController: viewController)
		
		let client = OSCUdpClient(host: "192.168.0.200", port: 55555)
		if let message = try? OSCMessage(with: "/light_on", arguments: [])
		{
			if let _ = try? client.send(message)
			{
			}
		}
		
		if let vc = viewController
		{
			Timer.scheduledTimer(withTimeInterval: 8.0, repeats: false) { timer in
				
				vc.performSegue(withIdentifier: "toAR", sender: nil)
				
			}
		}
	}
	
}
