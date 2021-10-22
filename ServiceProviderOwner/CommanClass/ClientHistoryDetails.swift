//
//  ClientHistoryDetails.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 26/08/21.
//

import Foundation

struct ClientHistoryDetails {
    var name:String?
    var space_Name:String?
    var id:Int?
    var status:String?
    var bill:Int?
    var date:String?
    var time:String?
    var invoiceLink:String?
    var paymentReceipt:String?
    
    init(object:[String:Any]) {
        name = object["className"] as? String ?? ""
        space_Name = object["spaceName"] as? String ?? ""
        id = object["bookingID"] as? Int ?? 0
        status = object["status"] as? String ?? ""
        bill = object["bill"] as? Int ?? 0
        date = object["date"] as? String ?? ""
        time = object["slot"] as? String ?? ""
        invoiceLink = object["invoiceLink"] as? String ?? ""
        paymentReceipt = object["paymentReceiptLink"] as? String ?? ""
    }
    
}
