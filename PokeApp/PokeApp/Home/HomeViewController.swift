//
//  HomeViewController.swift
//  PokeApp
//
//  Created by Daniel Cano on 29/4/25.
//

import UIKit
import Kingfisher

protocol HomeView: AnyObject {
    func loadData()
}

class HomeViewController: UIViewController, HomeView {
    
    var presenter: HomePresenter?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a Pokemon"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        setupLayout()
        tableView.register(PokeViewCell.self, forCellReuseIdentifier: "PokeViewCell")
        presenter?.fetchPokemons()
    }

    func setupLayout() {
        view.addSubview(searchBar)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func loadData() {
        tableView.reloadData()
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfPokemons() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokeViewCell", for: indexPath) as? PokeViewCell {
            if let urlString = presenter?.item(at: indexPath.row).imageUrl,
               let url = URL(string: urlString) {
                cell.pokeImageView.kf.setImage(with: url)
            }
            cell.nameLabel.text = presenter?.item(at: indexPath.row).name

            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if position > contentHeight - frameHeight - 100 {
            presenter?.fetchPokemons()
        }
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.filterPokemons(with: searchText)
    }
}
