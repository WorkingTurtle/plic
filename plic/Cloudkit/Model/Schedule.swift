//
//  Schedule.swift
//  plic
//
//  Created by 박원빈 on 2022/06/15.
//

import Foundation
import CloudKit

struct Schedule {
    let uuid: String
    let createdAt: Date
    let updatedAt: Date
    
    let title: String
    let description: String?
    let startDate: Date
    let endDate: Date
    let isAllDaySchedule: Bool
    let isCoupleSchedule: Bool
    let isSpecialDay: Bool
}

extension Schedule: Record {
    
    init(title: String, description: String?, startDate: Date, endDate: Date, isAllDaySchedule: Bool, isCoupleSchedule: Bool, isSpecialDay: Bool) {
        self.uuid = UUID().uuidString
        self.createdAt = Date()
        self.updatedAt = Date()
        
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
        self.isAllDaySchedule = isAllDaySchedule
        self.isCoupleSchedule = isCoupleSchedule
        self.isSpecialDay = isSpecialDay
    }
    
    init(record: CKRecord) {
        self.uuid = record.recordID.recordName
        self.createdAt = record.creationDate!
        self.updatedAt = record.modificationDate!
        self.title = record.object(forKey: CKConstant.Field.title) as! String
        self.description = record.object(forKey: CKConstant.Field.description) as! String?
        self.startDate = record.object(forKey: CKConstant.Field.startDate) as! Date
        self.endDate = record.object(forKey: CKConstant.Field.endDate) as! Date
        self.isAllDaySchedule = record.object(forKey: CKConstant.Field.isAllDaySchedule) as! Bool
        self.isCoupleSchedule = record.object(forKey: CKConstant.Field.isCoupleSchedule) as! Bool
        self.isSpecialDay = record.object(forKey: CKConstant.Field.isSpecialDay) as! Bool
    }
    
    func getRecordID() -> CKRecord.ID {
        let zoneID = CloudKitManager.coupleZone.zoneID
        let recordID = CKRecord.ID(recordName: uuid, zoneID: zoneID)
        return recordID
    }
    
    func convertToCKRecord() -> CKRecord {
        let record = CKRecord(recordType: CKConstant.RecordType.Schedule, recordID: getRecordID())
        return mergeWithCKRecord(record)
    }
    
    func mergeWithCKRecord(_ record: CKRecord) -> CKRecord {
        record.setValue(title, forKey: CKConstant.Field.title)
        record.setValue(description, forKey: CKConstant.Field.description)
        record.setValue(startDate, forKey: CKConstant.Field.startDate)
        record.setValue(endDate, forKey: CKConstant.Field.endDate)
        record.setValue(isAllDaySchedule, forKey: CKConstant.Field.isAllDaySchedule)
        record.setValue(isCoupleSchedule, forKey: CKConstant.Field.isCoupleSchedule)
        record.setValue(isSpecialDay, forKey: CKConstant.Field.isSpecialDay)
        return record
    }
}
