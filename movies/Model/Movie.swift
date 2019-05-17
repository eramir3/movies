//
//  Info.swift
//  movies
//
//  Created by Esteban on 5/11/19.
//  Copyright © 2019 Esteban Ramirez. All rights reserved.
//

import Foundation

class Movie {
    
    var id: Int?
    
    var image: String?
    
    var title: String?
    
    var releaseDate: String?
    
    var overview: String?
    
    var popular: Bool?
    
    var topRated: Bool?
    
    var upcoming: Bool?
    
    var type: String?
    
    
    init(){ }
    
    init(id: Int, image: String, title: String, releaseDate: String, overview: String, popular: Bool, topRated: Bool, upcoming: Bool, type: String) {
        
        self.id = id
        self.image = image
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.popular = popular
        self.topRated = topRated
        self.upcoming = upcoming
        self.type = type
    }
   
}
