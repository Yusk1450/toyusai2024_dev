//
//  ARViewController.swift
//  Toyusai2024
//
//  Created by ichinose-PC on 2024/10/18.
//

import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController, ARSCNViewDelegate
{
    @IBOutlet var sceneView: ARSCNView!
	
	var isDetected = false
    
    override func viewDidLoad()
	{
		super.viewDidLoad()
		
		sceneView.delegate = self
//		sceneView.showsStatistics = true
	}

	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)

		let configuration = ARImageTrackingConfiguration()
		if let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "ARResources", bundle: Bundle.main) {
			configuration.trackingImages = referenceImages
			configuration.maximumNumberOfTrackedImages = 1
		}
		sceneView.session.run(configuration)
	}

	override func viewWillDisappear(_ animated: Bool)
	{
		super.viewWillDisappear(animated)

		sceneView.session.pause()
	}

	// MARK: - ARSCNViewDelegate
	func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor)
	{
		guard let imageAnchor = anchor as? ARImageAnchor else { return }

		let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
							 height: imageAnchor.referenceImage.physicalSize.height)
		
		// 任意の画像を設定 (例: "display_image.png")
		plane.firstMaterial?.diffuse.contents = UIImage(named: "student")

		let planeNode = SCNNode(geometry: plane)
		planeNode.eulerAngles.x = -.pi / 2

		node.addChildNode(planeNode)
		
		if (!self.isDetected)
		{
			DispatchQueue.main.async
			{
				Timer.scheduledTimer(timeInterval: 10,
									 target: self,
									 selector: #selector(ARViewController.timerAction(timer:)),
									 userInfo: nil,
									 repeats: false)
			}
		}
		
		self.isDetected = true
	}
	
	@objc func timerAction(timer:Timer)
	{
		self.dismiss(animated: true)

		Timer.scheduledTimer(withTimeInterval: 5.0,
							 repeats: false) { timer in

			GameDirector.shared.sendFlagToServer(flagIndex: 0)
			GameDirector.shared.changeScene(scene: ClearMemberCardScene())
			
		}
	}
}
