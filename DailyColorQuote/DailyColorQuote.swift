//
//  DailyColorQuote.swift
//  DailyColorQuote
//
//  Created by Keyhan Mortezaeifar on 22/11/2023.
//

//import WidgetKit
//import SwiftUI
//
//struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//            let currentDate = Date()
//            let currentDayIndex = Calendar.current.component(.weekday, from: currentDate) - 1
//
//            return SimpleEntry(date: currentDate, day: (1 + currentDayIndex) % 7 + 1)
//        }
//
//        func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//            let currentDate = Date()
//            let currentDayIndex = Calendar.current.component(.weekday, from: currentDate) - 1
//
//            let entry = SimpleEntry(date: currentDate, day: (1 + currentDayIndex) % 7 + 1)
//            completion(entry)
//        }
//    
//    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
//        var entries: [SimpleEntry] = []
//        
//        let currentDate = Date()
//        
//        // Calculate the day index based on the current day of the week
//        let calendar = Calendar.current
//        let currentDayIndex = calendar.component(.weekday, from: currentDate) - 1
//        
//        // Calculate the next 7 days
//        for day in 0..<7 {
//            let entryDate = calendar.date(byAdding: .day, value: (day + currentDayIndex) % 7, to: currentDate)!
//            
//            let entry = SimpleEntry(date: entryDate, day: (day + currentDayIndex) % 7 + 1)
//            entries.append(entry)
//        }
//        
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let day: Int
//}
//
//struct DailyColorQuoteEntryView : View {
//    var entry: Provider.Entry
//    
//    @StateObject private var quoteViewModel = QuoteViewModel()
//    
//    var body: some View {
//        ZStack {
//            ColorModel.colorForDay(entry.day)
////                .edgesIgnoringSafeArea(.all)
//                .padding(-16)
//                .containerBackground(for: .widget) {
//                    Color.clear
//                }
//                .overlay(
//                    VStack {
//                        Text(quoteViewModel.currentQuote?.quote ?? "Yo")
//                            .font(.title3)
//                            .foregroundColor(.white)
//                            .padding()
//                        
//                        Text("- \(quoteViewModel.currentQuote?.author ?? "Me")")
//                            .font(.caption)
//                            .foregroundColor(.white)
//                    }
//                )
//                .onAppear {
//                    // Load the quote for the current day when the ContentView appears
//                    quoteViewModel.loadQuoteForDay(Calendar.current.component(.weekday, from: Date()))
//                }
//        }
//    }
//}
//
//struct DailyColorQuote: Widget {
//    let kind: String = "DailyColorQuote"
//    
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
//            DailyColorQuoteEntryView(entry: entry)
//        }
//        .configurationDisplayName("Daily Color Quote")
//        .description("Change color every day.")
//    }
//}
//
//extension ConfigurationAppIntent {
//    fileprivate static var smiley: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "😀"
//        return intent
//    }
//    
//    fileprivate static var starEyes: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "🤩"
//        return intent
//    }
//}
//
//#Preview(as: .systemSmall) {
//    DailyColorQuote()
//} timeline: {
//    SimpleEntry(date: .now, day: 1)
//    SimpleEntry(date: .now, day: 2)
//    SimpleEntry(date: .now, day: 3)
//    SimpleEntry(date: .now, day: 4)
//    SimpleEntry(date: .now, day: 5)
//    SimpleEntry(date: .now, day: 6)
//    SimpleEntry(date: .now, day: 7)
//}


import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct DailyColorQuoteEntryView: View {
    var entry: Provider.Entry

    @StateObject private var quoteViewModel = QuoteViewModel()

    var body: some View {
        ZStack {
            Color.random
                .padding(-16)
                .containerBackground(for: .widget) {
                    Color.clear
                }
                .overlay(
                    VStack {
                        Text(quoteViewModel.currentQuote?.quote ?? "Loading Quote...")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()

                        Text("- \(quoteViewModel.currentQuote?.author ?? "Loading Author...")")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                )
                .onAppear {
                    // Load the quote for the current day when the ContentView appears
                    quoteViewModel.loadQuoteForDay(Calendar.current.component(.weekday, from: Date()))
                }
        }
    }
}

extension Color {
    static var random: Color {
        Color(red: Double.random(in: 0...1),
              green: Double.random(in: 0...1),
              blue: Double.random(in: 0...1))
    }
}

struct DailyColorQuote: Widget {
    let kind: String = "DailyColorQuote"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DailyColorQuoteEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Color Quote")
        .description("Change color and quote every day.")
    }
}

struct DailyColorQuote_Previews: PreviewProvider {
    static var previews: some View {
        DailyColorQuoteEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
