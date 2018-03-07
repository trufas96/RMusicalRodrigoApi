import UIKit
import Alamofire
import UIKit

class SongsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    //var list = [List]()
    var arraySong = [Songs]()
    @IBOutlet weak var STable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        STable.delegate = self
        STable.dataSource = self
        getSongs()
    }
    
    
    public func getSongs() {
        let url = "http://localhost:8888/apiRmusicalRodrigo/public/index.php/Songs/songs.json"
        var token = ""
        
        if (UserDefaults.standard.string(forKey: "token") != nil) {
            token = UserDefaults.standard.string(forKey: "token")!
        }
        else
        {
            token = ""
        }
        let header = ["Authorization": token, "Accept": "application/json"]
        
        Alamofire.request(url, method: .get, headers : header).responseJSON{ response in
            print("RESULT :: \(response.result)")
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                let array = data.data
                switch(data.code){
                case 200:
                    var recivedData = data.data as! NSArray
                    
                    for songs in recivedData {
                        self.arraySong.append(Songs(json: songs as! NSDictionary))
                    }
                    self.STable.reloadData()
                    break
                case 401:
                    print("API ::: \(data.message)")
                    break
                default:
                    break
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySong.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = STable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arraySong[indexPath.row].title
        return cell
    }
    
    
    
    
}

