//
//  DetailViewController.swift
//  PokeApp
//
//  Created by Daniel Cano on 5/5/25.
//

import UIKit
import Kingfisher

protocol DetailView: AnyObject {
    func show(detail: PokemonDetail)
    func showError(_ message: String)
}

class DetailViewController: UIViewController, DetailView {

    var presenter: DetailPresenter?

    // MARK: - Views

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    lazy var contentView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }

    // MARK: - Layout

    func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])

        contentView.addArrangedSubview(imageView)
        contentView.addArrangedSubview(nameLabel)
        contentView.addArrangedSubview(infoLabel)

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    // MARK: - View Protocol

    func show(detail: PokemonDetail) {
        if let name = detail.name?.capitalized {
            nameLabel.text = "#\(detail.id ?? 0) - \(name)"
            self.title = name
        }

        infoLabel.text = """
        Height: \(detail.height ?? 0)
        Weight: \(detail.weight ?? 0)
        """

        if let urlString = detail.sprites?.front_default,
           let url = URL(string: urlString) {
            imageView.kf.setImage(with: url)
        }

        if let types = detail.types {
            for entry in types {
                if let typeName = entry.type?.name {
                    let label = makeTypeBadge(text: typeName.capitalized, type: typeName.lowercased())
                    contentView.addArrangedSubview(label)
                }
            }
        }
    }

    func showError(_ message: String) {
        nameLabel.text = message
    }

    // MARK: - Helpers

    func makeTypeBadge(text: String, type: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = backgroundColor(for: type)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        return label
    }

    func backgroundColor(for type: String) -> UIColor {
        switch type {
        case "fire": return .systemRed
        case "water": return .systemBlue
        case "grass": return .systemGreen
        case "electric": return .systemYellow
        case "psychic": return .systemPurple
        case "ground": return .brown
        case "rock": return .darkGray
        case "ice": return .cyan
        case "bug": return .systemTeal
        case "dragon": return .systemIndigo
        case "dark": return .black
        case "fairy": return .systemPink
        default: return .gray
        }
    }
}

