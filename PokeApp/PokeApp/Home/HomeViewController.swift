//
//  HomeViewController.swift
//  PokeApp
//
//  Created by Daniel Cano on 29/4/25.
//

import UIKit

protocol HomeView: AnyObject {
    func reloadData()
}

class HomeViewController: UIViewController, HomeView {
    
    weak var presenter: HomePresenter?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        setupLayout()
        tableView.register(PokeViewCell.self, forCellReuseIdentifier: "PokeViewCell")
        reloadData()
    }

    func setupLayout() {
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func reloadData() {
        presenter?.fetchPokemons()
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfPokemons() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokeViewCell", for: indexPath) as? PokeViewCell {
            cell.nameLabel.text = presenter?.item(at: indexPath.row).name
            cell.pokeImageView.image = UIImage(named: presenter?.item(at: indexPath.row).url ?? "")
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}

