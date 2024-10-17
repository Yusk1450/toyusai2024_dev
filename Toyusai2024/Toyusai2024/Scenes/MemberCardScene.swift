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
			"学生証をなくした、多分教室にあると思うんだけど"
		]
	}
	
	override func start()
	{
		// AR起動
		
		Timer.scheduledTimer(withTimeInterval: 10,
							 repeats: false) { timer in
			
			GameDirector.shared.changeScene(scene: ClearMemberCardScene())
			
		}
	}
	
}
