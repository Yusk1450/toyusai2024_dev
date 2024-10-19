//
//  ViewController.swift
//  ipad screen01
//
//  Created by 中野結菜 on 2024/10/08.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GameDirectorDelegate
{
	var items = [String]()
	
	var gimmickIdxOld = 0
	
	@IBOutlet weak var labelW: UILabel!
	@IBOutlet weak var labelB: UILabel!
	@IBOutlet weak var labelR: UILabel!
	
	@IBOutlet weak var input: UITextField!
	@IBOutlet weak var upbox: UIImageView!
	@IBOutlet weak var leftbox: UIImageView!
	@IBOutlet weak var downbox1: UIImageView!
	@IBOutlet weak var downbox2: UIImageView!
	
	@IBOutlet weak var tableView: UITableView!
	
	var boxViews = [UIImageView]()
	var animationBoxIndex = 0
	
	var audioPlayer:AVAudioPlayer?
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		let director = GameDirector.shared
		director.delegate = self
		
		let attributedString = NSMutableAttributedString(string: "00:00")
		// 文字間隔を2.0ポイントに設定
		attributedString.addAttribute(.kern, value: 20.0, range: NSMakeRange(0, attributedString.length))
		
		// ラベルに設定
		self.labelW.attributedText = attributedString
		self.labelR.attributedText = attributedString
		self.labelB.attributedText = attributedString
		
		self.labelW.textColor = UIColor.rgba(red: 255, green: 255, blue: 255, alpha: 1.0)
		self.labelW.font = UIFont(name: "05HomuraM-SemiBold", size: 55)
		self.labelR.textColor = UIColor.rgba(red: 161, green: 0, blue: 0, alpha: 0.6)
		self.labelR.font = UIFont(name: "05HomuraM-SemiBold", size: 55)
		self.labelB.textColor = UIColor.rgba(red: 21, green: 169, blue: 233, alpha: 0.5)
		self.labelB.font = UIFont(name: "05HomuraM-SemiBold", size: 55)
		
		updateTimeLabel(time: GameDirector.shared.remainGameTime)
		
		//背景カラー
		view.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 49/255, alpha: 1.0)
		
		// キーボード表示
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShowNotification),name: UIResponder.keyboardWillShowNotification,object: nil)
		
		// キーボード非表示
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHideNotification),name: UIResponder.keyboardWillHideNotification,object: nil)
		
		let path = Bundle.main.path(forResource: "sound", ofType: "mp3")
		let url = URL(fileURLWithPath: path!)
		self.audioPlayer = try? AVAudioPlayer(contentsOf: url)
		self.audioPlayer?.prepareToPlay()
		
		self.boxViews = [self.downbox2, self.leftbox, self.upbox]
		
		director.currentViewController = self
		
		Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
			director.startGame()
		}
	}
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		
		self.startAnimation(boxView: self.boxViews[0])
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		return 84.0
	}
	
	func numberOfSections(in tableView: UITableView) -> Int
	{
		//セクション１、返す
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		//テーブルビューの中身
		return self.items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		//セルの名前
		let identifier = "SnsCell"
		//セルの再利用
		var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
		
		if (cell == nil)
		{
			//再利用されなかった時新しく作ってる
			cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
		}
		
		let userLabel = cell?.viewWithTag(95) as? UILabel
		userLabel?.font = UIFont(name: "05HomuraM-SemiBold", size: 10)
		
		//何番目が選択されてる？
		let label = cell?.viewWithTag(100) as? UILabel
		label?.font = UIFont(name: "05HomuraM-SemiBold", size: 12)
		label?.text = self.items[indexPath.row]
		
		return cell!
	}
	
	func gameDirectorDidChangeNextScript(gameDirector: GameDirector, script: String)
	{
		self.audioPlayer?.play()
		
		self.items.insert(script, at: 0)
		self.tableView.reloadData()
	}
	
	func gameDirectorDidUpdate(gameDirector: GameDirector)
	{
		updateTimeLabel(time: gameDirector.remainGameTime)
		
		
		if (gameDirector.gimmickFlags[3])
		{
			self.stopAnimation()
		}
		else if (gameDirector.gimmickFlags[2] && self.animationBoxIndex == 1)
		{
			self.animationBoxIndex = 2
			startAnimation(boxView: self.boxViews[2])
		}
		else if (gameDirector.gimmickFlags[0] && self.animationBoxIndex == 0)
		{
			self.animationBoxIndex = 1
			startAnimation(boxView: self.boxViews[1])
		}
		
	}
	
	private func updateTimeLabel(time:Int)
	{
		let paddedMinutes = String(format: "%02d", time / 60)
		let paddedSeconds = String(format: "%02d", time % 60)
		
		let formattedTime = "\(paddedMinutes):\(paddedSeconds)"
		
		self.labelW.text = formattedTime
		self.labelR.text = formattedTime
		self.labelB.text = formattedTime
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
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{
		textField.resignFirstResponder()
		return true
	}
	
	private func stopAnimation()
	{
		for v in self.boxViews
		{
			v.layer.removeAllAnimations()
		}
	}
	
	private func startAnimation(boxView:UIView)
	{
		self.stopAnimation()
		
		boxView.alpha = 1.0
		
	   // 2秒かけて透明にし、完了したら2秒かけて元に戻す。
	   UIView.animate(withDuration: 2.0,
					   delay: 0.0,
					   options: [.repeat, .autoreverse],
					  animations: {

		   boxView.alpha = 0.0
		   
			}, completion: nil)
	}
 
}

