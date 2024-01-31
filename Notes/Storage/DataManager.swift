//
//  DataManager.swift
//  Notes
//
//  Created by Дмитрий Скок.
//

import UIKit
import CoreData

final class DataManager {
    static let shared = DataManager()
    private init() {}

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
    private var fetchingNotes: [NoteEntity] = []

    func addNote(text: String) {
        let newNote = NoteEntity(context: context)
        newNote.text = text
        save()
    }

    func loadDemoNote() -> [NoteEntity] {
        addNote(text: R.String.testNote)
        do {
            fetchingNotes = try context.fetch(request)
        } catch {
            print(R.String.errorLoad)
        }
        return fetchingNotes
    }

    func loadNotes() -> [NoteEntity] {
        do {
            fetchingNotes = try context.fetch(request)
        } catch {
            print(R.String.errorLoad)
        }
        return fetchingNotes
    }

    func save() {
        do {
            try context.save()
        } catch {
            print(R.String.errorSaving)
        }
    }

    func delete(indexPath: IndexPath) {
        do {
            fetchingNotes = try context.fetch(request)
            let remove = fetchingNotes.remove(at: indexPath.row)
            context.delete(remove)
            save()
        } catch {

        }
    }

    func getNote(noteIndex: Int) -> NoteEntity {
        fetchingNotes[noteIndex]
    }
}
