//
//  Responses.swift
//  RMusicalRodrigoApi
//
//  Created by alumnos on 7/3/18.
//  Copyright © 2018 rodrigo. All rights reserved.
//

import Foundation

class Responses{
    
    let code : Int!
    let message : String!
    let data : Any!
    
    init(jsonData : [String : Any]){
        self.code = jsonData["code"] as! Int
        self.message = jsonData["message"] as! String
        self.data = jsonData["data"]
    }
    
    
    init(json : [String : Any]){
        self.code = json["code"] as! Int
        self.message = json["message"] as! String
        self.data = json["data"]
    }
    
    init(code : Int , message : String , data : [String : Any]){
        self.code = code
        self.message = message
        self.data = data
        
    }
    
    
}
