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
	
	override func start()
	{
		self.delegate?.gameSceneDidStart(scene: self)
		
		Timer.scheduledTimer(withTimeInterval: 10.0,
							 repeats: false) { timer in
			
			GameDirector.shared.changeScene(scene: MemberCardScene())
		}
	}
	
	override func update()
	{
	}
	
	override func stop()
	{
	}
}
