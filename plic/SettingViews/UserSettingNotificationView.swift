//
//  UserSettingNotificationView.swift
//  plic
//
//  Created by 이영준 on 2022/06/16.
//

import SwiftUI
import CloudKit

class CoupleRecordNorificationViewModel: ObservableObject {
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    
    func subscribeToNotification() {
//        let predicate = NSPredicate(format: "\(CKConstant.Field.isCoupleSchedule) == %@",  NSNumber(value: true))
        let subscription = CKQuerySubscription(recordType: CKConstant.RecordType.Schedule, predicate: NSPredicate(value: true),  subscriptionID: "imsiID", options: .firesOnRecordCreation)
        
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
        
        let predicate2 = NSPredicate(format: "\(CKConstant.Field.isCoupleSchedule) == %@",  NSNumber(value: true))
        let subscription2 = CKQuerySubscription(recordType: CKConstant.RecordType.Schedule, predicate: predicate2,  subscriptionID: "imsiID2", options: .firesOnRecordCreation)
        let notification2 = CKSubscription.NotificationInfo()

        let subscription3 = CKDatabaseSubscription(subscriptionID: "Bean")
        subscription3.recordType = CKConstant.RecordType.Schedule

        notification2.title = "Plic Calendar"
        notification2.alertBody = "함께하는 일정이 등록되었습니다"
        notification2.soundName = "default"

        subscription2.notificationInfo = notification2
        subscription3.notificationInfo = notification2


        CKContainer.default().sharedCloudDatabase.save(subscription3) { returnedSubscription, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully subscribed to notification!2")
            }
        }
        
        let subscription4 = CKDatabaseSubscription(subscriptionID: "wowowowow")

        let notificationInfo4 = CKSubscription.NotificationInfo()
        notificationInfo4.shouldSendContentAvailable = true
        subscription4.notificationInfo = notificationInfo4

        let operation = CKModifySubscriptionsOperation(subscriptionsToSave: [subscription4], subscriptionIDsToDelete: [])
        operation.modifySubscriptionsCompletionBlock = { savedSubscriptions, deletedSubscriptionIDs, operationError in
            if operationError != nil {
                print(operationError)
                return
            } else {
                print("🐧")
            }
        }

        CKContainer.default().sharedCloudDatabase.add(operation)
        
    }
    
    func unsubscribeToNotification() {
        CKContainer.default().privateCloudDatabase.delete(withSubscriptionID: "imsiID") { returnedID, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully unscribed!")
            }
        }
        
        CKContainer.default().sharedCloudDatabase.delete(withSubscriptionID: "imsiID3") { returnedID, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully unscribed!2")
            }
        }
    }
}

struct UserSettingNotificationView: View {
    @StateObject private var vm = CoupleRecordNorificationViewModel()
    // TODO: 어플 시작했을 때 false로 저장되어있는데 이거 기존값 저장하도록 해야함
    @State private var isToggle = false
    @State private var isToggleOpposite = true
    
    var body: some View {
        VStack{
            Toggle("커플 일정 생성 시 알림", isOn: $isToggle)
                .toggleStyle(SwitchToggleStyle(tint: Color("plicPink")))
                .onChange(of: isToggle){ _ in
                    if (isToggle) {
                        vm.subscribeToNotification()
                    } else  {
                        vm.unsubscribeToNotification()

                    }
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
