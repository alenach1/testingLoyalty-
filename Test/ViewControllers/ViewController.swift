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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    func startActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        lable.isHidden = true
        usernameTextField.isHidden = true
        passwordTextField.isHidden = true
        loginButtonOutlet.isHidden = true
    }
    
    func newAuth() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.lable.isHidden = false
        self.usernameTextField.isHidden = false
        self.passwordTextField.isHidden = false
        self.loginButtonOutlet.isHidden = false
        self.usernameTextField.text = ""
        self.passwordTextField.text = ""
        self.lable.text = "Пожалуйста, введите логин и пароль для входа"
        self.lable.textColor = .black
    }
    
    func createRequest() {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        
        startActivityIndicator()
        
        guard let url = URL(string: "http://37.140.199.187:3000/auth/login") else { return }
        let userData = ["username" : username, "password" : password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let _ = response, let data = data else { return }
            
            do {
                let userData = try JSONDecoder().decode(UserModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.newAuth()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
                    vc?.user = userData
                    guard let viewController = vc else { return }
                    self.present(viewController,animated: true, completion: nil)
                }
            } catch {
                DispatchQueue.main.async {
                    self.newAuth()
                    self.lable.text = "Данные введены не правильно, повторите попытку"
                    self.lable.textColor = .red
                }
                print(error)
            }
        }.resume()
    }
    
    @IBAction func loginButton(_ sender: Any) {
      createRequest()
    }
}

