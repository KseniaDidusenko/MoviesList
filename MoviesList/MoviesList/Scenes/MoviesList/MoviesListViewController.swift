//
//  MoviesListViewController.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let refreshControl = UIRefreshControl()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            MovieCell.self,
            forCellReuseIdentifier: String(describing: MovieCell.self)
        )
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let emptyView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.Images.empty)
        imageView.tintColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = Constants.Titles.noResults
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var presenter: MoviesListPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        presenter?.getMovies()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        setupNavigationController()
        setupTableView()
        setupSearchController()
        setupLayout()
    }
    
    private func setupNavigationController() {
        navigationController?.isNavigationBarHidden = false
        title = Constants.Titles.topRated
    }
    
    private func setupTableView() {
        refreshControl.addTarget(
            self,
            action: #selector(handleRefreshControl),
            for: .valueChanged
        )
        tableView.refreshControl = self.refreshControl
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = Constants.Titles.searchMovie
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(emptyView)
        emptyView.addSubview(emptyImageView)
        emptyView.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            emptyView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            
            emptyImageView.widthAnchor.constraint(equalToConstant: 200),
            emptyImageView.heightAnchor.constraint(equalToConstant: 200),
            emptyImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            
            emptyLabel.centerXAnchor.constraint(equalTo: emptyImageView.centerXAnchor),
            emptyLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: 12.0)
        ])
    }
    
    @objc private func handleRefreshControl() {
        if !searchController.isActive {
            presenter?.handleRefreshControl()
        }
    }
}

// MARK: - UITableViewDelegate

extension MoviesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectRow(at: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension MoviesListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: MovieCell.self),
            for: indexPath
        ) as? MovieCell
        else { return UITableViewCell() }
        
        if let movie = presenter?.getMovie(at: indexPath) {
            cell.setup(with: movie)
        }
        
        cell.selectionStyle = .gray
        
        return cell
    }
}

// MARK: - UI Update

extension MoviesListViewController: MoviesListViewProtocol {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.Titles.ok, style: .default, handler: { (action) in
        }))
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showEmptyView(isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.emptyView.isHidden = isHidden
            self?.tableView.reloadData()
        }
    }
    
    func updateMovies() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
}

// MARK: - UISearchResultsUpdating

extension MoviesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let inputTextByUser = searchController.searchBar.text else { return }
        presenter?.searchMovies(with: inputTextByUser)
    }
}
