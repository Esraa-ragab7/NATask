//
//  IngredientInputViewController.swift
//  NATask
//
//  Created by Esraa Mohamed Ragab on 08/09/2021.
//

import UIKit
import RxCocoa
import RxSwift

class IngredientInputViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var analyzeButton: UIButton!
    
    // MARK: - Properties
    private var ingredientInputViewModal = IngredientInputViewModal()
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToBackgroundView()
        bind()
    }
    
    // MARK: - Bind Method
    func bind() {
        inputTextView.rx.text.orEmpty.asObservable()
            .bind(to: ingredientInputViewModal.inputText)
            .disposed(by: disposeBag)
        
        analyzeButton.rx.tap
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.ingredientInputViewModal.analyzeText(view: self)
            }).disposed(by: disposeBag)
        
        ingredientInputViewModal.isAnalyzeButtonEnabled.bind(to: analyzeButton.rx.isEnabled).disposed(by: disposeBag)
        
        ingredientInputViewModal.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showAppLoader()
            } else {
                self.hideAppLoader()
            }
        }).disposed(by: disposeBag)
    }
    
}

extension IngredientInputViewController {
    func addTapGestureToBackgroundView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap) // Add gesture recognizer to background view
    }
    
    @objc func handleTap() {
        inputTextView.resignFirstResponder() // dismiss keyoard
    }
}
