//
//  TaskListRealm.swift
//  DataStorage
//
//  Created by Daniil Oreshenkov on 19.09.2022.
//

import RealmSwift
import Foundation

class TaskList: Object {
    @Persisted var name = ""
    @Persisted var date = Date()
    @Persisted var tasks = List<Task>()
}

class Task: Object {
    @Persisted var name = ""
    @Persisted var note = ""
    @Persisted var date = Date()
    @Persisted var isComplete = false
}
