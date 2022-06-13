//
//  EditingPlanView.swift
//  plic
//
//  Created by 김승훈 on 2022/06/13.
//

import SwiftUI

struct EditingPlanView: View {
    @State private var name = ""
    @State var challenge = "목표 / 연인에게 한 마디"
    
    var body: some View {
        ZStack{
            Color("plicLightestGrey")
                .ignoresSafeArea()
            VStack{
                HStack{
                    Image(systemName: "chevron.left")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                        .foregroundColor(Color("plicPink"))
                        .padding(.leading, 20)
                    Spacer()
                    Text("목표 수정")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                        .foregroundColor(Color("plicBlack"))
                    Spacer()
                    Text("완료")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                        .foregroundColor(Color("plicPink"))
                .padding(.trailing, 20)
                }
                .padding(.bottom, 30)
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("plicWhite"))
                        VStack{
                            TextField("\(challenge)", text: $name).padding()
                            
                        }
                     
                        
                        
                    }
                }
                .frame(width: 350, height: 45)
                .padding([.leading,.trailing], 20)
                Spacer()
            }
        }
        
        
            
//            VStack(){
//                Text("목표 수정")
//                        .font(.system(size: 17, weight: .bold, design: .serif))
//            Form{
//                Section{
//                TextField("목표 연인에게 한마디", text: $name)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .keyboardType(.decimalPad)
//                        .modifier(TextFieldClearButton(scheduleNameText: $name))
//                        .multilineTextAlignment(.leading)
//                }
//                }
//            }
            
    }
}

struct EditingPlanView_Previews: PreviewProvider {
    static var previews: some View {
        EditingPlanView()
    }
}
