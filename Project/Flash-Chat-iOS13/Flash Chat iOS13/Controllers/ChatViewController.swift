//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    var message: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.title = ConstantNameFlashChat.titleFlashChat
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: ConstantNameFlashChat.cellNibName, bundle: nil), forCellReuseIdentifier: ConstantNameFlashChat.reuseableSell)
        loadMessage()
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let message = messageTextfield.text, let userMail = Auth.auth().currentUser?.email {
            db.collection(ConstantNameFlashChat.collectionMessage).addDocument(data: [
                ConstantNameFlashChat.senderField: userMail,
                ConstantNameFlashChat.bodyField: message,
                "Date": Date().timeIntervalSinceReferenceDate
            ])
            { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Send Message successfully")
                    self.loadMessage()
                }
            }
        }
    }
    
    func loadMessage() {
        
        db.collection(ConstantNameFlashChat.collectionMessage).order(by: ConstantNameFlashChat.timeSendMessage).addSnapshotListener { (DocumentSnapshot, Err) in
            self.message = []
            if let err = Err {
                print("Error getting documents: \(err)")
            } else {
                if let document = DocumentSnapshot?.documents {
                    for doc in document {
                        let dataMessage = doc.data()
                        if let sender = dataMessage[ConstantNameFlashChat.senderField] as? String, let bodyMessage = dataMessage[ConstantNameFlashChat.bodyField] as? String {
                  
                 
                            self.message.append(Message(sender: sender, body: bodyMessage))
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.message.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .bottom , animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            guard let vc = self.presentingViewController else { return }
            
            while (vc.presentingViewController != nil) {
                vc.dismiss(animated: true, completion: nil)
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantNameFlashChat.reuseableSell, for: indexPath) as! MessageCell
        cell.label.text = message[indexPath.row].body
        //print("Email User: \(Auth.auth().currentUser?.email) and Sender: \(message[indexPath.row].sender) ")
        if  message[indexPath.row].sender == Auth.auth().currentUser?.email! {
            print("Email User: \( Auth.auth().currentUser?.email) and Sender: \(message[indexPath.row].sender) ")
            cell.avatarYou.isHidden = true
            cell.avatar.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: ConstantNameFlashChat.color.BrandPurble)
        } else {
           // print("Email User: \(String(describing: Auth.auth().currentUser?.email!)) and Sender: \(message[indexPath.row].sender) ")
            cell.avatar.isHidden = true
            cell.avatarYou.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: ConstantNameFlashChat.color.BrandBlue)
        }
        return cell
    }
}


