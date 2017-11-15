//
//  MemeEditorViewController.swift
//  Meme_2.0_Draft2
//
//  Created by Yugandhara Lad on 11/14/17.
//  Copyright © 2017 Yugandhara Lad. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {

    @IBOutlet var txtFieldTop: UITextField!
    
    @IBOutlet var txtFieldBottom: UITextField!
    
    var keyBoardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.txtFieldTop.backgroundColor = UIColor.clear
        self.txtFieldBottom.backgroundColor = UIColor.clear
        txtFieldTop.delegate = self
        txtFieldBottom.delegate = self
    }
    
    
    
    
    
   
    
    @IBAction func btnCancelClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}

 //Mark: - Extension for UITextFieldDelegate
extension MemeEditorViewController: UITextFieldDelegate {
    
    //textField should return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("return key pressed")
        
        
        if let nextTextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
            print("goes in txtfield bottom")
            frameShifts()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func frameShifts()  {
        if txtFieldBottom.isEditing {
            view.frame.origin.y -= keyBoardHeight
        }
    }
    
    //keyboard notifications
    
    //Subscribe to keyboard notifications
    
    func subscribeToKeyBoardNotifications()  {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    //Keyboard will show
    
    @objc func keyboardWillShow (_ notification: Notification) {
        print("Keyboard shows")
        keyBoardHeight = getKeyboardHeight(notification)
    }
    
    //keyboard height
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let myUserInfo = notification.userInfo
        let keyboardSize = myUserInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
        
    }
    
    // keyboard will hide
    @objc func keyboardWillHide (_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    //Unsubscribe to keyboard notifications
    func unsubscrideToKeyboardNotification() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyBoardNotifications()
    }

}
