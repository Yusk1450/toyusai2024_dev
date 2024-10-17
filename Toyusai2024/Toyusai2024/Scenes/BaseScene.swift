//
//  BaseScene.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/17.
//

import UIKit

protocol GameSceneDelegate: AnyObject
{
	func gameSceneDidStart(scene:BaseScene)
}

class BaseScene: NSObject
{
	var scenario = [String]()
	
	var delegate:GameSceneDelegate?
	
	func start()
	{
		self.delegate?.gameSceneDidStart(scene: self)
	}
	
	func update()
	{
	}
	
	func stop()
	{
	}
}
