//
//  SearchResult.swift
//  StoreSearch
//
//  Created by Rami on 1/14/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import Foundation

class ResultArray: Codable {
   var resultCount = 0
   var results = [SearchResult]()
}

class SearchResult: Codable, CustomStringConvertible {
   var artistName: String? = ""
   var trackName: String? = ""
   var kind: String? = ""
   var trackPrice: Double? = 0.0
   var currency = ""
   
   var imageSmall = ""
   var imageLarge = ""
   var storeURL: String? = ""
   var genre = ""
   
   var name: String {
      return trackName ?? ""
   }
   var description: String {
      return "Kind: \(kind ?? "None"), Name:\(name), Artist Name: \(artistName ?? "None"), Genre: \(genre)"
   }
   
   enum CodingKeys: String, CodingKey {
      case imageSmall = "artworkUrl60"
      case imageLarge = "artworkUrl100"
      case storeURL = "trackViewUrl"
      case genre = "primaryGenreName"
      // these map as the same name
      case kind, artistName, trackName
      case trackPrice, currency
   }
}
