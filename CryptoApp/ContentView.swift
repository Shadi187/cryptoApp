//
//  ContentView.swift
//  CryptoApp
//
//  Created by boshFbt on 23/07/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            
            VStack{
                Text("AccentColor")
                    .foregroundColor(Color.theme.accent)
                Text("Secondary Text Color")
                    .foregroundColor(Color.theme.secondaryText)
                Text("Red Color")
                    .foregroundColor(Color.theme.red)
                Text("Green Color")
                    .foregroundColor(Color.theme.green)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
