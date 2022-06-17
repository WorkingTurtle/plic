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
    
    var body: some View {
        ZStack{
            Image("onboardingBackgroundImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea(.all)
            
            VStack{
                Spacer()
                
                Image("plicLogoExample")
                    .resizable()
                    .frame(width: 290, height: 118)
                    .padding(.top, 70)
                    .padding(.bottom, 116)
                
                Spacer()
            }
        }
        .onAppear{
            self.vm.requestNotificationPermission()
        }
    }
}

struct OnboardingRequestNotificationPermission_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingRequestNotificationPermission()
    }
}
