//
//  LoginViewController.swift
//  ToDoListApp
//
//  Created by BhuvanaR on 5/30/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    @IBAction func LoginBtnAction(_ sender: UIButton) {
        if let toDoListView = self.storyboard?.instantiateViewController(withIdentifier: "ToDoListScene"){
            navigationController?.pushViewController(toDoListView, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
}
