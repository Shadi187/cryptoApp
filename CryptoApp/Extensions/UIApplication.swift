//
//  UIApp.swift
//  CryptoApp
//
//  Created by boshFbt on 26/07/2023.
//

import Foundation
import SwiftUI

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for: nil)
    }
}
