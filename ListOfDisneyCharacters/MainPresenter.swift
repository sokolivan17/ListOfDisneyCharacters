//
//  MainPresenter.swift
//  ListOfDisneyCharacters
//
//  Created by Ваня Сокол on 03.08.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    var characters: [Character]? { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getCharacters()
}

class MainPresenter: MainViewPresenterProtocol {
    var characters: [Character]?
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!

    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getCharacters()
    }

    func getCharacters() {
        networkService.getCharacters { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self.characters = characters
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
