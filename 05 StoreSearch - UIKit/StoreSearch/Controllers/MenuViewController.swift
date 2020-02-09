//
//  MenuViewController.swift
//  StoreSearch
//
//  Created by Rami on 2/8/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit
// MARK: - Protocols
protocol MenuViewControllerDelegate: class {
   func MenuViewControllerSendEmail(_ controller: MenuViewController)
}

class MenuViewController: UITableViewController {
   weak var delegate: MenuViewControllerDelegate?
   
   // MARK: - TableView Delegates
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if indexPath.row == 0 {
         delegate?.MenuViewControllerSendEmail(self)
      }
   }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
}
