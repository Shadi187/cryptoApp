//
//  HomeView.swift
//  CryptoApp
//
//  Created by boshFbt on 23/07/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio:Bool = false // animate right
    @State private var showPortfolioView:Bool = false  // new sheet
    
    var body: some View {
        ZStack{
            // background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            
            //Content layer
            VStack{
                homeHeader
                HomeStatsView(showPortofolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitles
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio{
                    portofolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }.environmentObject(dev.homeVM)
        
    }
}

extension HomeView{
    private var homeHeader: some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate:$showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portofolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees:showPortfolio ? 180 : 0))
                .onTapGesture{
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }.padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List{
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin:coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }.listStyle(PlainListStyle())

    }
    
    private var portofolioCoinsList: some View {
        List{
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin:coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }.listStyle(PlainListStyle())

    }
    
    private var columnTitles: some View {
        HStack{
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            
            Button (action:{
                withAnimation(.linear(duration:2.0)){
                    vm.reloadData()
                }
            } , label: {
                Image(systemName: "goforward")
            }).rotationEffect(Angle(degrees:vm.isLoading ? 360 : 0), anchor: .center)

        
        }.font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal)

    }
}
