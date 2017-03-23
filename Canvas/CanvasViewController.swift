//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Gokulsree Yenugadhati on 3/23/17.
//  Copyright © 2017 Gokul Yenugadhati. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceCenterOriginal: CGPoint!
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 250
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func didPanTry(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
            print("Gesture began")
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)

            print("Gesture is changing")
        } else if sender.state == .ended {
            
            if velocity.y > 0 {
                trayView.center = trayDown
                if(trayOriginalCenter != trayDown){
                    arrowImage.transform = arrowImage.transform.rotated(by: CGFloat(M_PI))
                }
                
            }else{
                trayView.center = trayUp
                if(trayOriginalCenter != trayUp){
                arrowImage.transform = arrowImage.transform.rotated(by: CGFloat(M_PI))
                }
            }
            print("Gesture ended")
        }
    }
    

    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        var imageView = sender.view as! UIImageView
        
        if sender.state == .began {
            newlyCreatedFace = UIImageView(image: imageView.image)
            newlyCreatedFace.center = imageView.center
            
            newlyCreatedFace.center.y += trayView.frame.origin.y
            view.addSubview(newlyCreatedFace)
            newlyCreatedFaceCenterOriginal = newlyCreatedFace.center
            
            newlyCreatedFace.isUserInteractionEnabled = true
            print("Gesture began")
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceCenterOriginal.x + translation.x, y: newlyCreatedFaceCenterOriginal.y + translation.y)
            print("Gesture is changing")
        } else if sender.state == .ended {
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
        
            print("Gesture ended")
        }
        
     
    }
    
    
    
    func didPan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceCenterOriginal = newlyCreatedFace.center
            print("Gesture began")
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceCenterOriginal.x + translation.x, y: newlyCreatedFaceCenterOriginal.y + translation.y)

            print("Gesture is changing")
        } else if sender.state == .ended {
            print("Gesture ended")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
