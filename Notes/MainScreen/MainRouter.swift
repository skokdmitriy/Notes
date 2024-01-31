//
//  MainRouter.swift
//  Notes
//
//  Created by Дмитрий Скок.
//

import UIKit

final class MainRouter {
    weak var viewController: UIViewController?

    func showNote(_ indexPathRow: Int) {
        if let viewController {
            let noteViewController = NoteAssembly.create(index: indexPathRow)
            viewController.navigationController?.pushViewController(noteViewController, animated: true)
        }
    }

    func addNewNote() {
        if let viewController {
            let noteViewController = NoteAssembly.create()
            viewController.navigationController?.pushViewController(noteViewController, animated: true)
        }
    }
}
