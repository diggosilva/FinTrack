//
//  FinTrackTests.swift
//  FinTrackTests
//
//  Created by Diggo Silva on 14/12/25.
//

import XCTest
@testable import FinTrack

final class AddTransactionViewModelTests: XCTestCase {
    
    private var repository: MockRepository!
    private var delegate: MockDelegate!
    private var viewModel: AddTransactionViewModel!

    override func setUp() {
        super.setUp()
        repository = MockRepository()
        delegate = MockDelegate()
        viewModel = AddTransactionViewModel(repository: repository)
        viewModel.delegate = delegate
    }

    override func tearDown() {
        viewModel = nil
        delegate = nil
        repository = nil
        super.tearDown()
    }

    func testWhenFieldsIsEmpty_ExpectError() {
        let date = Date()

        viewModel.save(date: date, incomeText: nil, expenseText: nil)

        XCTAssertEqual(delegate.lastErrorMessage, "Você deve informar pelo menos um dos valores (Entrada ou Saída).")
        XCTAssertFalse(repository.saveCalled, "Repository.save não deveria ser chamado quando a validação falha.")
        XCTAssertFalse(delegate.savedCalled, "Delegate.savedTransaction não deveria ser chamado quando a validação falha.")
    }

    func testWhenIncomeInvalid_ExpectError() {
        let date = Date()

        viewModel.save(date: date, incomeText: "abc", expenseText: nil)

        XCTAssertEqual(delegate.lastErrorMessage, "Valor de entrada inválido.")
        XCTAssertFalse(repository.saveCalled)
        XCTAssertFalse(delegate.savedCalled)
    }

    func testWhenExpenseInvalid_ExpectError() {
        let date = Date()

        viewModel.save(date: date, incomeText: nil, expenseText: "xyz")

        XCTAssertEqual(delegate.lastErrorMessage, "Valor de saída inválido.")
        XCTAssertFalse(repository.saveCalled)
        XCTAssertFalse(delegate.savedCalled)
    }

    func testWhenHaveIncomeOnly_ExpectSaveAndNotify() {
        let date = makeDate(year: 2025, month: 5, day: 25)
        let incomeText = "10.5"

        viewModel.save(date: date, incomeText: incomeText, expenseText: nil)

        XCTAssertTrue(repository.saveCalled)
        XCTAssertTrue(delegate.savedCalled)

        XCTAssertEqual(repository.savedTransactions.count, 1)
        let saved = repository.savedTransactions.first!
        XCTAssertEqual(saved.income, 10.5)
        XCTAssertEqual(saved.expense, 0.0)
        XCTAssertEqual(saved.date, date)
    }

    func testWhenHaveExpenseOnly_ExpectSaveAndNotify() {
        let date = makeDate(year: 2025, month: 5, day: 26)
        let expenseText = "5.25"

        viewModel.save(date: date, incomeText: nil, expenseText: expenseText)

        XCTAssertTrue(repository.saveCalled)
        XCTAssertTrue(delegate.savedCalled)

        XCTAssertEqual(repository.savedTransactions.count, 1)
        let saved = repository.savedTransactions.first!
        XCTAssertEqual(saved.income, 0.0)
        XCTAssertEqual(saved.expense, 5.25)
        XCTAssertEqual(saved.date, date)
    }

    func testWhenHaveBoth_ExpectSaveAndNotify() {
        let date = makeDate(year: 2025, month: 5, day: 27)
        let incomeText = "3"
        let expenseText = "2"

        viewModel.save(date: date, incomeText: incomeText, expenseText: expenseText)

        XCTAssertTrue(repository.saveCalled)
        XCTAssertTrue(delegate.savedCalled)

        XCTAssertEqual(repository.savedTransactions.count, 1)
        let saved = repository.savedTransactions.first!
        XCTAssertEqual(saved.income, 3.0)
        XCTAssertEqual(saved.expense, 2.0)
        XCTAssertEqual(saved.date, date)
    }
}
