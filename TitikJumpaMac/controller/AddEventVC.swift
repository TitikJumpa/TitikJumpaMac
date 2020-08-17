//
//  AddEventVC.swift
//  TitikJumpaMac
//
//  Created by Sufiandy Elmy on 17/08/20.
//  Copyright © 2020 Sufiandy Elmy. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class AddEventViewController: UIViewController {
    
    
    let publicdatabase = CKContainer(identifier: "iCloud.titikjumpa").publicCloudDatabase
    
    @IBOutlet weak var nameEvent: UITextField!
    @IBOutlet weak var locationEvent: UITextField!
    @IBOutlet weak var descEvent: UITextField!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var totalVolunteer: UITextField!
    @IBOutlet weak var points: UITextField!
    @IBOutlet weak var qrcode: UITextField!
    @IBOutlet weak var saved: UIButton!
    
    override func viewDidLoad() {
    super.viewDidLoad()

        
    }
    
    @IBAction func saved(_ sender: Any) {
   
        
        var event = Event(recordID: CKRecord.ID(), name: nameEvent.text!, description: descEvent.text!, location: locationEvent.text!, total_vol: Int(totalVolunteer.text!)!, points: Int(points.text!)!, start_date: startDate.date, end_date: endDate.date, qrcode: qrcode.text!)
        
   
        
        //segue
          performSegue(withIdentifier:"BacktoMain", sender: nil)

        // Haptic
        AddEvent(event: event)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        //dialog alert
           let alert = UIAlertController(title:"You're added to event!", message:"Yay!!", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Yeah!!", style: .default, handler: { (UIAlertAction) in
               
           }))
           present(alert, animated: true)
    }
    func AddEvent(event: Event){
               let itemRecord = CKRecord(recordType: "Event")
               itemRecord["name"] = event.name as CKRecordValue
               itemRecord["location"] = event.location as CKRecordValue
               itemRecord["total_vol"] = event.total_vol as CKRecordValue
               itemRecord["points"] = event.points as CKRecordValue
               itemRecord["start_date"] = event.start_date as CKRecordValue
               itemRecord["end_date"] = event.end_date as CKRecordValue
               itemRecord["qrcode"] = event.qrcode as CKRecordValue

               CKContainer(identifier: "iCloud.titikjumpa").publicCloudDatabase.save(itemRecord) { (record, err) in
                   DispatchQueue.main.async {
                       if let err = err {
                           print("error \(err)")
                           return
                       }

                   }
               }
               
               
               
           }
        
        
    }
