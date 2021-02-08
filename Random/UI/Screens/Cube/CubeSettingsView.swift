//
//  CubeSettingsView.swift
//  Random
//
//  Created by Vitalii Sosin on 08.02.2021.
//  Copyright © 2021 Sosin.bet. All rights reserved.
//

import SwiftUI

struct CubeSettingsView: View {
    
    private var appBinding: Binding<AppState.AppData>
    init(appBinding: Binding<AppState.AppData>) {
        self.appBinding = appBinding
    }
    @Environment(\.injected) private var injected: DIContainer
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        Text("Монет сгенерировано:")
                            .foregroundColor(.primaryGray())
                            .font(.robotoMedium18())
                        Spacer()
                        
                        Text("\(appBinding.cube.listResult.wrappedValue.count)")
                            .foregroundColor(.primaryGray())
                            .font(.robotoMedium18())
                    }
                    
                    HStack {
                        Text("Последняя монета:")
                            .foregroundColor(.primaryGray())
                            .font(.robotoMedium18())
                        Spacer()
                        
                        Text("\(appBinding.cube.listResult.wrappedValue.last ?? "нет")")
                            .foregroundColor(.primaryGray())
                            .font(.robotoMedium18())
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Text("Очистить")
                        }
                        Spacer()
                    }
                }
            }
            .navigationBarTitle(Text("Настройки"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                appBinding.cube.showSettings.wrappedValue = false
            }) {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(Color.primaryGray())
        })
        }
    }
}

struct CubeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CubeSettingsView(appBinding: .constant(.init()))
    }
}