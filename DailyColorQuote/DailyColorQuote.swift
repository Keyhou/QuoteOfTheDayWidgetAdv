//
//  DailyColorQuote.swift
//  DailyColorQuote
//
//  Created by Keyhan Mortezaeifar on 22/11/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), day: 1)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), day: 1)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Calculate the next 7 days
        for day in 1...7 {
            let currentDate = Calendar.current.date(byAdding: .day, value: day, to: Date()) ?? Date()
            let entry = SimpleEntry(date: currentDate, day: day)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let day: Int
}

struct DailyColorQuoteEntryView : View {
    var entry: Provider.Entry
    
    @StateObject private var quoteViewModel = QuoteViewModel()
    
    var body: some View {
        ZStack {
            ColorModel.colorForDay(entry.day)
                .edgesIgnoringSafeArea(.all)
                .containerBackground(for: .widget) {
                    Color.clear
                }
            Text("Quote:")
//            Text(entry.date, style: .time)
        }
    }
}

struct DailyColorQuote: Widget {
    let kind: String = "DailyColorQuote"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DailyColorQuoteEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Color Quote")
        .description("Change color every day.")
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    DailyColorQuote()
} timeline: {
    SimpleEntry(date: .now, day: 1)
    SimpleEntry(date: .now, day: 2)
    SimpleEntry(date: .now, day: 3)
    SimpleEntry(date: .now, day: 4)
    SimpleEntry(date: .now, day: 5)
    SimpleEntry(date: .now, day: 6)
    SimpleEntry(date: .now, day: 7)
}
