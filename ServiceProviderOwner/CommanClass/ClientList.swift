//
//  ClientList.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 07/09/21.
//

import Foundation

struct ClientList {
    var client_Name:String?
    var space_Name:String?
    var class_Name:String?
    var date:String?
    var time:String?
    var id:Int?
    
    init(obj:[String:Any]) {
        client_Name = obj["clientName"] as? String ?? ""
        space_Name = obj["spaceName"] as? String ?? ""
        class_Name = obj["className"] as? String ?? ""
        date = obj["date"] as? String ?? ""
        time = obj["slot"] as? String ?? ""
        id = obj["bookingID"] as? Int ?? 0
    }
}
