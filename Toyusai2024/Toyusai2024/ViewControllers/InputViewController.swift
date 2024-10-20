//
//  InputViewController.swift
//  Toyusai2024
//
//  Created by ISHIGO Yusuke on 2024/10/20.
//

import UIKit

class InputViewController: UIViewController, UITextFieldDelegate
{
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var textFieldLbl: UILabel!
	
	@IBOutlet weak var textField: UITextField!
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		self.textField.attributedPlaceholder = NSAttributedString(
			string: self.textField.placeholder ?? "", attributes: [.foregroundColor: UIColor.white])

		self.titleLbl.font = UIFont(name: "05HomuraM-SemiBold", size: 28)
		self.textFieldLbl.font = UIFont(name: "05HomuraM-SemiBold", size: 16)
		
		self.textField.font = UIFont(name: "05HomuraM-SemiBold", size: 17)
		
		// キーボード表示
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShowNotification),name: UIResponder.keyboardWillShowNotification,object: nil)
		
		// キーボード非表示
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHideNotification),name: UIResponder.keyboardWillHideNotification,object: nil)
    }
    
	@objc func keyboardWillShowNotification(notification:NSNotification)
	{
		guard let userInfo = notification.userInfo else { return }
		guard let isLocalUserInfoKey = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? NSNumber else { return }
		
		if (!isLocalUserInfoKey.boolValue) { return }
		
		let transform = CGAffineTransform(translationX: 0, y: -200)
		self.view.transform = transform
	}
	
	@objc func keyboardWillHideNotification(notification:NSNotification)
	{
		guard let userInfo = notification.userInfo else { return }
		guard let isLocalUserInfoKey = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? NSNumber else { return }
		
		if (!isLocalUserInfoKey.boolValue) { return }
		
		self.view.transform = CGAffineTransform.identity
	}
	
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
	{
		if let text = self.textField.text
		{
			if (text.trimmingCharacters(in: .whitespacesAndNewlines) != "")
			{
				return true
			}
		}
		return false
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		let nextViewController = segue.destination as? ConfirmViewController
		nextViewController?.message = self.textField.text
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{
		textField.resignFirstResponder()
		return true
	}
}
