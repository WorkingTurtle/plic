//
//  SplashView.swift
//  plic
//
//  Created by 이영준 on 2022/06/17.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    @StateObject private var dateData = DateData()
    @State private var isRequestDone = false
    
    let persistenceController = PersistenceController.shared
    

    @ViewBuilder
    var body: some View {
        if coupleViewModel.loadCnt < 1 && !isRequestDone {
            OnboardingRequestNotificationPermission()
                .onAppear() {
                    coupleViewModel.fetchSchedules() {
                        isRequestDone = true
                    }
                }
        } else {
            if coupleViewModel.isReady && coupleViewModel.root?.object(forKey: "nicknamePartner") != nil {
                TapBarMainView(tabbarIndex: 0)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(dateData)
            }
            else if (coupleViewModel.isReady && coupleViewModel.share?.participants.count == 1 && coupleViewModel.root?.object(forKey: "nicknameOwner") != nil) {
                OnboardingStartShareUser()
            }
            else {
                OnboardingStartView()
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
