//
//  ContentView.swift
//  QuoteOfTheDayWidgetAdv
//
//  Created by Keyhan Mortezaeifar on 22/11/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var quoteViewModel = QuoteViewModel()

    var body: some View {
        VStack {
            Text("Today's Quote:")
                .font(.headline)
                .padding()

            Text(quoteViewModel.currentQuote?.quote ?? "")
                .font(.body)
                .padding()

            Text("- \(quoteViewModel.currentQuote?.author ?? "")")
                .font(.caption)
                .padding()

            Spacer()

            Button("Load Today's Quote") {
                // Manually trigger loading a quote for today
                quoteViewModel.loadQuoteForDay(Calendar.current.component(.weekday, from: Date()))
            }
            .padding()
        }
        .onAppear {
            // Load the quote for the current day when the ContentView appears
            quoteViewModel.loadQuoteForDay(Calendar.current.component(.weekday, from: Date()))
        }
    }
}

#Preview {
    ContentView()
}
