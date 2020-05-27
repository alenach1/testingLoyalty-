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
    
    init(user: UserModel) {
        self.user = user
        super.init(nibName: "SecondViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func start() {
        guard let user = user else { return }
        print(user.login)
//        loginLable.text = user.login
//        idLable.text = user.id
    }
}
