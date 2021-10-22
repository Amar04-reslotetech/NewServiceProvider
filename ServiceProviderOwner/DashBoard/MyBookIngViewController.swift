//
//  MyBookIngViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 23/08/21.
//

import UIKit

class MyBookIngViewController: UIViewController {
    
    var type = ""
    var serviceeProviderList = [MyBooking]()
    var searchServiceProvider = [MyBooking]()

    @IBOutlet weak var lblAll: UILabel!
    @IBOutlet weak var lblActive: UILabel!
    @IBOutlet weak var myHideShowView: UIView!
    @IBOutlet weak var btnHide: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.type = "Active"
        getList()
        myHideShowView.isHidden = true
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
             self.lblActive.isUserInteractionEnabled = true
             self.lblActive.addGestureRecognizer(labelTap)
        let labelTap1 = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped1(_:)))
             self.lblAll.isUserInteractionEnabled = true
             self.lblAll.addGestureRecognizer(labelTap1)
        
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
            print("labelTapped")
        self.type = "Active"
        
        myHideShowView.isHidden = true
        }
    @objc func labelTapped1(_ sender: UITapGestureRecognizer) {
            print("labelTappedffvf")
        self.type = "All"
        myHideShowView.isHidden = true
        }
   
}


//MARKS: Add Booking Pressed
extension MyBookIngViewController
{
    @IBAction func btnAddBookingPressed(_ sender:UIButton)
    {
        
    }
}


//MARKS: Back Button Pressed
extension MyBookIngViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARKS: Hide and Show Fillter Pressed
extension MyBookIngViewController
{
    @IBAction func btnHodeShowFillterPressed(_ sender:UIButton)
    {
        
        myHideShowView.isHidden = false
        
        
    }
}


//MARKS: Get Data
extension MyBookIngViewController
{
    func getList()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!,"type":self.type]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
    Api.getServicesProviderHistoryList(param,header)
        {  (res, err)  in
            print(res!)
            if err != nil
            {
                self.removeSpinner()
//                self.noHistory.isHidden = false
                self.tableView.isHidden = true
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
//                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                  
//                    self.noHistory.isHidden = true
                    self.tableView.isHidden = false
//                    self.serviceeProviderList.removeAll()
                   let cleint_List = res!["spaceList"] as! Array<Dictionary<String,Any>>
                    if cleint_List != nil
                    {
                        for i in cleint_List
                        {
                        let objec = MyBooking(object: i)
                        self.serviceeProviderList.append(objec)
                        }
                    }
//
                    self.searchServiceProvider = self.serviceeProviderList
//
                    self.removeSpinner()
                    self.tableView.reloadData()
                    
                }
                else
                {
                    self.removeSpinner()
//                    self.noHistory.isHidden = false
                    self.tableView.isHidden = true
//                    self.txtEmail.text = ""
//                    self.showNotification(title: "App name", message: res!["Message"] as? String ?? "")
                    
                }
               
        
            }
    }
    }
}


//MARKS: TableVIew DataSource
extension MyBookIngViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceeProviderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var indec = serviceeProviderList[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyBookingTableViewCell
        cell.setupUI(with: indec)
      
        return cell
    }
}


//MARKS: TableView Delegate
extension MyBookIngViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = serviceeProviderList[indexPath.item]
        let story:UIStoryboard = UIStoryboard.init(name:"Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "BookingDeatilsViewController") as! BookingDeatilsViewController
        vc.data = index
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


