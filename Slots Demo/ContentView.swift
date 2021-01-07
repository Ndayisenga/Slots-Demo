//
//  ContentView.swift
//  Slots Demo
//
//  Created by Jean Claude Ndayisenga on 03/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symbols = ["apple", "star", "cherry"]
    
    @State private var numbers = Array(repeating: 0, count: 9)
    
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    
    @State private var credits = 1000
    
    private var betAmount = 5
    
    var body: some View {
        
        ZStack {
            
            // Background
            Rectangle().foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Rectangle().foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255)).rotationEffect(Angle(degrees: 45)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                
                Spacer()
                
                //  Title
                HStack {
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    Text("SwiftUI slots").bold().foregroundColor(.white)
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }
                .scaleEffect(2)
                
                Spacer()
                
                // Credits Counter
                Text("Credits:  "   + String(credits)).foregroundColor(.black).padding(.all, 10).background(Color.white.opacity(0.5)).cornerRadius(20)
                Spacer()
                
                // Cards
                
                VStack {
                    HStack {
                        
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[0]], background: $backgrounds[0])
                        
                        CardView(symbol: $symbols[numbers[1]], background: $backgrounds[1])
                        
                        
                        CardView(symbol: $symbols[numbers[2]], background: $backgrounds[2])
                        
                        Spacer()
                        
                        
                    }
                    
                    HStack {
                        
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[3]], background: $backgrounds[3])
                        
                        CardView(symbol: $symbols[numbers[4]], background: $backgrounds[4])
                        
                        
                        CardView(symbol: $symbols[numbers[5]], background: $backgrounds[5])
                        
                        Spacer()
                        
                        
                    }
                    HStack {
                        
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[6]], background: $backgrounds[6])
                        
                        CardView(symbol: $symbols[numbers[7]], background: $backgrounds[7])
                        
                        
                        CardView(symbol: $symbols[numbers[8]], background: $backgrounds[8])
                        
                        Spacer()
                        
                        
                    }
                }
                
                Spacer()
                // Button
                
                HStack (spacing: 20) {
               
                    VStack {
                        
                        Button(action: {
                            //process a single spin
                            self.processResults()
                            
                        }) {
                            Text("spin").bold().foregroundColor(.white).padding(.all, 10).padding([.leading, .trailing], 30).background(Color.pink).cornerRadius(20)
                        
                       
                    }
                        Text("\(betAmount) credits ").padding(.top, 10).font(.footnote)
                        
                    }
                    
                    VStack {
                        
                        Button(action: {
                            //process a single spin
                            self.processResults(true)
                            
                        }) {
                            Text("Max spin").bold().foregroundColor(.white).padding(.all, 10).padding([.leading, .trailing], 30).background(Color.pink).cornerRadius(20)
                        
                       
                    }
                        Text("\(betAmount * 5) credits ").padding(.top, 10).font(.footnote)
                        
                    }
                }
                
                
                Spacer()
            }
            
            
        }
    }
    
    func processResults(_ isMax:Bool = false) {
       
        // set background back to white
        
        
        self.backgrounds = self.backgrounds.map({_ in Color.white
            
        })
      
        if isMax {
            
            //spin all the cards
            
            self.numbers = self.numbers.map({ _ in Int.random(in: 0...self.symbols.count - 1)
                
            })
        }
        else {
            //spin the middle row
          
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1)
            
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1)
            
        }
        
        
        
        
        //Check Winnings
        
        processWin(isMax)
        
    }
    
    
    func processWin(_ isMax:Bool = false)  {
          
        var matches = 0
        
        if !isMax {
            // processing for single spin
            
            if isMatch(3, 4, 5) {
                matches += 1 }
            
        }
        else {
            //processing for max spin
            //top row
            if isMatch(0, 1, 2) {
                matches += 1 }
            
            
            // middle row
            
            if isMatch(3, 4, 5)
            { matches += 1 }
            
            //bottom row
            
            if isMatch(6, 7, 8)
            { matches += 1 }
            
            //diagonal top left to bottom right
            if isMatch(0, 4, 8)
            {  matches += 1 }
               
            
            
            //diagonal top right to bottom left
            if isMatch(2, 4, 6)
            {  matches += 1 }
        }
        
        
        //check matches and distribute credits
        if matches > 0 {
           //at least 1 win
            self.credits += matches * betAmount * 2
        }
        else if !isMax {
            //0 wins , single spin
            
            self.credits -= betAmount
        }
        else {
            //0 wins , max spin
            self.credits -= betAmount * 5
        }
    }
    
    func isMatch(_ index1:Int, _ index2:Int, _ index3:Int) -> Bool {
        if self.numbers[index1] == self.numbers[index2] && self.numbers[index2] ==  self.numbers[index3] {
             
            self.backgrounds[index1] = Color.green
            
            self.backgrounds[index2] = Color.green
            
            self.backgrounds[index3] = Color.green
            
            return true
        }
        
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
