//
//  ViewController.swift
//  Test
//
//  Created by alena on 27.05.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var user: UserModel?
    
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    @IBAction func loginButton(_ sender: Any) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        
        guard let url = URL(string: "http://37.140.199.187:3000/auth/login") else { return }
        let userData = ["username" : username, "password" : password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response, let data = data else { return }
            do {
                
                let userData = try JSONDecoder().decode(UserModel.self, from: data)
                self.user = userData
                
                
            } catch {
                print(error)
            }
        }.resume()
        guard let user = user else { return }
        let vc = SecondViewController(user: user)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

