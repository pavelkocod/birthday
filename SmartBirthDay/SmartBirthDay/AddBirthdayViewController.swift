//
//  ViewController.swift
//  SmartBirthDay
//
//  Created by Александр Павелко on 12.04.2023.
//

import UIKit
import CoreData

protocol AddBirthdayViewControllerDelegate {
    func addBirthdayViewController(_ addBirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday)
}

// MARK: AddBirthdayViewController

class AddBirthdayViewController: UIViewController {
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var birthdatePicker: UIDatePicker!
    
    var delegate: AddBirthdayViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthdatePicker.maximumDate = Date()
    }

    @IBAction func saveTaped(_ sender: UIBarButtonItem) {
        //print("Нажата кнопка сохранения.")
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let birthdate = birthdatePicker.date
        //let newBirthday = Birthday(firstName: firstName, lastName: lastName, birthday: birthdate)
        //delegate?.addBirthdayViewController(self, didAddBirthday: newBirthday)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newBirthday = Birthday(context: context)
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthdate = birthdate
        newBirthday.birthdeyId = UUID().uuidString
        
        if let uniqueId = newBirthday.birthdeyId {
            print("BirthdId - \(uniqueId)")
        }
        
        do {
            try context.save()
        } catch let error {
            print("Не уалось сохранить из-за ошибки \(error)")
        }
        
        dismiss(animated: true, completion: nil)
        
        print("Создана запись о дне рождении!")
        print("Имя: \(newBirthday.firstName!)")
        print("Фамилия: \(newBirthday.lastName!)")
        print("Дата рождения: \(newBirthday.birthdate!)")
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}

