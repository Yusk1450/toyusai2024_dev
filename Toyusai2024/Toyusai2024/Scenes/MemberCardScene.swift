//
//  MemberCardScene.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/17.
//

import UIKit

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
		
		if let vc = viewController
		{
			Timer.scheduledTimer(withTimeInterval: 8.0, repeats: false) { timer in
				
				vc.performSegue(withIdentifier: "toAR", sender: nil)
				
			}
		}
	}
	
}
