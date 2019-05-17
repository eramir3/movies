//
//  InfoViewController.swift
//  movies
//
//  Created by Esteban on 5/12/19.
//  Copyright © 2019 Esteban Ramirez. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    var info = Movie()
    
    let titleLabel = UILabel()
    
    let releaseDateLabel = UILabel()
    
    var pictureImage = UIImage()
    
    var pictureImageView = UIImageView()
    
    var type = String()
    
    var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: statusBarHeight + 120, width: self.view.bounds.width, height: 21))
        titleLabel.textAlignment = .center
        titleLabel.text = info.title
        self.view.addSubview(titleLabel)
        
        
        let pictureImageView = UIImageView(frame: CGRect(x: self.view.bounds.width/4, y: titleLabel.frame.origin.y + titleLabel.frame.height/2 + 30, width: self.view.bounds.width/2, height: self.view.bounds.width/2))
        pictureImageView.contentMode = .scaleAspectFit
        pictureImageView.image = pictureImage
        self.view.addSubview(pictureImageView)
        
        
        let releaseDateLabel = UILabel(frame: CGRect(x: 0, y: pictureImageView.frame.origin.y + pictureImageView.frame.height + 30, width: self.view.bounds.width, height: 21))
        releaseDateLabel.textAlignment = .center
        releaseDateLabel.text = "Release: \(info.releaseDate!)"
        self.view.addSubview(releaseDateLabel)
        
        
        let overviewLabel = UILabel(frame: CGRect(x: 10, y: 0, width: self.view.bounds.width - 20, height: 0))
        overviewLabel.textAlignment = .center
        overviewLabel.text = info.overview
        overviewLabel.numberOfLines = 0
        overviewLabel.textAlignment = .justified
        overviewLabel.frame.size = overviewLabel.bounds.size
        overviewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        overviewLabel.sizeToFit()
        
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: releaseDateLabel.frame.origin.y + 50, width: screenWidth, height: self.view.bounds.height - (releaseDateLabel.frame.origin.y)))
        scrollView.addSubview(overviewLabel)
        scrollView.contentSize = CGSize(width: screenWidth, height: self.view.bounds.height + overviewLabel.bounds.size.height - scrollView.frame.origin.y)
        self.view.addSubview(scrollView)
    }
    
    func setupViews() {
        
        navigationItem.title = type
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        self.view.backgroundColor = UIColor.white
    }

}
