//
//  OnboardingStartShareUser.swift
//  plic
//
//  Created by 이영준 on 2022/06/15.
//

import SwiftUI
import CloudKit

// TODO: 사용자가 <링크 보내기> 선택하고 sheet가 올라올 경우 1) 그냥 sheet 를 끌 경우 ->
// 메시지를 보냈을 때 사용자가 추가된 경우를 저장하는 state 변수를 만들 수 있나? -> 이거 하면 <링크 보내기> 버튼 disable 가능

struct OnboardingStartShareUser: View {
    @EnvironmentObject var viewModel: CoupleViewModel
    
    @State private var isSharing = false
    @State private var isSendingButtonClicked = false
    
    @State private var controller: UICloudSharingController?
    @State private var isPartner = false
    
    @State private var isStartButtonClicked = false
    
//    init(){
//         viewModel.fetchSchedules {
//             print("Successfully Fetched!")
//        }
//    }
    
    func getView() -> ProxyCloudSharingView? {
        if controller != nil {
            return ProxyCloudSharingView(controller: controller!)
        }  else {
            return nil
        }
    }
    
    var body: some View {
        ZStack{
            Image("onboardingBackgroundImage2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center){
                
                Spacer()
                
                Image("loveletter")
                    .resizable()
                    .frame(width: 88, height: 88)
                
                Spacer().frame(height: 21)

                Text("연인에게 공유를 시작해주세요")
                    .font(Font.custom("SpoqaHanSansNeo-Bold", size: 25))

                Spacer().frame(height: 40)
                
                Button(action: {
                    Task {
                        controller = await viewModel.addShare()
                        print(controller?.share)
                        isSharing = true
                    }
                    isSendingButtonClicked = true
                }) {
                    Text("링크 보내기")
                        .font(Font.custom("SpoqaHanSansNeo-Bold", size: 18))
                        .foregroundColor(Color("plicPink"))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white))
                        .padding(.horizontal, 20)
                }.sheet(isPresented: $isSharing){
                    self.getView()
                }
                
                Spacer().frame(height: 18)

                VStack(alignment: .leading, spacing: 0){
                    RecycleSubtitleTextOnly(subtitleText: "주의사항")
                    Spacer().frame(height: 10)
                    RecycleSubtitleTextOnly(subtitleText: "1. PLIC 어플리케이션을 먼저 시작한 사용자가 상대 연인에게 링크\n     를 보내주어야 합니다.")
                    Spacer().frame(height: 5)
                    RecycleSubtitleTextOnly(subtitleText: "2. 링크를 받은 상대 연인이 위 링크를 통해 어플리케이션을 실행시\n    키면 연결이 정상적으로 동작합니다.")
                }
                
                Spacer()
                
                NavigationLink(destination: TapBarMainView(tabbarIndex: 0), isActive: $isStartButtonClicked){ self.startButton() }

            }
            .onAppear() {
                viewModel.fetchSchedules {
                    print("Successfully Fetched!")
               }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
    
    @ViewBuilder
    func startButton() -> some View {
        if viewModel.isReady && viewModel.share?.participants.count == 2 || viewModel.root != nil {
            Button(action: {
                print("buttonclick")
                isStartButtonClicked = true
            }) {
                Text("Plic 시작하기")
                    .font(Font.custom("SpoqaHanSansNeo-Bold", size: 18))
                    .foregroundColor(Color("plicPink"))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white))
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 62)
            
        } else {
            Button(action: {}) {
                Text("Plic 시작하기")
                    .font(Font.custom("SpoqaHanSansNeo-Bold", size: 18))
                    .foregroundColor(Color("plicLightgrey"))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white))
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 62)
        }
    }
}

struct OnboardingStartShareUser_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStartShareUser()
    }
}
