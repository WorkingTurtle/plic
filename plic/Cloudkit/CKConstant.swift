//
//  CKConstant.swift
//  plic
//
//  Created by 박원빈 on 2022/06/15.
//

import Foundation

struct CKConstant {
    // TODO: containerIdentifier 변경하기
    static let containerIdentifier = "iCloud.com.workingturtle.plic"
    static let isCoupleZoneReady = "isCoupleZoneReady"
        
    struct Zone {
        static let Couple = "CoupleZone"
        static let Default = "_defaultZone"
    }
    
    struct RecordType {
        static let Schedule = "Schedule"
        static let Couple = "Couple"
        static let CloudKitShare = "cloudkit.share"
    }
    
    struct Field {
        static let nicknameOwner = "nicknameOwner"
        static let nicknamePartner = "nicknamePartner"
        static let firstMeetingDate = "firstMeetingDate"
        static let ownerBirthDay = "ownerBirthDay"
        static let partnerBirthDay = "partnerBirthDay"
        
        static let title = "title"
        static let description = "description"
        static let startDate = "startDate"
        static let endDate = "endDate"
        static let isAllDaySchedule = "isAllDaySchedule"
        static let isCoupleSchedule = "isCoupleSchedule"
        static let isSpecialDay = "isSpecialDay"
    }
    
    struct Sort {
        static let creationDate = "creationDate"
        static let modificationDate = "modificationDate"
    }
}
