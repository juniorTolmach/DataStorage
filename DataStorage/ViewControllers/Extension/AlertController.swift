//
//  AlertController.swift
//  DataStorage
//
//  Created by Daniil Oreshenkov on 12.09.2022.
//

import UIKit

extension UIAlertController {
    static func createAlertController(withTitle title: String) -> UIAlertController {
        UIAlertController(title: title, message: "What do you want to do", preferredStyle: .alert)
    }
    
    func action(task: Task?, completion: @escaping (String) -> Void) {
        let saveAlert = UIAlertAction(title: "Save", style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAlert)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Task"
            textField.text = task?.title
        }
    }
}
