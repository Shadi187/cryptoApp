//
//  Color.swift
//  CryptoApp
//
//  Created by boshFbt on 23/07/2023.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = ColorTheme()
}


struct ColorTheme{
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}
