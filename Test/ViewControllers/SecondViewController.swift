//
//  SecondViewController.swift
//  Test
//
//  Created by alena on 27.05.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var user: UserModel?
    
    @IBOutlet weak var loginLable: UILabel!
    @IBOutlet weak var idLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func start() {
        guard let user = user else { return }
        loginLable.text = user.login
        idLable.text = user.id
    }
}
