//
//  ViewController.swift
//  ListOfDisneyCharacters
//
//  Created by Ваня Сокол on 03.08.2023.
//

import UIKit

class ViewController: UIViewController {
    let cellId = "mvpCellId"
    lazy var tableView = UITableView()
    var presenter: MainViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
    }

    override func loadView() {
        view = tableView
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.characters?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let character = presenter.characters?[indexPath.row]

        cell.textLabel?.text = character?.name

        guard let imagePath = character?.imageUrl,
              let imageURL = URL(string: imagePath),
              let imageData = try? Data(contentsOf: imageURL)
        else {
            cell.imageView?.image = UIImage(systemName: "face.smiling")
            return cell
        }

        cell.imageView?.image = UIImage(data: imageData)
        return cell
    }
}

extension ViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
    }

    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
