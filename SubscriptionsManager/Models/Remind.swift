
import Foundation
import CoreData


struct Remind{
    var time: String
    var day: String
    var before: String
    
    //odd name :D
    var remindOnDayBefore: Int {
        let time = (Remind.allValues.firstIndex(of: time) ?? 0) - 1
        return time
    }
    
    static let dayDefaultValue = "Day(s)"
    static let beforeDefaultValue = "before"
    static let timeDefaultValue = "Same"
    
    static var allValues: [String] {
        ["Never", "Same", "1", "2", "3", "4", "5", "6","7"]
    }

}
