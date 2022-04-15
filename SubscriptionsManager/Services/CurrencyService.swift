//
//  CurrencyService.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 15/4/2022.
//

import Foundation

class CurrencyService {
    static let shared = CurrencyService()
    
    func getAllCurrencies() -> [Currency]{
        let json = readLocalFile(forName: "Currencies")!
        return parse(jsonData: json)
    }
    
    private func parse(jsonData: Data) -> [Currency] {
        do {
            let currencyList = try JSONDecoder().decode([Currency].self,
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
