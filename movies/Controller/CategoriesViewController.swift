//
//  IntroViewController.swift
//  movies
//
//  Created by Esteban on 5/12/19.
//  Copyright © 2019 Esteban Ramirez. All rights reserved.
//

import UIKit

class CategoriesViewController: UITableViewController {
    
    let categories = [Category.POPULAR.rawValue,
                      Category.TOP_RATED.rawValue,
                      Category.UPCOMING.rawValue]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Categories"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return Type.TV_SHOWS.rawValue
        }
        return Type.MOVIES.rawValue
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController2 = MovieListViewController()
        
        if indexPath.section == 1 {
            viewController2.type = Type.TV_SHOWS.rawValue
        }
        else {
            viewController2.type = Type.MOVIES.rawValue
        }
       
        let row = tableView.indexPathForSelectedRow!.row
        switch row {
            case 0:
                viewController2.category = Category.POPULAR.rawValue
            case 1:
                viewController2.category = Category.TOP_RATED.rawValue
            case 2:
                viewController2.category = Category.UPCOMING.rawValue
            default:
                viewController2.category = Category.POPULAR.rawValue
        }
        navigationController?.pushViewController(viewController2, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }

}
