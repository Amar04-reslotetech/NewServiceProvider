//
//  AddBookingFirstViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 26/08/21.
//

import UIKit

class AddBookingFirstViewController: UIViewController {
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    var spaceListArray = [SpaceList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker1.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker1.datePickerMode = .date
        
        self.addDatePicker(datePicker, textfield:txtStartDate , selector: #selector(donePressed))
        self.addDatePicker1(datePicker1, textfield:txtEndDate , selector: #selector(donePressed3))

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.tableFooterView = UIView()
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
    
    func addDatePicker1(_ datepicker : UIDatePicker, textfield: UITextField, selector: Selector) {
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:selector)
        let cancleButton =  UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
        let spaceButton =  UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
        toolbar.setItems([cancleButton,spaceButton ,doneButton], animated: false)
        textfield.inputAccessoryView = toolbar
        textfield.inputView = datePicker1
        
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.dateFormat = DateFormats.format13.rawValue
        txtStartDate.text = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
     
        
        view.endEditing(true)
       
        
    }
    @objc func donePressed3(){
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.dateFormat = DateFormats.format13.rawValue
        txtEndDate.text = dateFormatter.string(from: datePicker1.date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
     
        
        view.endEditing(true)
       
        
    }

}

//MARKS: Back Button Pressed
extension AddBookingFirstViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARKS: Get Availble Space Action
extension AddBookingFirstViewController
{
    @IBAction func btnGetAvailablePressed(_ sender:UIButton)
    {
        if txtStartDate.text?.isEmpty == true
        {
            
        }
        else if txtEndDate.text?.isEmpty == true
        {
            
        }
        else
        {
            getSpaceData()
        }
        
    }
}


//MARKS: TableView Dataspurce
extension AddBookingFirstViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spaceListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var index = spaceListArray[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListOfSpaceTableViewCell
        cell.setupUI(with: index)
        return cell
    }
}

//MARKS: Talbeview Delegate
extension AddBookingFirstViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = spaceListArray[indexPath.row]
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "AddBookignSecondViewController") as! AddBookignSecondViewController
        vc.spaceArray = index
        vc.startDate = txtStartDate.text!
        vc.endDate = txtEndDate.text!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARKS: Get Data
extension AddBookingFirstViewController
{
    func  getSpaceData()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
    Api.getSPAvailableSpaceList(param,header)
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
                   let cleint_List = res!["SpaceList"] as! Array<Dictionary<String,Any>>
                    if cleint_List != nil
                    {
                        for i in cleint_List
                        {
                        let objec = SpaceList(object: i)
                        self.spaceListArray.append(objec)
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



