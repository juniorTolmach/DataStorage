//
//  FamifyTableViewController.swift
//  DataStorage
//
//  Created by Daniil Oreshenkov on 11.09.2022.
//

import UIKit

protocol NewFamilyMemberDelegate {
    func saveNewFamilyMember(_ newFamilyMember: Family)
}

class FamifyTableViewController: UITableViewController {
    
    private var family: [Family] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        family = UserDefaultsManager.shared.fetchFamily()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newFamilyMemberVC = segue.destination as? NewFamilyMemberViewController else { return }
        newFamilyMemberVC.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        family.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let family = family[indexPath.row]
        content.text = family.fullname
        content.secondaryText = family.status
        cell.contentConfiguration = content
        cell.configureUserDefaults(with: family)

        return cell
    }
}

extension FamifyTableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            UserDefaultsManager.shared.deleteContant(at: indexPath.row)
            family.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
extension FamifyTableViewController: NewFamilyMemberDelegate {
    func saveNewFamilyMember(_ newFamilyMember: Family) {
        family.append(newFamilyMember)
        tableView.reloadData()
    }
    
    
}
