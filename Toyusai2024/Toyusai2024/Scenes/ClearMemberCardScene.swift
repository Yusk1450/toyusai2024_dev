//
//  ClearMemberCardScene.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/17.
//

import UIKit

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
