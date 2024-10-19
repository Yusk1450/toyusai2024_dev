//
//  FirstScene.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/17.
//

import UIKit

class FirstScene: BaseScene
{
	override init()
	{
		super.init()
		
		self.scenario = [
			"展示会、成功すると良いな",
			"皆で準備できるなら、きっと感動させられるものが作れるよね"
		]
	}
	
	override func start(viewController:UIViewController?)
	{
		super.start(viewController: viewController)
		
		Timer.scheduledTimer(withTimeInterval: 6.0,
							 repeats: false) { timer in
			
			GameDirector.shared.changeScene(scene: MemberCardScene())
		}
	}
	
	override func update(viewController:UIViewController?)
	{
	}
	
	override func stop(viewController:UIViewController?)
	{
	}
}
