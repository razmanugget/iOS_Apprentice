//
//  ViewController.swift
//  StoreSearch
//
//  Created by Rami on 1/13/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit


// MARK: - Enums | Extensions | Protocol
extension SearchVC: UISearchBarDelegate {
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      if !searchBar.text!.isEmpty {
         // dismiss the keyboard
         searchBar.resignFirstResponder()
         isLoading = true
         tableView.reloadData()
         
         hasSearched = true
         searchResults = []
         
         let url = iTunesURL(searchText: searchBar.text!)
         let session = URLSession.shared
         let dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                       print("Failure! \(error.localizedDescription)")
                    } else if let httpResponse = response as? HTTPURLResponse,
                       httpResponse.statusCode == 200 {
                       print("Success! \(data!)")
                    } else {
                       print("Failure! \(response!)")
                    }
            
            
//            if let error = error {
//               print("Failure! \(error.localizedDescription)")
//            } else {
//               print("Current Success! \(response!)")
//            }
         })
         dataTask.resume()
      }
   }

   
   
   func position(for bar: UIBarPositioning) -> UIBarPosition {
      return .topAttached
   }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView,
                  numberOfRowsInSection section: Int)
      -> Int {
         if isLoading {
            return 1
         } else if !hasSearched {
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
         if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.loadingCell, for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
         } else if searchResults.count == 0 {
            return tableView.dequeueReusableCell(
               withIdentifier: TableView.CellIdentifiers.nothingFoundCell,
               for: indexPath)
         } else {
            let cell = tableView.dequeueReusableCell(
               withIdentifier: TableView.CellIdentifiers.searchResultCell,
               for: indexPath) as! SearchResultCell
            
            let searchResult = searchResults[indexPath.row]
            cell.nameLabel.text = searchResult.name
            if searchResult.artist.isEmpty {
               cell.artistNameLabel.text = "Unknown"
            } else {
               cell.artistNameLabel.text = String(format: "%@ (%@)",
                                                  searchResult.artist, searchResult.type)
            }
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
         if searchResults.count == 0 || isLoading {
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
   var isLoading = false
   
   
   struct TableView {
      struct CellIdentifiers {
         static let searchResultCell = "SearchResultCell"
         static let nothingFoundCell = "NothingFoundCell"
         static let loadingCell = "LoadingCell"
      }
   }
   
   @IBOutlet weak var searchBar: UISearchBar!
   @IBOutlet weak var tableView: UITableView!

   
   func parse(data: Data) -> [SearchResult] {
      do {
         let decoder = JSONDecoder()
         let result = try decoder.decode(ResultArray.self, from: data)
         return result.results
      } catch {
         print("JSON Error: \(error)")
         return []
      }
   }
   
   
   // MARK: - Helper Methods
   func iTunesURL(searchText: String) -> URL {
      let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
      let urlString = String(format: "https://itunes.apple.com/searchlol?term=%@&limit=200", encodedText)
      let url = URL(string: urlString)
      return url!
   }
   
   func showNetworkError() {
      let alert = UIAlertController(
         title: "Whoops...",
         message: "There was an error accessing the iTunes Store. Please try again.",
         preferredStyle: .alert)
      
      let action = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(action)
      present(alert, animated: true, completion: nil)
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
      cellNib = UINib(nibName: TableView.CellIdentifiers.loadingCell, bundle: nil)
      tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.loadingCell)
   }
   
}
