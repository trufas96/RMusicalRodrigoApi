//
//  Songs.swift
//  RMusicalRodrigoApi
//
//  Created by alumnos on 7/3/18.
//  Copyright © 2018 rodrigo. All rights reserved.
//

import Foundation
import UIKit
class Songs{
    var id : String
    var title : String
    var url : String

    
    init(json: NSDictionary) {
        id = (json["id"] as? String)!
        title = json["title"] as? String ?? ""
        url = (json["url"] as? String)!
    }
    
}
