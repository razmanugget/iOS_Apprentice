//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by Rami on 1/15/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
   
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var artistNameLabel: UILabel!
   @IBOutlet weak var artworkImageView: UIImageView!
   
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
}
