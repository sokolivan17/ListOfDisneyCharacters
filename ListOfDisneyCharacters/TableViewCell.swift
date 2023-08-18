//
//  TableViewCell.swift
//  ListOfDisneyCharacters
//
//  Created by Ваня Сокол on 04.08.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    static var identifier = "Cell"

    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var characterNameBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255 / 255, green: 219 / 255, blue: 139 / 255, alpha: 1.0)
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemBrown.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var characterName: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarcy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupHierarcy() {
        contentView.addSubview(characterNameBackgroundView)
        contentView.addSubview(characterName)
        contentView.addSubview(characterImage)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            characterNameBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            characterNameBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            characterNameBackgroundView.trailingAnchor.constraint(equalTo: characterImage.leadingAnchor, constant: -10),
            characterNameBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70),

            characterName.leadingAnchor.constraint(equalTo: characterNameBackgroundView.leadingAnchor, constant: 5),
            characterName.topAnchor.constraint(equalTo: characterNameBackgroundView.topAnchor, constant: 5),
            characterName.trailingAnchor.constraint(equalTo: characterNameBackgroundView.trailingAnchor, constant: -5),
            characterName.bottomAnchor.constraint(equalTo: characterNameBackgroundView.bottomAnchor, constant: -5),

            characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            characterImage.widthAnchor.constraint(equalToConstant: contentView.frame.width - 30 - contentView.frame.width / 3),
            characterImage.heightAnchor.constraint(equalTo: characterImage.widthAnchor, multiplier: 1.53),
        ])
    }

    // MARK: - Configure
    public func configure(with viewModel: CharacterViewModel) {
        characterName.text = viewModel.title

        if let data = viewModel.imageData {
            characterImage.image = UIImage(data: data)
        } else if let  url = viewModel.imageURL {

            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }

                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.characterImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }

    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        characterName.text = ""
        characterImage.image = nil
    }
}
