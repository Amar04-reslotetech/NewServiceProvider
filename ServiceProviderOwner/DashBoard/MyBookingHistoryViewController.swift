//
//  MyBookingHistoryViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 26/08/21.
//

import UIKit

class MyBookingHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var history = [MyBookingHistory]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.tableFooterView = UIView()
        getData()
    }
    

   
}


//MARKS: Back Button Pressed
extension MyBookingHistoryViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARKS: Get Data
extension MyBookingHistoryViewController
{
    func getData()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
    Api.HistorySP(param,header)
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
                    self.history.removeAll()
                   let cleint_List = res!["historyList"] as! Array<Dictionary<String,Any>>
                    if cleint_List != nil
                    {
                        for i in cleint_List
                        {
                        let objec = MyBookingHistory(object: i)
                        self.history.append(objec)
                        }
                    }
//
//                    self.search_History = self.history
//
                    self.removeSpinner()
                    self.tableView.reloadData()
                    
                }
                else
                {
                    self.removeSpinner()
                    self.tableView.isHidden = true

                    
                }
               
        
            }
    }
    }
}


//MARKS: Tableview Datasource
extension MyBookingHistoryViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = history[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyBookingHistoryTableViewCell
        cell.setupUI(with: index)
        cell.delegate = self
        return cell
    }
}

//MARKS: Custom Delegate
extension MyBookingHistoryViewController:HistorySP
{
    func makePayment(cell: MyBookingHistoryTableViewCell) {
        let indexPath = self.tableView.indexPathForRow(at: cell.center)!
        let data = history[indexPath.row]
        var param = [String:Any]()
        param = ["bookingID":data.id!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        
        Api.MakePayment(param,header)
        {  (res, err)  in
//            print(res!)
            if err != nil
            {
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["Success"] != nil, res!["Success"] as? Bool == true
                {
                    
                    self.getData()
                    

                    
                }
                else
                {
//                    self.txtEmail.text = ""
                    self.showNotification(title: "App name", message: res!["Message"] as? String ?? "")
                    
                }
            }
        }
        
    }
    
    
}

//MARKS:Tableview delegate
extension MyBookingHistoryViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
