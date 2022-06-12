//
//  OnboardingStartView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI

struct OnboardingStartView: View {
    
    var body: some View {
        ZStack{
            Image("onboardingBackgroundImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea(.all)
            VStack{
                
                Spacer()
                
                //이미지 png Asset에 다시 받아서 변경 예정
                Image("plicLogoExample")
                    .resizable()
                    .frame(width: 290, height: 118)
                    .padding(.top, 70)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("시작하기")
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

struct OnboardingStartView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStartView()
    }
}
