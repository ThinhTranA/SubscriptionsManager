//
//  SortOrder.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 19/5/2022.
//

import Foundation
import UIKit


enum SortOrder {
    case AtoZ
    case ZtoA
    case PriceHighToLow
    case PriceLowToHigh
    
    var description : String {
        switch(self){
        case .AtoZ:
            return "Name A to Z"
        case .ZtoA:
            return "Name Z to A"
        case .PriceHighToLow:
            return "Price High to Low"
        case .PriceLowToHigh:
            return "Price Low to High"
        }
    }
    
    var icon: UIImage {
        switch(self){
        case .AtoZ:
            return .init(systemName: "a.circle")!
        case .ZtoA:
            return .init(systemName: "z.circle")!
        case .PriceHighToLow:
            return .init(systemName: "dollarsign.circle")!
        case .PriceLowToHigh:
            return .init(systemName: "dollarsign.circle.fill")!
        }
    }
    
    static var allValues: [SortOrder] {
        return [.PriceLowToHigh, .PriceHighToLow, .ZtoA, .AtoZ]
    }
}
