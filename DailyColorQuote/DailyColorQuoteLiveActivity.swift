//
//  DailyColorQuoteLiveActivity.swift
//  DailyColorQuote
//
//  Created by Keyhan Mortezaeifar on 22/11/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DailyColorQuoteAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DailyColorQuoteLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DailyColorQuoteAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DailyColorQuoteAttributes {
    fileprivate static var preview: DailyColorQuoteAttributes {
        DailyColorQuoteAttributes(name: "World")
    }
}

extension DailyColorQuoteAttributes.ContentState {
    fileprivate static var smiley: DailyColorQuoteAttributes.ContentState {
        DailyColorQuoteAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DailyColorQuoteAttributes.ContentState {
         DailyColorQuoteAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DailyColorQuoteAttributes.preview) {
   DailyColorQuoteLiveActivity()
} contentStates: {
    DailyColorQuoteAttributes.ContentState.smiley
    DailyColorQuoteAttributes.ContentState.starEyes
}
