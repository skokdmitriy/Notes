//
//  MainViewController.swift
//  Notes
//
//  Created by Дмитрий Скок.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    // MARK: - Private properties

    private let viewModel: MainViewModel

    // MARK: - Initialization

    init(viewModel: MainViewModel) {
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
        configureNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.fetchNotes()
        tableView.reloadData()
    }

    // MARK: - Private functions

    private func embedView() {
        view.addSubview(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupAppearance() {
        view.backgroundColor = .systemBackground
    }

    private func configureNavigationBar() {
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addNewNote)
        )
    }

    @objc private func addNewNote() {
        viewModel.tapOnNewNote()
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.notesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                       for: indexPath
        ) as? NoteTableViewCell else {
            return UITableViewCell()
        }

        let note = viewModel.notesArray[indexPath.row]
        if let noteText = note.text {
            cell.configureCell(text: noteText)
        } else {
            print("text is empty")
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.tapOnNote(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteNote(indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
