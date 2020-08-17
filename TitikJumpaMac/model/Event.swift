//
//  Event.swift
//  TitikJumpaMac
//
//  Created by Sufiandy Elmy on 17/08/20.
//  Copyright © 2020 Sufiandy Elmy. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

struct Event{
    var recordID: CKRecord.ID?
    var name: String
    var description: String
    var location: String
    var total_vol: Int
    var points: Int
    var start_date: Date
    var end_date: Date
    var qrcode: String
    
}
