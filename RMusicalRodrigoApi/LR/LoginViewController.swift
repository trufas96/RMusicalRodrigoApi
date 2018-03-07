import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func send(_ sender: UIButton) {
        
        
        
        //create the url with URL
        let url = URL(string: "http://localhost:8888/apiRmusicalRodrigo/public/index.php/users/login.json")! //change the url
        //create the session object
        let session = URLSession.shared
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
        
        let name : String = nameTF.text!
        let pass : String = passwordTF.text!
        let parameters = "userName=\(name)&password=\(pass)"
        request.httpBody = parameters.data(using: .utf8)
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
           /* if let json = response.result.value {
                
            }*/
            
            
            
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                    let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                    
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


