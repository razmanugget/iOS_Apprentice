//
//  Functions.swift
//  MyLocations
//
//  Created by Rami on 1/9/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import Foundation

let applicationDocumentsDirectory: URL = {
   let paths = FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask
   )
   return paths[0]
}()


func afterDelay(_ seconds: Double, run: @escaping () -> Void) {
   print("getting delayed")
   DispatchQueue.main.asyncAfter(deadline: .now() + seconds,
                                 execute: run)
}
