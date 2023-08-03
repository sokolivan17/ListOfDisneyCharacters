//
//  NetworkService.swift
//  ListOfDisneyCharacters
//
//  Created by Ваня Сокол on 03.08.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCharacters(completion: @escaping (Result<Characters?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getCharacters(completion: @escaping (Result<Characters?, Error>) -> Void) {
        let urlString = "https://api.disneyapi.dev/character"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("Data error")
                return
            }

            do {
                let obj = try JSONDecoder().decode(Characters.self, from: data)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
