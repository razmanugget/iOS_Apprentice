//
//  PersistencyHelper.swift
//  Bullseye
//
//  Created by Rami on 12/29/19.
//  Copyright © 2019 Lyfebug. All rights reserved.
//

import Foundation

class PersistencyHelper {
   static func saveHighScores(_ items: [HighScoreItem]) {
      let encoder = PropertyListEncoder()
      do {
         let data = try encoder.encode(items)
         try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
      } catch {
         print("Error encoding item array: \(error.localizedDescription)")
      }
   }
   static func loadHighScores() -> [HighScoreItem] {
      var items = [HighScoreItem]()
      let path = dataFilePath()
      if let data = try? Data(contentsOf: path) {
         let decoder = PropertyListDecoder()
         do {
            items = try decoder.decode([HighScoreItem].self, from: data)
         } catch {
            print("Error decoding item array: \(error.localizedDescription)")
         }
      }
      return items
   }
   static func dataFilePath() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      return paths[0].appendingPathComponent("HighScores.plist")
   }
}
