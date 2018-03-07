//
//  Request.swift
//  RMusicalRodrigoApi
//
//  Created by alumnos on 7/3/18.
//  Copyright © 2018 rodrigo. All rights reserved.
//
import  UIKit
import Alamofire
import Foundation


class Request {
    let view : UIViewController
    let myActivityIndicator : UIActivityIndicatorView
    let headers : HTTPHeaders
   
    
    init(view : UIViewController, myActivityIndicator : UIActivityIndicatorView) {
        let tokenSaved : String!
        if(UserDefaults.standard.string(forKey: "token") != nil){
            tokenSaved = UserDefaults.standard.string(forKey: "token")
        }else{
            tokenSaved = ""
        }
        self.headers = [
            "Authorization": tokenSaved,
            "Accept": "application/json"
        ]
        self.myActivityIndicator = myActivityIndicator
        self.view = view
    }
}
