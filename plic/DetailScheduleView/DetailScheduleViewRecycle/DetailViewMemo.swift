//
//  DetailViewMemo.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/11.
//

import SwiftUI


// 작성된 메모 확인란
struct DetailViewMemo: View {
    let schedule: Schedule
    @State var memoText: String?
    @State private var isShowingDialog: Bool = false
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    @Environment(\.presentationMode) var presentationMode

    
        //Alert가 기본 틴트 컬러를 빨간색으로 가지게 하기 위한 코드
    init(schedule: Schedule) {
        self.schedule = schedule
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemRed
    }
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "square.and.pencil")
                    .frame(width: 16, height: 18)
                    .foregroundColor(Color("plicPink"))
                    .padding(.leading, 24)
                Text("메모")
                    .font(.custom("SpoqaHanSansNeo-Regular",size: 14))
                    .padding(.leading, 5)
                Spacer()
            }
            
            ZStack(alignment: .topLeading){
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350, height: 146)
                    .foregroundColor(Color("plicLightestgrey"))
                Text("\(schedule.description ?? "비어 있는 메모")")
                    .font(.custom("SpoqaHanSansNeo-Regular",size: 14))
                    .foregroundColor((schedule.description != nil) ? .black : .gray)
                    .padding(12)
            }
            
            Button(action: {
                isShowingDialog = true
            }) {
                Text("일정 삭제")
                    .foregroundColor(.white)
                    .font(.custom("SpoqaHanSansNeo-Regular",size: 17))
                    .background(RoundedRectangle(cornerRadius: 10)
                        .frame(width: 350, height: 46)
                        .foregroundColor(Color("plicPink")))
                    .padding(.top, 13)
                
            }.confirmationDialog("", isPresented: $isShowingDialog, titleVisibility: .hidden) {
                Button("일정 삭제", role: .destructive) {
                    //일정 삭제 코드
                    coupleViewModel.deleteSchedule(schedule: self.schedule)
                    
                    coupleViewModel.fetchSchedules() {
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                Button("취소", role: .cancel) {
                }
            }
        }
        .onAppear(){
            coupleViewModel.fetchSchedules() {
            }
        }
    }
}


