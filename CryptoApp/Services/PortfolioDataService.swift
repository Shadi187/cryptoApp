//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by boshFbt on 31/07/2023.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String  = "PortfolioContainer"
    private let entityName:String = "PortfolioEntitiy"
    
    @Published var savedEntities: [PortfolioEntitiy] = []
    
    init(){
        container = NSPersistentContainer(name:containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
        }
        self.getPortfolio()
    }
    
    // MARK: PUBLIC
    func updatePortfolio(coin:CoinModel, amount:Double){
        // check if coin is already in portfolio
        if let entity = savedEntities.first(where:{$0.coinId == coin.id}){
            if amount > 0 {
            update(entity: entity, amount: amount)
        }else {
            delete(entity: entity)
        }
        }
        else{
            add(coin: coin, amount: amount)
        }
            
    }
    
    
    // MARK: PRIVATE
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntitiy>(entityName: entityName)
        do{
           savedEntities =  try container.viewContext.fetch(request)
        } catch let error {
            print("ERROR FETCHING PORTFOLIO ENTITIES. \(error)")
        }
    }
    
    private func add(coin:CoinModel, amount:Double){
        let entity = PortfolioEntitiy(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity:PortfolioEntitiy, amount:Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity:PortfolioEntitiy){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save(){
        do{
            try container.viewContext.save()
        } catch let error {
            print("ERROR SAVING TO CORE DATA! \(error)")
        }
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
    
    
}
