//
//  MainViewModel.swift
//  Notes
//
//  Created by Дмитрий Скок on 30.01.2024.
//

import Foundation

final class MainViewModel {
    private let dataManager = DataManager.shared
    private let router: MainRouter
    var notesArray: [NoteEntity] = []

    init(router: MainRouter) {
        self.router = router
        firstRun()
    }

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

    private func firstRun() {
        if !UserDefaults.standard.bool(forKey: "isFirstRun") {
            UserDefaults.standard.set(true, forKey: "isFirstRun")
            notesArray = dataManager.loadDemoNote()
        } else {
            fetchNotes()
        }
    }
}
