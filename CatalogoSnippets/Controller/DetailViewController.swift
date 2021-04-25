//
//  DetailViewController.swift
//  CatalogoSnippets
//
//  Created by Pedro Barbosa on 25/03/21.
//

import UIKit
import Sourceful

class DetailViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var languageItem: UIBarButtonItem!
    @IBOutlet weak var detailTextView: SyntaxTextView!
    
    let swiftLexer = SwiftLexer()
    let pythonLexer = Python3Lexer()
    
    private var isSwiftLexer: Bool = true
    
    var snippet: Snippet? {
        didSet {
            refreshUI()
        }
    }
    
    var sourceCodeTheme: SourceCodeTheme {
        if UIApplication.activeTraitCollection.userInterfaceStyle == .dark {
            return DarkTheme()
        } else {
            return LightTheme()
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTextView.theme = sourceCodeTheme
        detailTextView.delegate = self

        // Attach a toolbar with common key symbols to make typing easier.
        detailTextView.contentTextView.inputAccessoryView = UIView.editingToolbar(target: self, action: #selector(insertCharacter))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 14.0, *) {
            let swiftLexerAction: UIAction = .init(title: "Swift", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off, handler: { (action) in
                self.isSwiftLexer = true
            })
            
            let pythonLexerAction : UIAction = .init(title: "Python 3", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off, handler: { (action) in
                self.isSwiftLexer = false
            })
            
            let actions = [swiftLexerAction, pythonLexerAction]
            let menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: actions)
            
            languageItem.primaryAction = nil
            languageItem.menu = menu
        }
    }
    
    // MARK: - Helpers
    private func refreshUI() {
        loadViewIfNeeded()
        title = snippet?.name ?? "New Snippet"
        detailTextView.text = snippet?.content ?? ""
    }

    // MARK: - Selectors
    /// Called when the user taps a key symbol in our input accessory view.
    @objc func insertCharacter(_ sender: UIBarButtonItem) {
        guard let value = UnicodeScalar(sender.tag) else { return }
        let string = String(value)
        detailTextView.insertText(string)
        UIDevice.current.playInputClick()
    }

}

// MARK: - SnippetSelectionDelegate
extension DetailViewController: SnippetSelectionDelegate {
    func snippetSelected(_ newSnippet: Snippet) {
        snippet = newSnippet
    }
}

// MARK: - SyntaxTextViewDelegate
extension DetailViewController: SyntaxTextViewDelegate {
    /// Send back our Swift lexer for this source code.
    func lexerForSource(_ source: String) -> Lexer {
        return isSwiftLexer ? swiftLexer : pythonLexer
    }
}
