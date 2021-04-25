//
//  MasterTableViewController.swift
//  CatalogoSnippets
//
//  Created by Pedro Barbosa on 25/03/21.
//

import UIKit

protocol TagSelectionDelegate: AnyObject {
    func tagSelected(_ newTag: Tag)
}

class MasterTableViewController: UITableViewController {
    
    // MARK: - Properties
    weak var delegate: TagSelectionDelegate?
    
    var tags: [Tag] = [
        Tag(name: "Network", snippets: [
            Snippet(name: "Snippet 1", content: "let x = 10"),
            Snippet(name: "Snippet 2", content: "let y = true")
        ]),
        Tag(name: "Persistência", snippets: [
            Snippet(name: "Snippet 1", content: "let x = 10"),
            Snippet(name: "Snippet 3", content: "let z = \"abc\"")
        ]),
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
        cell.textLabel?.text = tags[indexPath.row].name
      return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTag = tags[indexPath.row]
        delegate?.tagSelected(selectedTag)
        
        if (delegate as? SupplementaryTableViewController) != nil {
          splitViewController?.show(.supplementary)
        }
    }
}
