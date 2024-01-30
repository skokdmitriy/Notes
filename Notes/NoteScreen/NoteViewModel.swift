//
//  NoteViewModel.swift
//  Notes
//
//  Created by Дмитрий Скок.
//

import Foundation

final class NoteViewModel {
    private let dataManager = DataManager.shared
    private let router: NoteRouter
    var selectedNote: NoteEntity?
    var index: Int?

    init(router: NoteRouter, index: Int? = nil) {
        self.router = router
        self.index = index

        getNote()
    }

    func popToRoot() {
        router.popToRootViewController()
    }

    func saveButtonAction(_ text: String) {
        guard selectedNote != nil,
              let selectedNote = selectedNote else {
            return dataManager.addNote(text: text)
        }
        selectedNote.text = text
        dataManager.save()
    }

    func backButtonAction(_ text: String) {
        popToRoot()
        guard selectedNote != nil,
              let selectedNote = selectedNote else {
            return
        }
        selectedNote.text = text
        dataManager.save()
        print("back")
    }


    private func getNote() {
        guard let index else {
            return
        }
        selectedNote = dataManager.getNote(noteIndex: index)
    }
}
