//
//  Extansion + TableViewCell.swift
//  DataStorage
//
//  Created by Daniil Oreshenkov on 11.09.2022.
//

import UIKit

extension UITableViewCell {
    
    //MARK: - UserDefaults
    func configureUserDefaults(with family: Family) {
        var content = defaultContentConfiguration()
        
        content.text = family.fullname
        content.secondaryText = family.status

        contentConfiguration = content
    }
    
    //MARK: - Realm
    
    func configureRealm(with taskList: TaskList) {
        let currentTasks = taskList.tasks.filter("isComplete = false")
        var content = defaultContentConfiguration()
        
        content.text = taskList.name
        
        if taskList.tasks.isEmpty {
            content.secondaryText = "0"
            accessoryType = .none
        } else if currentTasks.isEmpty {
            content.secondaryText = nil
            accessoryType = .checkmark
        } else {
            content.secondaryText = "\(currentTasks.count)"
            accessoryType = .none
        }

        contentConfiguration = content
    }

}
