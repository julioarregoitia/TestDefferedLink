//
//  ContentView.swift
//  TestDefferedLink
//
//  Created by Julio Cesar on 3/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModelContentView()
    
    var body: some View {
        
        VStack {
            Button("Login with Facebook") {
                self.viewModel.fbLogginButton()
            }
            
            Text(viewModel.facebookResultString)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
