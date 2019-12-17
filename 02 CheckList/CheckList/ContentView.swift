//
//  ContentView.swift
//  CheckList
//
//  Created by Rami on 12/17/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   var body: some View {
      NavigationView {
         List {
            Section(header: Text("High priority")) {
               Text("Walk the dog")
               Text("Brush my teeth")
               Text("Learn iOS development")
            }
            Section(header: Text("Low priority")) {
               Text("Soccer practice")
               Text("Eat ice cream")
            }
         }
         .listStyle(GroupedListStyle())
         .navigationBarTitle("Checklist")
      }
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
