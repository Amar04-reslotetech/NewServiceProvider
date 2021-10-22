//
//  AddClassesViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 08/09/21.
//

import UIKit
import iOSDropDown

class AddClassesViewController: UIViewController {

    @IBOutlet weak var tablrView: UITableView!
    @IBOutlet weak var txtCharges: UITextField!
    @IBOutlet weak var txtTimeSlot: DropDown!
    @IBOutlet weak var lblNameOfProgram: UITextField!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnBusiness: UIButton!
    @IBOutlet weak var myHideShowView: UIView!
    var history = [ClassSpBooking]()
    var eidtHistory:ClassAndProgram?
    var isCOming = false
    var id = 0
    var timeArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getBusiness()
        myHideShowView.isHidden = true
        
        if isCOming == true
        {
            btnBusiness.setTitle(eidtHistory!.progrma!, for: .normal)
            lblNameOfProgram.text = eidtHistory!.className!
            txtTimeSlot.text = eidtHistory!.time!
            lblDate.text = eidtHistory!.dates!
            id = eidtHistory!.bookingID!
            
        }
        tablrView.tableFooterView = UIView()
    }
    

   

}


//MARKS: Back Button Pressed
extension AddClassesViewController
{
    @IBAction func btnBackPreseed(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARKS: Select Business Pressed
extension AddClassesViewController
{
    @IBAction func btnSelectBusineessPressed(_ sender:UIButton)
    {
//        history.removeAll()
        myHideShowView.isHidden = false
    }
}


//MARKS: Get Business List
extension AddClassesViewController
{
    func getBusiness()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
    Api.getSpBooking(param,header)
        {  (res, err)  in
            print(res)
            if err != nil
            {
                self.removeSpinner()
//                self.noHistory.isHidden = false
                self.tablrView.isHidden = true
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
//                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                  
//                    self.noHistory.isHidden = true
                    self.tablrView.isHidden = false
//                    self.serviceeProviderList.removeAll()
                   let cleint_List = res!["BookingList"] as! Array<Dictionary<String,Any>>
                    if cleint_List != nil
                    {
                        for i in cleint_List
                        {
                        let objec = ClassSpBooking(object: i)
                        self.history.append(objec)
                        }
                    }
////
//                    self.search_History = self.history
////
                    self.removeSpinner()
                    self.tablrView.reloadData()
                    
                }
                else
                {
                    self.removeSpinner()
                    self.tablrView.isHidden = true

                    
                }
               
        
            }
    }
    }
}

//MARKS: Tableview Datasource
extension AddClassesViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var index = history[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! MySpaceTableViewCell
        cell.lblName.text = index.space_Name!
        return cell
    }
}


//MARKS: TableView Delegate
extension AddClassesViewController:UITableViewDelegate
{
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = history[indexPath.item]
        id = index.id!
        btnBusiness.setTitle(index.space_Name, for: .normal)
        lblDate.text = index.date!
        myHideShowView.isHidden = true
        getTimeSlots()
    }
}


//MARKS: get Time Slots
extension AddClassesViewController
{
    func   getTimeSlots()
    {
        var param = [String:Any]()
        param = ["bookingID":id]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.getTimeSlots(param,header)
        {  (res, err)  in
//            print(res!)
            if err != nil
            {
                self.removeSpinner()
//                self.tableView.isHidden = true
//                self.noServicesProvider.isHidden = false
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
//                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
//                    self.tableView.isHidden = false
//                    self.noServicesProvider.isHidden = true
//                    self.serviceeProviderList.removeAll()
                    let cleint_List = res!["SlotList"] as! Array<Any>
                    if cleint_List != nil
                    {
                        for i in cleint_List
                        {
                            self.timeArray.append(i as! String)
                        }
                    }
                    
                    self.txtTimeSlot.listWillAppear {
                        self.view.endEditing(true)
                    }
                    
                    self.txtTimeSlot.optionArray = self.timeArray
//                    self.txtSelectClient.optionIds = self.client_ID_Array
                    self.txtTimeSlot.didSelect{(selectedText , index ,id) in
                        self.txtTimeSlot.text = "\(selectedText)"
//                        self.client_ID = id
                    }
                    
//                    self.searchServiceProvider = self.serviceeProviderList
                    
                    self.removeSpinner()
//                    self.tableView.reloadData()
                    
                }
                else
                {
                    self.removeSpinner()
//                    self.tableView.isHidden = true
//                    self.noServicesProvider.isHidden = false
////                    self.txtEmail.text = ""
//                    self.showNotification(title: "App name", message: res!["Message"] as? String ?? "")
                    
                }
               
        
            }
    }
        
    }
}



//MARKS: Button Save Preesed
extension AddClassesViewController
{
    @IBAction func btnSavePressed(_ sender:UIButton)
    {
        
        if id == 0
        {
        self.showNotification(title: "App name", message: "Please Select Business")
            
        }
        else if txtCharges.text?.isEmpty == true
        {
            self.showNotification(title: "App name", message: "Enter Charges")
        }
        else if txtTimeSlot.text?.isEmpty == true
        {
            self.showNotification(title: "App name", message: "Select Time Slots")
        }
        else if lblNameOfProgram.text?.isEmpty == true
        {
            self.showNotification(title: "App name", message: "Enter Name Of Program")
        }
        else
        {
            if isCOming == true
            {
                EditClassBooking()
            }
            else
            {
            addClassBooking()
            }
        }
        
    }
}


//MARKS: Cancel Pressed
extension AddClassesViewController
{
    @IBAction func btnCanclePressed(_ sender:UIButton)
    {
        myHideShowView.isHidden = true
    }
}


//MARKS: add  addClassBooking()

extension AddClassesViewController
{
    func  addClassBooking()
    {
        var param = [String:Any]()
        param = ["bookingID":id,"name":lblNameOfProgram.text!,"slot":txtTimeSlot.text!,"charges":txtCharges.text!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.postNewSpClass(param,header)
        {  (res, err)  in
//            print(res!)
            if err != nil
            {
                self.removeSpinner()
//                self.tableView.isHidden = true
//                self.noServicesProvider.isHidden = false
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
//                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
               
                    let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let vc = story.instantiateViewController(identifier: "ClassAndProgramViewController") as! ClassAndProgramViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                
                }
                    
                 
                    
                
                else
                {

                    
                }
               
        
            }
        }
    }
}


//MARKS: add  addClassBooking()

extension AddClassesViewController
{
    func  EditClassBooking()
    {
        var param = [String:Any]()
        param = ["bookingID":id,"name":lblNameOfProgram.text!,"slot":txtTimeSlot.text!,"charges":txtCharges.text!,"classID":eidtHistory!.id!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.EditNewSpClass(param,header)
        {  (res, err)  in
//            print(res!)
            if err != nil
            {
                self.removeSpinner()
//                self.tableView.isHidden = true
//                self.noServicesProvider.isHidden = false
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
//                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
               
                    let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let vc = story.instantiateViewController(identifier: "ClassAndProgramViewController") as! ClassAndProgramViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                
                }
                    
                 
                    
                
                else
                {

                    
                }
               
        
            }
        }
    }
}

