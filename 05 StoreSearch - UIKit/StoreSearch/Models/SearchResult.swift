//
//  SearchResult.swift
//  StoreSearch
//
//  Created by Rami on 1/14/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import Foundation

// MARK: - Global Function
// overriding < >
func < (lhs: SearchResult, rhs: SearchResult) -> Bool {
   return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}
func > (lhs: SearchResult, rhs: SearchResult) -> Bool {
   return lhs.name.localizedStandardCompare(rhs.name) == .orderedDescending
}

// MARK: - Classes
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
    
   var trackViewUrl: String?
   var collectionName: String?
   var collectionViewUrl: String?
   var collectionPrice: Double?
   var itemPrice: Double?
   var itemGenre: String?
   var bookGenre: [String]?
   
   enum CodingKeys: String, CodingKey {
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case itemGenre = "primaryGenreName"
        case bookGenre = "genres"
        case itemPrice = "price"
        
        // these map as the same name
        case kind, artistName, currency
        case trackName, trackPrice, trackViewUrl
        case collectionName, collectionViewUrl, collectionPrice
     }
   
   
   // MARK: - Computed Properties
   var name: String {
      return trackName ?? collectionName ?? ""
   }
   var description: String {
      return "Kind: \(kind ?? "None"), Name:\(name), Artist Name: \(artistName ?? "None"), Genre: \(genre)"
   }
   var storeURL: String {
      return trackViewUrl ?? collectionViewUrl ?? ""
   }
   var price: Double {
      return trackPrice ?? collectionPrice ?? itemPrice ?? 0.0
   }
   var genre: String {
      if let genre = itemGenre {
         return genre
      } else if let genres = bookGenre {
         return genres.joined(separator: ",")
      }
      return ""
   }
   var type: String {
      let kind = self.kind ?? "audiobook"
      switch kind {
      case "album": return NSLocalizedString("Album",
                                             comment: "Localized kind: Album")
      case "audiobook": return NSLocalizedString("Audio Book",
                                                 comment: "Localized kind: Audio Book")
      case "book": return NSLocalizedString("Book",
                                            comment: "Localized kind: Book")
      case "ebook": return NSLocalizedString("E-Book",
                                             comment: "Localized kind: E-Book")
      case "feature-movie": return NSLocalizedString("Movie",
                                                     comment: "Localized kind: Feature Movie")
      case "music-video": return NSLocalizedString("Music Video",
                                                   comment: "Localized kind: Music Video")
      case "podcast": return NSLocalizedString("Podcast",
                                               comment: "Localized kind: Podcast")
      case "software": return NSLocalizedString("App",
                                                comment: "Localized kind: Software")
      case "song": return NSLocalizedString("Song",
                                            comment: "Localized kind: Song")
      case "tv-episode": return NSLocalizedString("TV Episode",
                                                  comment: "Localized kind: TV Episode")
      default: break
      }
      return kind
   }
   var artist: String {
      return artistName ?? ""
   }
  
}
