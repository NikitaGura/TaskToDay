//
//  TaskViewController.swift
//  TaskToday
//
//  Created by Nikita Gura on 04.12.2018.
//  Copyright © 2018 Nikita Gura. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class TaskViewController: UIViewController {
    
    // MARK: - Properties
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var betweenConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(with:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        textView.becomeFirstResponder()
        textView.delegate = self
        
    }
    
    // MARK: - Actions
    
    @objc func keyboardWillShow(with notification: Notification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height + 16
        
        bottomConstraint.constant = keyboardHeight
        betweenConstraint.constant = 20
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func actionDone(_ sender: Any) {
        let task = Task(context: PersistenceSerivce.context)
        task.text = textView.text
       
        PersistenceSerivce.saveContext()
        dismissAndResign()
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        dismissAndResign()
    }
    
    fileprivate func dismissAndResign() {
        dismiss(animated: true)
        textView.resignFirstResponder()
    }
}

// MARK: - Delegates

@available(iOS 10.0, *)
extension TaskViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if buttonDone.isHidden {
            
            textView.text = textView.text.replacingOccurrences(of: "Type somthing", with: "")
            textView.textColor = UIColor.black
            
            buttonDone.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
