//
//  ViewController.swift
//  StoreSearch
//
//  Created by Rami on 1/13/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit
var dataTask: URLSessionDataTask?

// MARK: - Enums | Extensions | Protocol
extension SearchVC: UISearchBarDelegate {
   func performSearch() {
      if !searchBar.text!.isEmpty {
         // dismiss the keyboard
         searchBar.resignFirstResponder()
         dataTask?.cancel()
         isLoading = true
         tableView.reloadData()
         
         hasSearched = true
         searchResults = []
         
         let url = iTunesURL(searchText: searchBar.text!,
                             category: segmentedControl.selectedSegmentIndex)
         let session = URLSession.shared
         dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error as NSError?, error.code == -999 {
               return
            } else if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
               if let data = data {
                  self.searchResults = self.parse(data: data)
                  self.searchResults.sort(by: <)
                  // switching back to the main thread
                  DispatchQueue.main.async {
                     self.isLoading = false
                     self.tableView.reloadData()
                  }
                  return
               }
            } else {
               print("Failure! \(response!)")
            }
            DispatchQueue.main.async {
               self.hasSearched = false
               self.isLoading = false
               self.tableView.reloadData()
               self.showNetworkError()
            }
         })
         dataTask?.resume()
      }
   }
   
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      performSearch()
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
            
            cell.configure(for: searchResult)
            return cell
         }
   }
   
   func tableView(_ tableView: UITableView,
                  didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      performSegue(withIdentifier: "ShowDetail", sender: indexPath)
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
   var landscapeVC: LandscapeVC?
   
   @IBOutlet weak var segmentedControl: UISegmentedControl!
   @IBOutlet weak var searchBar: UISearchBar!
   @IBOutlet weak var tableView: UITableView!
   
   
   // MARK: - Actions
   @IBAction func segmentChanged(_ sender: UISegmentedControl) {
      performSearch()
   }
   
   struct TableView {
      struct CellIdentifiers {
         static let searchResultCell = "SearchResultCell"
         static let nothingFoundCell = "NothingFoundCell"
         static let loadingCell = "LoadingCell"
      }
   }
   
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
   func iTunesURL(searchText: String, category: Int) -> URL {
      let kind: String
      switch category {
      case 1: kind = "musicTrack"
      case 2: kind = "software"
      case 3: kind = "ebook"
      default: kind = ""
      }
      let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
      let urlString =  "https://itunes.apple.com/search?" + "term=\(encodedText)&limit=200&entity=\(kind)"
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
   
   func showLandscape(with coordinator: UIViewControllerTransitionCoordinator) {
      // check to make sure landscape isn't already enabled
      guard landscapeVC == nil else { return }
      // with no segue, must instantiate the VC manually
      landscapeVC = storyboard!.instantiateViewController(
         withIdentifier: "LandscapeVC") as? LandscapeVC
      if let controller = landscapeVC {
         // set the size / position of the new controller
         controller.view.frame = view.bounds
         // add the controller's view as a subview
         view.addSubview(controller.view)
         addChild(controller)
         // the new VC has a parent VC with didMove
         controller.didMove(toParent: self)
      }
   }
   
   func hideLandscape(with coordinator: UIViewControllerTransitionCoordinator) {
      
   }
   
   
   // MARK: - Navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowDetail" {
         let detailVC = segue.destination as! DetailVC
         let indexPath = sender as! IndexPath
         let searchResult = searchResults[indexPath.row]
         detailVC.searchResult = searchResult
      }
   }
   
   
   // MARK: - View Controller Life Cycle
   override func willTransition(
      to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
      super.willTransition(to: newCollection, with: coordinator)
      
      switch newCollection.verticalSizeClass {
      case .compact:
         showLandscape(with: coordinator)
      case .regular, .unspecified:
         hideLandscape(with: coordinator)
      @unknown default:
         fatalError()
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      searchBar.becomeFirstResponder()
      // allow for 20pt status bar, 44pt search bar
      tableView.contentInset = UIEdgeInsets(top: 108, left: 0,
                                            bottom: 0, right: 0)
      var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
      tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
      cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
      tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
      cellNib = UINib(nibName: TableView.CellIdentifiers.loadingCell, bundle: nil)
      tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.loadingCell)
      
      let segmentColor = UIColor(red: 10/255, green: 80/255, blue: 80/255, alpha: 1)
      let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
      let normalTextAttributes = [NSAttributedString.Key.foregroundColor: segmentColor]
      segmentedControl.selectedSegmentTintColor = segmentColor
      segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
      segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
      segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .highlighted)
   }
   
}
