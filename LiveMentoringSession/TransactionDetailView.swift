//
//  TransactionDetailView.swift
//  LiveMentoringSession
//
//  Created by Ryan Neil Stroud on 16/9/2023.
//

import SwiftUI

public struct TransactionDetailView: View {
    typealias Callback = (Result<Void, Error>) -> Void
    
    private let approvalCallback: Callback
    private let rejectionCallback: Callback
    
    init(approvalCallback: @escaping Callback, rejectionCallback: @escaping Callback) {
        self.approvalCallback = approvalCallback
        self.rejectionCallback = rejectionCallback
    }
    
    public var body: some View {
        VStack {
            Button("Successful Approval") {
                approvalCallback(.success(()))
            }
            Button("Failed Approval") {
                approvalCallback(.failure(NSError(domain: "failed approval", code: 0)))
            }
            Button("Successful Rejection") {
                rejectionCallback(.success(()))
            }
            Button("Failed Rejection") {
                rejectionCallback(.failure(NSError(domain: "failed rejection", code: 0)))
            }
        }
    }
    
}
