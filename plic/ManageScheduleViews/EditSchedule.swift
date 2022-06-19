//
//  EditSchedule.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/14.
//

import SwiftUI


struct EditSchedule: View {
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let schedule: Schedule
    @State var scheduleName: String = ""
    @State var allDayToggle: Bool = false
    @State var timeStart: Date = Date()
    @State var timeEnd: Date = Date()
    @State var noteContent: String = "메모를 작성해 주세요"
    @State var whoSchedule = "함께"

    
    init(schedule: Schedule) {
        self.schedule = schedule
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("plicPink"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:UIColor.black], for: .normal)
        UISegmentedControl.appearance().backgroundColor = .white
    }

    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(schedule.title, text: $scheduleName)
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                        .foregroundColor((noteContent == "") ? Color("plicLightgrey") : .black )
                        .disableAutocorrection(true)
                        .modifier(TextFieldClearButton(scheduleNameText: $scheduleName))
                        .multilineTextAlignment(.leading)
                }
                
                Section {
                    Toggle("하루 종일", isOn: $allDayToggle)
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                        .toggleStyle(SwitchToggleStyle(tint: Color("plicPink")))
                    // toggle을 눌렀을 때, 날짜만 설정할 수 있도록 if문
                    if allDayToggle {
                        // 전 날을 체크할 수 없도록 in: Date 사용
                        DatePicker("시작", selection: $timeStart, in: schedule.startDate..., displayedComponents: .date)
                            .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                            .accentColor(Color("plicPink"))
                        // 시작 날짜보다 이전의 날짜를 선택하지 못하게끔 in: timeStart... 사용
                        DatePicker("종료", selection: $timeEnd, in: schedule.endDate..., displayedComponents: .date)
                            .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                            .accentColor(Color("plicPink"))
                     } else {
                         DatePicker("시작", selection: $timeStart, in: schedule.startDate...)
                             .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                             .accentColor(Color("plicPink"))
                         DatePicker("종료", selection: $timeEnd, in: schedule.endDate...)
                             .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                             .accentColor(Color("plicPink"))
                     }
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
                        .foregroundColor((noteContent == "") ? Color("plicLightgrey") : .black )
                        .frame(height: 250)
                        .disableAutocorrection(true)
                        .onTapGesture {
                            //메모가 없을 때 placeholder 역할
                            if self.noteContent == "메모를 작성해 주세요" {
                                self.noteContent = ""
                            }
                        }
                }
            }.navigationBarTitle("일정 수정", displayMode: .inline)
                .font(.custom("SpoqaHanSansNeo-Bold", size: 17))
                .navigationBarItems(
                    leading: Button(action: {self.presentationMode.wrappedValue.dismiss()}) { Text("취소") }.font(.custom("SpoqaHanSansNeo-Regular", size: 17)).foregroundColor(Color("plicPink")),
                    trailing: Button(action: {
                        addSchedule()
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }) { Text("완료")}.font(.custom("SpoqaHanSansNeo-Regular", size: 17)).foregroundColor(Color("plicPink"))
                )
        }.onAppear(){
            self.allDayToggle = schedule.isAllDaySchedule
            self.noteContent = schedule.description!
            if(schedule.isCoupleSchedule){
                self.whoSchedule = "함께"
                }else{
                    self.whoSchedule = "사용자1"
            }
            self.noteContent = schedule.description!
        }
    }
    // CloudKit에 일정 등록
        private func addSchedule() {
            let schedule = Schedule(title: scheduleName, description: noteContent, startDate: timeStart, endDate: timeEnd, isAllDaySchedule: allDayToggle, isCoupleSchedule: whoSchedule == "함께", isSpecialDay: false)
            coupleViewModel.addSchedule(schedule)
        }
}

// 키보드 내리는 입력 완료 함수
