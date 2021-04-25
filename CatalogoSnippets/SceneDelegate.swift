//
//  SceneDelegate.swift
//  CatalogoSnippets
//
//  Created by Pedro Barbosa on 25/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard
            let splitViewController = window?.rootViewController as? UISplitViewController,
            let leftNavController = splitViewController.viewControllers[0]
                as? UINavigationController,
            let masterTableViewController = leftNavController.viewControllers.first
                as? MasterTableViewController,
            
            let masterNavViewController = splitViewController.viewControllers[1]
                as? UINavigationController,
            let supplementaryTableViewController = masterNavViewController.viewControllers.first
                as? SupplementaryTableViewController,
            
            let detailNavViewController = splitViewController.viewControllers[2]
                as? UINavigationController,
            let detailViewController = detailNavViewController.viewControllers.first
                as? DetailViewController
        else { fatalError() }
        
        let firstTag = masterTableViewController.tags.first
        supplementaryTableViewController.tag = firstTag

        let firstSnippet = supplementaryTableViewController.tag?.snippets.first
        detailViewController.snippet = firstSnippet
        
        masterTableViewController.delegate = supplementaryTableViewController as TagSelectionDelegate
        supplementaryTableViewController.delegate = detailViewController as SnippetSelectionDelegate
    }
}

