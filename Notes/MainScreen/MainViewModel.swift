//
//  MainViewModel.swift
//  Notes
//
//  Created by Дмитрий Скок.
//

import Foundation

final class MainViewModel {
    // MARK: - Properties

    var notesArray: [NoteEntity] = []

    // MARK: - Private properties

    private let dataManager = DataManager.shared
    private let router: MainRouter

    // MARK: - Initialization

    init(router: MainRouter) {
        self.router = router
        firstRun()
    }

    // MARK: - Functions

    func fetchNotes() {
        notesArray.removeAll()
        notesArray = dataManager.loadNotes()
    }

    func deleteNote(_ indexPath: IndexPath) {
        notesArray.remove(at: indexPath.row)
        dataManager.delete(indexPath: indexPath)
    }

    func tapOnNote(indexPath: IndexPath) {
        router.showNote(indexPath.row)
    }

    func tapOnNewNote() {
        router.addNewNote()
    }

    // MARK: - Private functions

    private func firstRun() {
        if !UserDefaults.standard.bool(forKey: "isFirstRun") {
            UserDefaults.standard.set(true, forKey: "isFirstRun")
            notesArray = dataManager.loadDemoNote()
        } else {
            fetchNotes()
        }
    }
}
