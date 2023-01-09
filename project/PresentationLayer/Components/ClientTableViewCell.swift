//
//  ClientTableViewCell.swift
//  project
//
//  Created by Alisher Djuraev on 09/01/23.
//

import UIKit

final class ClientTableViewCell: UITableViewCell {
    
    static let identifier = "ClientTableViewCell"
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor(red: 170/255, green: 171/255, blue: 173/255, alpha: 1.0)
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(red: 43/255, green: 45/255, blue: 51/255, alpha: 1.0)
        return label
    }()
    
    private let linkImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        image.image = UIImage(named: "ChainImage")
        image.contentMode = .scaleAspectFill
        image.isHidden = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if selectedBackgroundView == nil {
            selectedBackgroundView = UIView()
        }
        selectedBackgroundView?.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(firstLabel)
        contentView.addSubview(secondLabel)
        contentView.addSubview(linkImage)
        
        setConstraints()
    }
    
    private func setConstraints() {
        firstLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(12)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.bottom.equalTo(contentView.snp.bottom).offset(-12)
        }
        
        linkImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(30)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
            make.bottom.equalTo(contentView.snp.bottom).offset(-12)
        }
    }
    
    public func configure(with vm: TitleViewModel) {
        firstLabel.text = vm.model.titleName
        secondLabel.text = vm.model.descriptionName
        linkImage.isHidden = !vm.canCopy
    }
    
    required init?(coder: NSCoder) {
        coder.decodeObject(forKey: "firstLabel")
        coder.decodeObject(forKey: "secondLabel")
        coder.decodeObject(forKey: "linkImage")
        super.init(coder: coder)
    }
}
