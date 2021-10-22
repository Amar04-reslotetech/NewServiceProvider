//
//  ClassAndProgram.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 07/09/21.
//

import Foundation

struct ClassAndProgram {
    var className:String?
    var time:String?
    var progrma:String?
    var id:Int?
    var bookingID:Int?
    var dates:String?
    
    
    init(object:[String:Any]) {
        className = object["className"] as? String ?? ""
        time = object["slot"] as? String ?? ""
        progrma = object["spaceName"] as? String ?? ""
        id = object["classID"] as? Int ?? 0
        bookingID = object["bookingID"] as? Int ?? 0
        dates = object["dates"] as? String ?? ""
    }
    
}
