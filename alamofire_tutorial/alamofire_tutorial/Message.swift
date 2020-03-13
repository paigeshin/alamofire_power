//
//  Message.swift
//  alamofire_tutorial
//
//  Created by shin seunghyun on 2020/03/13.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import ObjectMapper

struct Message: Mappable {
    
    var user: String?
    var message: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        user <- map["user"]
        message <- map["message"]
    }
    
}
