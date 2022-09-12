//
//  NewFamilyMemberViewController.swift
//  DataStorage
//
//  Created by Daniil Oreshenkov on 11.09.2022.
//

import UIKit

class NewFamilyMemberViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var statusTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    let status = ["Папа", "Мама", "Сын", "Дочка"]
    var pickerView = UIPickerView()
    
    var delegate: NewFamilyMemberDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        surnameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        statusTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        statusTextField.inputView = pickerView
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        saveAndEdit()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc private func textFieldDidChange() {
        guard let name = nameTextField.text, let surname = surnameTextField.text, let status = statusTextField.text else { return }
        if !name.isEmpty, !surname.isEmpty, !status.isEmpty {
            saveButton.isEnabled = true
        }
        
    }
    
    private func saveAndEdit() {
        guard let name = nameTextField.text else { return }
        guard let surname = surnameTextField.text else { return }
        guard let status = statusTextField.text else { return }
        
        let newFamilyMember = Family(name: name, surname: surname, status: status)
        UserDefaultsManager.shared.save(newFamilyMember: newFamilyMember)
        
        delegate?.saveNewFamilyMember(newFamilyMember )
        dismiss(animated: true)
    }
    
}

extension NewFamilyMemberViewController: UITableViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        status.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        status[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statusTextField.text = status[row]
        statusTextField.resignFirstResponder()
    }
    
    
}
