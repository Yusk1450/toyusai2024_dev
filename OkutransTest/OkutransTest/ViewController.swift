//
//  ViewController.swift
//  OkutransTest
//
//  Created by ISHIGO Yusuke on 2024/05/29.
//

import UIKit
import AVFoundation
import CoreMotion
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, OkutransDetectorDelegate
{
	@IBOutlet weak var playerView: PlayerView!
	
	var isPlayed = false
	
	var timer:Timer?
	
	var detector = OkutransDetector()
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.detector.delegate = self
		
		self.playerView.player = AVPlayer(playerItem: self.getPlayerItem(fileName: "nbu_fes2024"))
		self.playerView.isHidden = true
		
		NotificationCenter.default.addObserver(
			forName: .AVPlayerItemDidPlayToEndTime,
			object: nil, queue: .main) { [weak self] notification in
				
				guard let wself = self else { return }
				
				wself.isPlayed = true
				
				let ip = "192.168.0.115"
				let url = "http://\(ip):8888/WORKS/NBU/toyusai2024_dev/server/flag"
				
				AF.request(
					url,
					method: .post,
					parameters: ["flag_id": 3])
				.responseJSON { res in
					}
				
			}
		
		Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
			
			let ip = "192.168.0.115"
			let url = "http://\(ip):8888/WORKS/NBU/toyusai2024_dev/server/flag"
			
			AF.request(url,
					   method: .get,
					   parameters: nil,
					   encoding: URLEncoding.default,
					   headers: nil
			)
				.responseJSON { res in
				
					print(res.data)
					
					if let data = res.data
					{
						let json = JSON(data)
						
						if (json[2].boolValue)
						{
							DispatchQueue.main.async {
								self.playerView.isHidden = false
							}
						}
					}

			}
			
		}
	}
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		
		self.detector.startDetection()
	}
	
	override func viewDidDisappear(_ animated: Bool)
	{
		super.viewDidDisappear(animated)
		
		self.detector.stopDetection()
	}
	
	func getPlayerItem(fileName:String) -> AVPlayerItem?
	{
		guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp4") else
		{
			print("URL is nil")
			return nil
		}
		
		return AVPlayerItem(url: url)
	}
	
	func OkutransDetectorDidDetection(detector: OkutransDetector)
	{
		print("Detection!")
		
		guard let player = self.playerView.player else {
			return
		}
				
		if (player.rate == 0.0 && !self.isPlayed)
		{
			player.seek(to: .zero)
			player.play()
		}
		
		
	}


}

