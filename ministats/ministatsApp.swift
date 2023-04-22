//
//  ministatsApp.swift
//  ministats
//
//  Created by Jan Rokita on 21/04/2023.
//

import SwiftUI
import Combine
import MachO
import ActivityKit


@main
struct ministatsApp: App {
    let observer = ActivityObserver()
    // get app version 
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0"
    @State private var text: String = "ministats"
    @State private var observerStarted: Bool = false
    
    
    var body: some Scene {
        MenuBarExtra(text) {
            Text("ministats v\(version)")
                .frame(width: 100, height: 50)
            Divider()
            
            if (!observerStarted) {
                Button("Start") {
                    observer.updatedStatisticsHandler = { observer in
                        let cpuUsage = String(Int(observer.cpuUsage.percentage))
                        let ramUsage = String(Int(observer.memoryPerformance.percentage))
                        
                        text = "CPU: \(cpuUsage)% • RAM: \(ramUsage)%"
                    };
                    
                    observer.start(interval: 3.0)
                    observerStarted = true
                }
                .keyboardShortcut("s")
            }
            
            Divider()
            Button("Quit") {
                observer.stop()
                observerStarted = false
                NSApplication.shared.terminate(self)
            }
            .keyboardShortcut("q")
        }
        .menuBarExtraStyle(.menu)
    }
}
