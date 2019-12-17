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
               Group {
                  Text("Walk the dog")
                  Text("Brush my teeth")
                  Text("Learn iOS development")
                  Text("Make dinner")
                  Text("Do laundry")
                  Text("Pay bills")
               }
               Group {
                  Text("Finish homework")
                  Text("Change internet provider")
                  Text("Read Raywenderlich.com")
                  Text("Clean the kitchen")
                  Text("Wash the car")
               }
            }
            Section(header: Text("Low priority")) {
               Text("Soccer practice")
               Text("Eat ice cream")
               Text("Take vocal lessons")
               Text("Record hit single")
               Text("Learn every martial art")
               Text("Design costume")
               Text("Design crime-fighting vehicle")
               Text("Come up with superhero name")
               Text("Befriend space raccoon")
               Text("Save the world")
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
