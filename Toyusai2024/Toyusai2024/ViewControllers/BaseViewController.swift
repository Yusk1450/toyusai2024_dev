//
//  BaseViewController.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/20.
//

import UIKit

class BaseViewController: UIViewController
{
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
		
    }
    


}
