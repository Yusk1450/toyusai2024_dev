//
//  NormalEnd2ViewController.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/20.
//

import UIKit

class NormalEnd2ViewController: UIViewController {

    override func viewDidLoad()
	{
        super.viewDidLoad()

    }
    
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		
		Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
			self.performSegue(withIdentifier: "toEnd", sender: nil)
		}
	}

}
