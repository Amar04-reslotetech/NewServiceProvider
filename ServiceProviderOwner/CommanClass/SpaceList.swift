//
//  SpaceList.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 27/08/21.
//

import Foundation

struct SpaceList {
    var id:Int?
    var name:String?
    var address:String?
    var slotArray:Array<Any>?
    
    init(object:[String:Any]) {
        id = object["spaceID"] as? Int ?? 0
        name = object["spaceName"] as? String ?? ""
        address = object["address"] as? String ?? ""
        slotArray = object["slotArray"] as? Array<Any>
    }
    
}
