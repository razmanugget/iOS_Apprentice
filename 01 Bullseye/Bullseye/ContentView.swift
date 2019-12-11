//
//  ContentView.swift
//  Bullseye
//
//  Created by Rami on 12/10/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   @State var alertIsVisible: Bool = false

   var body: some View {
      VStack {
         Text("hey there!!")
            .fontWeight(.semibold)
            .foregroundColor(.green)
         Button(action: {
            print("Button pressed!")
            self.alertIsVisible = true
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
