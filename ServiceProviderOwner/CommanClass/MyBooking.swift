//
//  MyBooking.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 23/08/21.
//

import Foundation

struct MyBooking {
    var space_Name:String?
     var address:String?
    var start_Date:String?
    var end_Date:String?
    var slotArray:Array<String>?
    var id:Int?
    
    
    init(object:[String:Any]) {
        space_Name = object["spaceName"] as? String ?? ""
        address = object["spaceAddress"] as? String ?? ""
        start_Date = object["startDate"] as? String ?? ""
        end_Date = object["endDate"] as? String ?? ""
        slotArray = object["startTime"] as? Array<String>
        id = object["spaceAllocateID"] as? Int ?? 00
     }
    
    
}
