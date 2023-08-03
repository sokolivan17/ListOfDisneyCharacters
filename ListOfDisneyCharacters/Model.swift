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
