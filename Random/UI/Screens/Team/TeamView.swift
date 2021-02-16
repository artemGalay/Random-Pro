//
//  TeamView.swift
//  Random Pro
//
//  Created by Vitalii Sosin on 14.02.2021.
//  Copyright © 2021 Sosin.bet. All rights reserved.
//

import SwiftUI

struct TeamView: View {
    private var appBinding: Binding<AppState.AppData>
    init(appBinding: Binding<AppState.AppData>) {
        self.appBinding = appBinding
    }
    @Environment(\.injected) private var injected: DIContainer
    @State var countTeam = ["1", "2", "3", "4", "5", "6"]
    @State var selectedTeam = 1
    
    var body: some View {
        VStack {
            header
            if appBinding.team.listResult1.wrappedValue.isEmpty {
                what
            } else {
                content
            }
            generateButton
            
        }
        
        .navigationBarTitle(Text(NSLocalizedString("Команды", comment: "")), displayMode: .inline)
        .navigationBarItems(trailing: HStack(spacing: 24) {
            Button(action: {
                appBinding.team.showAddPlayer.wrappedValue.toggle()
            }) {
                Image(systemName: "person.badge.plus")
                    .font(.system(size: 24))
            }
            
            Button(action: {
                appBinding.team.showSettings.wrappedValue.toggle()
            }) {
                Image(systemName: "gear")
                    .font(.system(size: 24))
            }
            .sheet(isPresented: appBinding.team.showSettings, content: {
                TeamSettingsView(appBinding: appBinding)
            })
        })
        
    }
}

private extension TeamView {
    var header: some View {
        VStack {
            Text(NSLocalizedString("Количество команд", comment: ""))
                .font(.robotoMedium20())
                .foregroundColor(.primaryGray())
            
            Picker(selection: $selectedTeam,
                   label: Text("Picker")) {
                ForEach(0..<countTeam.count) {
                    Text("\(countTeam[$0])")
                }
            }
            .disabled(appBinding.team.disabledPickerView.wrappedValue)
            .pickerStyle(SegmentedPickerStyle())
            .padding(.top, 16)
            .padding(.horizontal, 16)
        }
        .padding(.top, 16)
    }
}

private extension TeamView {
    var what: some View {
        VStack {
            Spacer()
            
            Button(action: {
                if !appBinding.team.listTempPlayers.wrappedValue.isEmpty {
                    appBinding.team.selectedTeam.wrappedValue = selectedTeam
                    generateListTeams(state: appBinding)
                    appBinding.team.disabledPickerView.wrappedValue = true
                    Feedback.shared.impactHeavy(.medium)
                }
            }) {
                Text("?")
                    .font(.robotoBold70())
                    .foregroundColor(.primaryGray())
            }
            
            Spacer()
        }
    }
}

private extension TeamView {
    private var content: AnyView {
        switch appBinding.team.selectedTeam.wrappedValue + 1 {
        case 1:
            return AnyView(teamOne)
        case 2:
            return AnyView(teamTwo)
        case 3:
            return AnyView(teamThree)
        case 4:
            return AnyView(teamFour)
        case 5:
            return AnyView(teamFive)
        case 6:
            return AnyView(teamSix)
        default:
            return AnyView(what)
        }
    }
}

private extension TeamView {
    var teamOne: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult1,
                                  teamNumber: 1)
                Spacer()
            }
            .padding(.top)
        }
    }
}

private extension TeamView {
    var teamTwo: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult1,
                                  teamNumber: 1)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult2,
                                  teamNumber: 2)
                Spacer()
            }
            .padding(.top)
        }
    }
}

private extension TeamView {
    var teamThree: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult1,
                                  teamNumber: 1)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult2,
                                  teamNumber: 2)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult3,
                                  teamNumber: 3)
                Spacer()
            }
            .padding(.top)
        }
    }
}

private extension TeamView {
    var teamFour: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult1,
                                  teamNumber: 1)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult2,
                                  teamNumber: 2)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult3,
                                  teamNumber: 3)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult4,
                                  teamNumber: 4)
                Spacer()
            }
            .padding(.top)
        }
    }
}

private extension TeamView {
    var teamFive: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult1,
                                  teamNumber: 1)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult2,
                                  teamNumber: 2)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult3,
                                  teamNumber: 3)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult4,
                                  teamNumber: 4)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult5,
                                  teamNumber: 5)
                Spacer()
            }
            .padding(.top)
        }
    }
}

private extension TeamView {
    var teamSix: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult1,
                                  teamNumber: 1)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult2,
                                  teamNumber: 2)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult3,
                                  teamNumber: 3)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult4,
                                  teamNumber: 4)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult5,
                                  teamNumber: 5)
                ScrollTeamPlayers(listPlayers: appBinding.team.listResult6,
                                  teamNumber: 6)
                Spacer()
            }
            .padding(.top)
        }
    }
}

private extension TeamView {
    var generateButton: some View {
        Button(action: {
            if !appBinding.team.listTempPlayers.wrappedValue.isEmpty {
                appBinding.team.selectedTeam.wrappedValue = selectedTeam
                generateListTeams(state: appBinding)
                saveTeamToUserDefaults(state: appBinding)
                appBinding.team.disabledPickerView.wrappedValue = true
                Feedback.shared.impactHeavy(.medium)
            }
        }) {
            ButtonView(background: .primaryTertiary(),
                       textColor: .primaryPale(),
                       borderColor: .primaryPale(),
                       text: NSLocalizedString("Сгенерировать", comment: ""),
                       switchImage: false,
                       image: "")
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

// MARK: Actions
private extension TeamView {
    private func generateListTeams(state: Binding<AppState.AppData>) {
        injected.interactors.teamInteractor
            .generateListTeams(state: state)
    }
}

private extension TeamView {
    private func saveTeamToUserDefaults(state: Binding<AppState.AppData>) {
        injected.interactors.teamInteractor
            .saveTeamToUserDefaults(state: state)
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(appBinding: .constant(.init()))
    }
}
