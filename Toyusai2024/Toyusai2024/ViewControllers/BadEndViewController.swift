//
//  BadEndViewController.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/20.
//

import UIKit

class BadEndViewController: UIViewController
{
	@IBOutlet weak var message1: UILabel!
	@IBOutlet weak var message2: UILabel!
	@IBOutlet weak var message3: UILabel!
	@IBOutlet weak var message4: UILabel!
	@IBOutlet weak var message5: UILabel!
	@IBOutlet weak var message6: UILabel!

	var lbls = [UILabel]()
	var counter = 0
	
	var imageCounter = 1
	var imageTimer:Timer?

    override func viewDidLoad()
	{
        super.viewDidLoad()

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
			self.imageCounter = 0
			self.imageTimer = Timer.scheduledTimer(
				withTimeInterval: 1.0,
				repeats: true) { timer in
					
					let img = UIImage(named: "bad\(self.imageCounter)")
					let imgView = UIImageView(image: img)
					imgView.frame = self.view.frame
					imgView.center = self.view.center
					self.view.addSubview(imgView)
					
					if (self.imageCounter >= 11)
					{
						self.imageTimer?.invalidate()
						
						Timer.scheduledTimer(withTimeInterval: 5.0,
											 repeats: false) { timer in
							
							self.performSegue(withIdentifier: "toEnd", sender: nil)
							
						}
					}
					self.imageCounter += 1
				}
//			for lbl in self.lbls
//			{
//				let attributedString = NSMutableAttributedString(string: lbl.text!)
//				attributedString.addAttribute(.foregroundColor,
//											  value: UIColor.rgba(red: 161, green: 0, blue: 0, alpha: 1.0),
//											  range: NSRange(location: 0, length: lbl.text!.count))
//			}

			return
		}
		self.lbls[self.counter].isHidden = false
	}
}
