

import UIKit
import Alamofire



class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var list = [List]()
    var arrayList = [List]()
    @IBOutlet weak var LTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LTable.delegate = self
        LTable.dataSource = self
        getList()
    }

    
    public func getList() {
        let url = "http://localhost:8888/apiRmusicalRodrigo/public/index.php/Lists/show.json"
        var token : String = ""
        
        if (UserDefaults.standard.string(forKey: "token") != nil) {
            token = UserDefaults.standard.string(forKey: "token")!
        }
        else
        {
            token = ""
        }
        let header = [
            "Authorization": token,
            "Accept": "application/json"]
        
        Alamofire.request(url, method: .get, headers : header).responseJSON{
            response in
            print("RESULT :: \(response.result)")
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                let array = data.data
                print(array)
                switch(data.code){
                case 200:
                    var recivedData = data.data as! NSArray
                    
                    for lists in array as! [NSDictionary]{
                        self.arrayList.append(List(json: lists))
                    }
                    self.LTable.reloadData()
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
        return arrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arrayList[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
  
}
