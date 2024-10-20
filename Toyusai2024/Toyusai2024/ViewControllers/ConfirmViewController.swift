//
//  ConfirmViewController.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/20.
//

import UIKit

class ConfirmViewController: UIViewController
{
	@IBOutlet weak var textField: UITextField!
	
	
	var message:String?

    override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.textField.text = self.message
	}
	
	@IBAction func okBtnAction(_ sender: Any)
	{
		guard let message = self.message else { return }
		
		// 楽しかった
		if (message.trimmingCharacters(in: .whitespacesAndNewlines).contains("楽"))
		{
			self.performSegue(withIdentifier: "toFun", sender: nil)
		}
		// 感動した
		else if (message.trimmingCharacters(in: .whitespacesAndNewlines).contains("感動"))
		{
//			self.performSegue(withIdentifier: "toTrue", sender: nil)
			self.performSegue(withIdentifier: "toFun", sender: nil)
		}
		// その他
		else
		{
			self.performSegue(withIdentifier: "toBad", sender: nil)
		}
		
	}
	
	@IBAction func returnBtnAction(_ sender: Any)
	{
		self.dismiss(animated: true)
	}
	
	
}
