//
//  QuoteViewModel.swift
//  QuoteOfTheDayWidgetAdv
//
//  Created by Keyhan Mortezaeifar on 22/11/2023.
//

import Foundation

class QuoteViewModel: ObservableObject {
    @Published var currentQuote: Quote?

    func loadQuoteForDay(_ day: Int) {
        let quotes = QuoteProvider.loadQuotes()

        // Ensure the quotes array is not empty
        guard !quotes.isEmpty else {
            print("Quotes array is empty.")
            return
        }

        let quoteIndex = (day - 1) % quotes.count
        currentQuote = quotes[quoteIndex]
    }
}
