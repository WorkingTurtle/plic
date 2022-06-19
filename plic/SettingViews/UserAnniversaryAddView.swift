//
//  UserAnniversaryAddView.swift
//  plic
//
//  Created by 최홍준 on 2022/06/15.
//

import SwiftUI

struct UserAnniversaryAddView: View {
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var scheduleName: String = ""
    @State var anniversaryDate = Date()
    @State var noteContent: String = ""
    
    
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
                Section(header: Text("기념일을 설정해주세요").padding(.leading, -20)) {
                    DatePicker("날짜", selection: $anniversaryDate, displayedComponents: .date)
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                        .accentColor(Color("plicPink"))
                }
                Section(header: Text("노트 작성하기").padding(.leading, -20)) {
                    TextField("메모를 작성해주세요", text: $noteContent)
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                        .disableAutocorrection(true)
                        .padding(.bottom, 210)
                        .cornerRadius(10)
                        .frame(height: 250)
                        .overlay(
                            Button(action: {/*  */}) {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(Color("plicPink"))
                                    .padding(.bottom, 210)
                                    .padding(.leading, 290)
                            })
                }
                
            }
            .navigationBarTitle("기념일 추가", displayMode: .inline).font(.custom("SpoqaHanSansNeo-Bold", size: 17))
            .navigationBarItems(leading:
                                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                Image(systemName: "chevron.left")
            }
                .font(.custom("SpoqaHanSansNeo-Regular", size: 17)).foregroundColor(Color("plicPink")),
                                trailing:
                                    Button(action: {
                addSchedule()
                self.presentationMode.wrappedValue.dismiss()
                
            }) {
                Text("완료")
            }
                .font(.custom("SpoqaHanSansNeo-Regular", size: 17)).foregroundColor(Color("plicPink"))
            )
        }
    }
    private func addSchedule() {
        let schedule = Schedule(title: scheduleName, description: noteContent, startDate: anniversaryDate, endDate: anniversaryDate, isAllDaySchedule: true, isCoupleSchedule: true, isSpecialDay: true)
        coupleViewModel.addSchedule(schedule)
    }
}

struct UserAnniversaryAddView_Previews: PreviewProvider {
    static var previews: some View {
        UserAnniversaryAddView()
    }
}
