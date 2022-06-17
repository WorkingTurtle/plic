//
//  UserSettingNotificationView.swift
//  plic
//
//  Created by 이영준 on 2022/06/16.
//

import SwiftUI
import CloudKit

class CoupleRecordNorificationViewModel: ObservableObject {

    func subscribeToNotification() {
        let predicate = NSPredicate(format: "\(CKConstant.Field.isCoupleSchedule) == %@",  NSNumber(value: true))
        // TODO: subscriptionID: root?.recordID.recordName
        let subscription = CKQuerySubscription(recordType: CKConstant.RecordType.Schedule, predicate: predicate,  subscriptionID: "imsiID", options: .firesOnRecordCreation)
        
        let notification = CKSubscription.NotificationInfo()
        
        notification.title = "Plic Calendar"
        notification.alertBody = "함께하는 일정이 등록되었습니다"
        notification.soundName = "default"
        
        subscription.notificationInfo = notification
        
        CKContainer.default().privateCloudDatabase.save(subscription) { returnedSubscription, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully subscribed to notification!")
            }
            
        }
    }
    
    func unsubscribeToNotification() {
        CKContainer.default().privateCloudDatabase.delete(withSubscriptionID: "imsiID") { returnedID, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully unscribed!")
            }
        }
    }
}

struct UserSettingNotificationView: View {
    @StateObject private var vm = CoupleRecordNorificationViewModel()
    @State private var isToggle = false
    @State private var isToggleOpposite = true
    
    var body: some View {
        VStack{
            Toggle("커플 일정 생성 시 알림", isOn: $isToggle)
                .toggleStyle(SwitchToggleStyle(tint: Color("plicPink")))
                .onChange(of: isToggle){ _ in
                    isToggleOpposite.toggle()
                    vm.subscribeToNotification()
                }
                .onChange(of: isToggleOpposite){ _ in
                    vm.unsubscribeToNotification()
                }
                .padding(.horizontal, 20)
            Spacer()
        }
        .navigationBarTitle(Text("알림 설정"), displayMode: .inline)
            .font(.custom("SpoqaHanSansNeo-Bold", size: 17))
        .padding(.top, 30)
    }
}

struct UserSettingNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingNotificationView()
    }
}
