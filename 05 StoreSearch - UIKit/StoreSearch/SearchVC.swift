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
      print("The search text is: '\(searchBar.text!)'")
   }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
   
}


class SearchVC: UIViewController {
   
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
