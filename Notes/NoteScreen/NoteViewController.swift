//
//  NoteViewController.swift
//  Notes
//
//  Created by Дмитрий Скок.
//

import UIKit
import SnapKit

final class NoteViewController: UIViewController {
    // MARK: - Views

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 17)
        textView.keyboardDismissMode = .interactive
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textView.allowsEditingTextAttributes = true
        return textView
    }()

    // MARK: - Private properties

    private let dataManager = DataManager.shared
    private let viewModel: NoteViewModel

    // MARK: - Initialization

    init(viewModel: NoteViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        embedView()
        setupLayout()
        setupAppearance()
        setupNavigationBar()
        registerForKeyboardNotification()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        textView.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        view.endEditing(true)
    }

    // MARK: - Private functions

    private func embedView() {
        view.addSubview(textView)
    }

    private func setupLayout() {

        textView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupAppearance() {
        view.backgroundColor = .systemBackground
        textView.text = viewModel.selectedNote?.text
    }

    @objc private func doneButtonAction () {
        view.endEditing(true)
    }

    @objc private func saveButtonAction () {
        viewModel.saveNote(text: textView.text)
    }

    @objc private func backButtonAction() {
        if textView.text.isEmpty == true {
            viewModel.popToRoot()
        } else {
            viewModel.saveNote(text: textView.text)
            viewModel.popToRoot()
        }
    }
}

// MARK: - Setup NavigationBar

private extension NoteViewController {
    func setupNavigationBar() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(backButtonAction)
        )

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
}


// MARK: - Setup Keyboard

private extension NoteViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        if let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue  {
            let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
            textView.contentInset = edgeInsets
            textView.scrollIndicatorInsets = edgeInsets
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                target: self,
                                                                action: #selector(doneButtonAction)
            )
        }
    }

    @objc func keyboardHideShow() {
        if textView.text.isEmpty == false {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                                target: self,
                                                                action: #selector(saveButtonAction)
            )
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}
