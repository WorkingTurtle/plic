//
//  RecordProtocol.swift
//  plic
//
//  Created by 박원빈 on 2022/06/15.
//

import Foundation
import CloudKit

protocol Record {
    var uuid: String { get }
    var createdAt: Date { get }
    var updatedAt: Date { get }
    
    init(record: CKRecord)
    
    
    func getRecordID() -> CKRecord.ID
    func convertToCKRecord() -> CKRecord
    func mergeWithCKRecord(_ record: CKRecord) -> CKRecord
}
