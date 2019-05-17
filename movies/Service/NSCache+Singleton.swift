//
//  NSCache+Singleton.swift
//  movies
//
//  Created by Esteban on 5/12/19.
//  Copyright © 2019 Esteban Ramirez. All rights reserved.
//

import Foundation
import UIKit


class Cache: NSObject , NSDiscardableContent {
    
    public var cacheInfo: Movie!
    
    public var cacheImage: UIImage!
    
    static let cacher = NSCache<NSString, Cache>()
    
    static let cacherImage = NSCache<NSString, Cache>()
    
    func beginContentAccess() -> Bool {
        return true
    }
    
    func endContentAccess() {
        
    }
    
    func discardContentIfPossible() {
        
    }
    
    func isContentDiscarded() -> Bool {
        return false
    }
}





/*
class Cache: NSCache<AnyObject, AnyObject> {
    
    static let shared = NSCache<AnyObject, AnyObject>()
    
    static let images = NSCache<AnyObject, AnyObject>()
    
    public override init() {
        super.init()
    }
}
*/
