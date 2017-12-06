//
//  ChatViewController.swift
//  TextMe
//
//  Created by Michail Mishev on 6/12/17.
//  Copyright © 2017 Michail Mishev. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var heightConstraints: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")    // nib == xib

    }
    
    
    
    
    
    //Requred TableView Methods:
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomTableViewCell
        
        let messageArray = ["FirstMessage", "SecondMessage", "ThirdMessage", "FourthMessage"]
        
        cell.messageBody.text = messageArray[indexPath.row]
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    @IBAction func logoutPressed(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
            navigationController?.popViewController(animated: true)
        }
        catch {
            print("Error: There was a problem signing out.")
        }
        
        
    }
    
    
    
    @IBAction func sendPressed(_ sender: Any) {
        
        //
        
    }
    
  

}
