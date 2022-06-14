//
//  OnboardingUsernameView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI

struct OnboardingUsernameView: View {
    @State var userNickname: String = ""
    @State private var isButtonClicked = false
    let titleText: String = "사용할 이름 또는 애칭을 \n입력해 주세요"
    let subtitleText: String = "추후 사용자 설정 란에서 변경이 가능합니다"
    let buttonText: String = "다음 단계"
    
    
    var buttonIsValid: Bool {
        if userNickname.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("onboardingBackgroundImage2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 0){
                    
                    Spacer()
                    
                    RecycleTitleText(titleText: titleText, subtitleText: subtitleText)
                    
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
                    
                    NavigationLink(destination: OnboardingDateOfBirth(), isActive: $isButtonClicked){ EmptyView() }
                        .disabled(true)
                    
                    Button(action: {
                        isButtonClicked = true
                    }) {
                        Text("\(buttonText)")
                            .font(Font.custom("SpoqaHanSansNeo-Bold", size: 18))
                            .foregroundColor(buttonIsValid ? Color("plicPink") : Color("plicGrey"))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white).cornerRadius(10))
                            .padding(.horizontal, 20)
                    }
                    .disabled(!buttonIsValid)
                    .padding(.bottom, 23)
                    
                    
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
                        Spacer()
                    }
                    .padding(.bottom, 31)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

struct OnboardingUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingUsernameView()
    }
}
