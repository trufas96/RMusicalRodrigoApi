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
    var id : Int
    var title : String
    var url : URL

    
    init(json: NSDictionary) {
        id = (json["id"] as? Int)!
        title = json["title"] as? String ?? ""
        url = (json["url"] as? URL)!
    }
    
}
