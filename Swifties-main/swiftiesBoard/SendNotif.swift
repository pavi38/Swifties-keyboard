//
//  SendNotif.swift
//  swiftiesBoard
//
//  Created by Pavneet Cheema on 3/28/24.
//

import Foundation
import Firebase
import Swifties


class SendNotif{
    init(){
        
    }
    func handleSend(notif: String){
        var vm = test()
        print(notif)
        print(vm.currentUser.uid)
    }
}
