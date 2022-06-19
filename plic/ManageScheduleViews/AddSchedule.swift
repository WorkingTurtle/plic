//
//  AddSchedule1.swift
//  plic
//
//  Created by 최홍준 on 2022/06/11.
//

import SwiftUI


// 제목 란에서 내용을 입력했을 때, X버튼이 생성되고 X버튼을 눌렀을 때 기입한 내용이 삭제됨
struct TextFieldClearButton: ViewModifier {
    @Binding var scheduleNameText: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            if !scheduleNameText.isEmpty {
                Button(action: { self.scheduleNameText = "" }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color("plicLightgrey"))
                })
            }
        }
    }
}

struct AddSchedule: View {
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    // NavigationBar의 버튼을 눌렀을 때, Modal View가 닫히게끔
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // 제목 변경
    @State var scheduleName: String = ""
    // 일정 추가에서 하루 종일로 설정할 수 있게끔 toggle button 생성
    @State var allDayToggle = false
    // 시작 날짜, 시간 설정
    @State var timeStart = Date()
    // 종료 날짜, 시간 설정
    @State var timeEnd = Date()
    // 노트 작성 내용
    @State var noteContent: String = "메모를 작성해 주세요"
    // 사용자 선택에 관한 설정(함께, 사용자 둘), 선택할 때 tag값을 줌
    @State var whoSchedule = "함께"

    //누구의 일정인가요 아래 피커 색상에 대한 설정
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("plicPink"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
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
                    // toggle을 눌렀을 때, 날짜만 설정할 수 있도록 if문
                    if allDayToggle {
                        // 전 날을 체크할 수 없도록 in: Date 사용
                        DatePicker("시작", selection: $timeStart, in: Date()..., displayedComponents: .date)
                            .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                            .accentColor(Color("plicPink"))
                        // 시작 날짜보다 이전의 날짜를 선택하지 못하게끔 in: timeStart... 사용
                        DatePicker("종료", selection: $timeEnd, in: timeStart..., displayedComponents: .date)
                            .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                            .accentColor(Color("plicPink"))
                     } else {
                         DatePicker("시작", selection: $timeStart, in: Date()...)
                             .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                             .accentColor(Color("plicPink"))
                         DatePicker("종료", selection: $timeEnd, in: timeStart...)
                             .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                             .accentColor(Color("plicPink"))
                     }
                }
                    

                
                Section(header: Text("누구의 일정인가요?").padding(.leading, -20)) {
                    Picker(selection: $whoSchedule, label: Text("")) {
                        Text("사용자1").tag("사용자1")
                        Text("함께").tag("함께")
                    }
                        .pickerStyle(SegmentedPickerStyle())
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
            }
            .navigationBarTitle("일정 추가", displayMode: .inline)
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

struct AddSchedule_Previews: PreviewProvider {
    static var previews: some View {
        AddSchedule()
    }
}
