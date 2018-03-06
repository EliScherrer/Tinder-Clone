//
//  CardsViewController.swift
//  tinder
//
//  Created by Eli Scherrer on 3/5/18.
//  Copyright © 2018 Eli Scherrer. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var ryanImageView: UIImageView!
    
    var cardInitialCenter: CGPoint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
    
    

    @IBAction func didPanRyan(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        
        if sender.state == .began {
            cardInitialCenter = ryanImageView.center
        }
        else if sender.state == .changed {
            
            if (translation.x > 80 || translation.x < -80) {
                UIView.animate(withDuration:0.15, animations: {
                    // This causes first view to fade in and second view to fade out
                    self.ryanImageView.alpha = 0
                })
            }
            
            else {
                ryanImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                print("moved: \(translation.x)")
                
                //dragged from top half
                if (sender.location(in: ryanImageView).y < ryanImageView.center.y) {
                    ryanImageView.transform = CGAffineTransform(rotationAngle: CGFloat((translation.x / 300)) * CGFloat(45 * Double.pi / 180))
                }
                //dragged from bottom half
                else {
                    ryanImageView.transform = CGAffineTransform(rotationAngle: CGFloat((translation.x / 300)) * CGFloat(45 * Double.pi / 180) * CGFloat(-1))
                }
            }
            
        }
        else if sender.state == .ended {
            
            ryanImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0))

            if (translation.x > 80 || translation.x < -80) {
                self.ryanImageView.center = self.cardInitialCenter
                self.ryanImageView.alpha = 1
            }
            else {
                //make the image bounce back
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.ryanImageView.center = self.cardInitialCenter
                }, completion: nil)
                
                self.ryanImageView.alpha = 1
                
            }
            
            
        }
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
