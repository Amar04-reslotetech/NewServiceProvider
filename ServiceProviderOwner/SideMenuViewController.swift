//
//  SideMenuViewController.swift
//  GymTime_IosApp
//
//  Created by MaibaMM01 on 24/07/19.
//  Copyright © 2019 maibasoft. All rights reserved.
//

import UIKit


class SideMenuViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource
{

 
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblComapnyName: UILabel!
    
       var SideArray = ["name","Collection","Lead","Enroll","Switch","LogOut","Dami","staff"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.width-50
        lblUserName.text = UserDefaults.standard.value(forKey: "name")! as? String
        lblComapnyName.text = UserDefaults.standard.value(forKey: "email")! as? String


       
        
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SideArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = SideArray[indexPath.row]
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier , for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = SideArray[indexPath.row]
        if index == "Switch"
        {
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "UpdateProfileViewController") as! UpdateProfileViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if index == "name"
        {
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "ClientHistoryViewController") as! ClientHistoryViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if index == "Collection"
        {
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "ClientBookingViewController") as! ClientBookingViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if index == "staff"
        {
            
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
        
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if index == "Enroll"
        {
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "MyBookingHistoryViewController") as! MyBookingHistoryViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if index == "Lead"
        {
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "ClassAndProgramViewController") as! ClassAndProgramViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        
        revealViewController()?.revealToggle(animated: true)
    }
    
    
    
    

}
