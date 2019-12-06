//
//  EntriesTableViewController.swift
//  iOS Journal-CoreData
//
//  Created by Lambda_School_Loaner_201 on 12/4/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import UIKit
import CoreData

class EntriesTableViewController: UITableViewController {
    
    var entries: [Entry] {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        
        do {
            let result = try moc.fetch(fetchRequest)
            return result
        }catch {
            NSLog("Error fetching tasks: \(error)")
            return []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath)
        
        // Configure the cell...
        guard let journalCell = cell as? EntryTableViewCell else {return cell}
        let entry = entries[indexPath.row]
        journalCell.entry = entry
        
        return journalCell
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let entry = entries[indexPath.row]
            let moc = CoreDataStack.shared.mainContext
            moc.delete(entry)
            
            do {
                try moc.save()
            }catch {
                NSLog("Error deleting entry herror: \(error)")
                
            }
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "JournalCellSegue" {
            guard let vc = segue.destination as? EntryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            let entry = entries[indexPath.row]
            
            vc.entry = entry
        }
    }
}
