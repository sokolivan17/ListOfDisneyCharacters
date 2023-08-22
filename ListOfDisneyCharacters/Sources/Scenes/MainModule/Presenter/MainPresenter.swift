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
    var characters: [CharacterViewModel] { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getCharacters()
}

final class MainPresenter: MainViewPresenterProtocol {
    var characters = [CharacterViewModel]()
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getCharacters()
    }

    public func getCharacters() {
        networkService.getCharacters { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self?.characters = characters.compactMap({
                        CharacterViewModel(title: $0.name,
                                           imageURL: URL(string: $0.imageUrl))
                    })
                    self?.view?.success()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
}
