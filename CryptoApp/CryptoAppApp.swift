//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by boshFbt on 23/07/2023.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
               HomeView()
                    .navigationBarHidden(true)
                    
            }.environmentObject(vm)
        }
    }
}
