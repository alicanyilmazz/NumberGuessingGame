//
//  ViewController.swift
//  NumberGuessingGame
//
//  Created by alican on 23.08.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var txtGuessingNumber: UITextField!
    
    @IBOutlet weak var GuessingNumberImage: UIImageView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var txtGuessedNumber: UITextField!
    
    @IBOutlet weak var GuessedNumberImage: UIImageView!
    
    @IBOutlet weak var btnGuess: UIButton!
    
    @IBOutlet weak var lblResult: UILabel!
    
    @IBOutlet weak var imgStar1: UIImageView!
    
    @IBOutlet weak var imgStar2: UIImageView!
    
    @IBOutlet weak var imgStar3: UIImageView!
    
    @IBOutlet weak var imgStar4: UIImageView!
    
    @IBOutlet weak var imgStar5: UIImageView!
    
    var stars : [UIImageView] = [UIImageView]()
    
    let numberOfMaxGuess : Int = 5
    var numberOfGuess : Int = 0
    var targetNumber : Int = -1
    var guessStatus : Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stars = [imgStar1,imgStar2,imgStar3,imgStar4,imgStar5]
        GuessedNumberImage.isHidden = true
        GuessedNumberImage.isHidden = true
        btnGuess.isEnabled = false
        btnGuess.backgroundColor = UIColor.gray
        txtGuessingNumber.isSecureTextEntry = true
        lblResult.text = ""
        
    }

    @IBAction func btnSaveCliked(_ sender: UIButton) {
        
        GuessingNumberImage.isHidden = false
        if let guessNumber = Int(txtGuessingNumber.text!){
            targetNumber = guessNumber
            btnGuess.isEnabled = true
            btnGuess.backgroundColor = UIColor.orange
            btnSave.backgroundColor = UIColor.systemPink
            txtGuessingNumber.isEnabled = false
            txtGuessedNumber.isEnabled = true
            btnSave.isEnabled = false
            GuessingNumberImage.image = UIImage(named: "ok")
        }else{
            GuessingNumberImage.image = UIImage(named: "error")
        }
    }
    
    @IBAction func btnGuessCliked(_ sender: UIButton) {
        
        if  guessStatus == true || numberOfGuess > numberOfMaxGuess {
            return
        }
        GuessedNumberImage.isHidden = false
        if let guessedNumber = Int(txtGuessedNumber.text!){
            numberOfGuess += 1
            stars[numberOfGuess-1].image = UIImage(named: "emptystar")

            if guessedNumber > targetNumber {
                GuessedNumberImage.image = UIImage(named: "below")
                txtGuessedNumber.backgroundColor = UIColor.systemPink
            }else if guessedNumber < targetNumber{
                GuessedNumberImage.image = UIImage(named: "upward")
                txtGuessedNumber.backgroundColor = UIColor.systemPink
            }else{
                GuessedNumberImage.image = UIImage(named: "accept")
                btnSave.isEnabled = true
                lblResult.text = "Your Guess is True!"
                txtGuessedNumber.backgroundColor = UIColor.systemGreen
                txtGuessingNumber.isSecureTextEntry = false
                guessStatus = true
                
                let alertController = UIAlertController(title: "Success!", message: "Congratulations", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "okey", style: UIAlertAction.Style.default){
                    (action : UIAlertAction) in print("button clicked!")
                }
                let playAgainAction = UIAlertAction(title: "try", style: UIAlertAction.Style.default){
                    (action : UIAlertAction) in self.returnToBack()
                }
                alertController.addAction(playAgainAction)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
                return
            }
        }else{
            GuessedNumberImage.image = UIImage(named: "error")
        }
        
        if numberOfGuess == numberOfMaxGuess {
            btnGuess.isEnabled = false
            GuessedNumberImage.image = UIImage(named: "error")
            lblResult.text = "Game over!"
            txtGuessingNumber.isSecureTextEntry = false
            
            var alerController = UIAlertController(title: "Unfortunately", message: "Game over", preferredStyle: UIAlertController.Style.alert)
            var action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alerController.addAction(action)
            present(alerController, animated: true, completion: nil)
            
            return
        }
        
    }
    
    func returnToBack(){
        numberOfGuess = 0
        targetNumber = -1
        guessStatus = false
        txtGuessingNumber.isSecureTextEntry = true
        btnSave.isEnabled = true
        btnGuess.isEnabled = false
        txtGuessingNumber.text = ""
        txtGuessedNumber.text = ""
        GuessingNumberImage.isHidden = true
        GuessedNumberImage.isHidden = true
        lblResult.text = ""
        txtGuessedNumber.isEnabled = false
        txtGuessingNumber.isEnabled = true
        for eachStar in stars {
            eachStar.image = UIImage(named: "star")
        }
    }
    
    

}

