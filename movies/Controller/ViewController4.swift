//
//  ViewController.swift
//  movies
//
//  Created by Esteban on 5/11/19.
//  Copyright © 2019 Esteban Ramirez. All rights reserved.
//

/*
import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var type = String()
    
    var category = String()
    
    let tableView: UITableView = {
        let tableView2 = UITableView()
        tableView2.separatorStyle = .none
        return tableView2
    }()
    
    let bandCellId = "bandCellId"
    
    var movies = [Info]()
    
    var searchMovie = [Info]()
    
    var searching = false
    
    static let cacher = Cache.cacher
    
    static let cacherImage = Cache.cacherImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        searchBarSetup()
        
        if Reachability.isConnectedToNetwork() {
            loadOnlineInfo()
        }
        else{
            loadCachedInfo()
        }
    }
    
    
    private func searchBarSetup() {
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else {return}
        
        if searchText == "" {
            searchMovie = movies
        }
        else {
            searching = true
            searchMovie = movies.filter({$0.title!.prefix(searchText.count) == searchText})
        }
        
        tableView.reloadData()
    }
    
    func setupViews() {
        navigationItem.title = "\(category) \(type)"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BandCell.self, forCellReuseIdentifier: bandCellId)
        view.addSubview(tableView)
        tableView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return searchMovie.count
        }
        else {
            return movies.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: bandCellId, for: indexPath) as! BandCell
        
        if searching {
            cell.titleLabel.text = searchMovie[indexPath.row].title
            cell.releaseDateLabel.text = "Release Date: \(searchMovie[indexPath.item].releaseDate ?? "No date")"
            
            let aux = ViewController2.cacherImage.object(forKey:  ("\(searchMovie[indexPath.item].id ?? -1)" as AnyObject) as! NSString)
            let aux2 = aux?.cacheImage != nil ? aux?.cacheImage : UIImage(imageLiteralResourceName: "No_image_available.svg")
            cell.pictureImageView.image = aux2
        }
        else {
            cell.titleLabel.text = movies[indexPath.item].title
            cell.releaseDateLabel.text = "Release Date: \(movies[indexPath.item].releaseDate ?? "No date")"
        }
        
        if !Reachability.isConnectedToNetwork() {
            
            if searching {
                let aux = ViewController2.cacherImage.object(forKey:  ("\(searchMovie[indexPath.item].id ?? -1)" as AnyObject) as! NSString)
                let aux2 = aux?.cacheImage != nil ? aux?.cacheImage : UIImage(imageLiteralResourceName: "No_image_available.svg")
                cell.pictureImageView.image = aux2
            }
            else {
                
                let aux = ViewController2.cacherImage.object(forKey:  ("\(movies[indexPath.item].id ?? -1)" as AnyObject) as! NSString)
                let aux2 = aux?.cacheImage != nil ? aux?.cacheImage : UIImage(imageLiteralResourceName: "No_image_available.svg")
                cell.pictureImageView.image = aux2
            }
            
            
            
            /*
             var aux: Cache
             var aux2: UIImage
             
             if searching {
             aux = ViewController2.cacherImage.object(forKey:  ("\(searchMovie[indexPath.item].id ?? -1)" as AnyObject) as! NSString)!
             }
             else {
             aux = ViewController2.cacherImage.object(forKey:  ("\(searchMovie[indexPath.item].id ?? -1)" as AnyObject) as! NSString)!
             }
             
             aux2 = aux.cacheImage != nil ? aux.cacheImage : UIImage(imageLiteralResourceName: "No_image_available.svg")
             cell.pictureImageView.image = aux2
             */
            
            
            return cell
        }
        
        if !searching {
            if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(movies[indexPath.item].image ?? "")") {
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    
                    var image: UIImage?
                    
                    if let data = data {
                        image = UIImage(data: data)!
                    }
                    
                    let cacheImage = Cache()
                    cacheImage.cacheImage = image
                    ViewController2.cacherImage.setObject(cacheImage, forKey: "\( self.movies[indexPath.item].id ?? -1)" as NSString)
                    
                    DispatchQueue.main.async {
                        
                        cell.pictureImageView.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let infoController = InfoViewController()
        let currentCell = tableView.cellForRow(at: indexPath) as! BandCell
        
        if searching {
            infoController.info = searchMovie[tableView.indexPathForSelectedRow!.row]
        }
        else {
            infoController.info = movies[tableView.indexPathForSelectedRow!.row]
        }
        
        infoController.pictureImage = currentCell.pictureImageView.image ?? UIImage(named:"No_image_available.svg")!
        infoController.type = type
        navigationController?.pushViewController(infoController, animated: true)
    }
    
    
    // load online info of movies or tv shows
    func loadOnlineInfo() {
        
        let infoService = InfoService.shared.prepareURL(type: type, category: category)
        let url = URL(string: infoService["url"]!)!
        let body = infoService["body"]
        let category2 = infoService["category"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if error != nil {
                    print("Server Error")
                    return
                }
                
                do {
                    guard let data = data else {
                        print("Data Error")
                        return
                    }
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    
                    guard let results = json?["results"] as? [NSDictionary] else {
                        return
                    }
                    
                    for result in results {
                        
                        let popular = category2 == Category.POPULAR.rawValue
                        let topRated = category2 == Category.TOP_RATED.rawValue
                        let upcoming = category2 == Category.UPCOMING.rawValue
                        
                        if self.type == Type.MOVIES.rawValue {
                            
                            let imageString = result["poster_path"] as? String ?? ""
                            
                            let movie = Info(id:  (result["id"] as! Int), image: (imageString), title: (result["original_title"] as! String), releaseDate: (result["release_date"] as! String), overview: (result["overview"] as! String), popular: popular, topRated: topRated, upcoming: upcoming, type: self.type)
                            
                            self.movies.append(movie)
                            
                            let cacheInfo = Cache()
                            cacheInfo.cacheInfo = movie
                            ViewController2.cacher.setObject(cacheInfo, forKey: "\(movie.id ?? -1)" as NSString)
                        }
                        else {
                            
                            let imageString = result["poster_path"] as? String ?? ""
                            
                            let movie = Info(id: (result["id"] as! Int), image: (imageString ), title: (result["original_name"] as! String), releaseDate: (result["first_air_date"] as! String), overview: (result["overview"] as! String), popular: popular, topRated: topRated, upcoming: upcoming, type: self.type)
                            
                            self.movies.append(movie)
                            
                            let cacheInfo = Cache()
                            cacheInfo.cacheInfo = movie
                            ViewController2.cacher.setObject(cacheInfo, forKey: "\(movie.id ?? -1)" as NSString)
                        }
                    }
                    
                    self.tableView.reloadData()
                }
                catch {
                    print("JSON Error")
                    return
                }
            }
            }.resume()
    }
    
    // load cached info of movies or tv shows
    private func loadCachedInfo() {
        
        if let all =  ViewController2.cacher.value(forKey: "allObjects") as? NSArray {
            
            for object in all {
                
                let cachedObject = object as! Cache
                let cachedInfo = cachedObject.cacheInfo as Info
                
                if(category == Category.POPULAR.rawValue && cachedInfo.popular == true && cachedInfo.type == type) {
                    let movie = Info(id: cachedInfo.id!, image: cachedInfo.image!, title: cachedInfo.title!, releaseDate: cachedInfo.releaseDate!, overview: cachedInfo.overview!, popular: cachedInfo.popular!, topRated: cachedInfo.topRated!, upcoming: cachedInfo.upcoming!, type: type)
                    movies.append(movie)
                }
                else if(category == Category.TOP_RATED.rawValue && cachedInfo.topRated == true && cachedInfo.type == type) {
                    let movie = Info(id: cachedInfo.id!, image: cachedInfo.image!, title: cachedInfo.title!, releaseDate: cachedInfo.releaseDate!, overview: cachedInfo.overview!, popular: cachedInfo.popular!, topRated: cachedInfo.topRated!, upcoming: cachedInfo.upcoming!, type: type)
                    movies.append(movie)
                }
                else if(category == Category.UPCOMING.rawValue && cachedInfo.upcoming == true && cachedInfo.type == type) {
                    let movie = Info(id:  cachedInfo.id!, image: cachedInfo.image!, title: cachedInfo.title!, releaseDate: cachedInfo.releaseDate!, overview: cachedInfo.overview!, popular: cachedInfo.popular!, topRated: cachedInfo.topRated!, upcoming: cachedInfo.upcoming!, type: type)
                    movies.append(movie)
                }
                
                tableView.reloadData()
            }
        }
    }
    
}
*/
