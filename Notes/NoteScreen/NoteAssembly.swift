//
//  NoteAssembly.swift
//  Notes
//
//  Created by Дмитрий Скок.
//

import UIKit

final class NoteAssembly {
    static func create(index: Int? = nil) -> UIViewController {
        let router = NoteRouter()
        let viewModel = NoteViewModel(router: router, index: index)
        let viewController = NoteViewController(viewModel: viewModel)
        router.viewController = viewController
        return viewController
    }
}
