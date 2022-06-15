//
//  plicApp.swift
//  plic
//
//  Created by 이주화 on 2022/06/08.
//

import SwiftUI
import Foundation

@main
struct plicApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var dateData = DateData()
    
    var body: some Scene {
        WindowGroup {
            TapBarMainView(tabbarIndex: 0)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dateData)

        }
    }
}

