//
//  UpcomingEventVC.swift
//  TitikJumpaMac
//
//  Created by Sufiandy Elmy on 17/08/20.
//  Copyright © 2020 Sufiandy Elmy. All rights reserved.
//

import Foundation
import UIKit
import CloudKit
class UpcomingViewController: UIViewController {

    var events: [Event] = [Event]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getData()
    }

    func getData(){
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: "Event", predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        var listElement: Event!
        
        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                print(record["name"])
                let recordID = record.recordID
                guard let name = record["name"] as? String else {return}
                guard let location = record["location"] as? String else {return}
                guard let total_vol = record["total_vol"] as? Int else {return}
                guard let points = record["points"] as? Int else {return}
                guard let start_date = record["start_date"] as? Date else {return}
                guard let end_date = record["end_date"] as? Date else {return}
                guard let qrcode = record["qrcode"] as? String else {return}
                let description = record["description"] as? String ?? "no description"
                listElement = Event(recordID: recordID, name: name, description: description, location: location, total_vol: total_vol, points: points, start_date: start_date, end_date: end_date, qrcode: qrcode)
                self.events.append(listElement)
            }
        }
        
        operation.queryCompletionBlock = { cursor, error in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if let err = error {
                    //completion(.failure(err), false)
                    return
                }else{
                    //completion(.success(listElement), true)
                }
                
            }
            
        }
        
        CKContainer(identifier: "iCloud.titikjumpa").publicCloudDatabase.add(operation)
    }
    
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as? EventCell else {return UITableViewCell()}
        cell.configure(event: events[indexPath.section])

        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailEvent", sender: events[indexPath.section])
        //segue here
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetailEvent") {
            print(sender)
            guard let object = sender as? Event else { return }
            let vc = segue.destination as! GenerateQRCode
            vc.event = object
        }
    }
}
