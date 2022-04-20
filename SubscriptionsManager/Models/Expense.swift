//
//  CompanyServices.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 19/4/2022.
//

import Foundation
import UIKit

struct Expense{
    let name: String
    let logo: String
    let category: String
    let color: UIColor
}

class ExpenseService{
    static let shared = ExpenseService()
    func getAllExpenses() -> [Expense]{
        // TODO: Move to Cloud Kit?
        return [
            Expense(name: "Apple Music", logo: "AppleMusic", category: "Music", color: UIColor.init(hexaString: "#FB435B")),
            Expense(name: "Apple TV+", logo: "AppleTVPlus", category: "Entertainment", color: UIColor.init(hexaString: "#000000")),
            Expense(name: "Spotify", logo: "Spotify", category: "Music", color: UIColor.init(hexaString: "#1ED760")),
            Expense(name: "Netflix", logo: "Netflix", category: "Entertainment", color: UIColor.init(hexaString: "#E50913")),
            Expense(name: "Stan", logo: "Stan", category: "Entertainment", color: UIColor.init(hexaString: "#0073FA")),
            Expense(name: "Disney+", logo: "DisneyPlus", category: "Entertainment", color: UIColor.init(hexaString: "#0F48A2")),
            Expense(name: "Youtube Preminum", logo: "Youtube", category: "Entertainment", color: UIColor.init(hexaString: "#F40000")),
            Expense(name: "Amazon Prime", logo: "AmazonPrime", category: "Entertainment", color: UIColor.init(hexaString: "#00A8E1")),
            Expense(name: "HBO", logo: "HBO", category: "Entertainment", color: UIColor.init(hexaString: "#050505")),
            Expense(name: "Hulu", logo: "Hulu", category: "Entertainment", color: UIColor.init(hexaString: "#1CE783")),
            Expense(name: "Xbox", logo: "Xbox", category: "Entertainment", color: UIColor.init(hexaString: "#107C10")),
            Expense(name: "Twitch", logo: "Twitch", category: "Entertainment", color: UIColor.init(hexaString: "#6444A3")),
            Expense(name: "Apple Developer Program", logo: "Apple", category: "Productivity", color: UIColor.init(hexaString: "#999999")),
            Expense(name: "Dropbox", logo: "Dropbox", category: "Productivity", color: UIColor.init(hexaString: "#0061FE")),
            Expense(name: "iCloud", logo: "iCloud", category: "Productivity", color: UIColor.init(hexaString: "#36A5F7")),
            Expense(name: "Google Cloud", logo: "GoogleCloud", category: "Productivity", color: UIColor.init(hexaString: "#4285F4")),
            Expense(name: "Github", logo: "Github", category: "Productivity", color: UIColor.init(hexaString: "#030303")),
            Expense(name: "Microsoft Office", logo: "MicrosoftOffice", category: "Productivity", color: UIColor.init(hexaString: "#EB3C00")),
            Expense(name: "Microsoft Azure", logo: "MicrosoftAzure", category: "Productivity", color: UIColor.init(hexaString: "#0F539C")),
            Expense(name: "Microsoft OneDrive", logo: "MicrosoftOneDrive", category: "Productivity", color: UIColor.init(hexaString: "#0364B8")),
            Expense(name: "Adobe Creative Cloud", logo: "AdobeCreativeCloud", category: "Productivity", color: UIColor.init(hexaString: "#FD1056")),
            Expense(name: "Figma", logo: "Figma", category: "Productivity", color: UIColor.init(hexaString: "#2D2D37")),
            Expense(name: "Sketch", logo: "Sketch", category: "Productivity", color: UIColor.init(hexaString: "#EA6C00")),
            Expense(name: "GoDaddy", logo: "GoDaddy", category: "Productivity", color: UIColor.init(hexaString: "#1BDBDB")),
            Expense(name: "Pluralsight", logo: "Pluralsight", category: "Education", color: UIColor.init(hexaString: "#EB206B")),
            Expense(name: "Skillshare", logo: "Skillshare", category: "Education", color: UIColor.init(hexaString: "#000000")),
            Expense(name: "AT&T", logo: "AT&T", category: "Utilities", color: UIColor.init(hexaString: "#009EDB")),
            Expense(name: "T-Mobile", logo: "TMobile", category: "Utilities", color: UIColor.init(hexaString: "#E20074")),
            Expense(name: "Optus", logo: "Optus", category: "Utilities", color: UIColor.init(hexaString: "#00A3AD")),
            Expense(name: "Telstra", logo: "Telstra", category: "Utilities", color: UIColor.init(hexaString: "#004D9D")),
            Expense(name: "Vodafone", logo: "Vodafone", category: "Utilities", color: UIColor.init(hexaString: "#F81600")),
        ]
    }
}
