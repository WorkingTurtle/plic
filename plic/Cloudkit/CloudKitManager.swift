//
//  CloudKitManager.swift
//  plic
//
//  Created by 박원빈 on 2022/06/15.
//

import CloudKit

class CloudKitManager {

    static let privateDB = CKContainer.default().privateCloudDatabase
    static let sharedDB = CKContainer.default().sharedCloudDatabase
    
    static let coupleZone = CKRecordZone(zoneName: CKConstant.Zone.Couple)
    static let defaultZone = CKRecordZone(zoneName: CKConstant.Zone.Default)
    
    static var isCoupleZoneReady: Bool {
        return UserDefaults.standard.bool(forKey: CKConstant.isCoupleZoneReady)
    }
    
    class func setupCoupleZone() {
        let zoneOperation = CKModifyRecordZonesOperation(recordZonesToSave: [coupleZone], recordZoneIDsToDelete: nil)
        
        zoneOperation.modifyRecordZonesResultBlock = { result in
            switch result {
            case .failure(let error):
                NSLog("CloudKit ModifyRecordZones Error: \(error.localizedDescription)")
            case .success():
                UserDefaults.standard.set(true, forKey: CKConstant.isCoupleZoneReady)
            }
        }
        
        CloudKitManager.privateDB.add(zoneOperation)
    }
}
