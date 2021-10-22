//
//  serviceProvider.swift
//  ServiceProvider
//
//  Created by Amar Patil on 07/05/21.
//

import Foundation
struct serviceProvider
{
    var id:Int?
    var firstName:String?
    var lastName:String?
    var address:String?
    var email:String?
    var contact:Int?
    var currentSpace:String?
    var f_Id:Int?
    var business:String?
    var space:String?
    var start_Date:String?
    var end_Date:String?
    var category:String?
    
    init(object:[String:Any])
    {
        id = object["client_id_i"] as? Int ?? 0
        firstName = object["firstName"] as? String ?? ""
        address = object["address"] as? String ?? ""
        email = object["email"] as? String ?? ""
        contact = object["contact"] as? Int ?? 0
        lastName = object["lastName"] as? String ?? ""
    }
}
