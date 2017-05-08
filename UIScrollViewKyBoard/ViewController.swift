//
//  ViewController.swift
//  UIScrollViewKyBoard
//
//  Created by Anh Tuong Nguyen on 5/8/17.
//  Copyright © 2017 Anh Tuong Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var activeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector((self.keyboardDidShow(notification:))), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector((self.keyboardWillBeHidden(notification:))), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.activeTextField = nil
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeTextField = textField
    }
    
    func keyboardDidShow(notification: NSNotification) {
        if let activeField = self.activeTextField, let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.ScrollView.contentInset = contentInsets
            self.ScrollView.scrollIndicatorInsets = contentInsets
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
            if (!aRect.contains(activeField.frame.origin)) {
                self.ScrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.ScrollView.contentInset = contentInsets
        self.ScrollView.scrollIndicatorInsets = contentInsets
    }
}

