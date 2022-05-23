//
//  Emojis.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 23/5/2022.
//

import Foundation

struct Emojis {
    let category: String
    let list: [String]
    
    //TODO: add init with this func
    init(category: String, list: [String] ){
        self.category = category
        self.list = list
    }
    
    static func toList(range: ClosedRange<Int>) -> [String]{
        var list: [String] = []
        for i in range {
            guard let scalar = UnicodeScalar(i) else { continue }
            let c = String(scalar)
            list.append(c)
        }
        return list
    }
    
}
