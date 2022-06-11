//
//  AddSchedule1.swift
//  plic
//
//  Created by 최홍준 on 2022/06/11.
//

import SwiftUI

struct AddSchedule1: View {
    
    // NavigationBar의 버튼을 눌렀을 때, Modal View가 닫히게끔
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // 제목 변경
    @State var scheduleName: String = ""
    // 일정 추가에서 하루 종일로 설정할 수 있게끔 toggle button 생성
    @State private var allDayToggle = false
    // 시작 날짜, 시간 설정
    @State private var timetoStart = Date()
    
    
    var body: some View {
        ZStack {
            ColorManage.plicModalgrey
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                Form {
                    Section {
                        TextField("제목", text: $scheduleName)
                            .font(.custom("SpoqaHanSansNeo-Bold", size: 17))
                            .cornerRadius(10)
                            .overlay(
                                HStack {
                                    Spacer()
                                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(ColorManage.plicDarkgrey)
                                    }
                                })
                        
                    }
                    
                    Section {
                        Toggle("하루 종일", isOn: $allDayToggle)
                        // if allDayToggle {
                        // 하루 종일 체크 O
                        // } else {
                        // 하루 종일 체크 X
                        DatePicker("시작", selection: $timetoStart)
                        DatePicker("종료", selection: $timetoStart)
                    }
                    
                    Section(header: Text("누구의 일정인가요?").padding(.leading, -20)) {
                        // 사용자를 변수로
                        HStack {
                            Button(action: {/*some action*/}) {
                                Text("사용자1")
                            }
                            .font(.custom("SpoqaHanSansNeo-Bold", size: 17))
                            .foregroundColor(Color(.black))
                            Spacer()
                            Button(action: {/*some action*/}) {
                                Text("함께")
                            }
                            .font(.custom("SpoqaHanSansNeo-Bold", size: 17))
                            .foregroundColor(Color(.black))
                            Spacer()
                            Button(action: {/*some action*/}) {
                                Text("사용자2")
                            }
                            .font(.custom("SpoqaHanSansNeo-Bold", size: 17))
                            .foregroundColor(Color(.black))
                        }
                    }
                    
                    Section(header: Text("노트 작성하기").padding(.leading, -20)) {
                        // 작성된 노트가 보이게끔 해야함(새로운 페이지 X, Textfield)
                        Spacer()
                            .frame(height: 250)
                        // 버튼을 누르면 노트 작성 페이지로 이동하게 해야 함
                            .overlay(
                                Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                                    Image(systemName: "square.and.pencil")
                                        .foregroundColor(ColorManage.plicPink)
                                        .padding(.bottom, 220)
                                        .padding(.leading, 610)
                                })
                    }
                }
                .navigationBarTitle("일정추가", displayMode: .inline).font(.custom("SpoqaHanSansNeo-Bold", size: 17))
                .navigationBarItems(leading:
                                        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                    Image(systemName: "chevron.left")
                }.font(.custom("SpoqaHanSansNeo-Bold", size: 17)).foregroundColor(ColorManage.plicPink),
                                    trailing: Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                    Text("완료")
                }.font(.custom("SpoqaHanSansNeo-Bold", size: 17)).foregroundColor(ColorManage.plicPink))
            }
        }
    }
}

struct ColorManage {
    static let plicPink = Color("plicPink")
    static let plicGrey = Color("plicGrey")
    static let plicDarkgrey = Color("plicDarkgrey")
    static let plicModalgrey = Color("plicModalgrey")
}
struct AddSchedule1_Previews: PreviewProvider {
    static var previews: some View {
        AddSchedule1()
    }
}
