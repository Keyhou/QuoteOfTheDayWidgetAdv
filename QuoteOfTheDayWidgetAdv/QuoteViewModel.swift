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
        let quoteIndex = (day - 1) % quotes.count
        currentQuote = quotes[quoteIndex]
    }
}
