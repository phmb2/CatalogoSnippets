//
//  SupplementaryViewController.swift
//  CatalogoSnippets
//
//  Created by Pedro Barbosa on 19/04/21.
//

import UIKit

protocol SnippetSelectionDelegate: AnyObject {
    func snippetSelected(_ newSnippet: Snippet)
}

class SupplementaryTableViewController: UITableViewController {
    
    // MARK: - Properties
    weak var delegate: SnippetSelectionDelegate?
    
    var tag: Tag? {
        didSet {
            refreshUI()
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helpers
    private func refreshUI() {
        loadViewIfNeeded()
        title = tag?.name ?? "New Tag"
    }
    
    // MARK: - Actions
    @IBAction func addSnippetsAction(_ sender: UIBarButtonItem) {
        tag?.snippets.insert(Snippet(name: "New Snippet", content: ""), at: 0)
        tableView.reloadData()
    }
    
    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tag?.snippets.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SnippetCell", for: indexPath)
        cell.textLabel?.text = tag?.snippets[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSnippet = (tag?.snippets[indexPath.row])!
        delegate?.snippetSelected(selectedSnippet)
        
        if (delegate as? DetailViewController) != nil {
          splitViewController?.show(.secondary)
        }
    }
}

// MARK: - TagSelectionDelegate
extension SupplementaryTableViewController: TagSelectionDelegate {
    func tagSelected(_ newTag: Tag) {
        tag = newTag
        tableView.reloadData()
    }
}
