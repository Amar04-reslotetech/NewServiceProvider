//
//  ClientHistory.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 26/08/21.
//

import Foundation

struct ClientHistory {
    var name:String?
    var id:Int?
    var address:String?
    var conatct:Int?
    var email:String?
    
    init(object:[String:Any]) {
        name = object["clientName"] as? String ?? ""
        id = object["clientID"] as? Int ?? 0
        address = object["clientAddress"] as? String ?? ""
        conatct = object["contact"] as? Int ?? 0
        email = object["email"] as? String ?? ""
    }
}
