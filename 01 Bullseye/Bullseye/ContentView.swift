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
   @State var sliderValue: Double = 50.0
   
   
   // User interface content and layout
   var body: some View {
      
      VStack {
         Spacer()
         // Target row
         HStack {
            Text("Put the bullseye as close as you can to:")
            Text("100")
         }
         
         Spacer()
         
         // Slider row
         HStack {
            Text("1")
            Slider(value: self.$sliderValue, in: 1...100)
            Text("100")
         }
         
           Spacer()
         
         // Button row
         Button(action: {
            print("Button pressed!")
            self.alertIsVisible = true
         }) {
            Text("Hit me!")
         }
         .alert(isPresented: self.$alertIsVisible) {
            Alert(title: Text("Hello there!"),
                  message: Text("The slider's value is\(Int(sliderValue.rounded()))."),
                  dismissButton: .default(Text("Awesome!")))
         }
         
           Spacer()
         
         // Score row
         HStack {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
               Text("Start over")
            }
            Spacer()
            Text("Score:")
            Text("999999")
            Spacer()
            Text("Round:")
            Text("999")
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
               Text("Info")
            }
         }
         .padding(.bottom, 20)
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
