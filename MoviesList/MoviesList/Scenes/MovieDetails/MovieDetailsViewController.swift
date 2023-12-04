//
//  MovieDetailsViewController.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let posterImageView: CustomCacheImageView = {
        let imageView = CustomCacheImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.Images.close), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.numberOfLines = 0
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let starView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: Constants.Images.starImage)
        imageView.tintColor = .black
        return imageView
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    var presenter: MovieDetailsPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        presenter?.getMovieDetails()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        setupViews()
        setupCloseButton()
        setupLayout()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(posterImageView)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(overviewLabel)
        scrollView.addSubview(starView)
        scrollView.addSubview(voteAverageLabel)
    }
    
    private func setupCloseButton() {
        closeButton.addTarget(
            self,
            action: #selector(didCloseButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func didCloseButtonTapped() {
        presenter?.didCloseButtonTapped()
    }
    
    private func setupLayout() {
        
        let padding: CGFloat = 12.0
        let imageWidth: CGFloat = view.frame.size.width
        let imageHeight: CGFloat = imageWidth / 1.7
        let buttonSize: CGFloat = 44.0
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            posterImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            
            closeButton.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: padding),
            closeButton.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -padding),
            closeButton.widthAnchor.constraint(equalToConstant: buttonSize),
            closeButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -padding),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            starView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: padding),
            starView.leadingAnchor.constraint(equalTo: overviewLabel.leadingAnchor),
            starView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding),
            
            voteAverageLabel.leadingAnchor.constraint(equalTo: starView.trailingAnchor, constant: padding),
            voteAverageLabel.centerYAnchor.constraint(equalTo: starView.centerYAnchor)
        ])
    }
}

// MARK: - UI Update

extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func updateDetails(_ movie: Movie) {
        if let url = URL(string: movie.posterPath ?? "") {
            posterImageView.loadImageWithUrl(url)
        }
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        voteAverageLabel.text = String(movie.voteAverage)
    }
}
