//
//  widgetextension.swift
//  widgetextension
//
//  Created by melih can durmaz on 30.03.2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    let data = DataService()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), streak: data.progress())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), streak: data.progress())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, streak: data.progress())
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let streak: Int
}

struct widgetextensionEntryView : View {
    var entry: Provider.Entry

    let data = DataService()
    
    var body: some View {
        ZStack {
            
            Circle()
                .stroke(.white.opacity(0.1), lineWidth: 20)
            
            let pct = Double(data.progress())/50.0
            
            Circle()
                .trim(from: 0, to: pct)
                .stroke(.pink, style: StrokeStyle(lineWidth: 20,
                                   lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(-90))
            
            VStack {
                
                
                Text(String(data.progress()))
                    .font(.title)
                    .foregroundStyle(.pink)
                    .bold()
                    
            }
            .foregroundStyle(.white)
            .fontDesign(.rounded)
        }
        .padding()
        .containerBackground(.white, for: .widget)
    }
}
//1
struct widgetextension: Widget {
    let kind: String = "widgetextension"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            widgetextensionEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemSmall])
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
    widgetextension()
} timeline: {
    SimpleEntry(date: .now, streak: 1)
    SimpleEntry(date: .now, streak: 4)
}
