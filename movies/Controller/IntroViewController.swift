//
//  IntroViewController.swift
//  movies
//
//  Created by Esteban on 5/14/19.
//  Copyright © 2019 Esteban Ramirez. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    
    let backgroundImg = UIImageView()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        backgroundImg.frame = CGRect(x: 0, y: 0, width: (self.view?.bounds.height)! * 1.688, height: (self.view.bounds.height))
        backgroundImg.image = UIImage(named: "unnamed.png")
        self.view.addSubview(backgroundImg)
        
        let button = UIButton(frame: CGRect(x: self.view.bounds.width/2 - 100, y: self.view.bounds.height/2, width: 200, height: 50))
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.setTitle("Enter", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationItem.title = "Peiky App"
        self.view.addSubview(button)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moveBgLeft()
        peikyAnimation()
    }
    
    @objc func buttonAction(sender: UIButton!) {
        
        let infoController = CategoriesViewController()
        navigationController?.pushViewController(infoController, animated: true)
    }
    
    func moveBgLeft() {
        
        UIView.animate(withDuration: 10, animations: {
            self.backgroundImg.frame.origin.x = -self.backgroundImg.bounds.width + self.view.bounds.width
        }) { (finished) in
            if finished {
                // move right
                self.moveBgRight()
            }
        }
    }
    
    func moveBgRight() {
        
        UIView.animate(withDuration: 10, animations: {
            self.backgroundImg.frame.origin.x = 0
        }) { (finished) in
            if finished {
                // move left
                self.moveBgLeft()
            }
        }
    }
    
    func peikyAnimation() {
        
        let layer = UIView()
        layer.frame = self.view.frame
        layer.backgroundColor = UIColor(red: 255/255, green: 1/255, blue: 97/255, alpha: 1)
        self.view.addSubview(layer)
        
        let icon = UIImageView()
        icon.image = UIImage(named: "logo.png")
        icon.frame.size.width = 100
        icon.frame.size.height = 50
        icon.center = view.center
        self.view.addSubview(icon)
        
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveLinear, animations: {
            
            icon.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
        }) { (finished:Bool) in
            
            if finished {
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    icon.transform = CGAffineTransform(scaleX: 20, y: 20)
                    
                    UIView.animate(withDuration: 0.1, delay: 0.3, options: .curveLinear, animations: {
                        
                        icon.alpha = 0
                        layer.alpha = 0
                        
                    }, completion: nil)
                    
                })
                
            }
        }
    }
    
}
