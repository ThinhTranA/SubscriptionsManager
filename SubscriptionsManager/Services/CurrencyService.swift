//
//  CurrencyService.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 15/4/2022.
//

import Foundation

class CurrencyService {
    static let shared = CurrencyService()
    
    func getCurrency(withCode code: String) -> Currency?{
        let allCur = getAllCurrencies()
        return allCur.first(where: {$0.code == code})
    }
    
    func getAllCurrencies() -> [Currency]{
        //
        let json = readLocalFile(forName: "Currencies")!
        let currencies: [Currency] = parse(jsonData: json)
        let currencyRankings = getCurrencyRankings()
        
        var currenciesWithRank = currencies.map{ cc -> Currency in
           let ccRank = currencyRankings.first(where: {$0.symbol == cc.code})
            var currency = cc
            currency.display = ccRank?.rank ?? 200
            
            let locale = Locale(identifier: currency.locale)
            currency.symbol = locale.currencySymbol 
            
            return currency
        }
        
        currenciesWithRank.sort{
            $0.display < $1.display
        }
        
        return currenciesWithRank
    }
    
    
    func getCurrencyRankings() -> [CurrencyRanking]{
        //Source: https://www.xe.com/popularity.php
        let jsonRanks = readLocalFile(forName: "CurrencyPopularityRankings")!
        let currencyRanks : [CurrencyRanking] = parse(jsonData: jsonRanks)
        return currencyRanks
    }
    
    private func parse<T>(jsonData: Data) -> [T] where T: Decodable {
        do {
            let currencyList = try JSONDecoder().decode([T].self,
                                                       from: jsonData)
            return currencyList
        
        } catch {
            print(error)
            print("decode error")
        }
        return []
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
