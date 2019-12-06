//
//  EntryDetailViewController.swift
//  iOS Journal-CoreData
//
//  Created by Lambda_School_Loaner_201 on 12/4/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var newEntryTitleTextField: UITextField!
    
    @IBOutlet weak var storyTextView: UITextView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        newEntryTitleTextField.delegate = self
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    private func updateViews() {
        guard isViewLoaded else { return }
        if let entry = entry {
            title = entry.title
            newEntryTitleTextField?.text = entry.title
            storyTextView?.text = entry.bodyText
        } else {
            title = "Create Journal"
        }
    }
    @IBAction func saveButton(_ sender: Any) {
        guard let title = newEntryTitleTextField.text, let body = storyTextView.text else { return }
        if (title.isEmpty && title.count < 20) || body.isEmpty {
            simpleAlert(title: "Error", message: "Your title/body is Empty.")
        }
        if let entry = entry {
            entry.title = title
            entry.bodyText = body
            entry.timestamp = Date()
        } else {
            let _ = Entry(title: title, bodyText: body)
        }
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Failed To Save: \(error)")
            simpleAlert(title: "Error", message: "Maybe your title is longer then 20 char.")
            return
        }
        navigationController?.popViewController(animated: true)
    }
    func simpleAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(ac, animated: true)
    }

}
