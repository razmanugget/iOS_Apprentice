//
//  ContentView.swift
//  Bullseye
//
//  Created by Rami on 12/10/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   var body: some View {
      VStack {
         Text("hey there!!")
            .fontWeight(.semibold)
            .foregroundColor(.green)
         Button(action: {
            print("Button pressed!")
         }) {
            Text("Hit me!")
         }
      }
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
