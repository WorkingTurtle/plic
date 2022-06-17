//
//  plicApp.swift
//  plic
//
//  Created by 이주화 on 2022/06/08.
//

import SwiftUI


@main
struct plicApp: App {
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    @StateObject private var coupleViewModel = CoupleViewModel()
    
    let persistenceController = PersistenceController.shared
    
    
    var body: some Scene {
        WindowGroup {
//            TapBarMainView(tabbarIndex: 0)
//            OnboardingStartShareUser()
            OnboardingStartView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(coupleViewModel)
        }
    }
}

