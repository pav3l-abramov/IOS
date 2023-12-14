//
//  Calculator.swift
//  calculator
//
//  Created by Илья Лошкарёв on 21.09.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation


/// Доступные операции
public enum Operation: String {
    case add = "+",
    sub = "-",
    mul = "×",
    div = "÷",
    sign = "±",
    perc = "%"
}


/// Протокол калькулятора
public protocol Calculator: class { // можно реализовывать только в ссылочном типе
    
    /// Представитель – объект, реагирующий на изменение внутреннего состояния калькулятора
    var delegate: CalculatorDelegate? { get set }
    
    /// Инициализатор
    /// `inputLength` – максимальная длина поля ввода (количество символов)
    /// `fractionLength` – максимальное количество знаков после заятой
    init(inputLength len: UInt, maxFraction frac: UInt)
    
    // Хранимое выражение: <левое значение> <операция> <правое значение>
    
    /// Левое значение - обычно хранит результат предыдущей операции
    var result: Double? { get }
    
    /// Текущая операция
    var operation: Operation? { get }
    
    /// Правое значение - к нему пользователь добавляет цифры
    var input: Double? { get }
    
    /// Добавить цифру к правому значению
    func addDigit(_ d: Int)
    
    /// Добавить точку к правому значению
    func addPoint()
    
    /// Правое значение содержит точку
    var hasPoint: Bool { get }
    
    /// Количество текущих знаков после запятой в правом значении
    var fractionDigits: UInt { get }
    
    /// Добавить операцию, если операция уже задана,
    /// вычислить предыдущее значение
    func addOperation(_ op: Operation)
    
    /// Вычислить значение выражения и записать его в левое значение
    func compute()
    
    /// Очистить правое значение
    func clear()
    
    /// Очистить всё выражение
    func reset()
}



public class CalculatorImpl: Calculator {
    
    public weak var delegate: CalculatorDelegate?
    
    private let inputLength: UInt
    private let maxFractionDigits: UInt
    
    private var _result: Double?
    private var _operation: Operation?
    private var _input: Double?
    
    public var result: Double? {
        return _result
    }
    
    public var operation: Operation? {
        return _operation
    }
    
    
    public var input: Double? {
        return _input
    }
    
    public var hasPoint: Bool {
        if let input = _input {
            return input.truncatingRemainder(dividingBy: 1) != 0
        }
        return false
    }
    
    public var fractionDigits: UInt {
        if let input = _input {
            let fraction = input - input.rounded(.towardZero)
            let precision = maxFractionDigits - UInt(String(fraction).count - 2)
            return precision
        }
        return 0
    }
    
    public required init(inputLength len: UInt, maxFraction frac: UInt) {
        inputLength = len
        maxFractionDigits = frac
    }
    
    public func addDigit(_ d: Int) {
        if let input = _input {
            if String(input).count - (hasPoint ? 1 : 0) < Int(inputLength) {
                let newInput = input * 10 + Double(d)
                _input = newInput
                delegate?.calculatorDidUpdateValue(self, with: newInput, valuePrecision: fractionDigits)
            } else {
                delegate?.calculatorDidInputOverflow(self)
            }
        } else {
            _input = Double(d)
            delegate?.calculatorDidUpdateValue(self, with: Double(d), valuePrecision: 0)
        }
    }
    
    public func addPoint() {
        if let input = _input {
            if !hasPoint {
                _input = input + pow(10, -Double(maxFractionDigits))
                delegate?.calculatorDidUpdateValue(self, with: _input!, valuePrecision: 1)
            }
        } else {
            _input = 0
            delegate?.calculatorDidUpdateValue(self, with: 0, valuePrecision: 1)
        }
    }
    
    public func addOperation(_ op: Operation) {
        if let input = _input {
            if operation != nil {
                compute()
                _input = _result
                _result = nil
                _operation = op
                delegate?.calculatorDidUpdateValue(self, with: _input!, valuePrecision: fractionDigits)
            } else {
                _result = input
                _operation = op
                _input = nil
            }
        } else if result != nil {
            _operation = op
        }
    }
    public func compute() {
        if let input = _input, let operation = _operation {
            switch operation {
            case .add:
                _result = (_result ?? 0) + input
            case .sub:
                _result = (_result ?? 0) - input
            case .mul:
                _result = (_result ?? 1) * input
            case .div:
                if input == 0 {
                    delegate?.calculatorDidDivideByZero(self)
                } else {
                    _result = (_result ?? 1) / input
                }
            case .sign:
                _input = -input
                delegate?.calculatorDidUpdateValue(self, with: _input!, valuePrecision: fractionDigits)
            case .perc:
                _input = _input! / 100
                delegate?.calculatorDidUpdateValue(self, with: _input!, valuePrecision: fractionDigits)
            }
            _operation = nil
            _input = nil
            delegate?.calculatorDidUpdateValue(self, with: _result!, valuePrecision: fractionDigits)
        }
    }
    
    public func clear() {
        _input = nil
        delegate?.calculatorDidUpdateValue(self, with: 0, valuePrecision: 0)
    }
    
    public func reset() {
        _result = nil
        _operation = nil
        _input = nil
        delegate?.calculatorDidUpdateValue(self, with: 0, valuePrecision: 0)
    }
    
}
