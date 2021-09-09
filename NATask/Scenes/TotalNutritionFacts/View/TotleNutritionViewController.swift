//
//  TotleNutritionViewController.swift
//  NATask
//
//  Created by Esraa Mohamed Ragab on 09/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

class TotleNutritionViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var factsTableView: UITableView!
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    var totalNutritionViewModal: TotalNutritionViewModal!
    private let factsCellIdentifierAndNibName = "FactsTableViewCell"
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabelViewCell()
        bind()
        totalNutritionViewModal.ingredientsSubjectOnNext()
    }
    
    func setupTabelViewCell() {
        factsTableView.register(UINib(nibName: factsCellIdentifierAndNibName, bundle: .main), forCellReuseIdentifier: factsCellIdentifierAndNibName)
    }
    
    // MARK: - Bind Method
    func bind() {
        totalNutritionViewModal.factsModelObservable
            .bind(to: self.factsTableView
                    .rx
                    .items(cellIdentifier: factsCellIdentifierAndNibName,
                           cellType: FactsTableViewCell.self)) { row, fact, cell in
                cell.factTitleLabel.text = fact.label
                cell.factValueLabel.text = "\(String(format: "%.1f", (fact.quantity ?? 0))) \(fact.unit ?? "")"
            }
            .disposed(by: disposeBag)
    }
}
