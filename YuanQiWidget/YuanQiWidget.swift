//
//  YuanQiWidget.swift
//  YuanQiWidget
//
//  Created by xuyanlan on 2022/7/2.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct YuanQiWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    var body: some View {
        let dateComos:DateComponents = Calendar.current.dateComponents([.hour, .minute], from: entry.date)
        switch family {
        case .systemSmall:
            ZStack(alignment: .center) {
//                Image(dateComos.second! % 2 == 0 ? "robot_tang" : "robot_xi").resizable().aspectRatio(contentMode: .fit)
                let content: String  = String(dateComos.hour ?? 0) + ":" + String(dateComos.minute ?? 0) + ":" + String(dateComos.second ?? 0)
                Text(content).foregroundColor(.white).font(.system(size: 20, weight: .bold)).frame(width: 120, height: 40, alignment: Alignment.topLeading)
//                let contentName = String("欢迎：") + (entry.configuration.testName ?? "")
//                Text(contentName).frame(width: 150, height: 100, alignment: Alignment.bottomLeading).foregroundColor(.white).font(.system(size: 20, weight: .black))
                Text(entry.date, style: .time)
            }
        case .systemMedium:
            
            Text(entry.date, style: .time)
        case .systemLarge:
            
            Text(entry.date, style: .time)
            
        default:
            
            Text(entry.date, style: .time)
        }
        
    }
}

@main
struct YuanQiWidget: Widget {
    let kind: String = "YuanQiWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            YuanQiWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct YuanQiWidget_Previews: PreviewProvider {
    static var previews: some View {
        YuanQiWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        YuanQiWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        YuanQiWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        
    }
}
