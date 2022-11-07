//
//  CountryListCell.swift
//  CountryList
//
//  Created by Дмитрий Дуров on 01.11.2022.
//

import UIKit


final class CountryListCell: UITableViewCell {
    
    lazy private var flagImageView: UIImageView = {
        let flagImageView = UIImageView()
        flagImageView.clipsToBounds = true
        flagImageView.contentMode = .scaleToFill
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        return flagImageView
    }()
    
    lazy private var countryNameLabel: UILabel = {
        let countryNameLabel = UILabel()
        countryNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return countryNameLabel
    }()
    
    lazy private var countryCapitalLabel: UILabel = {
        let countryCapitalLabel = UILabel()
        countryCapitalLabel.translatesAutoresizingMaskIntoConstraints = false
        return countryCapitalLabel
    }()
    
    lazy private var shevronImageView: UIImageView = {
        let shevronImageView = UIImageView()
        shevronImageView.tintColor = .systemGray
        shevronImageView.image = UIImage(systemName: "chevron.right")
        shevronImageView.translatesAutoresizingMaskIntoConstraints = false
        return shevronImageView
    }()
    
    lazy private var countryDescriptionSmallLabel: UILabel = {
        let countryDescriptionSmallLabel = UILabel()
        countryDescriptionSmallLabel.numberOfLines = 0
        countryDescriptionSmallLabel.translatesAutoresizingMaskIntoConstraints = false
        return countryDescriptionSmallLabel
    }()
    
    lazy private var stackView = UIStackView()
    
    var viewModel: CountryListCellViewModelProtocol! {
        didSet{
            countryNameLabel.text = viewModel.name
            countryCapitalLabel.text = viewModel.capital
            countryDescriptionSmallLabel.text = viewModel.descriptionSmall
            viewModel.flagImage = { imageData in
                self.flagImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(flagImageView)
        addSubview(countryDescriptionSmallLabel)
        setStackView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        private func setStackView() {
            addSubview(stackView)
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.spacing = 10
    
            let labelStackView = UIStackView()
            labelStackView.axis = .vertical
            labelStackView.distribution = .fill
            labelStackView.addArrangedSubview(countryNameLabel)
            labelStackView.addArrangedSubview(countryCapitalLabel)
    
            let topStackView = UIStackView()
            topStackView.axis = .horizontal
            topStackView.distribution = .fillProportionally
            topStackView.spacing = 10
            topStackView.alignment = .center
            topStackView.addArrangedSubview(flagImageView)
            topStackView.addArrangedSubview(labelStackView)
            topStackView.addArrangedSubview(shevronImageView)
    
            stackView.addArrangedSubview(topStackView)
            stackView.addArrangedSubview(countryDescriptionSmallLabel)
        }
    
    private func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
                        flagImageView.heightAnchor.constraint(equalToConstant: 40),
                        flagImageView.widthAnchor.constraint(equalToConstant: 60),
                        shevronImageView.heightAnchor.constraint(equalToConstant: 17),
                        shevronImageView.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
}
