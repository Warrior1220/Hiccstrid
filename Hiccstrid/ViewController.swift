//
//  ViewController.swift
//  Hiccstrid
//
//  Created by Warrior on 2018/11/4.
//  Copyright © 2018 Warrior. All rights reserved.
//


import UIKit
var h=1,operateFlag : String = ""
let alabel=UILabel.init()
var nF=0.0,nS=0.0,n3: Bool = true,n4=0.0,n5=0.0,n6=0.0,n7 = 0.0,n8 = 0.0,iPoint: Bool = true,iOperator: Bool = true,takeNag :Bool = true,n10: Bool = true//小数点要用iPoint来判断,n3则判断是否出现过运算符以决定键入的数字是存在第一个还是第二个中，n10也判断是否出现过运算符，但是用于连乘。
var numTogether = [String](),NumS:String = "",numberTogether = [String](),NumF:String = "",tempyStr:String = ""
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        alabel.frame=CGRect(x:0,y:0,width:UIScreen.main.bounds.width/1,height:300)
        alabel.backgroundColor = UIColor.white
        alabel.textAlignment = .right
        alabel.font = UIFont.systemFont(ofSize: 50)
        alabel.text="0"
        buttonset()
        self.view.addSubview(alabel)
    }
    func buttonset() {
        var st=[["AC","+/-","%","/"],["7","8","9","*"],["4","5","6","-"],["1","2","3","+"],["0","esc",".","="]]
        for a in 0...3 {
            for b in 0...4 {
                let button1:UIButton=UIButton(type:.system)
                button1.frame = CGRect(x: 0+UIScreen.main.bounds.width/4*CGFloat(a), y: 300+100*CGFloat(b), width: UIScreen.main.bounds.width/4, height: 100)
                button1.backgroundColor=UIColor.white
                button1.setTitle(st[b][a], for: .normal)
                button1.addTarget(self, action: #selector(Print(button1:)), for: .touchDown)
                button1.addTarget(self, action: #selector(PRint(button1:)), for:.touchUpInside)
                button1.addTarget(self, action: #selector(showNum(button1:)),for:.touchUpInside)
                button1.addTarget(self, action: #selector(putOutNum(button1:)),for:.touchUpInside)
                button1.titleLabel?.font=UIFont.systemFont(ofSize: 50)
                button1.layer.borderColor=UIColor.gray.cgColor
                button1.layer.borderWidth=2
                self.view.addSubview(button1)
            }
        }
    }
    @objc func showNum(button1:UIButton) {
        if !n3 {
            var m = button1.currentTitle
            if !iPoint {
                if button1.currentTitle == "." {
                    m = ""
                }
            }
            if (m == "0")||(m == "1")||(m == "2")||(m == "3")||(m == "4")||(m == "5")||(m == "6")||(m == "7")||(m == "8")||(m == "9")||(m == ".") {
                numTogether.append(button1.currentTitle!)
                NumS = numTogether.joined(separator:"")//numTogether储存第二个数
                alabel.text = NumS
            }
        }
        if n3 {
            var m = button1.currentTitle
            if !iPoint{
                if button1.currentTitle == "." {
                    m = ""
                }
            }
            if (m == "0")||(m == "1")||(m == "2")||(m == "3")||(m == "4")||(m == "5")||(m == "6")||(m == "7")||(m == "8")||(m == "9")||(m == ".") {
                numberTogether.append(button1.currentTitle!)
                NumF = numberTogether.joined(separator:"")//numberTogether储存第一个数
                alabel.text = NumF  }
        }
    }
    @objc func Print(button1:UIButton) {
        button1.backgroundColor = UIColor.gray
    }
    @objc func PRint(button1:UIButton) {
        button1.backgroundColor = UIColor.white
    }
    
    @objc func putOutNum(button1:UIButton) {
        let m = button1.currentTitle
        if (m == "0")||(m == "1")||(m == "2")||(m == "3")||(m == "4")||(m == "5")||(m == "6")||(m == "7")||(m == "8")||(m == "9")||(m == "."){
            NumS = alabel.text!
            if Double(NumS) != nil {
                nS = Double(NumS)!;n4 = nS
            }
            else {
                nS = 0;n4 = 0
            }
            if Double(NumF) != nil {
                nF = Double(NumF)!;n5 = nF
            }
            else {
                nF = 0;n5 = nF
            }
        }
        switch button1.currentTitle {
        case "AC": numberTogether = [String]();numTogether = [String](); alabel.text = "\(n4*0)";nS = n4*0;n3 = true;iPoint = true;iOperator = true;takeNag = true;n10 = true
        case "%": if iOperator {
            n7 = nF*0.01;nF = n7;NumF = "\(nF)";alabel.text = "\(nF)"
        }
        else {
            n7 = nS*0.01;nS = n7;NumS = "\(nS)";alabel.text = "\(nS)"
            }
        case "+/-": if takeNag {
            n8 = nF*(-1);nF = n8;NumF = "\(nF)";alabel.text = "\(nF)"
        }
        else {
            n8 = nS*(-1);nS = n8;NumS = "\(nS)";alabel.text = "\(nS)"
            }
        default : print("")
        }
        
        if n10 {
        switch button1.currentTitle {
        case "*" : tempyStr = "*";n3 = false;iPoint = true;iOperator = false;takeNag = false;n10 = false
        case "+" : tempyStr = "+";n3 = false;iPoint = true;iOperator = false;takeNag = false;n10 = false
        case "-" : tempyStr = "-";n3 = false;iPoint = true;iOperator = false;takeNag = false;n10 = false
        case "/" : tempyStr = "/";n3 = false;iPoint = true;iOperator = false;takeNag = false;n10 = false
        case "." : iPoint = false
        default : print("")
            }
        }
        else {
            switch button1.currentTitle {
            case "*" : nF = nS*nF;NumF = "\(nF)";alabel.text = NumF;numTogether = [String]()
            case "+" : nF = nS+nF;NumF = "\(nF)";alabel.text = NumF;numTogether = [String]()
            case "-" : nF = nF-nS;NumF = "\(nF)";alabel.text = NumF;numTogether = [String]()
            case "/" : nF = nF/nS;NumF = "\(nF)";alabel.text = NumF;numTogether = [String]()
            default : print()
            }
        }
        if m == "esc" {
            exit(0)
        }
        if m == "=" {
            n10 = true
            switch tempyStr {
            case "*" : n6 = nS*nF;nF = n6;NumF = "\(nF)";alabel.text = NumF;numTogether = [String]()
            case "+" : n6 = nS+nF;nF = n6;NumF = "\(nF)";alabel.text = NumF;numTogether = [String]()
            case "-" : n6 = nF-nS;nF = n6;NumF = "\(nF)";alabel.text = NumF;numTogether = [String]()
            case "/" : n6 = nF/nS;nF = n6;NumF = "\(nF)";alabel.text = NumF;numTogether = [String]()
            default : print("")
            }
        }
    }
}
