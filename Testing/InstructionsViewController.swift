//
//  InstructionsViewController.swift
//  Testing

import UIKit

class InstructionsViewController: UIViewController {

    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var gameName: UITextField!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var gameScore: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerName.delegate = self
        gameName.delegate = self
        gameScore.delegate = self
        // Do any additional setup after loading the view.
        //let localfilePath = Bundle.main.url(forResource: "intro", withExtension: "html");
        //let myRequest = NSURLRequest(url: localfilePath!);
        //webView.loadRequest(myRequest as URLRequest);
        //self.view.addSubview(webView)
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func insertDataClicked(_ sender: Any) {
        let player = playerName.text!
        let game = gameName.text!
        let latestscore = gameScore.text!
        let url = URL(string: "http://cs.binghamton.edu/~pmadden/courses/441score/postscore.php?player=\(player)&game=\(game)&score=\(String(latestscore))")!
        var dataFromServer = ""
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            dataFromServer = String(data: data, encoding: .utf8)!
        }
        
        task.resume()
        let alert = UIAlertController(title: "Data added successfully", message: dataFromServer, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        playerName.text = ""
        gameName.text = ""
        gameScore.text = ""
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameScore.resignFirstResponder()
    }
}

extension InstructionsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
