//
//  OnboardingStartView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI
import CloudKit
import Combine

// Check user iCloud
class iCloudStatusViewModel: ObservableObject {
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    var cancellables = Set<AnyCancellable>()

    init() {
        getiCloudStatus()
    }

    private func getiCloudStatus() {
        CloudkitUtility.getiCloudStatus()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] success in
                self?.isSignedInToiCloud = success
            }
            .store(in: &cancellables)
    }
}


struct OnboardingStartView: View {
    @StateObject private var vm = iCloudStatusViewModel()
    @State private var titleText = "iCloud 연결 확인하기"
    @State private var isCloudStatusClicked = false
    @State private var nextView = false
    
    var body: some View {
        NavigationView{
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
                    
                    Spacer()
                    
                    NavigationLink(destination: OnboardingUsernameView(), isActive: $nextView) { EmptyView() }
                        .disabled(true)
                    
                    Button(action: {
                        isCloudStatusClicked = true
                    }) {
                        Text("iCloud 계정 연결하기")
                            .font(Font.custom("SpoqaHanSansNeo-Bold", size: 18))
                            .foregroundColor(Color("plicPink"))
                            .underline()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white))
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 62)
                }
                .alert(isPresented: $isCloudStatusClicked){
                    self.vm.isSignedInToiCloud ?
                    Alert(title: Text("iCloud 연결"), message: Text("iCloud에 계정이 연결되어 있습니다."), dismissButton: .default(Text("확인"), action: { self.nextView = true })) :
                    Alert(title: Text("iCloud 연결"), message: Text("iCloud 계정이 연결되어 있지 않습니다."), dismissButton: .destructive(Text("확인"), action: { }))
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

struct OnboardingStartView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStartView()
    }
}
