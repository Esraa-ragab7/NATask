//
//  IngredientListDetailsViewController.swift
//  NATask
//
//  Created by Esraa Mohamed Ragab on 09/09/2021.
//

import UIKit
import RxCocoa
import RxSwift

class IngredientListDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var totalNutritionButton: UIButton!
    
    // MARK: - Properties
    var ingredientLisrDetailsViewModal: IngredientLisrDetailsViewModal!
    private let disposeBag = DisposeBag()
    private let ingredientCellIdentifierAndNibName = "IngredientTableViewCell"
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabelViewCell()
        bind()
        ingredientLisrDetailsViewModal.ingredientsSubjectOnNext()
    }
    
    func setupTabelViewCell() {
        ingredientTableView.register(UINib(nibName: ingredientCellIdentifierAndNibName, bundle: .main), forCellReuseIdentifier: ingredientCellIdentifierAndNibName)
    }
    
    // MARK: - Bind Method
    func bind() {
        totalNutritionButton.rx.tap
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.ingredientLisrDetailsViewModal.showTotalNutrition(view: self)
            }).disposed(by: disposeBag)
        
        ingredientLisrDetailsViewModal.ingredientModelObservable
            .bind(to: self.ingredientTableView
                    .rx
                    .items(cellIdentifier: ingredientCellIdentifierAndNibName,
                           cellType: IngredientTableViewCell.self)) { row, ingredient, cell in
                cell.caloriesLabel.text = "\(ingredient.calories ?? 0)"
                cell.quantityUnitAndFoodLabel.text = ingredient.ingredientText ?? ""
                cell.weightLabel.text = "\(ingredient.totalWeight ?? 0)"
            }
            .disposed(by: disposeBag)
    }
}
