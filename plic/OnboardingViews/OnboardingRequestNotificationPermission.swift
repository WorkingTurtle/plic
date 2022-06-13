//
//  OnboardingRequestNotificationPermission.swift
//  plic
//
//  Created by 이영준 on 2022/06/13.
//

import SwiftUI
import CloudKit

class OnboardingRequestNotificationPermissionViewModel: ObservableObject {
    
    func requestNotificationPermission() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if success {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
}


struct OnboardingRequestNotificationPermission: View {
    @StateObject var vm = OnboardingRequestNotificationPermissionViewModel()
    @State private var isRequestDone = false
    
    var body: some View {
        ZStack{
            Image("onboardingBackgroundImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea(.all)
            
            NavigationLink(destination: OnboardingUsernameView(), isActive: $isRequestDone) { EmptyView() }
                .disabled(true)
        }
        .onAppear{
            self.vm.requestNotificationPermission()
            isRequestDone = true
        }
    }
}

struct OnboardingRequestNotificationPermission_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingRequestNotificationPermission()
    }
}
