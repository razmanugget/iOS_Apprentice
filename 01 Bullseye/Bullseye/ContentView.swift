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
   var sliderTargetDifference: Int {
      abs(self.sliderValueRounded - self.target)
   }
   
   // User interface views
   @State var alertIsVisible = false
   @State var sliderValue = 50.0
   @State var target = Int.random(in: 1...100)
   @State var score = 0
   @State var round = 1
   
   // computed
   var sliderValueRounded: Int {
      Int(self.sliderValue.rounded())
   }
   
   // User interface content and layout
   var body: some View {
      
      VStack {
         Spacer()
         // Target row
         HStack {
            Text("Put the bullseye as close as you can to:")
            Text("\(self.target)")
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
            self.alertIsVisible = true
         }) {
            Text("Hit me!")
         }
         .alert(isPresented: self.$alertIsVisible) {
            Alert(title: Text(alertTitle()),
                  message: Text(scoringMessage()),
                  dismissButton: .default(Text("Awesome!")) {
                     self.startNewRound()
               })
         }
         
         Spacer()
         
         // Score row
         HStack {
            Button(action: {
               self.startNewGame()
            }) {
               Text("Start over")
            }
            Spacer()
            Text("Score:")
            Text("\(self.score)")
            Spacer()
            Text("Round:")
            Text("\(self.round)")
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
               Text("Info")
            }
         }
         .padding(.bottom, 20)
      }
   }
   
   // Methods
   func pointsForCurrentRound() -> Int {
      let maximumScore = 100
      let points: Int
      
      if sliderTargetDifference == 0 {
         points = 200
      } else if sliderTargetDifference == 1 {
         points = 150
      } else {
         points = maximumScore - sliderTargetDifference
      }
      return points
   }
   
   func scoringMessage() -> String {
      return "The slider's value is \(sliderValueRounded).\n" +
      "The target value is \(target).\n" +
      "You scored \(self.pointsForCurrentRound()) points this round."
   }
   
   func alertTitle() -> String {
      let title: String
      if self.sliderTargetDifference == 0 {
         title = "Perfect!"
      } else if self.sliderTargetDifference < 5 {
         title = "You almost had it!"
      } else if self.sliderTargetDifference <= 10 {
         title = "Not bad."
      } else {
         title = "Are you even trying?"
      }
      return title
   }
   
   func startNewGame() {
      self.score = 0
      self.round = 1
      resetSliderAndTarget()
   }
   
   func startNewRound() {
      self.score = self.score + self.pointsForCurrentRound()
      self.round = self.round + 1
      resetSliderAndTarget()
   }
   
   func resetSliderAndTarget() {
      self.sliderValue = 50.0
      self.target = Int.random(in: 1...100)
   }
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
