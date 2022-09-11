//
//  Extansion + TableViewCell.swift
//  DataStorage
//
//  Created by Daniil Oreshenkov on 11.09.2022.
//

import UIKit

extension UITableViewCell {
    func configure(with family: Family) {
//        let currentTasks = taskList.tasks.filter("isComplete = false")
        var content = defaultContentConfiguration()
        
        content.text = family.fullname
        content.secondaryText = family.status

        contentConfiguration = content
    }
}
