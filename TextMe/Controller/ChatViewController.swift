//
//  ChatViewController.swift
//  TextMe
//
//  Created by Michail Mishev on 6/12/17.
//  Copyright © 2017 Michail Mishev. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var heightConstraints: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTextField.delegate = self
        
        //monitoring for tab gestures:
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tabGesture)
        
        messageTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")    // nib == xib
        
        congigureTableViewHeight()

    }
    
    
    
    
    
    //Requred TableView Methods:
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomTableViewCell
        
        let messageArray = ["FirstMessage", "SecondMessage SecondMessageSecondMessageSecondMessage SecondMessageSecondMessage SecondMessage SecondMessageSecondMessage", "ThirdMessage", "FourthMessage"]
        
        cell.messageBody.text = messageArray[indexPath.row]
        
        return cell
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    // ---------------------------------------
    
    
    
    
    
    @objc func tableViewTapped() {
        
        messageTextField.endEditing(true)
        
    }
    
    
    
    
    func congigureTableViewHeight() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
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
    
    
    
    //message sender box pops-up with animation for the keyboard:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.6, animations: {
            self.heightConstraints.constant = 258 + 50       // 258 = keyboard height
            self.view.layoutIfNeeded()
        })
        
    }
    
    
    
    //message sender box return when no keyboard:
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.6, animations: {
            self.heightConstraints.constant = 50     // 50 = send message box height
            self.view.layoutIfNeeded()
        })
        
    }
    
    
    
    @IBAction func sendPressed(_ sender: Any) {
        
        //
        
    }
    
  

}
