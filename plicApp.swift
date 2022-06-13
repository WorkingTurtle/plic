//
//  plicApp.swift
//  plic
//
//  Created by 이주화 on 2022/06/08.
//

import SwiftUI

@main
struct plicApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            EditingPlanView()
        }
    }
}
