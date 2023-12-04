//
//  MovieCell.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import UIKit

class MovieCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private let shadowView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = .white
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.4
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 10
        shadowView.layer.cornerRadius = 20.0
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        return shadowView
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(named: Constants.Colors.cellBackgroundColor)
        containerView.layer.cornerRadius = 20.0
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let movieCoverImage: CustomCacheImageView = {
        let imageView = CustomCacheImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.numberOfLines = 0
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
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    // MARK: Initializaton

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        contentView.addSubview(shadowView)
        contentView.addSubview(containerView)
        containerView.addSubview(movieCoverImage)
        containerView.addSubview(titleLabel)
        containerView.addSubview(starView)
        containerView.addSubview(voteAverageLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        
        let padding: CGFloat = 12.0
        let imageHeight: CGFloat = 140.0
        let imageWidth: CGFloat = imageHeight / 1.5
        
        let heightAnchor = movieCoverImage.heightAnchor.constraint(equalToConstant: imageHeight)
        heightAnchor.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            movieCoverImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            movieCoverImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            movieCoverImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            movieCoverImage.widthAnchor.constraint(equalToConstant: imageWidth),
            heightAnchor,

            titleLabel.topAnchor.constraint(equalTo: movieCoverImage.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieCoverImage.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),

            starView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            starView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            voteAverageLabel.leadingAnchor.constraint(equalTo: starView.trailingAnchor, constant: padding),
            voteAverageLabel.centerYAnchor.constraint(equalTo: starView.centerYAnchor)
        ])
    }
    
    func setup(with model: Movie) {
        if let url = URL(string: model.posterPath ?? "") {
            movieCoverImage.loadImageWithUrl(url)
        }
        titleLabel.text = model.title
        voteAverageLabel.text = String(model.voteAverage)
    }
}
