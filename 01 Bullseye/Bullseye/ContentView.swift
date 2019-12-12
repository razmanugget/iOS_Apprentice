//
//  ContentView.swift
//  Bullseye
//
//  Created by Rami on 12/10/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   // Properties
   
   // User interface views
   @State var alertIsVisible: Bool = false
   
   // User interface content and layout
   var body: some View {
      
      VStack {
         // Target row
         HStack {
            Text("Put the bullseye as close as you can to:")
            Text("100")
         }
         
         // Slider row
         HStack {
            Text("1")
            Slider(value: .constant(10))
            Text("100")
         }
         
         // Button row
         Button(action: {
            print("Button pressed!")
            self.alertIsVisible = true
         }) {
            Text("Hit me!")
         }
         .alert(isPresented: self.$alertIsVisible) {
            Alert(title: Text("Hello there!"),
                  message: Text("This is my first pop-up."),
                  dismissButton: .default(Text("Awesome!")))
         }
         
         // Score row
         HStack {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Text("Start over")
            }
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Text("Info")
            }
         }
      }
   }
   
   // Methods
   
}


// Preview
// =======

#if DEBUG
struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
#endif
