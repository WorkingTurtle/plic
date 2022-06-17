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
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    @StateObject private var coupleViewModel = CoupleViewModel()
    @StateObject private var dateData = DateData()

    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {

//          TapBarMainView(tabbarIndex: 0)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .environmentObject(dateData)
//            OnboardingStartShareUser()
//            OnboardingStartView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .environmentObject(coupleViewModel)
//             SplashView()
//                 .environmentObject(coupleViewModel)
            SplashView()
               .environment(\.managedObjectContext, persistenceController.container.viewContext)
               .environmentObject(dateData)
               .environmentObject(coupleViewModel)
        }
    }
}

