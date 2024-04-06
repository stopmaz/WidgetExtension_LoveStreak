//
//  ContentView.swift
//  widgetdemo
//
//  Created by melih can durmaz on 30.03.2024.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
   @AppStorage("streak", store: UserDefaults(suiteName: "group.com.stopmaz.widgetdemo")) var streak = 0
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                ZStack {
                    
                    Circle()
                        .stroke(.white.opacity(0.1), lineWidth: 20)
                    
                    let pct = Double(streak)/50.0
                    
                    Circle()
                        .trim(from: 0, to: pct)
                        .stroke(.pink, style: StrokeStyle(lineWidth: 20,
                                           lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                    
                    VStack {
                        
                        Text("Love Streak")
                            .font(.largeTitle)
                        Text(String(streak))
                            .font(.system(size: 70))
                            .bold()
                            
                    }
                    .foregroundStyle(.white)
                    .fontDesign(.rounded)
                }
                .padding(.horizontal, 50)
                
                Spacer()
                
                Button(action: {
                    streak += 1
                    
                    // -> Manually reload the widget
                    WidgetCenter.shared.reloadTimelines(ofKind: "widgetextension")
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.pink)
                            .frame(height: 50)
                        Text("+1")
                            .foregroundStyle(.white)
                    }
                })
                .padding(.horizontal)
                
                Spacer()
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
