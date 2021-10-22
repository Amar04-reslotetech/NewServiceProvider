//
//  AddClientViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 03/06/21.
//

import UIKit

class AddClientViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtAddresss: UITextField!
    @IBOutlet weak var txtContactNo: UITextField!
    
    @IBOutlet weak var txtEnail: UITextField!
   
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    var isComigFrom = false
    var ServiceProvder:serviceProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEnail.delegate = self
        self.txtEnail.addTarget(self, action: #selector(AddClientViewController.textFieldDidChange1(_:)), for: UIControl.Event.editingDidEnd)
        
        if isComigFrom == true
        {
            txtEnail.text = ServiceProvder!.email!
            txtLastName.text = ServiceProvder!.lastName!
            txtFirstName.text = ServiceProvder!.firstName!
            txtContactNo.text = ServiceProvder!.contact!.toString()
            txtAddresss.text = ServiceProvder!.address!
        }

        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange1(_ textfield:UITextField)
    {
        if   self.txtEnail.text == ""
        {
            
        }
        else if self.txtEnail.text!.isValidEmailId() == false
        {
            txtEnail.text = ""
            let alert = UIAlertController(title: "Alert", message: "Enter Valid Email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            
        }
    }
   

}


//MARKS: Add Client Pressed
extension AddClientViewController
{
    @IBAction func btnAddClientPressed(_ sender:UIButton)
    {
        if txtFirstName.text?.isEmpty ==  true
        {
            let alert = UIAlertController(title: "Alert", message: "First name Required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if txtLastName.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "Alert", message: "Last name Required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if txtEnail.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "Alert", message: "Email Required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if txtContactNo.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "Alert", message: "Contact Number Required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if txtAddresss.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "Alert", message: "Address Required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            if isComigFrom == true
            {
                editClientApi()
            }
            else
            {
            addClientApi()
            }
//            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
//            let vc = story.instantiateViewController(identifier: "ViewServicesProviderViewController") as! ViewServicesProviderViewController
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


//MARKS: Back Button Pressed
extension AddClientViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARKS: Add CLient Api
extension AddClientViewController
{
    func  addClientApi()
    {
        var param = [String:Any]()
       
        param = ["email":self.txtEnail.text!,"firstName":self.txtFirstName.text!,"phone":txtContactNo.text!,"address":txtAddresss.text!,"spID":UserDefaults.standard.value(forKey: "ID")!,"lastName":txtLastName.text!]
        print("parameter add services Provider  \(param)")
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        Api.addServicesProvider(param,header)
        {  (res, err)  in
            self.removeSpinner()
            if err != nil
            {
                self.removeSpinner()
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                    self.removeSpinner()
                   
                    let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let sw = story.instantiateViewController(withIdentifier: "ViewServicesProviderViewController") as! ViewServicesProviderViewController
                    self.navigationController?.pushViewController(sw, animated: true)

                }
                else
                {
                    self.removeSpinner()

                }
        }
        }
    }
}


//MARKS: Edit Client Api
extension AddClientViewController
{
    func editClientApi()
    {
        var param = [String:Any]()
       
        param = ["email":self.txtEnail.text!,"firstName":self.txtFirstName.text!,"phone":txtContactNo.text!,"address":txtAddresss.text!,"lastName":txtLastName.text!,"clientID":ServiceProvder!.id!]
        print("parameter add services Provider  \(param)")
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        Api.EditServicesProvider(param,header)
        {  (res, err)  in
            self.removeSpinner()
            if err != nil
            {
                self.removeSpinner()
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                    self.removeSpinner()
                   
                    let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let sw = story.instantiateViewController(withIdentifier: "ViewServicesProviderViewController") as! ViewServicesProviderViewController
                    self.navigationController?.pushViewController(sw, animated: true)

                }
                else
                {
                    self.removeSpinner()

                }
        }
        }
    }
}
