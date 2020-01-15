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
      hasSearched = true
      if searchBar.text! != "justin bieber" {
         for i in 0...2 {
            let searchResult = SearchResult()
            searchResult.name = String(format: "Fake Result %d for", i)
            searchResult.artistName = searchBar.text!
            searchResults.append(searchResult)
         }
      }
      tableView.reloadData()
   }
   func position(for bar: UIBarPositioning) -> UIBarPosition {
      return .topAttached
   }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView,
                  numberOfRowsInSection section: Int)
      -> Int {
         if !hasSearched {
            return 0
         } else if searchResults.count == 0 {
            return 1
         } else {
            return searchResults.count
         }
   }
   func tableView(_ tableView: UITableView,
                  cellForRowAt indexPath: IndexPath)
      -> UITableViewCell {
         let cellIdentifier = "SearchResultCell"
         
         var cell: UITableViewCell! = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier)
         if cell == nil {
            cell = UITableViewCell(style: .subtitle,
                                   reuseIdentifier: cellIdentifier)
         }
         if searchResults.count == 0 {
            cell.textLabel!.text = "(Nothing found)"
            cell.detailTextLabel!.text = ""
         } else {
            let searchResult = searchResults[indexPath.row]
            cell.textLabel!.text = searchResult.name
            cell.detailTextLabel!.text = searchResult.artistName
         }
         return cell
   }
   func tableView(_ tableView: UITableView,
                  didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
   }
   func tableView(_ tableView: UITableView,
                  willSelectRowAt indexPath: IndexPath)
      -> IndexPath? {
         if searchResults.count == 0 {
            return nil
         } else {
            return indexPath
         }
   }
}


class SearchVC: UIViewController {
   var searchResults = [SearchResult]()
   var hasSearched = false
   
   
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
