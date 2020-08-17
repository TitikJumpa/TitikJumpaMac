//
//  SignInViewController.swift
//  TitikJumpaMac
//
//  Created by Sufiandy Elmy on 17/08/20.
//  Copyright © 2020 Sufiandy Elmy. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class SignInViewController: UIViewController {

    let publicdatabase = CKContainer(identifier: "iCloud.titikjumpa").publicCloudDatabase
    
    @IBOutlet weak var emailfield: UITextField!
    @IBOutlet weak var passwordfield: UITextField!
    
    public var verifyStatus = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//            if CoreSign.sharedLogin.isLogin() {
//                print("mantap")
//                print(CoreSign.sharedLogin.isLogin())
//                performSegue(withIdentifier: "mainScreen", sender: nil)
//            }else{
//                print("false")
//                print(CoreSign.sharedLogin.isLogin())
//
//            }
    }

    
    class CoreSign {
        
        static let sharedLogin = CoreSign()
        
        func isLogin() -> Bool {
            return UserDefaults.standard.bool(forKey: "isLogin")
        }
        
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        // Haptic
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        validate(emailverify: emailfield.text!, passwordverify: passwordfield.text!) { (result) in
            switch result {
            case .success(let cek):
                if cek == true {
                    self.performSegue(withIdentifier: "mainScreen", sender: nil)
                }else{
                    let alert = UIAlertController(title: "Wrong Username/Password", message: "Wrong Username/Password. Case Sensitive", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                        //action
                    }))
                    self.present(alert, animated: true)
                }
            case .failure(_):
                print("fail")
            }
        }
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        // Haptic
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        performSegue(withIdentifier: "BackSignUp", sender: nil)
    }
    
    
    //Validate
    func validate(emailverify: String, passwordverify: String, completion: @escaping (Result<Bool, Error>) -> ()){
        var cek = false
        let email = emailverify
        let password = passwordverify
        
        let predicate = NSPredicate(format: "email == %@", email)
        let query = CKQuery(recordType: "Volunteer", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                print(record["email"]!)
                if( email == record["email"]! && password == record["password"]! ){
                    //Berhasil
                    print("Berhasil")
                    let defaults = UserDefaults.standard
                    defaults.set(self.emailfield.text, forKey: "email")
                    defaults.set(true, forKey: "isLogin")
                    print("ini isLogin : \(defaults.bool(forKey: "isLogin"))")
                    
                    print("\(record.recordID)")
                    
                    //defaults.set(record.recordID, forKey: "recordID")
                    
//                    Volunteer(recordID: record.recordID, name: record["name"] as! String, email: record["email"] as! String, phone: record["phone"] as! String, points: record["points"] as! Int, role: record["role"] as! Int, communityID: record["communityID"] as! Int, password: record["password"] as! String)
                    VolunteerRecordID(recordID: record.recordID)
                    cek = true
                    completion(.success(cek))
                }else{
                    completion(.success(cek))
                    print("Salah")
                    
                }
                
            }
            
        }
    operation.queryCompletionBlock = {cursor, error in
        DispatchQueue.main.async {
            completion(.success(cek))
        }
    }
        
    
        publicdatabase.add(operation)
        
    }
    
    
    
}

