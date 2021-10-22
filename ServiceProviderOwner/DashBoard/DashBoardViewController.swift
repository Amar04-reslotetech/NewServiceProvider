//
//  DashBoardViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 03/06/21.
//

import UIKit

class DashBoardViewController: UIViewController {

    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var lblTotalSLots: UILabel!
    @IBOutlet weak var lblTodayBookSlots: UILabel!
    @IBOutlet weak var lblActiveClient: UILabel!
    @IBOutlet weak var lblTotalCLient: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 50
        height.constant = 0

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
    }
    

   

}



//MARKS: Add Client Pressed
extension DashBoardViewController
{
    @IBAction func btnAddClientPreesed(_ sender:UIButton)
    {
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "ViewServicesProviderViewController") as! ViewServicesProviderViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARKS: Add Availability Pressed
extension DashBoardViewController
{
    @IBAction func btnAddAvailabilityPressed(_ sender:UIButton)
    {
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "MyBookIngViewController") as! MyBookIngViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



//MARKS: Side Menu Open
extension DashBoardViewController
{
    @IBAction func btnSideMenuPressed(_ sender:UIButton)
    {
        revealViewController().revealToggle(sender)
    }
}


///MARKS: Get Data
extension DashBoardViewController
{
    func  getData()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.getDashBoard(param,header)
        {  (res, err)  in
//            print(res!)
            if err != nil
            {
                self.removeSpinner()

            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                  
                    self.removeSpinner()
                    self.lblActiveClient.text = String(res!["activeClients"] as! Int)
                    self.lblTotalSLots.text = String(res!["totalSpaces"] as! Int)
                    self.lblTotalCLient.text = String(res!["totalClients"] as! Int)
                    self.lblTodayBookSlots.text = String(res!["todaysBookedSpaces"] as! Int)
//                    self.lblActiveProvider.text! = String(res!["activeProviders"] as! Int)
//                    self.lblTotalProvider.text! = String(res!["totalProviders"] as! Int)
//                    self.lblTotalSpace.text! = String(res!["totalSpaces"] as! Int)
//                    self.lblTodaysBookedSpace.text! = String(res!["todaysBookings"] as! Int)
                    
                }
                else
                {
                    self.removeSpinner()

                    
                }
               
        
            }
    }
    }
}

