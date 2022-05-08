

import Foundation

struct BillingCycle {
    var quantity: Int
    var unit: BillingCycleUnit
    
    init(quantity: Int, unit: BillingCycleUnit){
        self.quantity = quantity
        self.unit = unit
    }
    
    var description: String {
        "\(quantity) \(unit)\(quantity>1 ? "s" : "")"
    }
}

enum BillingCycleUnit: Int {
    case week
    case month
    case year
}
