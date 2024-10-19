//
//  FirstViewController.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/17.
//

import UIKit

class FirstViewController: UIViewController
{
	@IBOutlet weak var startBtn: UIButton!
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

		let attributedString = NSMutableAttributedString(string: "GAME START")
		attributedString.addAttribute(.kern, value: 2.0, range: NSMakeRange(0, attributedString.length))
		attributedString.addAttribute(.font, value: UIFont(name: "05HomuraM-SemiBold", size: 40), range: NSMakeRange(0, attributedString.length))

		self.startBtn.setAttributedTitle(attributedString, for: .normal)
    }


}
