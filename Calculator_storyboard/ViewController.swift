//
//  ViewController.swift
//  Calculator_storyboard
//
//  Created by 임혜정 on 6/25/24.
//

import UIKit
//git test
class ViewController: UIViewController {
    @IBOutlet var 버튼들: [UIButton]!
    @IBOutlet weak var 표시창: UILabel!
    
    private var 새로운입력 = true
    private var 현재식 = ""
    private var 계산완료 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        인터페이스스타일()
    }
    
    @IBAction func 버튼눌림(_ 발신: UIButton) {
        if let 연산 = 연산자(rawValue: 발신.tag) {
            연산자처리(연산)
        } else {
            숫자입력(발신.tag)
        }
    }
    
    func 숫자입력(_ 숫자: Int) {
        if 계산완료 {
            초기화()
            계산완료 = false
        }
        
        if 새로운입력 {
            if 숫자 != 0 || !현재식.isEmpty {
                표시창.text = 표시창.text == "0" ? "\(숫자)" : (표시창.text ?? "") + "\(숫자)"
                현재식 += "\(숫자)"
                새로운입력 = false
            }
        } else {
            표시창.text? += "\(숫자)"
            현재식 += "\(숫자)"
        }
    }
    
    private func 연산자처리(_ 연산: 연산자) {
        정리현재식()
        
        switch 연산 {
        case .더하기, .빼기, .곱하기, .나누기:
            if !현재식.isEmpty && !["+", "-", "*", "/"].contains(현재식.last!) {
                현재식 += 연산.연산기호
                표시창.text? += 연산.연산기호
            }
            새로운입력 = true
            계산완료 = false
        case .는:
            guard !현재식.isEmpty else { return }
            let expression = NSExpression(format: 현재식)
            if let 결과 = expression.expressionValue(with: nil, context: nil) as? NSNumber {
                let 정수결과 = Int(round(결과.doubleValue))
                표시창.text = "\(정수결과)"
                현재식 = "\(정수결과)"
                계산완료 = true
            } else {
                표시창.text = "Error"
                현재식 = ""
            }
            새로운입력 = true
        case .초기화:
            초기화()
        }
    }
    
    private func 정리현재식() {
        if let 마지막문자 = 현재식.last, "+-*/".contains(마지막문자) {
            현재식.removeLast()
        }
    }
    
    private func 초기화() {
        표시창.text = "0"
        새로운입력 = true
        현재식 = ""
        계산완료 = false
    }
}

enum 연산자: Int {
    case 더하기 = 100
    case 빼기 = 101
    case 곱하기 = 102
    case 나누기 = 103
    case 는 = 104
    case 초기화 = 105
    
    var 연산기호: String {
        switch self {
        case .더하기: return "+"
        case .빼기: return "-"
        case .곱하기: return "*"
        case .나누기: return "/"
        case .는: return "="
        case .초기화: return "AC"
        }
    }
}

extension ViewController {
    private func 인터페이스스타일() {
        view.backgroundColor = .black
        버튼들.forEach {
            $0.frame.size = CGSize(width: 80, height: 80)
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 40
        }
        표시창.text = "0"
    }
}
