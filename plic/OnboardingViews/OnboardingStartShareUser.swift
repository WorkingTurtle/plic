//
//  OnboardingStartShareUser.swift
//  plic
//
//  Created by 이영준 on 2022/06/15.
//

import SwiftUI
import CloudKit

struct OnboardingStartShareUser: View {
    var viewModel: CoupleViewModel?
    @State private var controller: UICloudSharingController?
    
    init(){
        viewModel = CoupleViewModel()
        viewModel?.fetchSchedules {
            print("Successfully Fetched!")
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
                
                Spacer().frame(height: 228)
                
                Image("loveletter")
                    .resizable()
                    .frame(width: 88, height: 88)
                
                Spacer().frame(height: 21)

                Text("연인에게 공유를 시작해주세요")
                    .font(Font.custom("SpoqaHanSansNeo-Bold", size: 25))

                Spacer().frame(height: 40)
                
                Button(action: {

                }) {
                    Text("링크 보내기")
                        .font(Font.custom("SpoqaHanSansNeo-Bold", size: 18))
                        .foregroundColor(Color("plicPink"))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white))
                        .padding(.horizontal, 20)
                }
                
                Spacer().frame(height: 18)

                VStack(alignment: .leading, spacing: 0){
                    RecycleSubtitleTextOnly(subtitleText: "주의사항")
                    Spacer().frame(height: 10)
                    RecycleSubtitleTextOnly(subtitleText: "1. PLIC 어플리케이션을 먼저 시작한 사용자가 상대 연인에게 링크\n    를 보내주어야 합니다.")
                    Spacer().frame(height: 5)
                    RecycleSubtitleTextOnly(subtitleText: "2. 링크를 받은 상대 연인이 위 링크를 통해 어플리케이션을 실행시\n     키면 연결이 정상적으로 동작합니다.")
                }
                
                Spacer().frame(height: 135)

                Button(action: {
                    
                }) {
                    Text("PLIC 시작하기")
                        .font(Font.custom("SpoqaHanSansNeo-Bold", size: 18))
                        .foregroundColor(Color("plicPink"))
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
}

struct OnboardingStartShareUser_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStartShareUser()
    }
}
