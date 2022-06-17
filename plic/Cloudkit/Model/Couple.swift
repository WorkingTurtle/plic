//
//  Couple.swift
//  plic
//
//  Created by 박원빈 on 2022/06/15.
//

import Foundation
import CloudKit

struct Couple {
    let uuid: String
    let createdAt: Date
    let updatedAt: Date
    
    var nicknameOwner: String?
    var nicknamePartner: String?
    var firstMeetingDate: Date?
    var ownerBirthDay: Date?
    var partnerBirthDay: Date?
}

extension Couple: Hashable, Record {
    
    
    init() {
        self.uuid = UUID().uuidString
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    init(record: CKRecord) {
        self.uuid = record.recordID.recordName
        self.createdAt = record.creationDate!
        self.updatedAt = record.modificationDate!
        self.nicknameOwner = record.object(forKey: CKConstant.Field.nicknameOwner) as! String?
        self.nicknamePartner = record.object(forKey: CKConstant.Field.nicknamePartner) as! String?
        self.firstMeetingDate = record.object(forKey: CKConstant.Field.firstMeetingDate) as! Date?
        self.ownerBirthDay = record.object(forKey: CKConstant.Field.ownerBirthDay) as! Date?
        self.partnerBirthDay = record.object(forKey: CKConstant.Field.partnerBirthDay) as! Date?
    }
    
    func getRecordID() -> CKRecord.ID {
        let zoneID = CloudKitManager.coupleZone.zoneID
        let recordID = CKRecord.ID(recordName: uuid, zoneID: zoneID)
        return recordID
    }
    
    func convertToCKRecord() -> CKRecord {
        let record = CKRecord(recordType: CKConstant.RecordType.Couple, recordID: getRecordID())
        return mergeWithCKRecord(record)
    }
    
    func mergeWithCKRecord(_ record: CKRecord) -> CKRecord {
        record.setValue(nicknameOwner, forKey: CKConstant.Field.nicknameOwner)
        record.setValue(nicknamePartner, forKey: CKConstant.Field.nicknamePartner)
        record.setValue(firstMeetingDate, forKey: CKConstant.Field.firstMeetingDate)
        record.setValue(ownerBirthDay, forKey: CKConstant.Field.ownerBirthDay)
        record.setValue(partnerBirthDay, forKey: CKConstant.Field.partnerBirthDay)
        return record
    }
}
