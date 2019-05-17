//
//  InfoService.swift
//  movies
//
//  Created by Esteban on 5/14/19.
//  Copyright © 2019 Esteban Ramirez. All rights reserved.
//

import Foundation

class InfoService: NSObject {
    
    let apiKey = "f48e8b760240f03deb028f40ad542def"
    
    static let shared = InfoService()
    
    func prepareURL(type: String, category: String) -> [String: String] {
        
        var url = [String: String]()
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: currentDate)
        
        if type == Type.MOVIES.rawValue {
            
            url["url"] = "https://api.themoviedb.org/3/discover/movie"
            
            switch category {
                
                case Category.POPULAR.rawValue:
                    url["category"] = Category.POPULAR.rawValue
                    url["body"] = "api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
                
                case Category.TOP_RATED.rawValue:
                    url["category"] = Category.TOP_RATED.rawValue
                    url["body"] = "api_key=\(apiKey)&language=en-US&sort_by=vote_count.desc&include_adult=false&include_video=false&page=1"
                
                case Category.UPCOMING.rawValue:
                    url["category"] = Category.UPCOMING.rawValue
                    url["body"] = "api_key=\(apiKey)&language=en-US&region=US&sort_by=release_date.asc&include_adult=false&include_video=false&page=1&primary_release_year=2019&primary_release_date.gte=2019-05-17&release_date.gte=\(date)&year=2019"
                
                default:
                    url["body"] = ""
            }
        }
        else {
            
            url["url"] = "https://api.themoviedb.org/3/discover/tv"
            
            switch category {
                
                case Category.POPULAR.rawValue:
                    url["category"] = Category.POPULAR.rawValue
                    url["body"] = "api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false"
                
                case Category.TOP_RATED.rawValue:
                    url["category"] = Category.TOP_RATED.rawValue
                    url["body"] = "api_key=\(apiKey)&language=en-US&sort_by=vote_average.desc&air_date.gte=\(date)&first_air_date.gte=\(date)&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false"
                
                case Category.UPCOMING.rawValue:
                    url["category"] = Category.UPCOMING.rawValue
                    url["body"] = "api_key=\(apiKey)&language=en-US&sort_by=first_air_date.asc&air_date.gte=\(date)&first_air_date.gte=\(date)&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false"
                
                default:
                    url["body"] = ""
            }
        }
        
        return url
    }
}
