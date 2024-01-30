//
//  NoteRouter.swift
//  Notes
//
//  Created by Дмитрий Скок.
//

import UIKit

final class NoteRouter {
    weak var viewController: UIViewController?

    func popToRootViewController() {
        if let viewController = viewController {
            viewController.navigationController?.popToRootViewController(animated: true)
        }
    }
}
