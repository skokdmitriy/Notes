//
//  MainAssembly.swift
//  Notes
//
//  Created by Дмитрий Скок.
//

import UIKit

final class MainAssembly {
    static func create() -> UIViewController {
        let router = MainRouter()
        let viewModel = MainViewModel(router: router)
        let viewController = MainViewController(viewModel: viewModel)
        router.viewController = viewController
        return viewController
    }
}
