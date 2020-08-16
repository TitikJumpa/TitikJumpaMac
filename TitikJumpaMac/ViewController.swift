//
//  ViewController.swift
//  TitikJumpaMac
//
//  Created by Sufiandy Elmy on 16/08/20.
//  Copyright © 2020 Sufiandy Elmy. All rights reserved.
//

import SideMenu
import UIKit

class ViewController: UIViewController {
    
    var menu: SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }
    
    @IBAction func didTapMenu (){
        present(menu!, animated: true)
        
    }

}

class MenuListController: UITableViewController {
    
    var items = ["Upcoming Events", "Add Events"]
    
    let color = UIColor (red: 0.0/255, green: 24.0/255, blue: 50.0/255, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = color
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath )
        
        cell.textLabel?.text  = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = color
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

 
