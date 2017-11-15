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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.txtFieldTop.backgroundColor = UIColor.clear
        self.txtFieldBottom.backgroundColor = UIColor.clear
        txtFieldTop.delegate = self
        txtFieldBottom.delegate = self
    }
    
    
    
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    //keyboard notifications
    
    func subscribeToKeyBoardNotifications()  {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        print("Keyboard shows")
    }

}
