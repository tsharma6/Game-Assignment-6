import UIKit


class ViewController: UIViewController {

    var sc:[Int] = []
    var tableData:[String] = []
    
    var jsonlength:Int = 0
    var jsonData : [[String: Any]]?
    var highestScoreAllData = ""
    @IBOutlet weak var highscore: UILabel!
    
    var game  = "Killspree"
    var scores:[Int] = []
    
    @IBOutlet weak var HighestScore: UILabel!
    
    @IBOutlet weak var mytextview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONData()
        usleep(2000000)
        highscore.text = String(getHigh())
        mytextview.text = highestScoreAllData
     }
    
    
    func appendSC(X:Int) {
        scores.append(X)
    }
    
    func appendTableData(x:String){
        tableData.append(x)
    }
    
    func getscores() -> [Int] {
        sleep(1)
        return scores
    }
    
    func getHigh() -> Int {
        if(scores.count > 0){
            return scores.max()!
        }else{
            return -1
        }
    }
    
    func getJSONData(){
        let that = self
        
        guard let url = URL(string: "http://cs.binghamton.edu/~pmadden/courses/441score/getscores.php" ) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                that.jsonData = jsonArray
                that.jsonlength = jsonArray.count
                
                var highestLocal:Int = 0
                for dic in jsonArray{
                    guard let title = dic["game"] as? String else { return }
                    if title == that.game
                    {

                        guard let p = dic["player"] as? String else { return }
                        let sc = dic["score"] as! String
                        that.appendSC(X: Int(sc)!)
                        if(highestLocal < Int(sc)!){
                            that.highestScoreAllData = "Player:"+p+"\nGame:"+title+"\nScore:"+sc+"\n"
                            highestLocal = Int(sc)!
                        }
                        that.appendTableData(x: ""+title+":"+p+":"+sc)

                        
                    }

                }
                
                

            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        
        task.resume()
    }


    
    
}









