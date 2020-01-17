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
   
   var name: String {
      return trackName ?? ""
   }
   var description: String {
      return "Name:\(name), Artist Name: \(artistName ?? "None")"
   }
}
