//
//  CompanyServices.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 19/4/2022.
//

import Foundation

struct Expense{
    let name: String
    let logo: String
    let category: String
}

class ExpenseService{
    static let shared = ExpenseService()
    func getAllExpenses() -> [Expense]{
        // TODO: Move to Cloud Kit?
        return [
            Expense(name: "Apple Music", logo: "AppleMusic", category: "Music"),
            Expense(name: "Apple TV+", logo: "AppleTVPlus", category: "Entertainment"),
            Expense(name: "Spotify", logo: "Spotify", category: "Music"),
            Expense(name: "Netflix", logo: "Netflix", category: "Entertainment"),
            Expense(name: "Stan", logo: "Stan", category: "Entertainment"),
            Expense(name: "Disney+", logo: "DisneyPlus", category: "Entertainment"),
            Expense(name: "Youtube Preminum", logo: "Youtube", category: "Entertainment"),
            Expense(name: "Amazon Prime", logo: "AmazonPrime", category: "Entertainment"),
            Expense(name: "HBO", logo: "HBO", category: "Entertainment"),
            Expense(name: "Hulu", logo: "Hulu", category: "Entertainment"),
            Expense(name: "Xbox", logo: "Xbox", category: "Entertainment"),
            Expense(name: "Twitch", logo: "Twitch", category: "Entertainment"),
            Expense(name: "Apple Developer Program", logo: "Apple", category: "Productivity"),
            Expense(name: "Dropbox", logo: "Dropbox", category: "Productivity"),
            Expense(name: "iCloud", logo: "iCloud", category: "Productivity"),
            Expense(name: "Google Cloud", logo: "GoogleCloud", category: "Productivity"),
            Expense(name: "Github", logo: "Github", category: "Productivity"),
            Expense(name: "Microsoft Office", logo: "MicrosoftOffice", category: "Productivity"),
            Expense(name: "Microsoft Azure", logo: "MicrosoftAzure", category: "Productivity"),
            Expense(name: "Microsoft OneDrive", logo: "MicrosoftOneDrive", category: "Productivity"),
            Expense(name: "Adobe Creative Cloud", logo: "AdobeCreativeCloud", category: "Productivity"),
            Expense(name: "Figma", logo: "Figma", category: "Productivity"),
            Expense(name: "Sketch", logo: "Sketch", category: "Productivity"),
            Expense(name: "GoDaddy", logo: "GoDaddy", category: "Productivity"),
            Expense(name: "Pluralsight", logo: "Pluralsight", category: "Education"),
            Expense(name: "Skillshare", logo: "Skillshare", category: "Education"),
            Expense(name: "AT&T", logo: "AT&T", category: "Utilities"),
            Expense(name: "T-Mobile", logo: "TMobile", category: "Utilities"),
            Expense(name: "Optus", logo: "Optus", category: "Utilities"),
            Expense(name: "Telstra", logo: "Telstra", category: "Utilities"),
            Expense(name: "Vodafone", logo: "Vodafone", category: "Utilities"),
        ]
    }
}
