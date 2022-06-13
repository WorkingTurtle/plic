//
//  OnboardingUsernameView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI

struct OnboardingUsernameView: View {
    @State var userNickname: String = ""
    
    var body: some View {
        ZStack{
            Image("onboardingBackgroundImage2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 30){
                VStack(alignment: .leading, spacing: 15){
                    Text("사용할 이름 또는 애칭을 입력해 주세요")
                        .font(Font.custom("SpoqaHanSansNeo-Bold", size: 25))
                        .padding(EdgeInsets(top: 308, leading: 20, bottom: 0, trailing: 0))
                    Text("추후 사용자 설정 란에서 변경이 가능합니다")
                        .font(Font.custom("SpoqaHanSansNeo-Regular", size: 13))
                        .foregroundColor(Color("plicGrey"))
                        .padding(.leading, 20)
                }
                
                // 애칭 입력 텍스트필드
                TextField("본인의 애칭을 입력해 주세요", text: $userNickname)
                    .font(Font.custom("SpoqaHanSansNeo-Regular", size: 17))
                    .disableAutocorrection(true)
                // 텍스트 입력 시 지우기 (X) 버튼 나타나기
                    .modifier(TextFieldClearButton(scheduleNameText: $userNickname))
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 11, leading: 17, bottom: 11, trailing: 15))
                // 텍스트 값 입력되면 색상 변경
                    .foregroundColor((userNickname != "") ? .black : Color("plicGrey"))
                    .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white))
                    .padding(.horizontal, 20)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("다음 단계")
                        .font(Font.custom("SpoqaHanSansNeo-Bold", size: 18))
                        .foregroundColor(Color("plicPink"))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white).cornerRadius(10))
                        .padding(.horizontal, 20)
                }
                
                HStack(spacing: 12){
                    Spacer()
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color("plicPink"))
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color("plicLightgrey"))
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color("plicLightgrey"))
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color("plicLightgrey"))
                    Spacer()
                }
                .padding(.bottom, 31)
            }
        }
    }
}


struct OnboardingUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingUsernameView()
    }
}
