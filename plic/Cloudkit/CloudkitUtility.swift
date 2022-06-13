//
//  CloudkitUtility.swift
//  plic
//
//  Created by 이영준 on 2022/06/13.
//

import Foundation
import CloudKit
import Combine

// for Generic
protocol CloudKitableProtocol {
    init?(record: CKRecord)
    var record: CKRecord { get }
}

class CloudkitUtility {
    
    // error case
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
        
        case iCloudApplicationPermissionNotGranted
        
        case iCloudCouldNotFetchUserRecordID
        
        case iCloudColudNotDiscoverUser
    }
    
}

// MARK: USER FUNCTIONS
extension CloudkitUtility {
    
    // Check user iCloud status
    static private func getiCloudStatus(completion: @escaping (Result<Bool, Error>) -> ()){
        CKContainer.default().accountStatus { returnedStatus, returnedError in
            switch returnedStatus {
            case .available:
                completion(.success(true))
            case .restricted:
                completion(.failure(CloudKitError.iCloudAccountRestricted))
            case .noAccount:
                completion(.failure(CloudKitError.iCloudAccountNotFound))
            case .couldNotDetermine:
                completion(.failure(CloudKitError.iCloudAccountNotDetermined))
            default:
                completion(.failure(CloudKitError.iCloudAccountUnknown))
            }
        }
    }
    
    // future - getiCloudStatus
    static func getiCloudStatus() -> Future<Bool, Error> {
        Future { promise in
            CloudkitUtility.getiCloudStatus { result in
                promise(result)
            }
        }
    }
    
    
    // Request Permission to User
    static private func requestApplicationPermission(completion: @escaping (Result<Bool, Error>) -> ()){
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { returnedStatus, returnedError in
            if returnedStatus == .granted {
                completion(.success(true))
            } else {
                completion(.failure(CloudKitError.iCloudApplicationPermissionNotGranted))
            }
        }
    }
    
    static func requestApplicationPermission() -> Future<Bool, Error> {
        Future { promise in
            CloudkitUtility.requestApplicationPermission { result in
                promise(result)
            }
        }
    }
    
    
    // Fetch User RecordID
    static private func fetchUserRecordID(completion: @escaping (Result<CKRecord.ID, Error>) -> ()) {
        CKContainer.default().fetchUserRecordID { returnedID, returnedError in
            if let id = returnedID {
                completion(.success(id))
            } else if let error = returnedError {
                completion(.failure(error))
            } else {
                completion(.failure(CloudKitError.iCloudCouldNotFetchUserRecordID))
            }
        }
    }
    
    // Discover User Identity
    static private func discoverUserIdentity(id: CKRecord.ID, completion: @escaping (Result<String, Error>) -> ()) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { returnedIdentity, returnedError in
            if let name = returnedIdentity?.nameComponents?.givenName {
                completion(.success(name))
            } else {
                completion(.failure(CloudKitError.iCloudColudNotDiscoverUser))
            }
        }
    }
    
    static private func discoverUserIdentity(completion: @escaping (Result<String, Error>) -> ()) {
        fetchUserRecordID { fetchCompletion in
            switch fetchCompletion {
            case .success(let recordID):
                CloudkitUtility.discoverUserIdentity(id: recordID, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func discoverUserIdentity() -> Future<String, Error> {
        Future { promise in
            CloudkitUtility.discoverUserIdentity { result in
                promise(result)
            }
        }
    }
}

// MARK: CRUD FUNCTIONS

extension CloudkitUtility {
    
    static func fetch<T:CloudKitableProtocol>(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptors: [NSSortDescriptor]? = nil,
        resultsLimit: Int? = nil
    ) -> Future<[T], Error> {
        Future { promise in
            CloudkitUtility.fetch(predicate: predicate, recordType: recordType, sortDescriptors: sortDescriptors, resultsLimit: resultsLimit) { (items: [T]) in
                promise(.success(items))
            }
        }
    }
    
    static private func fetch<T:CloudKitableProtocol>(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptors: [NSSortDescriptor]? = nil,
        resultsLimit: Int? = nil,
        completion: @escaping (_ items: [T]) -> ()
    ) {
        
        // Create Operation
        let operation = createOperation(predicate: predicate, recordType: recordType, sortDescriptors: sortDescriptors, resultsLimit: resultsLimit)
        
        // Get Items in Query
        var returnedItems: [T] = []
        addRecordMatachedBlock(operation: operation) { item in
            returnedItems.append(item)
        }
        
        // Query Completion
        addQueryResultBlock(operation: operation) { finshed in
            completion(returnedItems)
        }
        
        // Execute Operation
        addOperation(operation: operation)
    }
    
    static private func createOperation(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptors: [NSSortDescriptor]? = nil,
        resultsLimit: Int? = nil) -> CKQueryOperation {
            let query = CKQuery(recordType: recordType, predicate: predicate)
            query.sortDescriptors = sortDescriptors
            let queryOperation = CKQueryOperation(query: query)
            if let limit = resultsLimit {
                queryOperation.resultsLimit = limit
        }
        return queryOperation
    }
    
    static private func addRecordMatachedBlock<T: CloudKitableProtocol>(operation: CKQueryOperation, completion: @escaping (_ item: T) -> ()) {
        operation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case .success(let record):
                guard let item = T(record: record) else { return }
                completion(item)
            case .failure:
                break
            }
        }
    }
    
    static private func addQueryResultBlock(operation: CKQueryOperation, completion: @escaping (_ finshed: Bool) -> ()) {
        operation.queryResultBlock = { returnedResult in
            completion(true)
        }
    }
    // add Operation for fetch
    static private func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().privateCloudDatabase.add(operation)
    }
    
    
    // add
    static func add<T:CloudKitableProtocol>(item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        // get record
        let record = item.record
        
        // save to cloudkit
        save(record: record, completion: completion)
    }
    
    // save
    static func save(record: CKRecord, completion: @escaping (Result<Bool, Error>) -> ()) {
        CKContainer.default().privateCloudDatabase.save(record) { returnedRecord, returnedError in
            if let error = returnedError {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    // update
    static func update<T:CloudKitableProtocol>(item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        add(item: item, completion: completion)
    }
    
    
    static func delete<T:CloudKitableProtocol>(item: T) -> Future<Bool, Error> {
        Future { promise in
            CloudkitUtility.delete(item: item, completion: promise)
        }
    }
    
    static private func delete<T:CloudKitableProtocol>(item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        CloudkitUtility.delete(record: item.record, completion: completion)
    }
    
    // delete
    static private func delete(record: CKRecord, completion: @escaping (Result<Bool, Error>) -> ()) {
        CKContainer.default().privateCloudDatabase.delete(withRecordID: record.recordID) { returnedRecordID, returnedError in
            if let error = returnedError {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
