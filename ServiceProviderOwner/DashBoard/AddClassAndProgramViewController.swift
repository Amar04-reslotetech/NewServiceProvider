//
//  AddClassAndProgramViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 07/09/21.
//

import UIKit
import iOSDropDown

class AddClassAndProgramViewController: UIViewController {

    @IBOutlet weak var txtBookingDate: UITextField!
    @IBOutlet weak var txtSelectProgram: DropDown!
    @IBOutlet weak var txtSelectClient: DropDown!
    var serviceeProviderList = [serviceProvider]()
    var cleint_Name = [String]()
    var client_ID_Array = [Int]()
    var businessArray = [String]()
    var client_ID = 0
    let datePicker = UIDatePicker()
    var isCOming = false
    var history:ClientList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.preferredDatePickerStyle = .wheels
      
        datePicker.datePickerMode = .date
        self.addDatePicker(datePicker, textfield:txtBookingDate , selector: #selector(donePressed))

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getClient()
        if isCOming == true
        {
            txtBookingDate.text = history!.date!
            txtSelectClient.text = history!.client_Name!
            txtSelectProgram.text = history!.class_Name!
        }
    }
    
    func addDatePicker(_ datepicker : UIDatePicker, textfield: UITextField, selector: Selector) {
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:selector)
        let cancleButton =  UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
        let spaceButton =  UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
        toolbar.setItems([cancleButton,spaceButton ,doneButton], animated: false)
        textfield.inputAccessoryView = toolbar
        textfield.inputView = datePicker
        
    }
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.dateFormat = DateFormats.format13.rawValue
        txtBookingDate.text = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        view.endEditing(true)
     getBusiness()
        
      
       
        
    }

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


//MARKS: get Client
extension AddClassAndProgramViewController
{
    func   getClient()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!,"type":"All"]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.getServicesProviderList(param,header)
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
                   let cleint_List = res!["clientList"] as! Array<Dictionary<String,Any>>
                    if cleint_List != nil
                    {
                        for i in cleint_List
                        {
                        let objec = serviceProvider(object: i)
                            self.client_ID_Array.append(objec.id!)
                            self.cleint_Name.append(objec.firstName!)
                        self.serviceeProviderList.append(objec)
                        }
                    }
                    
                    self.txtSelectClient.listWillAppear {
                        self.view.endEditing(true)
                    }
                    
                    self.txtSelectClient.optionArray = self.cleint_Name
                    self.txtSelectClient.optionIds = self.client_ID_Array
                    self.txtSelectClient.didSelect{(selectedText , index ,id) in
                        self.txtSelectClient.text = "\(selectedText)"
                        self.client_ID = id
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



//MARKS: Get Business
extension AddClassAndProgramViewController
{
    func getBusiness()
    {
        
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!,"date":txtBookingDate.text!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.getBookingDate(param,header)
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
                   let cleint_List = res!["classList"] as! Array<Any>
                    if cleint_List != nil
                    {
                        for i in cleint_List
                        {
                            
                            self.businessArray.append(i as! String)
//                        let objec = serviceProvider(object: i)
//                            self.client_ID_Array.append(objec.id!)
//                            self.cleint_Name.append(objec.firstName!)
//                        self.serviceeProviderList.append(objec)
                        }
                    }
                    
                    self.txtSelectClient.listWillAppear {
                        self.view.endEditing(true)
                    }
                    
                    self.txtSelectProgram.optionArray = self.businessArray
//                    self.txtSelectClient.optionIds = self.client_ID_Array
                    self.txtSelectProgram.didSelect{(selectedText , index ,id) in
                        self.txtSelectProgram.text = "\(selectedText)"
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



//MARKS: Add Cleint Booking Pressed
extension AddClassAndProgramViewController
{
    @IBAction func btnSavePressed(_ sender:UIButton)
    {
        
        if txtSelectClient.text?.isEmpty == true
        {
            
        }
        else if txtBookingDate.text?.isEmpty == true
        {
            
        }
        else if txtSelectProgram.text?.isEmpty == true
        {
            
        }
        else
        {
            if isCOming == true
            {
                editClient()
            }
            else
            {
            addClientBooking()
            }
        }
        
    }
}


//MARKS: Add Client Booking
extension AddClassAndProgramViewController
{
    func  addClientBooking()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!,"classID":txtSelectProgram.text!,"clientID":client_ID,"date":txtBookingDate.text!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.addClientBooking(param,header)
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
                    let vc = story.instantiateViewController(identifier: "ClientBookingViewController") as! ClientBookingViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                
                }
                    
                 
                    
                
                else
                {

                    
                }
               
        
            }
    }
    }
    
}


//MARKS: Edit Client Booking
extension AddClassAndProgramViewController
{
    func  editClient()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!,"classID":txtSelectProgram.text!,"clientID":client_ID,"date":txtBookingDate.text!,"bookingID":history!.id!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.EditClientBooking(param,header)
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
                    let vc = story.instantiateViewController(identifier: "ClientBookingViewController") as! ClientBookingViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                
                }
                    
                 
                    
                
                else
                {

                    
                }
               
        
            }
    }
    }
}
