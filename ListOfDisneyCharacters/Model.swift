//
//  Model.swift
//  ListOfDisneyCharacters
//
//  Created by Ваня Сокол on 03.08.2023.
//

import Foundation

struct Characters: Decodable {
    let data: [Character]
}

struct Character: Decodable {
    let name: String
    let imageUrl: String
}


class CharacterViewModel {
    let title: String
    let imageURL: URL?
    var imageData: Data? = nil

    init(title: String, imageURL: URL?) {
        self.title = title
        self.imageURL = imageURL
    }
}
