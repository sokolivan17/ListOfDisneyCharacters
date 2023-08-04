//
//  TableViewCell.swift
//  ListOfDisneyCharacters
//
//  Created by Ваня Сокол on 04.08.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    static var identifier = "Cell"

    var character: Character? {
        didSet {
            characterName.text = character?.name

            DispatchQueue.main.async {
                guard let imagePath = self.character?.imageUrl,
                      let imageURL = URL(string: imagePath),
                      let imageData = try? Data(contentsOf: imageURL)
                else {
                    self.characterImage.image = UIImage(systemName: "face.smiling")
                    return
                }

                self.characterImage.image = UIImage(data: imageData)
            }
        }
    }

    lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var characterName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
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
        contentView.addSubview(characterName)
        contentView.addSubview(characterImage)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            characterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            characterImage.heightAnchor.constraint(equalToConstant: 50),

            characterName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            characterName.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 10),

        ])
    }

    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        characterName.text = ""
        characterImage.image = nil
    }
}
