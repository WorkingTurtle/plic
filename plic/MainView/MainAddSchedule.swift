//
//  MainAddSchedule.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/14.
//

import SwiftUI


struct MainAddSchedule: View {
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var scheduleName: String = ""
    @State var allDayToggle: Bool = false
    @State var timeStart = Date()
    @State var timeEnd = Date()
    @State var noteContent: String = "메모를 작성해 주세요"
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
                        .toggleStyle(SwitchToggleStyle(tint: Color("plicPink")))
                    
                    DatePicker("시작", selection: $timeStart, in: Date()...)
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                        .accentColor(Color("plicPink"))
                    DatePicker("종료", selection: $timeEnd, in: timeStart...)
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                        .accentColor(Color("plicPink"))
                }
                
                Section(header: Text("누구의 일정인가요?").padding(.leading, -20)) {
                    Picker(selection: $whoSchedule, label: Text("")){
                        Text("사용자1").tag("사용자1")
                        Text("함께").tag("함께")
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("노트 작성하기").padding(.leading, -20)){
                    HStack{
                        Spacer()
                        Button(action: {
                            //버튼 클릭시 입력완료(키보드 내리기)
                            UIApplication.shared.endEditing()
                        }){
                            Text("완료")
                                .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                                .foregroundColor(Color("plicPink"))
                        }
                    }
                    TextEditor(text: $noteContent)
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                        .foregroundColor((noteContent == "메모를 작성해 주세요") ? Color("plicLightgrey") : .black )
                        .frame(height: 250)
                        .disableAutocorrection(true)
                        .onTapGesture {
                            //메모가 없을 때 placeholder 역할
                            if self.noteContent == "메모를 작성해 주세요" {
                                self.noteContent = ""
                            }
                        }
                }
            }.navigationBarTitle("일정 추가", displayMode: .inline)
                .font(.custom("SpoqaHanSansNeo-Bold", size: 17))
                .navigationBarItems(
                    leading: Button(action: {self.presentationMode.wrappedValue.dismiss()}) { Text("취소") }.font(.custom("SpoqaHanSansNeo-Regular", size: 17)).foregroundColor(Color("plicPink")),
                    trailing: Button(action: {
                        addSchedule()
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }) { Text("완료")}.font(.custom("SpoqaHanSansNeo-Regular", size: 17)).foregroundColor(Color("plicPink"))
                )
        }
    }
    // CloudKit에 일정 등록
        private func addSchedule() {
            let schedule = Schedule(title: scheduleName, description: noteContent, startDate: timeStart, endDate: timeEnd, isAllDaySchedule: allDayToggle, isCoupleSchedule: whoSchedule == "함께", isSpecialDay: false)
            coupleViewModel.addSchedule(schedule)
        }
}

// 키보드 내리는 입력 완료 함수
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct MainAddSchedule_Previews: PreviewProvider {
        static var previews: some View {
            MainAddSchedule()
    }
}
