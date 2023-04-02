//
//  CalcHeadeCell.swift
//  Calculator
//
//  Created by Viktoriya on 13.02.23.
//

import UIKit

class CalcHeadeCell: UICollectionReusableView {
    
    static let identifier = "CalcHeadeCell"
    
    // MARK: UI Components (Компоненты пользовательского интерфейса)
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 72 , weight: .regular)
        label.text = "Error "
        return label
    }()

    // MARK: - Lifecycle (Жизненный цикл)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(currentCalcText: String) {
        self.label.text = currentCalcText
    }
    
    // MARK: - UI Setup (Настройка пользовательского интерфейса)
    private func setupUI() {
        self.backgroundColor = .black
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            self.label.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)

            
        ])
        
        backgroundColor = .purple
    }
    
}
