

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
    
    private let monthToWeeks = 52/12
    private let yearToWeeks = 52
    private let yearToMonths = 12
    var weeksPeriod: Double {
        let weeks: Double
        switch(unit){
        case .week:
            weeks = 1
        case .month:
            weeks = 12/52
        case .year:
            weeks = 1/52
        }
        return weeks/Double(quantity)
    }
    
    var monthsPeriod: Double {
        let months: Double
        switch(unit){
        case .week:
            months = 52/12
        case .month:
            months = 1
        case .year:
            months = 1/12
        }
        return months/Double(quantity)
    }
    
    var yearsPeriod: Double {
        let years: Double
        switch(unit){
        case .week:
            years = 52/1
        case .month:
            years = 12/1
        case .year:
            years = 1
        }
        return years/Double(quantity)
    }
}

enum BillingCycleUnit: Int {
    case week
    case month
    case year
}
