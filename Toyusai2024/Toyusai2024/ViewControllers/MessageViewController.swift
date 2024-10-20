//
//  MessageViewController.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/20.
//

import UIKit
import AVFoundation

class MessageViewController: UIViewController
{
	@IBOutlet weak var message1: UILabel!
	@IBOutlet weak var message2: UILabel!
	@IBOutlet weak var message3: UILabel!
	@IBOutlet weak var message4: UILabel!
	@IBOutlet weak var message5: UILabel!
	@IBOutlet weak var message6: UILabel!

	var lbls = [UILabel]()
	var counter = 0
	
    override func viewDidLoad()
	{
		super.viewDidLoad()
		
		for v in self.view.subviews
		{
			if let lbl = v as? UILabel
			{
				lbl.font = UIFont(name: "05HomuraM-SemiBold", size: 28)
			}
		}
		
		self.lbls = [
			self.message1, self.message2, self.message3,
			self.message4, self.message5, self.message6
		]
		
		for lbl in self.lbls
		{
			lbl.isHidden = true
		}
		self.lbls[self.counter].isHidden = false
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
	{
		if (self.counter > self.lbls.count - 1)
		{
			return
		}
		self.counter += 1

		if (self.counter > self.lbls.count - 1)
		{
			self.performSegue(withIdentifier: "toInput", sender: nil)
			return
		}
		self.lbls[self.counter].isHidden = false
	}


}
