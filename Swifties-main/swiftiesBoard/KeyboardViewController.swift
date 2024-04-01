//
//  KeyboardViewController.swift
//  keyboard extension
//
//  Created by Pavneet Cheema on 2/17/24.
//

import UIKit
import Foundation

extension String {
    var isNumber: Bool {
        return self.allSatisfy { character in
            character.isNumber

        }
    }
}

class KeyboardViewController: UIInputViewController {
    
    var sn = SendNotif()
    
    //warning label
    var warning: UILabel! = UILabel()
    
    //keyboard key color
    var keyColor: UIColor = UIColor.systemBlue
    
    //arry with all the buttons for alphabet and num so we can iterate to remove them
    
    var alpaView: [UIButton] = []
    var numView: [UIButton] = []
    
    var BoardHeightConstraints:NSLayoutConstraint! = nil
    
    //special keys
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var SpaceButton: UIButton!
    @IBOutlet var numericButton: UIButton!
    @IBOutlet var BackKey: UIButton!
    @IBOutlet var returnKey: UIButton! = UIButton(type: .system)
    @IBOutlet var capButton: UIButton! = UIButton(type: .system)

    //flags for capslock buttons
    var isCapitial = false
    var SingleIsCapitial = true
    
    var isPotrait = true
    var isNumBoard = false
    var isHash = false
    
    var textTyped: String = ""
    var numTyped: String = ""
    
    //text recomandation buttons
    @IBOutlet var firstRecmmond: UIButton!
    @IBOutlet var secondRecmmond: UIButton!
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIScreen.main.bounds.height > UIScreen.main.bounds.width {
            
               isPotrait = false
            } else {
                isPotrait = true
            }
        CustomHeight()
        }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loading the view xib file
//        let nib = UINib(nibName: "AlphabetKeyView", bundle: nil)
//        let objects = nib.instantiate(withOwner: self, options: nil)
//        view = objects[0] as? UIView
//

        //keyboard height constraints
         CustomHeight()
         GingerAPI()
        

        //adding warning label to the view
        self.warning.textAlignment = .center
        self.warning.translatesAutoresizingMaskIntoConstraints = false
        SafeWarning()
        self.view.addSubview(self.warning)
        
        
        
        
        NSLayoutConstraint.activate([
            warning.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14), //0.14
            warning.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.25),
            warning.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            warning.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
        ])
        
        self.warning.layer.cornerRadius = 5
        
        //adding the text recommend buttons to the view
        
        self.firstRecmmond = UIButton(type: .system)
        self.firstRecmmond.setTitle(NSLocalizedString("I", comment: "Title for 'Next Keyboard' button"), for: [])
        self.firstRecmmond.sizeToFit()
        self.firstRecmmond.backgroundColor = UIColor( red: CGFloat(210/255.0), green: CGFloat(212/255.0), blue: CGFloat(217/255.0), alpha: CGFloat(1.0))
        self.firstRecmmond.setTitleColor(UIColor.systemBlue, for: .normal)
        self.firstRecmmond.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.firstRecmmond.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.firstRecmmond)
        
        NSLayoutConstraint.activate([
            firstRecmmond.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14), //0.14
            firstRecmmond.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.37),
            firstRecmmond.leftAnchor.constraint(equalTo: warning.rightAnchor, constant: 35),
            firstRecmmond.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
        ])
        
        //border between two recommondation button
        let border = UILabel()
        border.backgroundColor = UIColor.systemGray
        border.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(border)
        
        NSLayoutConstraint.activate([
            border.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.1), //0.14
            border.widthAnchor.constraint(equalToConstant: 0.3),
            border.leftAnchor.constraint(equalTo: self.firstRecmmond.rightAnchor, constant: 0),
            border.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        ])
        
        //self.secondRecmmond = UIButton(type: .system)
        self.secondRecmmond = UIButton(type: .system)
        self.secondRecmmond.setTitle(NSLocalizedString("The", comment: "Title for 'Next Keyboard' button"), for: [])
        self.secondRecmmond.sizeToFit()
        self.secondRecmmond.backgroundColor = UIColor( red: CGFloat(210/255.0), green: CGFloat(212/255.0), blue: CGFloat(217/255.0), alpha: CGFloat(1.0))
        self.secondRecmmond.setTitleColor(UIColor.systemBlue, for: .normal)
        self.secondRecmmond.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.secondRecmmond.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.secondRecmmond)
        
        NSLayoutConstraint.activate([
            secondRecmmond.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14), //0.14
            secondRecmmond.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.37),
            secondRecmmond.leftAnchor.constraint(equalTo: self.firstRecmmond.rightAnchor, constant: 2),
            secondRecmmond.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
        ])
        // Perform custom UI setup here
        
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("☺︎", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.titleLabel?.textColor = UIColor.systemBlue
        
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.backgroundColor = UIColor.systemGray3
        self.nextKeyboardButton.setTitleColor(UIColor.systemBlue, for: .normal)
        self.nextKeyboardButton.layer.masksToBounds = true
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        ShadowOnButton(button: self.nextKeyboardButton)
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        

        
        self.nextKeyboardButton.layer.cornerRadius = 5
        //capital button
        
        self.SpaceButton = UIButton(type: .system)
        
        self.SpaceButton.setTitle(NSLocalizedString("Space", comment: "Title for 'Next Keyboard' button"), for: [])
        self.SpaceButton.sizeToFit()
        self.SpaceButton.backgroundColor = UIColor.white
        self.SpaceButton.addTarget(self, action: #selector(SpaceButtonPressed), for: .touchUpInside)
        self.SpaceButton.translatesAutoresizingMaskIntoConstraints = false
        ShadowOnButton(button: self.SpaceButton)

        self.view.addSubview(self.SpaceButton)
        NSLayoutConstraint.activate([
            SpaceButton.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14),
            SpaceButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.53),
           SpaceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -3),
            SpaceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
        ])
        //self.SpaceButton.titleLabel?.font =  UIFont(name: "System", size: 20)
        self.SpaceButton.layer.cornerRadius = 5
        
        
        //numeric button
        self.numericButton = UIButton(type: .system)
        
        self.numericButton.setTitle(NSLocalizedString("123", comment: "Title for 'Next Keyboard' button"), for: [])
        self.numericButton.sizeToFit()
        self.numericButton.backgroundColor = UIColor.systemGray3
        self.numericButton.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        self.numericButton.translatesAutoresizingMaskIntoConstraints = false
        ShadowOnButton(button: self.numericButton)

        self.view.addSubview(self.numericButton)
        NSLayoutConstraint.activate([
            numericButton.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14),
            numericButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.111),
            numericButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 2),
            numericButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
        ])
        
        self.numericButton.layer.cornerRadius = 5
        
        NSLayoutConstraint.activate([
            nextKeyboardButton.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14),
            nextKeyboardButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.111),
            nextKeyboardButton.leftAnchor.constraint(equalTo: numericButton.rightAnchor, constant: 8), //-128
            //nextKeyboardButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 115),
            nextKeyboardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
        DisplayKeyboard()
        backButton()
        returnButton()
    }
    
    func ShadowOnButton(button: UIButton){
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
    }
    //change the label depending on if its safe or not
    
    func SafeWarning(){
        self.warning.text = "✅ Safe"
        self.warning.textColor = UIColor.white
        self.warning.font = UIFont.systemFont(ofSize: 20)
        self.warning.layer.borderColor = UIColor.systemGreen.cgColor
        self.warning.layer.borderWidth = 3.0
        for button in self.view.subviews{
            if button is UIButton {
              (button as! UIButton).setTitleColor(UIColor.systemBlue, for: .normal)
        }
    }
        returnKey.setTitleColor(UIColor.white, for: .normal)
        returnKey.backgroundColor = UIColor.systemBlue
}
    func unSafeWarning(){
            self.warning.text = "❌ UnSafe"
            self.warning.textColor = UIColor.white
            self.warning.font = UIFont.systemFont(ofSize: 15)
            self.warning.layer.borderColor = UIColor.systemRed.cgColor
            self.warning.layer.borderWidth = 3.0
            for button in self.view.subviews{
                if button is UIButton {
                  (button as! UIButton).setTitleColor(UIColor.systemRed, for: .normal)
            }
        }
        returnKey.setTitleColor(UIColor.white, for: .normal)
        returnKey.backgroundColor = UIColor.systemRed
    }
    func backButton(){
        self.BackKey = UIButton(type: .system)
        
        self.BackKey.setTitle(NSLocalizedString("⌫", comment: "Title for 'Next Keyboard' button"), for: [])
        self.BackKey.sizeToFit()
        self.BackKey.backgroundColor = UIColor.systemGray3
        self.BackKey.setTitleColor(self.keyColor, for: .normal)
        self.BackKey.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        self.BackKey.translatesAutoresizingMaskIntoConstraints = false
        self.BackKey.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.BackKey.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.BackKey.layer.shadowOpacity = 1.0
        self.BackKey.layer.shadowRadius = 0.0
        self.BackKey.layer.masksToBounds = false

        self.view.addSubview(self.BackKey)
        NSLayoutConstraint.activate([
            BackKey.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14),
            BackKey.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.13),
            BackKey.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4),
            BackKey.bottomAnchor.constraint(equalTo: numericButton.topAnchor, constant: -15),
        ])
        
        self.BackKey.layer.cornerRadius = 5
        
    }
    @objc func deleteButtonPressed(){
        textDocumentProxy.deleteBackward()
        if(self.textTyped.isEmpty == false){
            self.textTyped.remove(at: self.textTyped.index(before: self.textTyped.endIndex))
        }
        if(self.numTyped.isEmpty == false){
            self.numTyped.remove(at: self.numTyped.index(before: self.numTyped.endIndex))
        }
        SafeWarning()
    }
    func returnButton(){
        returnKey = UIButton(type: .system)
        
        returnKey.setTitle(NSLocalizedString("return", comment: "Title for 'Next Keyboard' button"), for: [])
        returnKey.sizeToFit()
        returnKey.addTarget(self, action: #selector(returnButtonPressed), for: .touchUpInside)
        returnKey.translatesAutoresizingMaskIntoConstraints = false
        ShadowOnButton(button: returnKey)

        self.view.addSubview(returnKey)
        NSLayoutConstraint.activate([
            returnKey.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14),
            returnKey.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.25),
            returnKey.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4),
            returnKey.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
        ])
        returnKey.layer.cornerRadius = 5
        self.returnKey.setTitleColor(UIColor.white, for: .normal)
        self.returnKey.backgroundColor = UIColor.systemBlue
        //returnKey.backgroundColor = UIColor(named: "blue")
    }
    
    @objc func numButtonPressed(){
        for view in alpaView{
            view.removeFromSuperview()
        }
        if(isNumBoard){
            DisplayKeyboard()
            isNumBoard = false
        }
        else{
            DisplayNumBoard()
            isNumBoard = true
        }

               
    }
    @objc func returnButtonPressed(){
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    @objc func SpaceButtonPressed(){
        var d = SendNotif()
        (textDocumentProxy as UIKeyInput).insertText(" ")
        d.handleSend(notif: "ff")
        let lastChar = textTyped.last!
        if(lastChar == "."){
            print(".")
        }
    }
    func initializeSubviews(xibFileName: String) {
        let view1 = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
        self.view.addSubview(view1)
        //view.frame = self.view.bounds
    }
    func ButtonToUppercase(){
        for button in self.view.subviews{
            if button is UIButton {
                let UCtitle = (button as! UIButton).titleLabel?.text?.uppercased()
                if(UCtitle?.count == 1){
                    (button as! UIButton).setTitle(UCtitle, for: .normal)
                }
            }
        }
    }
    func ButtonToLowercase(){
        for button in self.view.subviews{
            if button is UIButton {
                let LCtitle = (button as! UIButton).titleLabel?.text?.lowercased()
                (button as! UIButton).setTitle(LCtitle, for: .normal)
            }
        }
    }
    //action when the capital key is pressed
    @IBAction func CapitalButtonDoublePressed(){
        if(isCapitial == false){
            ButtonToUppercase()
        }
        isCapitial.toggle()
    }
    @IBAction func CapitalButtonPressed(){
        print(isCapitial)
        print(SingleIsCapitial)
        if(isCapitial == true){
            ButtonToLowercase()
            isCapitial.toggle()
        }
        else if(SingleIsCapitial == true && isCapitial == false){
            ButtonToLowercase()
            SingleIsCapitial.toggle()
        }
        else{
            ButtonToUppercase()
            SingleIsCapitial.toggle()
        }
        
    }
    
    func DisplayNumBoard(){
        self.alpaView = []
        var hashButton: UIButton
        var previous: UIButton? = nil
        var previous2: UIButton? = nil
        var previous3: UIButton? = nil
        let alpha_first_row = ["1","2","3","4","5","6","7","8","9","0"]
        let alpha_second_row = ["-","/",":",";","(",")","$","&","@", "\""]
        let alpha_third_row = [".",",","?","!","'"]
        
        
        
        hashButton = UIButton(type: .system)
        
        hashButton.setTitle(NSLocalizedString("#+=", comment: "Title for 'Next Keyboard' button"), for: [])
        hashButton.sizeToFit()
        hashButton.backgroundColor = UIColor.systemGray3
        hashButton.addTarget(self, action: #selector(hashButtonPressed), for: .touchUpInside)
        hashButton.translatesAutoresizingMaskIntoConstraints = false
        ShadowOnButton(button: hashButton)

        alpaView.append(hashButton)
        self.view.addSubview(hashButton)
        hashButton.layer.cornerRadius = 5
        NSLayoutConstraint.activate([
            hashButton.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14),
            hashButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.111),
            hashButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            hashButton.bottomAnchor.constraint(equalTo: numericButton.topAnchor, constant: -15),
        ])
        
        //thrid row of alphabets
        
        for key in alpha_third_row {
            let alpha = UIButton(type: .system)
            
            alpha.setTitle(NSLocalizedString(key, comment: "Title for 'Next Keyboard' button"), for: [])
            alpha.sizeToFit()
            alpha.backgroundColor = UIColor.white
            alpha.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            alpha.translatesAutoresizingMaskIntoConstraints = false
            ShadowOnButton(button: alpha)
            
            self.alpaView.append(alpha)
            self.view.addSubview(alpha)
            
            alpha.layer.cornerRadius = 5
            //constraints
            alpha.heightAnchor.constraint( equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14).isActive = true
            alpha.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.135).isActive = true
            alpha.bottomAnchor.constraint(equalTo: numericButton.topAnchor, constant: -15).isActive = true
            //BackKey.bottomAnchor.constraint(equalTo: numericButton.topAnchor, constant: -15),

            if (previous3 == nil) {
                //print(key)
                
                alpha.leftAnchor.constraint(equalTo: hashButton.rightAnchor, constant: 15).isActive = true
            }
            else{
                // we have a previous button – create a height constraint
                alpha.leftAnchor.constraint(equalTo: previous3!.rightAnchor, constant: 7).isActive = true
            }
            previous3 = alpha
            
        }
        
        for key in alpha_second_row {
            let alpha = UIButton(type: .system)
            
            alpha.setTitle(NSLocalizedString(key, comment: "Title for 'Next Keyboard' button"), for: [])
            alpha.sizeToFit()
            alpha.backgroundColor = UIColor.white
            alpha.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            alpha.translatesAutoresizingMaskIntoConstraints = false
            ShadowOnButton(button: alpha)
            
            self.alpaView.append(alpha)
            self.view.addSubview(alpha)
            
            alpha.layer.cornerRadius = 5
            //constraints
            alpha.heightAnchor.constraint( equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14).isActive = true
            alpha.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.089).isActive = true
            alpha.bottomAnchor.constraint(equalTo: previous3!.topAnchor, constant: -14).isActive = true

            if (previous2 == nil) {
                
                alpha.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
            }
            else{
                // we have a previous button – create a height constraint
                alpha.leftAnchor.constraint(equalTo: previous2!.rightAnchor, constant: 7).isActive = true
            }
            previous2 = alpha
            
        }
        
        //first alphabet row
        
        for key in alpha_first_row {
            let alpha = UIButton(type: .system)
            
            alpha.setTitle(NSLocalizedString(key, comment: "Title for 'Next Keyboard' button"), for: [])
            alpha.sizeToFit()
            alpha.backgroundColor = UIColor.white
            alpha.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            alpha.translatesAutoresizingMaskIntoConstraints = false
            ShadowOnButton(button: alpha)
            
            
            self.alpaView.append(alpha)
            self.view.addSubview(alpha)
            
            
            alpha.layer.cornerRadius = 5
            //constraints
            alpha.heightAnchor.constraint( equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14).isActive = true
            alpha.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.089).isActive = true
            alpha.bottomAnchor.constraint(equalTo: previous2!.topAnchor, constant: -14).isActive = true

            if (previous == nil) {
                
                alpha.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
            }
            else{
                // we have a previous button – create a height constraint
                alpha.leftAnchor.constraint(equalTo: previous!.rightAnchor, constant: 7).isActive = true
            }
            previous = alpha
            

        }
        
        //capslock button
       
  
    }
    
    
    @objc func hashButtonPressed(){
        
        //we loop over buttons to change their title
        
        //print(view.subviews.count)
        var hashkeys = ["_","\\","|","~","<",">","$","$","$",".","[","]","{","}","#","%","^","*","+","="]
        var numKeys = ["0","9","8","7","6","5","4","3","2","1","\"","/","@","&","$",")","(",";",":", "-"]
        let end = self.view.subviews.count - 1
        //let b: UIButton = self.view.subviews[17] as! UIButton
        
        //print(end)
        //print(b.titleLabel?.text)
        var j: Int = 0
        
        if(isHash){
            // i is between 17 and end because the "-" button is at 17 and "0" at end
            for i in 17...end{
                //print(j)
                if self.view.subviews[i] is UIButton {
                    (self.view.subviews[i] as! UIButton).setTitle(numKeys.removeLast(), for: .normal)
                    j = j+1
                }
                
            }
            isHash = false
        }
        else{
            for i in 17...end{
                //print(j)
                if self.view.subviews[i] is UIButton {
                    (self.view.subviews[i] as! UIButton).setTitle(hashkeys[j], for: .normal)
                    j = j+1
                }
                
            }
            //print(j)
            isHash = true
        }
    }
    
    
    func DisplayKeyboard(){
        self.alpaView = []
        var previous: UIButton? = nil
        var previous2: UIButton? = nil
        var previous3: UIButton? = nil
        let alpha_first_row = ["q","w","e","r","t","y","u","i","o","p"]
        let alpha_second_row = ["a","s","d","f","g","h","j","k","l"]
        let alpha_third_row = ["z","x","c","v","b","n","m"]
        
        capButton = UIButton(type: .system)
        
        capButton.setTitle(NSLocalizedString("⇧", comment: "Title for 'Next Keyboard' button"), for: [])
        capButton.sizeToFit()
        capButton.backgroundColor = UIColor.systemGray3
        capButton.addTarget(self, action: #selector(CapitalButtonPressed), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(CapitalButtonDoublePressed))
        tap.numberOfTapsRequired = 2
        capButton.addGestureRecognizer(tap)
        capButton.translatesAutoresizingMaskIntoConstraints = false
        ShadowOnButton(button: capButton)
        
        alpaView.append(capButton)
        self.view.addSubview(capButton)
        
        capButton.layer.cornerRadius = 5
        NSLayoutConstraint.activate([
            capButton.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14),
            capButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.111),
            capButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            capButton.bottomAnchor.constraint(equalTo: numericButton.topAnchor, constant: -15),
        ])
        
        //thrid row of alphabets
        
        for key in alpha_third_row {
            let alpha = UIButton(type: .system)
            
            alpha.setTitle(NSLocalizedString(key, comment: "Title for 'Next Keyboard' button"), for: [])
            alpha.sizeToFit()
            alpha.backgroundColor = UIColor.white
            alpha.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            alpha.translatesAutoresizingMaskIntoConstraints = false
            ShadowOnButton(button: alpha)
            
            self.alpaView.append(alpha)
            self.view.addSubview(alpha)
            
            alpha.layer.cornerRadius = 5
            //constraints
            alpha.heightAnchor.constraint( equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14).isActive = true
            alpha.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.089).isActive = true
            alpha.bottomAnchor.constraint(equalTo: numericButton.topAnchor, constant: -15).isActive = true
            //alpha.topAnchor.constraint(equalTo: previous2!.bottomAnchor, constant: 14).isActive = true

            if (previous3 == nil) {
                //print(key)
                
                alpha.leftAnchor.constraint(equalTo: capButton.rightAnchor, constant: 15).isActive = true
            }
            else{
                // we have a previous button – create a height constraint
                alpha.leftAnchor.constraint(equalTo: previous3!.rightAnchor, constant: 7).isActive = true
            }
            previous3 = alpha
            
        }
        
        for key in alpha_second_row {
            let alpha = UIButton(type: .system)
            
            alpha.setTitle(NSLocalizedString(key, comment: "Title for 'Next Keyboard' button"), for: [])
            alpha.sizeToFit()
            alpha.backgroundColor = UIColor.white
            alpha.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            alpha.translatesAutoresizingMaskIntoConstraints = false
            ShadowOnButton(button: alpha)
            
            self.alpaView.append(alpha)
            self.view.addSubview(alpha)
            
            alpha.layer.cornerRadius = 5
            //constraints
            alpha.heightAnchor.constraint( equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14).isActive = true
            alpha.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.089).isActive = true
            //alpha.topAnchor.constraint(equalTo: previous!.bottomAnchor, constant: 14).isActive = true
            alpha.bottomAnchor.constraint(equalTo: previous3!.topAnchor, constant: -14).isActive = true

            if (previous2 == nil) {
                
                alpha.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
            }
            else{
                // we have a previous button – create a height constraint
                alpha.leftAnchor.constraint(equalTo: previous2!.rightAnchor, constant: 7).isActive = true
            }
            previous2 = alpha
            
        }
        
        //first alphabet row
        
        for key in alpha_first_row {
            let alpha = UIButton(type: .system)
            
            alpha.setTitle(NSLocalizedString(key, comment: "Title for 'Next Keyboard' button"), for: [])
            alpha.sizeToFit()
            alpha.backgroundColor = UIColor.white
            alpha.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            alpha.translatesAutoresizingMaskIntoConstraints = false
            ShadowOnButton(button: alpha)
            
            self.alpaView.append(alpha)
            self.view.addSubview(alpha)
            
            alpha.layer.cornerRadius = 5
            //constraints
            alpha.heightAnchor.constraint( equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.14).isActive = true
            alpha.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.089).isActive = true
            //alpha.topAnchor.constraint(equalTo: warning.topAnchor, constant: 55).isActive = true
            alpha.bottomAnchor.constraint(equalTo: previous2!.topAnchor, constant: -14).isActive = true

            if (previous == nil) {
                
                alpha.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
            }
            else{
                // we have a previous button – create a height constraint
                alpha.leftAnchor.constraint(equalTo: previous!.rightAnchor, constant: 7).isActive = true
            }
            previous = alpha
            

        }
        
        
        //capslock button
        
        
        

    }
    
    //funcation types the the text to the text feild
    
    //
    func containsOnlyLetters(input: String) -> Bool {
       for chr in input {
          if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z")) {
             return false
          }
       }
       return true
    }
    
    @IBAction func buttonPressed(button :UIButton){
        let input = button.titleLabel?.text
        (textDocumentProxy as UIKeyInput).insertText("\(input!)")
        if (input!.isNumber){
            self.numTyped.append(input!)
            self.textTyped = ""
            let vrify = PLIVerification()
            print(self.numTyped)
            if(vrify.isValidCreditCardNumber(self.numTyped) || vrify.isSocialSecurityNumber(self.numTyped)){
                unSafeWarning()
            }
        }
        
        else{
            self.textTyped.append(input!)
            textrecomandations(str: textTyped)
            self.numTyped = ""
        }
        
        //when caplock pressed single time than turn buttons to lower case when any key pressed
        if(SingleIsCapitial == true){
            CapitalButtonPressed()
        }
        
        
    }
    
    //chnage the height when the view port height chnage i.e chnage in oreintation
    
    func CustomHeight(){
        var height: Int
        if(isPotrait){
            height = 280
        }
        else{
            height = 200
        }
        if(self.BoardHeightConstraints == nil){
            BoardHeightConstraints = NSLayoutConstraint.init(item: self.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: CGFloat(height))
            BoardHeightConstraints.priority = .defaultHigh
            view.addConstraint(BoardHeightConstraints)
        }
        else if(self.BoardHeightConstraints.constant != CGFloat(height)){
            self.BoardHeightConstraints.constant = CGFloat(height)
            
        }
    }
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.systemBlue
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    func textrecomandations(str: String){
        print(str)
        let textChecker = UITextChecker()
        let misspelledRange =
            textChecker.rangeOfMisspelledWord(in: str,
                                              range: NSRange(0..<str.utf16.count),
                                              startingAt: 0,
                                              wrap: false,
                                              language: "en_US")

        if misspelledRange.location != NSNotFound,
            let firstGuess = textChecker.guesses(forWordRange: misspelledRange,
                                                 in: str,
                                                 language: "en_US")?.first
        
        {
            self.firstRecmmond.setTitle(firstGuess, for: .normal)
        } else {
            print("Not found")
        }
    }
    func GingerAPI(){

        let headers = [
            "content-type": "text/plain",
            "Content-Type": "text/plain",
            "Accept-Encoding": "identity",
            "X-RapidAPI-Key": "b7f93f67c2msha5b2276d4e39c5bp1015eajsnd01887c03c77",
            "X-RapidAPI-Host": "ginger4.p.rapidapi.com"
        ]

        let postData = NSData(data: "Type your text here".data(using: String.Encoding.utf8)!)

        let request = NSMutableURLRequest(url: NSURL(string: "https://ginger4.p.rapidapi.com/correction?lang=US&generateRecommendations=false&flagInfomralLanguage=true")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })

        dataTask.resume()
    }
}
