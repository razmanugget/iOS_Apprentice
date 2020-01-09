//
//  Functions.swift
//  MyLocations
//
//  Created by Rami on 1/9/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import Foundation

func afterDelay(_ seconds: Double, run: @escaping () -> Void) {
   print("getting delayed")
   DispatchQueue.main.asyncAfter(deadline: .now() + seconds,
                                 execute: run)
}
