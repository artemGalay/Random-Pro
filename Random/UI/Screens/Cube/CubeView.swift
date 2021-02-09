//
//  CubeView.swift
//  Random
//
//  Created by Vitalii Sosin on 08.02.2021.
//  Copyright © 2021 Sosin.bet. All rights reserved.
//

import SwiftUI

struct CubeView: View {
    
    private var appBinding: Binding<AppState.AppData>
    init(appBinding: Binding<AppState.AppData>) {
        self.appBinding = appBinding
    }
    @Environment(\.injected) private var injected: DIContainer
    
    var body: some View {
        VStack {
            VStack {
                Text(NSLocalizedString("Количество кубиков", comment: ""))
                    .font(.robotoMedium20())
                    .foregroundColor(.primaryGray())
                
                Picker(selection: appBinding.cube.selectedCube,
                       label: Text("Picker")) {
                    ForEach(0..<appBinding.cube.countCube.wrappedValue.count) {
                        Text("\(appBinding.cube.countCube.wrappedValue[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top, 16)
                .padding(.horizontal, 16)
            }
            .padding(.top, 16)
            
            Spacer()
            
            if !appBinding.cube.listResult.wrappedValue.isEmpty {
                content
                    .onTapGesture {
                        generateCube(state: appBinding)
                        Feedback.shared.impactHeavy(.medium)
                    }
            } else {
                Text("?")
                    .font(.robotoBold70())
                    .foregroundColor(.primaryGray())
                    .onTapGesture {
                        generateCube(state: appBinding)
                    }
            }
            
            Spacer()
            listResults
            generateButton
        }
        .navigationBarTitle(Text(NSLocalizedString("Кубики", comment: "")), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            appBinding.cube.showSettings.wrappedValue.toggle()
        }) {
            Image(systemName: "gear")
        })
        .sheet(isPresented: appBinding.cube.showSettings, content: {
            CubeSettingsView(appBinding: appBinding)
        })
    }
}

private extension CubeView {
    private var content: AnyView {
        switch appBinding.cube.selectedCube.wrappedValue {
        case 0:
            return AnyView(cubeOneView)
        case 1:
            return AnyView(cubeTwoView)
        case 2:
            return AnyView(cubeThreeView)
        case 3:
            return AnyView(cubeFourView)
        case 4:
            return AnyView(cubeFiveView)
        case 5:
            return AnyView(cubeSixView)
        default:
            return AnyView(cubeOneView)
        }
    }
}

private extension CubeView {
    var cubeOneView: some View {
        VStack {
            BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeOne.wrappedValue - 1)
        }
    }
}

private extension CubeView {
    var cubeTwoView: some View {
        HStack {
            BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeOne.wrappedValue - 1)
            BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeTwo.wrappedValue - 1)
        }
    }
}

private extension CubeView {
    var cubeThreeView: some View {
        VStack {
            BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeOne.wrappedValue - 1)
            HStack {
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeTwo.wrappedValue - 1)
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeThree.wrappedValue - 1)
            }
        }
    }
}

private extension CubeView {
    var cubeFourView: some View {
        VStack {
            HStack {
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeOne.wrappedValue - 1)
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeTwo.wrappedValue - 1)
            }
            HStack {
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeThree.wrappedValue - 1)
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeFour.wrappedValue - 1)
            }
        }
    }
}

private extension CubeView {
    var cubeFiveView: some View {
        VStack {
            BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeOne.wrappedValue - 1)
            
            HStack {
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeTwo.wrappedValue - 1)
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeThree.wrappedValue - 1)
            }
            HStack {
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeFour.wrappedValue - 1)
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeFive.wrappedValue - 1)
            }
        }
    }
}

private extension CubeView {
    var cubeSixView: some View {
        VStack {
            HStack {
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeOne.wrappedValue - 1)
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeTwo.wrappedValue - 1)
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeThree.wrappedValue - 1)
            }
            HStack {
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeFour.wrappedValue - 1)
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeFive.wrappedValue - 1)
                BoxCellCubeOneView(selectedCubeView: appBinding.cube.cubeSix.wrappedValue - 1)
            }
        }
    }
}

private extension CubeView {
    var listResults: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(appBinding.cube.listResult.wrappedValue, id: \.self) { sum in
                    Text("\(sum)")
                        .foregroundColor(.primaryGray())
                        .font(.robotoMedium18())
                }
            }
            .padding(.leading, 16)
            .padding(.vertical, 16)
        }
    }
}

private extension CubeView {
    var generateButton: some View {
        Button(action: {
            generateCube(state: appBinding)
            Feedback.shared.impactHeavy(.medium)
        }) {
            ButtonView(background: .primaryTertiary(),
                       textColor: .primaryPale(),
                       borderColor: .primaryPale(),
                       text: NSLocalizedString("Бросить кубик(и)", comment: ""),
                       switchImage: false,
                       image: "")
        }
        .padding(16)
    }
}

// MARK: Actions
private extension CubeView {
    private func generateCube(state: Binding<AppState.AppData>) {
        injected.interactors.cubeInterator
            .generateCube(state: state)
    }
}

struct CubeView_Previews: PreviewProvider {
    static var previews: some View {
        CubeView(appBinding: .constant(.init()))
    }
}
