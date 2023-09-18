//
//  TransactionsFlow.swift
//  LiveMentoringSession
//
//  Created by Ryan Neil Stroud on 16/9/2023.
//

import UIKit
import SwiftUI

public protocol Timeable {
    var block: ((Timer) -> Void)? { get set }
}

class MyTimer: Timeable {
    private var timer: Timer?
    var block: ((Timer) -> Void)?
    
    init() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            self?.block?(timer)
        })
    }
}

/// How do I test this using Acceptance Tests
open class TransactionsFlow {
    public let navigationController = UINavigationController()
    
    public init() {}
    
    public func getListView() -> UINavigationController {
        /// Currently I use 1 model for both objects that are relatively close in nature, but we're expecting 20 or more "similar models".
        /// They'll all use the same cell view just with different properties.
        /// If I seperate them I'm thinking I need different view models for each model (since the view model owns the model)
        /// If I have new view models then do I need new views; since views own their view models in the current paradigm
        /// How can I decouple views and viewmodels?
        /// If I need to, how can one API support so many models?
        /// (All models will be quite similar, but have slightly different attributes)
        let models = [
            TransactionModel(
                id: UUID().uuidString,
                description: "Transaction Initiated. You need to approve.",
                optionalProperty: nil,
                expirationDate: Date() + 500),
            TransactionModel(
                id: UUID().uuidString,
                description: "Transaction Initiated. Your colleague needs to approve",
                optionalProperty: "A property that doesn't exist on self approval",
                expirationDate: Date() + 1000)
            ]
        
        let view = TransactionListView(models: models) { model in
            return TransactionCellView(
                viewModel: TransactionCellViewModel(
                    model: model,
                    timer: MyTimer()),
                tap: { self.setDetailView() })}
        let host = UIHostingController(rootView: view)
        navigationController.pushViewController(host, animated: true)
        return navigationController
    }
    
    public func setDetailView() {
        let view = TransactionDetailView(
            approvalCallback: { result in
                switch result {
                case .success:
                    self.navigationController.popViewController(animated: true)
                    self.showPrompt("Approval Was Successful")
                case .failure:
                    self.showPrompt("Approval Failed")
                }
            },
            rejectionCallback: { result in
                switch result {
                case .success:
                    self.navigationController.popViewController(animated: true)
                    self.showPrompt("Rejection Was Successful")
                case .failure:
                    self.showPrompt("Rejection Failed")
                }
            })
        
        let viewController = UIHostingController(rootView: view)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showPrompt(_ message: String) {
        var host: UIHostingController<PromptView>!
        let view = PromptView(message: message) {
            host.dismiss(animated: true)
        }
        host = UIHostingController(rootView: view)
        navigationController.present(host, animated: true)
    }
}
