//
//  ClassSpBooking.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 08/09/21.
//

import Foundation
struct ClassSpBooking {
    var id:Int?
    var date:String?
    var space_Name:String?
    init(object:[String:Any]) {
        id = object["bookingID"] as? Int ?? 0
        date = object["dates"] as? String ?? ""
        space_Name = object["spaceName"] as? String ?? ""
        
    }
}
