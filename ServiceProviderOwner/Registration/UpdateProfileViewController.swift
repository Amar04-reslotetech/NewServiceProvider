//
//  UpdateProfileViewController.swift
//  ServiceProvider
//
//  Created by Amar Patil on 16/04/21.
//

import UIKit

class UpdateProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtContact: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getProfile()
        txtEmail.isUserInteractionEnabled = false
        txtPassword.isSecureTextEntry = true
        txtConfirmPassword.isSecureTextEntry = true
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        txtPassword.autocorrectionType = .no
        txtConfirmPassword.autocorrectionType = .no
        
        txtPassword.addTarget(self, action: #selector(UpdateProfileViewController.password(_:)), for: .editingDidEnd)
        txtConfirmPassword.addTarget(self, action: #selector(UpdateProfileViewController.confirmPassword(_:)), for: .editingDidEnd)

        // Do any additional setup after loading the view.
    }
    
    @objc func password(_ textfield:UITextField)
    {
        if txtPassword.text?.isEmpty == true
        {
        }
    }
    @objc func confirmPassword(_ textfield:UITextField)
    {
        if txtPassword.text?.isEmpty == true
        {
            txtConfirmPassword.text = ""
            let alert = UIAlertController(title: "Alert", message: "Enter Password First", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        else if txtPassword.text! != txtConfirmPassword.text!
        {
            txtPassword.text = ""
            txtConfirmPassword.text = ""
            let alert = UIAlertController(title: "Alert", message: "Both Are Not match", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    

  
}



//MARKS: Back Button Pressed
extension UpdateProfileViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARKS: Update Pressed
extension UpdateProfileViewController
{
    @IBAction func btnUpdatePressed(_ sender:UIButton)
    {
      
        if txtName.text?.isEmpty == true
        {
            self.showNotification(title: "App name", message: "Name Required")
        }
        else if txtEmail.text?.isEmpty == true
        {
            self.showNotification(title: "App name", message: "Email Required")
        }
        else if txtContact.text?.isEmpty == true
        {
            self.showNotification(title: "App name", message: "Contact Required")
        }
        else if txtPassword.text?.isEmpty == true
        {
            self.showNotification(title: "App name", message: "Password Required")
        }
        else if txtConfirmPassword.text?.isEmpty == true
        {
            self.showNotification(title: "App name", message: "Confirm Password Required")
        }
        else
        {
            self.showSpinner(onView: view)
            updateProfile()
        }
        
    }
}



//MARKS: Get Profile
extension UpdateProfileViewController
{
    func getProfile()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.getProfileDetails(param,header)
        {  (res, err)  in
//            print(res!)
            if err != nil
            {
                self.removeSpinner()
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
//                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                  
                  
                    self.txtName.text = res!["name"] as? String ?? ""
                    self.txtEmail.text = res!["email"] as? String ?? ""
                    var num = res!["contact"] as? Int ?? 0
                    self.txtContact.text = num.toString()
                    self.txtPassword.text = res!["password"] as? String ?? ""
                    self.txtConfirmPassword.text = res!["password"] as? String ?? ""
                     
                }
                else
                {
                    self.removeSpinner()
//                    self.txtEmail.text = ""
//                    self.showNotification(title: "App name", message: res!["Message"] as? String ?? "")
                    
                }
               
        
            }
    }
    }
}


//MARKS: Update Profile APi
extension UpdateProfileViewController
{
    func  updateProfile()
    {
        var param = [String:Any]()
      
        param = ["name":txtName.text!,"phone":self.txtContact.text!,"email":self.txtEmail.text!,"password":self.txtPassword.text!,"spID":UserDefaults.standard.value(forKey: "ID")!]
        print("parameter update profile \(param)")
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.updateProfile(param,header)
        {  (res, err)  in
    //            print(res!)
            if err != nil
            {
                self.removeSpinner()
    //                AlertFunctions.showAlert(message: err!)
    //                self.txtEmail.text = ""
                
//                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                    self.removeSpinner()
                    
                    UserDefaults.standard.set(self.txtName.text!, forKey: "name")
                    UserDefaults.standard.set(self.txtEmail.text!, forKey: "email")
                   
                    let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let sw = story.instantiateViewController(withIdentifier: "sw") as! SWRevealViewController
                    self.navigationController?.pushViewController(sw, animated: true)
                    
//                    self.showNotification(title: "App name", message: res!["Message"] as? String ?? "")
                    
                }
                else
                {
                    self.removeSpinner()
    //                    self.txtEmail.text = ""
//                    self.showNotification(title: "App name", message: res!["Message"] as? String ?? "")
                    
                }
        }
        }
    }
}
