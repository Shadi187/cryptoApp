//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by boshFbt on 24/07/2023.
//

import SwiftUI



struct CoinImageView: View {
    @StateObject var vm:CoinImageViewModel
    init(coin:CoinModel){
        _vm = StateObject(wrappedValue:   CoinImageViewModel(coin:coin))
    }
    var body: some View {
        ZStack{
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if vm.isLoading {
                ProgressView()
            }else{
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}
