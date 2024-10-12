//
//  ViewController.swift
//  ipad screen01
//
//  Created by 中野結菜 on 2024/10/08.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    
    //timerの時間(15分,00秒)
    var time: [Int] = [15,0]
    
    let items = ["a","b","c","d"]
    
  
    @IBOutlet weak var labelW: UILabel!
    
    @IBOutlet weak var labelB: UILabel!
    
    @IBOutlet weak var labelR: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var upbox: UIImageView!
    
    @IBOutlet weak var leftbox: UIImageView!
    
    @IBOutlet weak var downbox1: UIImageView!
    
    @IBOutlet weak var downbox2: UIImageView!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let text = "00:00"
            let attributedString = NSMutableAttributedString(string: text)

            // 文字間隔を2.0ポイントに設定
        attributedString.addAttribute(.kern, value: 20.0, range: NSMakeRange(0, attributedString.length))

            // ラベルに設定
            labelW.attributedText = attributedString
            labelR.attributedText = attributedString
            labelB.attributedText = attributedString
        
        //背景カラー
        view.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 49/255, alpha: 1.0)
        
        button.frame = CGRect(x: 961, y: 686, width: 45, height: 45)
        
        // キーボード表示
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShowNotification),name: UIResponder.keyboardWillShowNotification,object: nil)

                // キーボード非表示
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
                NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHideNotification),name: UIResponder.keyboardWillHideNotification,object: nil)
        
        //labelの表示を初期化
        koushinTimes()
        
        //一秒ごとにtimerメソッドを呼び出す
        Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(timer) , userInfo: nil, repeats: true)
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
        //何番目が選択されてる？
        cell?.textLabel?.text = self.items[indexPath.row]
        cell?.textLabel?.font = UIFont(name: "05HomuraM-SemiBold", size: 18)
        cell?.textLabel?.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) 
    {
        print("タップされたよ")
    }
    
    //timerメソッド↓
    @objc func timer()
    {
        if time[0] == 0 && time[1] == 0 
        {
            return
        }
        
        if time[1] > 0 
        {
            // 秒が0以上の時、-1
            time[1] -= 1
        } 
        
        else
        {
            // 秒が0の時、分を減らし秒を59にリセット
            if time[0] > 0 
            {
                time[0] -= 1
                time[1] = 59
            }
        }
        
        koushinTimes()
    }
    
    //更新したタイマーの時間を表示するためのメソッド
    func koushinTimes() 
    {
        // %02dは2桁表示してくれる
        let paddedMinutes = String(format: "%02d", time[0])
        let paddedSeconds = String(format: "%02d", time[1])
        
        let formattedTime = "\(paddedMinutes):\(paddedSeconds)"
        
        labelW.text = formattedTime
        labelR.text = formattedTime
        labelB.text = formattedTime
        
        labelW.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        labelW.font = UIFont(name: "05HomuraM-SemiBold", size: 55)
        
        labelR.textColor = UIColor(red: 161/255, green: 0/255, blue: 0/255, alpha: 0.6)
        labelR.font = UIFont(name: "05HomuraM-SemiBold", size: 55)
        
        labelB.textColor = UIColor(red: 21/255, green: 169/255, blue: 233/255, alpha: 0.5)
        labelB.font = UIFont(name: "05HomuraM-SemiBold", size: 55)
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
    
    
    @IBAction func upButton(_ sender: Any) 
    {
        upbox.isHidden = false
        self.startAnimation()
//        downbox1.layer.removeAllAnimations()
//        downbox2.layer.removeAllAnimations()
        leftbox.layer.removeAllAnimations()
        
    }
    
    @IBAction func downButton2(_ sender: Any)
    {
        downbox2.isHidden = false
        self.startAnimation()
//        upbox.layer.removeAllAnimations()
//        downbox1.layer.removeAllAnimations()
//        leftbox.layer.removeAllAnimations()
    }
    
    
    @IBAction func downButton1(_ sender: Any)
    {
        downbox1.isHidden = false
        self.startAnimation()
//        upbox.layer.removeAllAnimations()
        downbox2.layer.removeAllAnimations()
//        leftbox.layer.removeAllAnimations()
    }
    
    @IBAction func leftButton(_ sender: Any) 
    {
        leftbox.isHidden = false
        self.startAnimation()
//        upbox.layer.removeAllAnimations()
        downbox1.layer.removeAllAnimations()
//        downbox2.layer.removeAllAnimations()
        
    }
    
    
    
    
    private func startAnimation() {
        
        
        
           // 2秒かけて透明にし、完了したら2秒かけて元に戻す。
           UIView.animate(withDuration: 2.0,
                           delay: 0.0,
                           options: [.repeat,.autoreverse],
                          animations: { 
                                        self.upbox.alpha = 0.0
               self.leftbox.alpha = 0.0
               self.downbox1.alpha = 0.0
               self.downbox2.alpha = 0.0
                }, completion: nil)
        }
 
}

