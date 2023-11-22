//
//  QuoteModel.swift
//  QuoteOfTheDayWidgetAdv
//
//  Created by Keyhan Mortezaeifar on 22/11/2023.
//

import Foundation

struct Quote: Codable {
    let quote: String
    let author: String
}

class QuoteProvider {
    static func loadQuotes() -> [Quote] {
        if let path = Bundle.main.path(forResource: "quotes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                return quotes
            } catch {
                // Handle error (e.g., print an error message)
                print("Error loading quotes: \(error)")
            }
        }
        return []
    }
}
