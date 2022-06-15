//
//  SettingProfileView.swift
//  plic
//
//  Created by 최홍준 on 2022/06/13.
//

import SwiftUI

struct SettingProfileView: View {
    
    // 뒤로 나가기
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // 본인의 애칭 수정
    @State var myNickName: String = ""
    // 상대방 애칭 수정
    @State var opponentNickName: String = ""
    // 처음 사귀게 된 날짜 수정
    @State var firstDay = Date()
    @State var check: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                Text("애칭 수정")
                    .font(.custom("SpoqaHanSansNeo-Bold", size: 17))
                    .padding(EdgeInsets(top: 65, leading: 20, bottom: 10, trailing: 0))
                TextField("본인의 애칭을 입력해 주세요", text: $myNickName)
                    .font(Font.custom("SpoqaHanSansNeo-Regular", size: 17))
                    .disableAutocorrection(true)
                // 텍스트 입력 시 지우기 (X) 버튼 나타나기
                    .modifier(TextFieldClearButton(scheduleNameText: $myNickName))
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 11, leading: 17, bottom: 11, trailing: 15))
                    .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("plicLightestgrey")))
                    .padding(.horizontal, 20)
                TextField("상대방의 애칭을 입력해 주세요", text: $opponentNickName)
                    .font(Font.custom("SpoqaHanSansNeo-Regular", size: 17))
                    .disableAutocorrection(true)
                // 텍스트 입력 시 지우기 (X) 버튼 나타나기
                    .modifier(TextFieldClearButton(scheduleNameText: $opponentNickName))
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 11, leading: 17, bottom: 11, trailing: 15))
                    .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("plicLightestgrey")))
                    .padding(.horizontal, 20)
                
                Text("사귀게 된 날짜 수정")
                    .font(.custom("SpoqaHanSansNeo-Bold", size: 17))
                    .padding(EdgeInsets(top: 65, leading: 20, bottom: 10, trailing: 0))
                VStack {
                    Button(action: {
                        check.toggle()
                    })
                    {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("plicLightestgrey"))
                                .frame(width: 350, height: 45)
                                .padding(.leading, 20)
                            Text("\(firstDay, formatter: RecycleDatePicker.dateformat)")
                                .font(Font.custom("SpoqaHanSansNeo-Regular", size: 20))
                                .foregroundColor(.black)
                        }
                    }
                    if(check){
                        DatePicker("선택", selection: $firstDay, displayedComponents: .date)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                            .font(.custom("SpoqaHanSansNeo-Bold", size: 17))
                    }
                    
                }
                
                Spacer()
                
                Button(action: {
                    /* 내용 저장하고 이전 페이지로 이동 */
                }) {
                    Text("완료")
                        .font(.custom("SpoqaHanSansNeo-Bold", size: 18))
                        .foregroundColor(Color("plicPink"))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("plicPeach")).cornerRadius(10))
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 31)
                
                .navigationBarTitle("프로필 수정", displayMode: .inline).font(.custom("SpoqaHanSansNeo-Bold", size: 17))
                .navigationBarItems(leading:
                                        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                    Image(systemName: "chevron.left")
                }
                    .font(.custom("SpoqaHanSansNeo-Regular", size: 17)).foregroundColor(Color("plicPink")))
            }
        }
    }
}

struct SettingProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SettingProfileView()
    }
}
