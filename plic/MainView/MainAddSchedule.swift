//
//  MainAddSchedule.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/14.
//

import SwiftUI

struct MainAddSchedule: View {
    // 임시로 값을 넘겨주는 뷰를 DetailScheduleView로 함
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var scheduleName: String = ""
    @State var allDayToggle: Bool = false
    @State var timeStart = Date()
    @State var timeEnd = Date()
    @State var noteContent: String = ""
    @State var whoSchedule = "함께"
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("plicPink"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:UIColor.black], for: .normal)
        UISegmentedControl.appearance().backgroundColor = .white
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("제목", text: $scheduleName)
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                        .disableAutocorrection(true)
                        .modifier(TextFieldClearButton(scheduleNameText: $scheduleName))
                        .multilineTextAlignment(.leading)
                }
                
                Section {
                    Toggle("하루 종일", isOn: $allDayToggle)
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                    
                    DatePicker("시작", selection: $timeStart, in: Date()...)
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                    DatePicker("종료", selection: $timeEnd, in: timeStart...)
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                }
                
                Section(header: Text("누구의 일정인가요?").padding(.leading, -20)) {
                    Picker(selection: $whoSchedule, label: Text("")){
                        Text("사용자1").tag("사용자1")
                        Text("함께").tag("함께")
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("노트 작성하기").padding(.leading, -20)){
//                    
//                    TextEditor(text: $noteContent)
//                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
//                        .disableAutocorrection(true)
//                        .padding(.bottom, 210)
//                        .cornerRadius(10)
//                        .frame(height: 250)
//                    
//                    TextField("메모를 작성해 주세요", text: $noteContent)
//                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
//                        .disableAutocorrection(true)
//                        .padding(.bottom, 210)
//                        .cornerRadius(10)
//                        .frame(height: 250)
//                        .overlay(
//                            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
//                                Image(systemName: "square.and.pencil")
//                                    .foregroundColor(Color("plicPink"))
//                                    .padding(.bottom, 210)
//                                    .padding(.leading, 290)
//                            })
                }
            }.navigationBarTitle("일정 추가", displayMode: .inline)
                .font(.custom("SpoqaHanSansNeo-Bold", size: 17))
                .navigationBarItems(leading:
                                        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                    Text("취소")
                }
                    .font(.custom("SpoqaHanSansNeo-Regular", size: 17)).foregroundColor(Color("plicPink")),
                                    trailing: Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                    Text("완료")
                }
                    .font(.custom("SpoqaHanSansNeo-Regular", size: 17)).foregroundColor(Color("plicPink"))
                )
        }
    }
}

struct MainAddSchedule_Previews: PreviewProvider {
    static var previews: some View {
        MainAddSchedule()
    }
}
