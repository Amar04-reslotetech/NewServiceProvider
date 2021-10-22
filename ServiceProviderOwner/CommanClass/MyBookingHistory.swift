//
//  MyBookingHistory.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 26/08/21.
//

import Foundation

struct MyBookingHistory {
    var name:String?
    var bill:Int?
    var id:Int?
    var date:String?
    var endDate:String?
    var hours:Int?
    var slots:String?
    var estBill:Int?
    var status:String?
    init(object:[String:Any]) {
        name = object["spaceName"] as? String ?? ""
        bill = object["estBill"] as? Int ?? 0
        id = object["bookingID"] as? Int ?? 0
        date = object["startDate"] as? String ?? ""
        endDate = object["endDate"] as? String ?? ""
        hours = object["totalHours"] as? Int ?? 0
        slots = object["Slots"] as? String ?? ""
        estBill = object["estBill"] as? Int ?? 0
        status = object["status"] as? String ?? ""
    }
}
