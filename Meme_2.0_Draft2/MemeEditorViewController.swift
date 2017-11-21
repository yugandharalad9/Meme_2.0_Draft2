//
//  MemeEditorViewController.swift
//  Meme_2.0_Draft2
//
//  Created by Yugandhara Lad on 11/14/17.
//  Copyright © 2017 Yugandhara Lad. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var txtFieldTop: UITextField!
    @IBOutlet var txtFieldBottom: UITextField!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var btnCamera: UIBarButtonItem!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var toolBar: UIToolbar!
    
    var keyBoardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.txtFieldTop.backgroundColor = UIColor.clear
        self.txtFieldBottom.backgroundColor = UIColor.clear
        txtFieldTop.delegate = self
        txtFieldBottom.delegate = self
    }
    
    //Action for Album Button
    @IBAction func pickImageFromAlbum(_ sender: UIBarButtonItem) {
        selectPic(_source: .photoLibrary)
    }
    
    
    //Action for Camera Button
    @IBAction func pickImageFromCamera(_ sender: UIBarButtonItem) {
        selectPic(_source: .camera)
    }
    
    //Allowing UIImagePickerController to pick Image
    func selectPic(_source: UIImagePickerControllerSourceType)  {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = _source
        present(picker, animated: true, completion: nil)
        
    }
    
    //Dismissing the UIImagePickerController
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //Pushing the SelectedImage into memeImageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        memeImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnCancelClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveMeme()  {
        let meme = Meme(topText: txtFieldTop.text!, bottomText: txtFieldBottom.text!, originalImage: memeImageView.image!, memedImage: generateMemedImage())
        
        //Add saved memedImages to the meme array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        //hiding toolbar and navigation bar
        toolBar.isHidden = true
        navigationBar.isHidden = true
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //showing toolbar and navigation bar after the memed image is generated
        toolBar.isHidden = false
        navigationBar.isHidden = false
        
        return memedImage
    }
    
    
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        var memedImages = [UIImage]()
        memedImages.append(memedImage)
        
        let activityController = UIActivityViewController(activityItems: memedImages as [AnyObject], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        
        present(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = { (activity, success, items, error) in
            print(success ? "SUCCESS!" : "FAILURE")
            
            if success {
                self.saveMeme()
                print("Memed Imaged saved")
                self.dismiss(animated: true, completion: nil)
            }
            
        }
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
        btnCamera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscrideToKeyboardNotification()
    }

}


