//
//  ARViewController.swift
//  Toyusai2024
//
//  Created by ichinose-PC on 2024/10/18.
//

import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set the view's delegate
            sceneView.delegate = self
            
            // Show statistics such as fps and timing information
            sceneView.showsStatistics = true
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            // Create a session configuration
            let configuration = ARImageTrackingConfiguration()

            // Load ARReferenceImages from Assets
            if let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "ARResources", bundle: Bundle.main) {
                configuration.trackingImages = referenceImages
                configuration.maximumNumberOfTrackedImages = 1
            }

            // Run the view's session
            sceneView.session.run(configuration)
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            // Pause the view's session
            sceneView.session.pause()
        }

        // MARK: - ARSCNViewDelegate
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard let imageAnchor = anchor as? ARImageAnchor else { return }

            // Create a plane to visualize the image
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                                 height: imageAnchor.referenceImage.physicalSize.height)
            
            // 任意の画像を設定 (例: "display_image.png")
            plane.firstMaterial?.diffuse.contents = UIImage(named: "student")

            // Create a node with the plane and rotate it
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2

            // Add the plane node to the scene
            node.addChildNode(planeNode)
        }
    }
