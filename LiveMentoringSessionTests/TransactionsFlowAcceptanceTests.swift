//
//  TransactionsFlowAcceptanceTests.swift
//  LiveMentoringSessionTests
//
//  Created by Ryan Neil Stroud on 16/9/2023.
//

import XCTest
import LiveMentoringSession
import ViewInspector
import SwiftUI

final class TransactionsFlowAcceptanceTests: XCTestCase {

//    func test_successfullyApprove() {
//        let sut = TransactionsFlowMock()
//        let _ = sut.getListView()
//        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
//
//        sut.setDetailView()
//        RunLoop.current.run(until: Date() + 2)
//
//        /// Check that detail page was pushed onto view controller
//        XCTAssertEqual(sut.navigationController.viewControllers.count, 2)
//        XCTAssertNotNil(sut.getDetailView())
//
//        try! sut.getDetailView()?.getApprovalSuccessfulButton()?.tap()
//        RunLoop.current.run(until: Date() + 2)
//
//        /// Check that detail page was popped onto view controller
//        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
//
//        RunLoop.current.run(until: Date() + 2)
//
//        /// Check that prompt was presented
//        XCTAssertNotNil(sut.navigationController.presentedViewController as? UIHostingController<PromptView>)
//        /// Check that prompt was dismissed
//        XCTAssertNil(sut.navigationController.presentedViewController)
//    }
    
    func test_failedToApprove() {
        
    }
    
    func test_successfullyRejected() {
        
    }
    
    func test_failedToReject() {
        
    }
    
    private class TransactionsFlowMock: TransactionsFlow {
        
        func getDetailView() -> TransactionDetailView? {
            (navigationController.viewControllers.last as? UIHostingController<TransactionDetailView>)?.rootView
        }
    }
    
}

private extension TransactionDetailView {
    
    func getApprovalSuccessfulButton() ->  InspectableView<ViewType.Button>? {
        try? inspect().find(button: "Approval Was Successful")
    }
    
}
