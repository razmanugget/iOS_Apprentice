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
   
   // MARK: - Public Methods
   func configure(for result: SearchResult) {
      nameLabel.text = result.name
      
      if result.artist.isEmpty {
         artistNameLabel.text = "Unknown"
      } else {
         artistNameLabel.text = String(format: "%@ (%@)",
                                       result.artist, result.type)
      }
   }

   
   override func awakeFromNib() {
      super.awakeFromNib()
      let selectedView = UIView(frame: CGRect.zero)
      selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255,
                                             blue: 160/255, alpha: 0.5)
      selectedBackgroundView = selectedView
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
}
