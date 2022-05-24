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
    let colorHex: String
    var isCustom: Bool = false
    
    static func RandomExpense() -> Expense {
        let list = Emojis.toList(range:  0x1F90C...0x1F9FF)
        let logo = list.randomElement() ?? ""
        return Expense(name: "", logo: logo, category: "Utilities", colorHex: "#1CE783", isCustom: true)
    }
}

class ExpenseService{
    static let shared = ExpenseService()
    func getAllExpenses() -> [Expense]{
        // TODO: Move to Cloud Kit?
        return [
            Expense(name: "Apple Music", logo: "AppleMusic", category: "Music", colorHex: "#FB435B"),
            Expense(name: "Apple TV+", logo: "AppleTVPlus", category: "Entertainment", colorHex: "#000000"),
            Expense(name: "Spotify", logo: "Spotify", category: "Music", colorHex: "#1ED760"),
            Expense(name: "Netflix", logo: "Netflix", category: "Entertainment", colorHex: "#E50913"),
            Expense(name: "Stan", logo: "Stan", category: "Entertainment", colorHex: "#0073FA"),
            Expense(name: "Disney+", logo: "DisneyPlus", category: "Entertainment", colorHex: "#0F48A2"),
            Expense(name: "Youtube Preminum", logo: "Youtube", category: "Entertainment", colorHex: "#F40000"),
            Expense(name: "Amazon Prime", logo: "AmazonPrime", category: "Entertainment", colorHex: "#00A8E1"),
            Expense(name: "HBO", logo: "HBO", category: "Entertainment", colorHex: "#050505"),
            Expense(name: "Hulu", logo: "Hulu", category: "Entertainment", colorHex: "#1CE783"),
            Expense(name: "Xbox", logo: "Xbox", category: "Entertainment", colorHex: "#107C10"),
            Expense(name: "Twitch", logo: "Twitch", category: "Entertainment", colorHex: "#6444A3"),
            Expense(name: "Apple Developer Program", logo: "Apple", category: "Productivity", colorHex: "#999999"),
            Expense(name: "Dropbox", logo: "Dropbox", category: "Productivity", colorHex: "#0061FE"),
            Expense(name: "iCloud", logo: "iCloud", category: "Productivity", colorHex: "#36A5F7"),
            Expense(name: "Google Cloud", logo: "GoogleCloud", category: "Productivity", colorHex: "#4285F4"),
            Expense(name: "Github", logo: "Github", category: "Productivity", colorHex: "#030303"),
            Expense(name: "Microsoft Office", logo: "MicrosoftOffice", category: "Productivity", colorHex: "#EB3C00"),
            Expense(name: "Microsoft Azure", logo: "MicrosoftAzure", category: "Productivity", colorHex: "#0F539C"),
            Expense(name: "Microsoft OneDrive", logo: "MicrosoftOneDrive", category: "Productivity", colorHex: "#0364B8"),
            Expense(name: "Adobe Creative Cloud", logo: "AdobeCreativeCloud", category: "Productivity", colorHex: "#FD1056"),
            Expense(name: "Figma", logo: "Figma", category: "Productivity", colorHex: "#2D2D37"),
            Expense(name: "Sketch", logo: "Sketch", category: "Productivity", colorHex: "#EA6C00"),
            Expense(name: "GoDaddy", logo: "GoDaddy", category: "Productivity", colorHex: "#1BDBDB"),
            Expense(name: "Pluralsight", logo: "Pluralsight", category: "Education", colorHex: "#EB206B"),
            Expense(name: "Skillshare", logo: "Skillshare", category: "Education", colorHex: "#000000"),
            Expense(name: "AT&T", logo: "AT&T", category: "Utilities", colorHex: "#009EDB"),
            Expense(name: "T-Mobile", logo: "TMobile", category: "Utilities", colorHex: "#E20074"),
            Expense(name: "Optus", logo: "Optus", category: "Utilities", colorHex: "#00A3AD"),
            Expense(name: "Telstra", logo: "Telstra", category: "Utilities", colorHex: "#004D9D"),
            Expense(name: "Vodafone", logo: "Vodafone", category: "Utilities", colorHex: "#F81600"),
        ]
    }
}
