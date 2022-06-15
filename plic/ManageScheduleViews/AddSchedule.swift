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
    @State var noteContent: String = ""
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
                    // toggle을 눌렀을 때, 날짜만 설정할 수 있도록 if문
                    if allDayToggle {
                        // 전 날을 체크할 수 없도록 in: Date 사용
                        DatePicker("시작", selection: $timeStart, in: Date()..., displayedComponents: .date)
                            .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                        // 시작 날짜보다 이전의 날짜를 선택하지 못하게끔 in: timeStart... 사용
                        DatePicker("종료", selection: $timeEnd, in: timeStart..., displayedComponents: .date)
                            .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                     } else {
                         DatePicker("시작", selection: $timeStart, in: Date()...)
                             .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                         DatePicker("종료", selection: $timeEnd, in: timeStart...)
                             .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                     }
                }
                    

                
                Section(header: Text("누구의 일정인가요?").padding(.leading, -20)) {
                    Picker(selection: $whoSchedule, label: Text("")) {
                        Text("사용자1").tag("사용자1")
                        Text("함께").tag("함께")
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("노트 작성하기").padding(.leading, -20)) {
                    // 작성된 노트가 보이게끔 해야함(새로운 페이지 X, Textfield)
                    TextField("메모를 작성해주세요", text: $noteContent)
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                        .disableAutocorrection(true)
                        .padding(.bottom, 210)
                        .cornerRadius(10)
                        .frame(height: 250)
                        .overlay(
                            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(Color("plicPink"))
                                    .padding(.bottom, 210)
                                    .padding(.leading, 290)
                            })
                }
            }
            .navigationBarTitle("일정 추가", displayMode: .inline).font(.custom("SpoqaHanSansNeo-Bold", size: 17))
            .navigationBarItems(leading:
                                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                Image(systemName: "chevron.left")
            }
                .font(.custom("SpoqaHanSansNeo-Regular", size: 17)).foregroundColor(Color("plicPink")),
                                trailing: Button(action: {/* 일정 저장*/}) {
                Text("완료")
            }
                .font(.custom("SpoqaHanSansNeo-Regular", size: 17)).foregroundColor(Color("plicPink"))
            )
        }
    }
}

struct AddSchedule_Previews: PreviewProvider {
    static var previews: some View {
        AddSchedule()
    }
}
