//
//  DetailViewController.swift
//  PokeApp
//
//  Created by Daniel Cano on 5/5/25.
//

import UIKit

protocol DetailView: AnyObject {
    func show(detail: PokemonDetail)
    func showError(_ message: String)
}

class DetailViewController: UIViewController, DetailView {

    var presenter: DetailPresenter?

    let nameLabel = UILabel()
    let imageView = UIImageView()
    let infoLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }

    func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [imageView, nameLabel, infoLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    func show(detail: PokemonDetail) {
        nameLabel.text = "#\(detail.id) - \(detail.name.capitalized)"
        infoLabel.text = "Height: \(detail.height), Weight: \(detail.weight)\nTypes: \(detail.types.map { $0.type.name.capitalized }.joined(separator: ", "))"
        if let urlString = detail.sprites.front_default, let url = URL(string: urlString) {
            imageView.kf.setImage(with: url)
        }
    }

    func showError(_ message: String) {
        nameLabel.text = message
    }
}
