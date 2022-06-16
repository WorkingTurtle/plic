//
//  OnboardingDateOfBirth.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI

struct OnboardingDateOfBirth: View {
    @State private var isButtonClicked = false
    @State var dateOfBirth = Date()
    let titleText: String = "본인의 생년월일을\n입력해 주세요"
    let subtitleText: String = "커플 달력에 표시될 생일 날짜입니다"
    let buttonText: String = "다음 단계"
    
    //날짜 포맷 함수
    static let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    
    var body: some View {
        ZStack{
            Image("onboardingBackgroundImage2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea(.all)
            VStack(alignment: .leading, spacing: 0){
                
                Spacer()
                
                RecycleTitleText(titleText: titleText, subtitleText: subtitleText)
                
                VStack{
                    
                    RecycleDatePicker(date: $dateOfBirth)
                  
                    NavigationLink(destination: OnboardingFirstDayWeMet().navigationBarHidden(true), isActive: $isButtonClicked){ EmptyView() }

                        .disabled(true)
                    
                    Button(action: {
                        isButtonClicked.toggle()
                    }) {
                        Text("\(buttonText)")
                            .font(Font.custom("SpoqaHanSansNeo-Bold", size: 18))
                            .foregroundColor(Color("plicPink"))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white).cornerRadius(10))
                            .padding(.horizontal, 20)
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 23)
                }
                HStack(spacing: 12){
                    Spacer()
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color("plicLightgrey"))
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color("plicPink"))
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color("plicLightgrey"))
                    Spacer()
                }
                .padding(.bottom, 31)
            }
        }
        .navigationBarHidden(true)
    }
}

struct OnboardingDateOfBirth_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDateOfBirth()
    }
}
