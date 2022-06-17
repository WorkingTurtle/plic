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
    
    let persistenceController = PersistenceController.shared
    

    @ViewBuilder
    var body: some View {
        if coupleViewModel.loadCnt < 2 {
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
            .onAppear() {
                coupleViewModel.fetchSchedules() {
                }
            }
        } else {
            if coupleViewModel.isReady && coupleViewModel.share?.participants.count == 2 || coupleViewModel.root != nil {
                TapBarMainView(tabbarIndex: 0)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(dateData)
            } else {
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
