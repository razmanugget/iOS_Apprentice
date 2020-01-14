//
//  ViewController.swift
//  StoreSearch
//
//  Created by Rami on 1/13/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit


// MARK: - Enums | Extensions | Protoc
extension SearchVC: UISearchBarDelegate {
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      // dismiss the keyboard
      searchBar.resignFirstResponder()
      searchResults = []
      for i in 0...2 {
         searchResults.append(String(format: "Fake Result %d for '%@'", i, searchBar.text!))
      }
      tableView.reloadData()
   }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView,
                  numberOfRowsInSection section: Int)
      -> Int {
         return searchResults.count
   }
   func tableView(_ tableView: UITableView,
                  cellForRowAt indexPath: IndexPath)
      -> UITableViewCell {
         let cellIdentifier = "SearchResultCell"
         
         var cell: UITableViewCell! = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier)
         if cell == nil {
            cell = UITableViewCell(style: .default,
                                   reuseIdentifier: cellIdentifier)
         }
         cell.textLabel!.text = searchResults[indexPath.row]
         return cell
   }
}


class SearchVC: UIViewController {
   var searchResults = [String]()
   
   
   @IBOutlet weak var searchBar: UISearchBar!
   @IBOutlet weak var tableView: UITableView!
   
   
   // MARK: - View Controller Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      // allow for 20pt status bar, 44pt search bar
      tableView.contentInset = UIEdgeInsets(top: 64, left: 0,
                                            bottom: 0, right: 0)
   }
   
}
