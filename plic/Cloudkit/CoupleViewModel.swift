//
//  CoupleViewModel.swift
//  plic
//
//  Created by 박원빈 on 2022/06/15.
//

import UIKit
import CloudKit

@MainActor
protocol CoupleViewModelDelegate: AnyObject {
    func showSharingController(_ controller: UICloudSharingController)
}

final class CoupleViewModel: ObservableObject {
    
    // MARK: - Property
    
    weak var delegate: CoupleViewModelDelegate?
    
    var share: CKShare? // cloudkit.share
    var root: CKRecord? // Couple
    
    var schedules: [Schedule] = []
    
    var isOwner: Bool = true
    
    let privateDB = CloudKitManager.privateDB
    let privateZone = CloudKitManager.coupleZone
    
    let sharedDB = CloudKitManager.sharedDB
    var sharedZone: CKRecordZone?
    
    @Published var isReady = false
    
    /* Example
     Owner Zone: <CKRecordZoneID: 0x2816a0e60; ownerName=__defaultOwner__, zoneName=CoupleZone>
     
     Participant Zone: <CKRecordZoneID: 0x280b991c0; ownerName=_a9bdc43038d1f1d3fee0b5b9e5c6010e, zoneName=CoupleZone>
    */
    
    func fetchShare() {
        let predicate = NSPredicate(value: true)
        let shareQuery = CKQuery(recordType: CKConstant.RecordType.CloudKitShare, predicate: predicate)
        
        privateDB.perform(shareQuery, inZoneWith: privateZone.zoneID) { records, error in
            print("🐶 \(records)")
            if let record = records?.first as? CKShare {
                self.share = record
            }
        }
        
    }
    
    func fetchSchedules(completion: @escaping () -> Void) {
        let predicate = NSPredicate(value: true)
        let scheduleQuery = CKQuery(recordType: CKConstant.RecordType.Schedule, predicate: predicate)
        let coupleQuery = CKQuery(recordType: CKConstant.RecordType.Couple, predicate: predicate)
        
        // Fetch owner's `share` type record in his private database
        fetchShare()
        
        // Fetch owner's photos in his private database
        privateDB.perform(scheduleQuery, inZoneWith: privateZone.zoneID) { records, error in
            if let scheduleRecords = records, !scheduleRecords.isEmpty {
                self.schedules = scheduleRecords.map { Schedule(record: $0) }
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
        
        // Fetch owner's root album in his private database
        privateDB.perform(coupleQuery, inZoneWith: privateZone.zoneID) { records, error in
            if let record = records?.first {
                self.root = record
                self.isReady = true
            }
        }
        
        // Fetch shared zones in participant's shared database
        sharedDB.fetchAllRecordZones { zones, error in
            guard let zone = zones?.first else { return }
                
            // If shared zone exists, the current user is a participant
            self.sharedZone = zone
            self.isOwner = false
            
            // Fetch owner's plans in participant's shared database
            self.sharedDB.perform(scheduleQuery, inZoneWith: zone.zoneID) { records, error in
                if let scheduleRecords = records, !scheduleRecords.isEmpty {
                    self.schedules = scheduleRecords.map { Schedule(record: $0) }
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
            
            // Fetch owner's root couple in participant's shared database
            self.sharedDB.perform(coupleQuery, inZoneWith: zone.zoneID) { records, error in
                if let record = records?.first {
                    self.root = record
                    self.isReady = true
                }
            }
        }
    }
    
    func addSchedule(_ schedule: Schedule) {
        schedules.append(schedule)
        uploadToCloudKit(schedule)
    }
    
    private func uploadToCloudKit(_ schedule: Schedule) {
        if isOwner {
            let record = schedule.convertToCKRecord()
            record.setParent(root)
            
            privateDB.save(record) { savedRecord, error in
                if let error = error {
                    print("Owner upload plan error: \(error)")
                }
                
                if savedRecord != nil {
                    print("Owner upload plan successfully")
                }
            }
        } else {
            guard let zoneID = sharedZone?.zoneID else {
                print("Participant has no shared zones")
                return
            }
            
            let recordID = CKRecord.ID(recordName: schedule.uuid, zoneID: zoneID)
            var record = CKRecord(recordType: CKConstant.RecordType.Schedule, recordID: recordID)
            record = schedule.mergeWithCKRecord(record)
            record.setParent(root)
            
            sharedDB.save(record) { savedRecord, error in
                if let error = error {
                    print("Participant upload plan error: \(error)")
                }
                
                if savedRecord != nil {
                    print("Participant upload plan successfully")
                }
            }
        }
    }
    
    func addShare() -> UICloudSharingController {
        let controller: UICloudSharingController
        
        if let shareRecord = share {
            controller = UICloudSharingController(share: shareRecord, container: CKContainer.default())
        } else {
            let root = Couple().convertToCKRecord()
            let share = CKShare(rootRecord: root)
            let operation = CKModifyRecordsOperation(recordsToSave: [share, root], recordIDsToDelete: nil)

            operation.modifyRecordsResultBlock = { result in
                switch result {
                case .failure(let error):
                    NSLog("Owner upload root couple error: \(error.localizedDescription)")
                case .success():
                    print("Owner upload root couple successfully")
                    self.root = root
                    self.share = share
                }
            }

            self.privateDB.add(operation)
            controller = UICloudSharingController(share: share, container: CKContainer.default())
        }

        return controller
    }
    
    func stopShare() {
        share = nil
    }
}
