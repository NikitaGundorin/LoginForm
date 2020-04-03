//
//  ViewController.swift
//  LoginForm
//
//  Created by Никита Гундорин on 02.04.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.addTarget(self, action: #selector(self.checkEmptyFields(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.checkEmptyFields(_:)), for: .editingChanged)
    }
    
    @IBAction func submit(_ sender: Any) {
        if (checkValidEmail(email: emailTextField.text) == false) {
            errorLabel.text = "Invalid email"
            return
        }
        guard let passwordError = checkValidPassword(password: passwordTextField.text)
            else {
                performSegue(withIdentifier: "login", sender: nil)
                return
        }
        errorLabel.text = passwordError
    }
    
    
    @objc func checkEmptyFields(_ textField: UITextField) {
        if (emailTextField.text != "" && passwordTextField.text != "") {
            submitButton.isEnabled = true
        }
        else {
            submitButton.isEnabled = false
        }
    }
    
    func checkValidEmail(email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func checkValidPassword(password: String?) -> String? {
        guard let password = password else { return "Please, enter a password" }
        
        if (password.count < 6) {
            return "Password must not be shorter than 6 characters"
        }
        
        if (!NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: password)) {
            return "Password must contain at least one uppercase letter"
        }
        
        if (!NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: password)) {
            return "Password must contain at least one lowercase letter"
        }
        
        if (!NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: password)) {
            return "Password must contain at least one number"
        }
        
        return nil
    }
}
