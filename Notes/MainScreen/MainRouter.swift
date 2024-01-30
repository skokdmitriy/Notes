//
//  MainRouter.swift
//  Notes
//
//  Created by Дмитрий Скок on 30.01.2024.
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
}
