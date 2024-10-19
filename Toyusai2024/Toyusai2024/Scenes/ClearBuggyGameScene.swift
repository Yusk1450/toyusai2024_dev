//
//  ClearCursedWebScene.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/17.
//

import UIKit

class ClearBuggyGameScene: BaseScene
{
	override init()
	{
		super.init()
		
		self.scenario = [
			"まだできない、どれだけ頑張ってもバグが出てくる"
		]
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
