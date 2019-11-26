//
//  Data.swift
//  Testing

import Foundation


class Data
{
    
    var playerset = UserDefaults.standard.bool(forKey: "playerset")
    var game  = "bally"
    var player = UserDefaults.standard.string(forKey: "player") ?? ""
    var scores:[Int] = []

    var latestscore:Int = 0

    
    func ABC(X:Int) {
            //print(X)
        scores.append(X)
        
        
    }
    
    func getscores() -> [Int] {
        sleep(1)
        return scores
    }
    
    
    
    func getHigh() -> Int {
        scores.append(1)
        return scores.max()!
    }
    
    
    
    
    func postscore(){
        
//        let url = URL(string: "http://cs.binghamton.edu/~pmadden/courses/441score/postscore.php?player=\(player)&game=\(game)&score=\(String(latestscore))")!
//
//        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
//        }
//
//        task.resume()
        
        
    }
    
    
    
    func JSONData(){
        guard let url = URL(string: "http://cs.binghamton.edu/~pmadden/courses/441score/getscores.php" ) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                //print(jsonResponse) //Response result
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                // print(jsonArray)
                //Now get title value

                for dic in jsonArray{
                    guard let title = dic["game"] as? String else { return }
                    if title == self.game
                    {

                        guard let p = dic["player"] as? String else { return }
                        if p == self.player
                        {

                        //   print(dic["score"] as! String)
                        let sc = dic["score"] as! String
                        //  self.scores.append(Int(sc)!)
                        //print(self.scores)

                        // let S = Scores(score: Int(sc)!)

                        self.ABC(X: Int(sc)!)
                        }
                    }

                }// delectus aut autem

            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
    }
    
    
    

}
