//
//  LoginViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 03/06/21.
//

import UIKit

class LoginViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var heightlblConfirmPassword: NSLayoutConstraint!
    
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var heightConfirmPassord: NSLayoutConstraint!
    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var heightLoginButton: NSLayoutConstraint!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var heighttxtPassword: NSLayoutConstraint!
    @IBOutlet weak var txtEmail: UITextField!
    var paswword = ""
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var heightlblPassword: NSLayoutConstraint!
    @IBOutlet weak var lblPassword: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "ID") != nil
        {
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "sw") as! SWRevealViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        heighttxtPassword.constant = 0
        heightlblPassword.constant = 0
        heightLoginButton.constant = 0
        self.heightConfirmPassord.constant = 0
        self.heightlblConfirmPassword.constant = 0
        btnLogin.isHidden = true
        txtEmail.delegate = self
        txtConfirmPassword.delegate = self
        self.txtEmail.addTarget(self, action: #selector(LoginViewController.textFieldDidChange1(_:)), for: UIControl.Event.editingDidEnd)
        self.txtPassword.addTarget(self, action: #selector(LoginViewController.textFieldDidChange2(_:)), for: UIControl.Event.editingDidEnd)
        self.txtConfirmPassword.addTarget(self, action: #selector(LoginViewController.textFieldDidChange3(_:)), for: UIControl.Event.editingDidEnd)

       
    }
    

    @objc func textFieldDidChange1(_ textfield:UITextField)
    {
        if   self.txtEmail.text == ""
        {
            
        }
        else if self.txtEmail.text!.isValidEmailId() == false
        {
            txtEmail.text = ""
            let alert = UIAlertController(title: "Alert", message: "Enter Valid Email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            verifyEmail()
        }
    }
    @objc func textFieldDidChange2(_ textfield:UITextField)
    {
        if   self.txtPassword.text == ""
        {
            
        }
        else if paswword == ""
        {
            
        }
        
        else if self.txtPassword.text! != paswword
        {
            txtPassword.text = ""
            let alert = UIAlertController(title: "Alert", message: "Enter Valid Password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            
        }
    }
    
    @objc func textFieldDidChange3(_ textfield:UITextField)
    {
        if   self.txtConfirmPassword.text == ""
        {
            
        }
        
        else if self.txtConfirmPassword.text! != txtPassword.text
        {
            txtPassword.text = ""
            let alert = UIAlertController(title: "Alert", message: "Enter Valid Password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            
        }
    }

}



//MARKS: Login Button Pressed
extension LoginViewController
{
    @IBAction func btnLoginPressed(_ sender:UIButton)
    {
        
        if paswword == ""
        {
            if txtEmail.text?.isEmpty == true
            {
                let alert = UIAlertController(title: "Alert", message: "Email Required", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if txtPassword.text?.isEmpty == true
            {
                let alert = UIAlertController(title: "Alert", message: "Password Required", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if txtConfirmPassword.text?.isEmpty == true
            {
                let alert = UIAlertController(title: "Alert", message: "Confirm Password Required", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            }
            else
            {
               loginAPI()
            }
        }
        else
        {
        if txtEmail.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "Alert", message: "Email Required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if txtPassword.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "Alert", message: "Password Required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
           loginAPI()
        }
        }
        
    }
}


//MARKS: Login APi Call
extension LoginViewController
{
    func loginAPI()
    {
        var param = [String:Any]()
       
        param = ["email":self.txtEmail.text!,"password":self.txtPassword.text!,"token":UserDefaults.standard.value(forKey: "deviceToken")! ]
        print("parameter Login  \(param)")
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.loginAPI(param,header)
        {  (res, err)  in
    
            if err != nil
            {
  
                self.removeSpinner()
                    self.txtEmail.text = ""
                self.txtPassword.text = ""
                

            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                    self.removeSpinner()
                    let id = res!["id"] as! Int
                    UserDefaults.standard.setValue(id, forKey: "ID")
                    let name = res!["name"] as? String ?? ""
                    let email = res!["email"] as? String ?? ""
                    UserDefaults.standard.set(name, forKey: "name")
                    UserDefaults.standard.set(email, forKey: "email")
                    let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let sw = story.instantiateViewController(withIdentifier: "sw") as! SWRevealViewController
                    self.navigationController?.pushViewController(sw, animated: true)

                    
                }
                else
                {
                    self.removeSpinner()
                        self.txtEmail.text = ""
                        self.txtPassword.text = ""

                    
                }
        }
        }
    }
}


//MARKS: Verify Email APi
extension LoginViewController
{
    func verifyEmail()
    {
        var param = [String:Any]()
       
        param = ["email":self.txtEmail.text!]
        print("parameter Verify Email  \(param)")
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.verifyEmail(param,header)
        { [self]  (res, err)  in
    //            print(res!)
            if err != nil
            {
    //                AlertFunctions.showAlert(message: err!)
//                    self.txtEmail.text = ""
//
                self.showNotification(title: "App name", message: err!)
           
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                    paswword = res!["password"] as? String ?? ""
                    if paswword == ""
                    {
                    self.heightConfirmPassord.constant = 50
                    self.heightlblConfirmPassword.constant  = 21
                    self.heighttxtPassword.constant = 50
                    self.heightlblPassword.constant = 21
                    self.heightLoginButton.constant = 60
                    self.btnLogin.isHidden = false
                    }
                    else
                    {
                       
                        self.heighttxtPassword.constant = 50
                        self.heightlblPassword.constant = 21
                        self.heightLoginButton.constant = 60
                        self.btnLogin.isHidden = false
                    }
                    

                }
                else
                {
//                        self.txtEmail.text = ""
                
                    
                    self.showNotification(title: "App name", message: res!["message"] as? String ?? "")
                    
                }
        }
        }
    }
    }

