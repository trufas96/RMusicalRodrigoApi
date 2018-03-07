//
//  Lists.swift
//  RMusicalRodrigoApi
//
//  Created by alumnos on 5/3/18.
//  Copyright © 2018 rodrigo. All rights reserved.
//

import Foundation
import UIKit


class List {
    var id : String
    var id_user : String
    var title : String
    
    
    init(json: NSDictionary) {
        id = (json["id"] as? String)!
        id_user = (json["id_user"] as? String)!
        title = (json["title"] as? String) ?? ""
    }
}
