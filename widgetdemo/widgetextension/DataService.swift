//
//  DataService.swift
//  widgetextensionExtension
//
//  Created by melih can durmaz on 30.03.2024.
//

import Foundation
import SwiftUI

struct DataService {
    
    @AppStorage("streak", store: UserDefaults(suiteName: "group.com.stopmaz.widgetdemo")) 
    private var streak = 0
    
    func log() {
        streak += 1
    }
    
    func progress() -> Int {
        return streak
    }
    
}
