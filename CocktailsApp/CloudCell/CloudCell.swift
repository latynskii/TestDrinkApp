//
//  cloudCell.swift
//  CocktailsApp
//
//  Created by EDUARD Latynsky on 30.03.2022.
//


import UIKit

class CloudCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "cloudCell"
        
    let cloudLabel: UILabel = {
        let cloudLabel = UILabel()
        cloudLabel.tintColor = .white
        cloudLabel.clipsToBounds = true
        cloudLabel.font = .systemFont(ofSize: 15, weight: .light)
        cloudLabel.textColor = .white
        return cloudLabel
    }()
    
    let helpView: UIView =  {
        let view = UIView()
        return view
    }()
    
    var viewModel: CloudCellViewModel? {
        didSet {
            cloudLabel.text = viewModel?.buttonName
        }
    }
    
    //MARK: - View Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    override func layoutSubviews() {
        if viewModel?.isTapped ?? false {
            self.addGradientBackground(firstColor: .red, secondColor: .purple)
        } else {
            self.removeSubLayer()
        }
        setupUI()
    }
    
    private func setupUI(){
        backgroundColor = .gray
        layer.cornerRadius = 10
    }
    
    //MARK: - Constrains
    private func setupConstrains() {
        addSubview(helpView)
        helpView.addSubview(cloudLabel)
        cloudLabel.translatesAutoresizingMaskIntoConstraints = false
        helpView.translatesAutoresizingMaskIntoConstraints = false

        helpView.snp.makeConstraints { make in
            make.leadingMargin.equalTo(self.snp_leadingMargin)
            make.trailingMargin.equalTo(self.snp_trailingMargin)
            make.topMargin.equalTo(self.snp_topMargin)
            make.bottomMargin.equalTo(self.snp_bottomMargin)
        }

        cloudLabel.snp.makeConstraints { make in
            make.leading.equalTo(helpView.snp_leadingMargin).offset(5)
            make.trailing.equalTo(helpView.snp_trailingMargin).offset(-5)
            make.top.equalTo(helpView.snp_topMargin)
            make.bottom.equalTo(helpView.snp_bottomMargin)
        }
    }
}
