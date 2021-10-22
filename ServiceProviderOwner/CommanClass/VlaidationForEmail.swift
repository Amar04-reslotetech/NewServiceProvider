//
//  VlaidationForEmail.swift
//  Resolutek_Agent
//
//  Created by Amar Patil on 07/12/20.
//

import Foundation


func validpassword(mypassword : String) -> Bool
    {

        let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: mypassword)
    }
