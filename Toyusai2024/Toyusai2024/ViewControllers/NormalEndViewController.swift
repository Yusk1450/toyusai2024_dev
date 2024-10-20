//
//  NormalEndViewController.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/20.
//

import UIKit

class NormalEndViewController: UIViewController
{
    override func viewDidLoad()
	{
        super.viewDidLoad()

    }
    

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
	{
		self.performSegue(withIdentifier: "toNext", sender: nil)
	}
}
