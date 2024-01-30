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
        saveNote(text: text)
    }

    func backButtonAction(_ text: String) {
        popToRoot()
        saveNote(text: text)
    }

    private func getNote() {
        guard let index else {
            return
        }
        selectedNote = dataManager.getNote(noteIndex: index)
    }

//        private func saveNote(text: String) {
//            guard selectedNote != nil,
//                  let selectedNote = selectedNote else {
//                return /*dataManager.addNote(text: text)*/
//            }
//            selectedNote.text = text
//            dataManager.save()
//        }

    private func saveNote(text: String) {
        if selectedNote != nil {
            selectedNote?.text = text
            dataManager.save()
        } else {
            dataManager.addNote(text: text)
        }
    }
}
