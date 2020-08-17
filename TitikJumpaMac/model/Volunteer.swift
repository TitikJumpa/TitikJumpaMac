//
//  Volunteer.swift
//  TitikJumpaMac
//
//  Created by Sufiandy Elmy on 17/08/20.
//  Copyright © 2020 Sufiandy Elmy. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

struct Volunteer {
    var recordID: CKRecord.ID?
    var name: String
    var email: String
    var phone: String
    var points: Int
    var role: Int
    var communityID: Int
    var password: String
}

struct VolunteerRecordID {
    var recordID: CKRecord.ID?
}
