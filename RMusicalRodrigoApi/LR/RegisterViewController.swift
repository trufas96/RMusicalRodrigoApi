//
//  RegisterViewController.swift
//  RoproductosMusical_Rodrigo
//
//  Created by alumnos on 1/3/18.
//  Copyright © 2018 rodrigo. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var idDeviceTF: UITextField!
    @IBOutlet weak var xTF: UITextField!
    @IBOutlet weak var yTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idDeviceTF.isEnabled = false
        xTF.isEnabled = false
        yTF.isEnabled = false


    }
    
    @IBAction func send(_ sender: UIButton) {
        
        
        //create the url with URL
        let url = URL(string: "http://localhost:8888/apiRmusicalRodrigo/public/index.php/users/register.json")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
        
        let name : String = nameTF.text!
        let pass : String = passwordTF.text!
        let email : String = emailTF.text!
        let idDevice : String = idDeviceTF.text!
        let x : String = xTF.text!
        let y : String = yTF.text!

        let parameters = "userName=\(name)&password=\(pass) &email=\(email)&id_device=\(idDevice)&x=\(x)&y=\(y)"
        request.httpBody = parameters.data(using: .utf8)
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response,
            error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    
                    let data = Responses(json: (json as NSDictionary) as! [String : Any])
                    
                    switch(data.code){
                        
                    case 200:
                        let recivedData = data.data as! NSDictionary
                        print(recivedData)
                        UserDefaults.standard.set(recivedData["token"] , forKey: "token")
                        
                        
                        break
                    case 400:
                        print("API ::: \(data.message)")
                        break
                    default:
                        break
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
}

