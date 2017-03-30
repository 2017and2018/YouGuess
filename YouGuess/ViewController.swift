//
//  ViewController.swift
//  YouGuess
//
//  Created by Lei Chen on 3/14/17.
//  Copyright © 2017 Lei Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var userDefault = UserDefaults()
    var playerValue = PlayerValue()
    @IBOutlet weak var player2: UIPickerView!
    @IBOutlet weak var player1: UIPickerView!
    @IBOutlet weak var WinnerState1: UILabel!
    @IBOutlet weak var WinnerState2: UILabel!
    @IBOutlet weak var TutalPoints1: UILabel!
    @IBOutlet weak var TutalPoints2: UILabel!
    @IBOutlet weak var SetPoints: UILabel!
    @IBOutlet weak var FinalWinner: UILabel!
    var num1 = 0
    var num2 = 0
    var points1 = 0
    var points2 = 0
    var playerValues1: [Int] = []
    var playerValues2: [Int] = []
    var set1 = 0
    var set2 = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for num in 0...10 {
            playerValues1.append(num)
        }
        
        for num in 0...10 {
            playerValues2.append(num)
        }
        userDefault.integer(forKey: "SelectedRow")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if (pickerView.tag == 1){
            return 1
        }else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return playerValues1.count
        }else{
            return playerValues2.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return "\(playerValues1[row])"
        }else{
            return "\(playerValues2[row])"
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var ComputerNumber: UILabel!


    @IBAction func GetNumber(_ sender: Any) {
        
        SetPoints.text = String(set1) + " : " + String(set2)
        let computerNum = arc4random() % 11
        ComputerNumber.text = String(computerNum)
        let index1 = player1.selectedRow(inComponent: 0)
        let index2 = player2.selectedRow(inComponent: 0)
        if playerValues1[index1] == Int(computerNum){
            if playerValues1[index1] == playerValues2[index2]{
                WinnerState1.text = "draw"
                WinnerState2.text = "draw"
                num1 = num1 + 10
                num2 = num2 + 10
                TutalPoints1.text = String(num1)
                TutalPoints2.text = String(num2)
            } else if playerValues1[index1] != playerValues2[index2]{
                WinnerState1.text = "win"
                WinnerState2.text = "lose"
                num1 = num1 + 10
                TutalPoints1.text = String(num1)
            }
        }else if playerValues2[index2] == Int(computerNum){
            num2 = num2 + 10
            TutalPoints2.text = String(num2)
            if playerValues1[index1] == playerValues2[index2]{
                WinnerState1.text = "draw"
                WinnerState2.text = "draw"
                num1 = num1 + 10
                TutalPoints1.text = String(num1)
            } else if playerValues1[index1] != playerValues2[index2] {
                WinnerState1.text = "lose"
                WinnerState2.text = "win"
            }
        } else if playerValues1[index1] == playerValues2[index2] {
            WinnerState1.text = "draw"
            WinnerState2.text = "draw"
            if playerValues1[index1] < Int(computerNum) {
                num1 = num1 + (10 - Int(computerNum) + playerValues1[index1]) / 2
                num2 = num2 + (10 - Int(computerNum) + playerValues1[index2]) / 2
                TutalPoints1.text = String(num1)
                TutalPoints2.text = String(num2)
            } else if playerValues1[index1] > Int(computerNum) {
                num1 = num1 + (10 - playerValues1[index1] + Int(computerNum)) / 2
                num2 = num2 + (10 - playerValues1[index2] + Int(computerNum)) / 2
                TutalPoints1.text = String(num1)
                TutalPoints2.text = String(num2)
            }
            
        }else if playerValues1[index1] < playerValues2[index2]{
            if playerValues2[index2] < Int(computerNum){
                num2 = num2 + 10 - Int(computerNum) + playerValues2[index2]
                WinnerState1.text = "lose"
                WinnerState2.text = "win"
                TutalPoints2.text = String(num2)
            } else if playerValues1[index1] < Int(computerNum) && Int(computerNum) < playerValues2[index2] {
                if Int(computerNum) - playerValues1[index1] > playerValues2[index2] - Int(computerNum){
                    num2 = num2 + 10 - playerValues2[index2] + Int(computerNum)
                    WinnerState1.text = "lose"
                    WinnerState2.text = "win"
                    TutalPoints2.text = String(num2)
                }else if Int(computerNum) - playerValues1[index1] == playerValues2[index2] - Int(computerNum){
                    num2 = num2 + (10 - playerValues2[index2] + Int(computerNum))/2
                    num1 = num1 + (10 - Int(computerNum) + playerValues1[index1])/2
                    WinnerState1.text = "draw"
                    WinnerState2.text = "draw"
                    TutalPoints1.text = String(num1)
                    TutalPoints2.text = String(num2)
                } else if Int(computerNum) - playerValues1[index1] < playerValues2[index2] - Int(computerNum){
                    num1 = num1 + 10 - Int(computerNum) + playerValues1[index1]
                    WinnerState1.text = "win"
                    WinnerState2.text = "lose"
                    TutalPoints1.text = String(num1)
                    TutalPoints2.text = String(num2)
                }
            } else if Int(computerNum) < playerValues1[index1] {
                num1 = num1 + 10 - playerValues1[index1] + Int(computerNum)
                WinnerState1.text = "win"
                WinnerState2.text = "lose"
                TutalPoints1.text = String(num1)
                TutalPoints2.text = String(num2)
            }
        } else if playerValues2[index2] < playerValues1[index1]{
            if playerValues1[index1] < Int(computerNum){
                num1 = num1 + 10 - Int(computerNum) + playerValues1[index1]
                WinnerState2.text = "lose"
                WinnerState1.text = "win"
                TutalPoints1.text = String(num1)
                TutalPoints2.text = String(num2)
            } else if playerValues2[index2] < Int(computerNum) && Int(computerNum) < playerValues1[index1] {
                if Int(computerNum) - playerValues2[index2] > playerValues1[index1] - Int(computerNum){
                    num1 = num1 + 10 - playerValues1[index1] + Int(computerNum)
                    WinnerState2.text = "lose"
                    WinnerState1.text = "win"
                    TutalPoints1.text = String(num1)
                }else if Int(computerNum) - playerValues2[index2] == playerValues1[index1] - Int(computerNum){
                    num1 = num1 + 10 - playerValues1[index1] + Int(computerNum)
                    num2 = num2 + 10 - Int(computerNum) + playerValues1[index1]
                    WinnerState2.text = "draw"
                    WinnerState1.text = "draw"
                    TutalPoints1.text = String(num1)
                    TutalPoints2.text = String(num2)
                } else if Int(computerNum) - playerValues2[index2] < playerValues1[index1] - Int(computerNum){
                    num2 = num2 + 10 - Int(computerNum) + playerValues2[index2]
                    WinnerState2.text = "win"
                    WinnerState1.text = "lose"
                    TutalPoints2.text = String(num2)
                }
            } else if Int(computerNum) < playerValues2[index2] {
                num2 = num2 + 10 - playerValues2[index2] + Int(computerNum)
                WinnerState2.text = "win"
                WinnerState1.text = "lose"
                TutalPoints2.text = String(num2)
            }
        }
        if num1 >= 100 {
            if num1 == num2{
                set1 = set1 + 1
                set2 = set2 + 1
                num1 = 0
                num2 = 0
                TutalPoints1.text = String(num1)
                TutalPoints2.text = String(num2)
            } else {
            set1 = set1 + 1
            num1 = 0
            num2 = 0
            TutalPoints1.text = String(num1)
            TutalPoints2.text = String(num2)
            }
        }
        if num2 >= 100 {
            if num1 == num2{
                set1 = set1 + 1
                set2 = set2 + 1
                num1 = 0
                num2 = 0
                TutalPoints1.text = String(num1)
                TutalPoints2.text = String(num2)
            } else {
            set2 = set2 + 1
            num1 = 0
            num2 = 0
            TutalPoints1.text = String(num1)
            TutalPoints2.text = String(num2)
            }
        }
        if set1 == 3{
            if set1 == set2{
                FinalWinner.text = "players draw!"
            } else{
            set1 = 0
            set2 = 0
                FinalWinner.text = "player1 win!"
            }
        }
        if set2 == 3{
            if set1 == set2{
                FinalWinner.text = "players draw!"
            } else {
            set1 = 0
            set2 = 0
                FinalWinner.text = "player2 win!"
            }
        }
    }
}
