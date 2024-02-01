//
//  Constants.swift
//  Notes
//
//  Created by Дмитрий Скок on 31.01.2024.
//

import UIKit

public enum R {
    enum String {
        static let testNote = "Test Note"
        static let errorLoad = "Error load Note"
        static let errorSaving = "Error saving data"

        static let noteCellReuseIdentifier = "NoteCell"
        static let mainTitle = "Notes"
        static let textIsEmpty = "Text is empty"

        static let isFirstRun = "isFirstRun"
    }

    enum Image {
        static let backButton = UIImage(systemName: "chevron.backward")
    }
}
