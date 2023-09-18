//
//  TransactionListView.swift
//  LiveMentoringSession
//
//  Created by Ryan Neil Stroud on 16/9/2023.
//

import SwiftUI

public struct TransactionModel {
    let id: String
    let description: String
    let optionalProperty: String?
    let expirationDate: Date
    
    public init(id: String, description: String, optionalProperty: String?, expirationDate: Date) {
        self.id = id
        self.description = description
        self.optionalProperty = optionalProperty
        self.expirationDate = expirationDate
    }
}

public class TransactionCellViewModel: ObservableObject {
    let model: TransactionModel
    var timer: Timeable
    @Published var expirationDateFormatted: String = ""
    
    public init(model: TransactionModel, timer: Timeable, getCurrentDate: @escaping () -> Date = { Date() }) {
        self.model = model
        self.timer = timer
        
        self.timer.block = { timer in
            let components = Calendar.current.dateComponents([.hour, .minute, .second], from: getCurrentDate(), to: model.expirationDate)
            
            self.expirationDateFormatted = "\(components.hour!)h \(components.minute!)m \(components.second!)s"
        }
    }
}

public struct TransactionCellView: View {
    @ObservedObject private var viewModel: TransactionCellViewModel
    private let tap: () -> Void
    
    public init(viewModel: TransactionCellViewModel, tap: @escaping () -> Void) {
        self.viewModel = viewModel
        self.tap = tap
    }
    
    public var body: some View {
        VStack {
            Text(viewModel.model.description)
            Text(viewModel.expirationDateFormatted)
                .id("12345")
        }
        .onTapGesture { tap() }
    }
}

struct TransactionListView: View {
    typealias LoadCell = (TransactionModel) -> TransactionCellView
    
    private var models = [TransactionModel]()
    private let loadCell: LoadCell
    
    init(models: [TransactionModel], loadCell: @escaping LoadCell) {
        self.models = models
        self.loadCell = loadCell
    }
    
    var body: some View {
        List(models, id: \.id) { model in
            loadCell(model)
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        let myModel = TransactionModel(
            id: UUID().uuidString,
            description: "Hello World",
            optionalProperty: nil,
            expirationDate: Date() + 300)
        TransactionListView(models: [myModel], loadCell: { model in
            TransactionCellView(
                viewModel: TransactionCellViewModel(
                    model: model,
                    timer: MyTimer()),
                tap: {})
        })
    }
}
