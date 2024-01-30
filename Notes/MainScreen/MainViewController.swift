//
//  MainViewController.swift
//  Notes
//
//  Created by Дмитрий Скок on 30.01.2024.
//

import UIKit

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

        setupLayout()
        configureNavigationBar()

        view.backgroundColor = .systemBackground
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.fetchNotes()
        tableView.reloadData()
    }

    private func setupLayout() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
        let vc = NoteAssembly.create()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.notesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NoteTableViewCell else {
            return UITableViewCell()
        }

        let note = viewModel.notesArray[indexPath.row]
        cell.configureCell(text: note.text ?? "default value")
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
