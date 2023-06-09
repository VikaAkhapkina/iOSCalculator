//
//  ViewController.swift
//  Calculator
//
//  Created by Viktoriya on 13.02.23.
//

import UIKit
import SnapKit

class CalcController: UIViewController {
    
    let viewModel: CalcControllerViewModel
    
// MARK: - UI Components (Компоненты пользовательского интерфейса)
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.register(CalcHeadeCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CalcHeadeCell.identifier)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.identifier)
        return collectionView
    }()

    
// MARK: - Lifecycle (Жизненный цикл)
    init(viewModel: CalcControllerViewModel = CalcControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setupUI()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.viewModel.updateView = {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
// MARK: - UI Setup (Настройка пользовательского интерфейса)
    private func setupUI() {
        view.addSubview(self.collectionView)
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }


}
// MARK: - CollectionView Methods (Методы CollectionView)
extension CalcController: UICollectionViewDataSource {
    
    // MARK: Section Header Cell
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalcHeadeCell.identifier, for: indexPath) as? CalcHeadeCell  else {
            fatalError("Failed to dequeue ButtonCell in CalcController")
        }
        header.configure(currentCalcText: self.viewModel.calcHeaderLabel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let totalellHeight = view.frame.size.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top
        let totalVerticalCellSpacing = CGFloat(10*4)
        let buttonsHeight = (view.frame.size.width - 40) / 4 * 5
        
        let headerHeight = totalellHeight - totalVerticalCellSpacing - buttonsHeight
        
        return CGSize(width: view.frame.size.width, height: headerHeight)
    }

    
    
// MARK: - Normal Cells (Buttons)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.calcButtonCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell else {
            fatalError("Failed to dequeue ButtonCell in CalcController ")
        }
        let calcButton = self.viewModel.calcButtonCells[indexPath.row]
        cell.configure(with: calcButton)
        return cell
    }
    
}

extension CalcController: UICollectionViewDelegate {
    
    
}

extension CalcController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let calcButton = self.viewModel.calcButtonCells[indexPath.row]

        switch calcButton {
        case let .number(int) where int == 0:
            return CGSize(
                width: ((view.frame.size.width - 40) / 2) + 10,
                height: (view.frame.size.width - 40) / 4
            )
        default:
            return CGSize(
                width: (view.frame.size.width - 40) / 4,
                height: (view.frame.size.width - 40) / 4
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let buttonCell = self.viewModel.calcButtonCells[indexPath.row]
        self.viewModel.didSelectButton(with: buttonCell)

    }
}
