//
//  Learner.swift
//  LearnerApp-Mini2
//
//  Created by Reem Quhal on 08/10/2023.
//

import Foundation
import CloudKit

struct Learner : Identifiable{
    let id : CKRecord.ID
    let firstName : String
    let lastName : String
    let major : String
    let age : Int
    
    init(record:CKRecord){
        self.id        = record.recordID
        self.firstName = record["firstName"] as? String ?? "N/A"
        self.lastName  = record["lastName"] as? String ?? "N/A"
        self.major     = record["major"] as? String ?? "N/A"
        self.age       = record["age"] as? Int ?? 18
    }
    
}
