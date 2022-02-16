//
//  ContentView.swift
//  Worlde
//
//  Created by Alexis on 14/2/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        ZStack {
            
            VStack{
                GameView(viewModel: viewModel)
                KeyboardView(viewModel: viewModel)
            }
            if viewModel.bannerType != nil {
                BannerView(bannerType: viewModel.bannerType!)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
