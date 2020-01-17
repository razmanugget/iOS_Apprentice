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
      
      if !searchBar.text!.isEmpty {
         // dismiss the keyboard
         searchBar.resignFirstResponder()
         searchResults = []
         hasSearched = true
         
         let url = iTunesURL(searchText: searchBar.text!)
         print("URL: '\(url)'")
         
         tableView.reloadData()
      }
      
      //      if searchBar.text! != "justin bieber" {
      //         for i in 0...2 {
      //            let searchResult = SearchResult()
      //            searchResult.name = String(format: "Fake Result %d for", i)
      //            searchResult.artistName = searchBar.text!
      //            searchResults.append(searchResult)
      //         }
      //      }
      
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
         if searchResults.count == 0 {
            return tableView.dequeueReusableCell(
               withIdentifier: TableView.CellIdentifiers.nothingFoundCell,
               for: indexPath)
         } else {
            let cell = tableView.dequeueReusableCell(
               withIdentifier: TableView.CellIdentifiers.searchResultCell,
               for: indexPath) as! SearchResultCell
            
            let searchResult = searchResults[indexPath.row]
            cell.nameLabel.text = searchResult.name
            cell.artistNameLabel.text = searchResult.artistName
            return cell
         }
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
   // MARK: - Variables/Constants
   var searchResults = [SearchResult]()
   var hasSearched = false
   
   
   struct TableView {
      struct CellIdentifiers {
         static let searchResultCell = "SearchResultCell"
         static let nothingFoundCell = "NothingFoundCell"
      }
   }
   
   @IBOutlet weak var searchBar: UISearchBar!
   @IBOutlet weak var tableView: UITableView!
   
   
   
   // MARK: - Helper Methods
   func iTunesURL(searchText: String) -> URL {
      let urlString = String(format: "https://itunes.apple.com/search?term=%@", searchText)
      let url = URL(string: urlString)
      return url!
   }
   
   
   // MARK: - View Controller Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      
      searchBar.becomeFirstResponder()
      // allow for 20pt status bar, 44pt search bar
      tableView.contentInset = UIEdgeInsets(top: 64, left: 0,
                                            bottom: 0, right: 0)
      var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
      tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
      cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
      tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
   }
   
}
