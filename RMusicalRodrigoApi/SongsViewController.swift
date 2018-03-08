import UIKit
import Alamofire
import UIKit

class SongsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var arraySong = [Songs]()
    @IBOutlet weak var STable: UITableView!
    var url : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        STable.delegate = self
        STable.dataSource = self
        getSongs()
        
    }
    
    
    public func getSongs() {
        let url = "http://localhost:8888/apiRmusicalRodrigo/public/index.php/Songs/songs.json"
        var token : String = ""
        
        if (UserDefaults.standard.string(forKey: "token") != nil) {
            token = UserDefaults.standard.string(forKey: "token")!
        }
        else
        {
            token = ""
        }
        let header = ["Authorization": token,
                     "Accept": "application/json"]
        
        Alamofire.request(url, method: .get, headers : header).responseJSON{
            response in
            print("RESULT :: \(response.result)")
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                let array = data.data
                switch(data.code){
                case 200:
                    var recivedData = data.data as! NSArray
                    
                    for songs in array as! [NSDictionary]{
                        self.arraySong.append(Songs(json: songs))
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
        let cell = STable.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = arraySong[indexPath.row].title
        url = arraySong[indexPath.row].url
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino = segue.destination as! MP3ViewController
        destino.url = url
    }
    
    
}

