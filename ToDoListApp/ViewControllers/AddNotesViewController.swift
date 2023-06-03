//
//  AddNotesViewController.swift
//  ToDoListApp
//
//  Created by BhuvanaR on 5/30/23.
//

import UIKit

class AddNotesViewController: UIViewController {
    
    @IBOutlet weak var titleTextview: UITextView!
    @IBOutlet weak var priority1Button: UIButton!
    @IBOutlet weak var priority2Button: UIButton!
    @IBOutlet weak var priority3Button: UIButton!
    @IBOutlet weak var priority4Button: UIButton!
    @IBOutlet weak var priority5Button: UIButton!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var dueTimeTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let priorityBgColor = UIColor(red: 255/255, green: 180/255, blue: 83/255, alpha: 1)
    let prioritiesColor = UIColor(red: 200/255, green: 226/255, blue: 253/255, alpha: 1)
    var prioritySelected = ""
    var toDoList: ToDoList? = ToDoList()
    var todoListDelegate: TodoListUpdate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setObserver()
        titleTextview.delegate = self
    }
    
    func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(aNotification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(aNotification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillBeHidden(aNotification: NSNotification) {
        let contentInsets: UIEdgeInsets = .zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillShow(aNotification: NSNotification) {
        let info = aNotification.userInfo!
        let kbSize: CGSize = ((info["UIKeyboardFrameEndUserInfoKey"] as? CGRect)?.size)!
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        toDoList?.title = titleTextview.text
        toDoList?.start_date = startDateTextField.text
        toDoList?.due_date = dueDateTextField.text
        toDoList?.due_time = dueTimeTextField.text
        toDoList?.priority = prioritySelected
        toDoList?.completion_date = "Today"
        toDoList?.creation_date = currentDate()
        ToDoDataManager().addToDoList(toDoList: toDoList)
        todoListDelegate?.reloadToDoList()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func Priority1Action(_ sender: UIButton) {
        prioritySelected = "P1"
        priority1Button.backgroundColor = priorityBgColor
        priority2Button.backgroundColor = prioritiesColor
        priority3Button.backgroundColor = prioritiesColor
        priority4Button.backgroundColor = prioritiesColor
        priority5Button.backgroundColor = prioritiesColor
    }
    
    @IBAction func Priority2Action(_ sender: UIButton) {
        prioritySelected = "P2"
        priority1Button.backgroundColor = prioritiesColor
        priority2Button.backgroundColor = priorityBgColor
        priority3Button.backgroundColor = prioritiesColor
        priority4Button.backgroundColor = prioritiesColor
        priority5Button.backgroundColor = prioritiesColor
    }
    
    @IBAction func Priority3Action(_ sender: UIButton) {
        prioritySelected = "P3"
        priority1Button.backgroundColor = prioritiesColor
        priority2Button.backgroundColor = prioritiesColor
        priority3Button.backgroundColor = priorityBgColor
        priority4Button.backgroundColor = prioritiesColor
        priority5Button.backgroundColor = prioritiesColor
    }
    
    @IBAction func Priority4Action(_ sender: UIButton) {
        prioritySelected = "P4"
        priority1Button.backgroundColor = prioritiesColor
        priority2Button.backgroundColor = prioritiesColor
        priority3Button.backgroundColor = prioritiesColor
        priority4Button.backgroundColor = priorityBgColor
        priority5Button.backgroundColor = prioritiesColor
    }
    
    @IBAction func Priority5Action(_ sender: UIButton) {
        prioritySelected = "P5"
        priority1Button.backgroundColor = prioritiesColor
        priority2Button.backgroundColor = prioritiesColor
        priority3Button.backgroundColor = prioritiesColor
        priority4Button.backgroundColor = prioritiesColor
        priority5Button.backgroundColor = priorityBgColor
    }
    
    
    func customizeUIFields() {
        titleTextview.layer.borderWidth = 1
        titleTextview.layer.borderColor = UIColor.black.cgColor//UIColor(red: 51, green: 51, blue: 51, alpha: 1).cgColor
        titleTextview.layer.cornerRadius = 8
        titleTextview.leftSpace(amount: 15)
        
        startDateTextField.layer.borderWidth = 1
        startDateTextField.layer.borderColor = UIColor.black.cgColor//UIColor(red: 51, green: 51, blue: 51, alpha: 1).cgColor
        startDateTextField.layer.cornerRadius = 8
        startDateTextField.setLeftPaddingPoints(amount: 15)
        startDateTextField.setRightPaddingPoints(15)
        
        dueDateTextField.layer.borderWidth = 1
        dueDateTextField.layer.borderColor = UIColor.black.cgColor//UIColor(red: 51, green: 51, blue: 51, alpha: 1).cgColor
        dueDateTextField.layer.cornerRadius = 8
        dueDateTextField.setLeftPaddingPoints(amount: 15)
        dueDateTextField.setRightPaddingPoints(15)
        
        dueTimeTextField.layer.borderWidth = 1
        dueTimeTextField.layer.borderColor = UIColor.black.cgColor//UIColor(red: 51, green: 51, blue: 51, alpha: 1).cgColor
        dueTimeTextField.layer.cornerRadius = 8
        dueTimeTextField.setLeftPaddingPoints(amount: 15)
        dueTimeTextField.setRightPaddingPoints(15)
        //dateView.isHidden = true
    }
    
    @IBAction func displayDateViewAction(_ sender: UIButton) {
        if sender.tag == 1 {
            showDatePicker(textField: self.startDateTextField)
        } else if sender.tag == 2 {
            showDatePicker(textField: self.dueDateTextField)
        } else {
            showTimePicker()
        }
    }
    
    func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        //formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = .current
        let currentDate = formatter.string(from: Date())
        return currentDate
    }
    
    func showDatePicker(textField: UITextField) {
        DateAndTimePicker.selectDate(title: "Select Date", cancelText: "Cancel", didSelectDate: {[weak self] (selectedDate) in
            // TODO: Your implementation for date
            textField.text = selectedDate.dateString("dd/MM/yyyy")
        })
    }
    
    func showTimePicker() {
        DateAndTimePicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { [weak self](selectedDate) in
            // TODO: Your implementation for date
            self?.dueTimeTextField.text = selectedDate.dateString("hh:mm a")
        })
    }
    
    func dateSelect()  {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 260))
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.addTarget(self, action: #selector(dateSelected(datePicker:)), for: UIControl.Event.valueChanged)

        let alertController = UIAlertController(title: "", message:" " , preferredStyle: UIAlertController.Style.actionSheet)
        alertController.view.addSubview(datePicker)//add subview

        let cancelAction = UIAlertAction(title: "Done", style: .cancel) { (action) in
            self.dateSelected(datePicker: datePicker)
        }
        
        alertController.addAction(cancelAction)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        alertController.view.addConstraint(height);
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func dateSelected(datePicker:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let currentDate = datePicker.date
        print(currentDate)
    }
    
//    func validateTextFields() {
//        if self.subject.text?.count == 0 {
//            saveB.backgroundColor = .lightGray
//            submitButton.isEnabled = false
//        } else if self.query.text?.count == 0 || (self.query.text == "\n") ||
//                    (self.query.text == "Enter Your query") {
//            submitButton.backgroundColor = .lightGray
//            submitButton.isEnabled = false
//        } else {
//            submitButton.backgroundColor = .black
//            submitButton.isEnabled = true
//        }
//    }

}

extension AddNotesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //self.validateTextFields()
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //self.validateTextFields()
        let acceptableCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,.?!:@_-&()'/ "
        let filtered = string.components(separatedBy: NSCharacterSet(charactersIn: acceptableCharacters).inverted).joined(separator: "")
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
        return (newString.rangeOfCharacter(from: NSCharacterSet.whitespacesAndNewlines).location != 0 && updatedText.count <= 50 && filtered == string)
    }
    
}

extension AddNotesViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter title here" {
            textView.textColor = .black
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
       // validateTextFields()
        self.view.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //validateTextFields()
        let acceptableCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,.?!:@_-&()'/ \n"
        let filtered = text.components(separatedBy: NSCharacterSet(charactersIn: acceptableCharacters).inverted).joined(separator: "")
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        let newString = (textView.text as NSString).replacingCharacters(in: range, with: text) as NSString
        return (newString.rangeOfCharacter(from: NSCharacterSet.whitespacesAndNewlines).location != 0 && updatedText.count <= 100 && filtered == text)
    }
    
}



