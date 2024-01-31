//
//  NoteViewModel.swift
//  Notes
//
//  Created by Дмитрий Скок.
//

import Foundation

final class NoteViewModel {
    // MARK: - Properties
    
    var selectedNote: NoteEntity?
    var index: Int?

    // MARK: - Private properties

    private let dataManager = DataManager.shared
    private let router: NoteRouter

    // MARK: - Initialization

    init(router: NoteRouter, index: Int? = nil) {
        self.router = router
        self.index = index

        getNote()
    }

    // MARK: - Functions

    func popToRoot() {
        router.popToRootViewController()
    }

    func saveNote(text: String) {
        if selectedNote != nil {
            selectedNote?.text = text
            dataManager.save()
        } else {
            dataManager.addNote(text: text)
        }
    }
    
    // MARK: - Private functions

    private func getNote() {
        guard let index else {
            return
        }
        selectedNote = dataManager.getNote(noteIndex: index)
    }
}
