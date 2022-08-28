//
//  ListPlayersScreenInteractor.swift
//  Random Pro
//
//  Created by Vitalii Sosin on 13.08.2022.
//

import UIKit

/// События которые отправляем из Interactor в Presenter
protocol ListPlayersScreenInteractorOutput: AnyObject {
  
  /// Были получены данные
  ///  - Parameters:
  ///   - players: Список игроков
  ///   - teamsCount: Количество команд
  func didRecive(players: [TeamsScreenPlayerModel], teamsCount: Int)
}

/// События которые отправляем от Presenter к Interactor
protocol ListPlayersScreenInteractorInput {
  
  /// Возвращает текущий список игроков
  func returnCurrentListPlayers() -> [TeamsScreenPlayerModel]
  
  /// Получить данные
  func getContent()
  
  /// Обновить контент
  ///  - Parameters:
  ///   - models: Модели игроков
  ///   - teamsCount: Общее количество игроков
  func updateContentWith(models: [TeamsScreenPlayerModel], teamsCount: Int)
  
  /// Обновить реакцию у игрока
  /// - Parameters:
  ///  - emoji: Реакция
  ///  - id: Уникальный номер игрока
  func updatePlayer(emoji: String, id: String)
  
  /// Обновить статус у игрока
  /// - Parameters:
  ///  - state: Статус игрока
  ///  - id: Уникальный номер игрока
  func updatePlayer(state: TeamsScreenPlayerModel.PlayerState, id: String)
  
  /// Добавить игрока
  ///  - Parameter name: Имя игрока
  func playerAdd(name: String?)
  
  /// Удалить игрока
  ///  - Parameter id: Уникальный номер игрока
  func playerRemove(id: String)
  
  /// Удалить всех игроков
  func removeAllPlayers()
}

/// Интерактор
final class ListPlayersScreenInteractor: ListPlayersScreenInteractorInput {
  
  // MARK: - Internal properties
  
  weak var output: ListPlayersScreenInteractorOutput?
  
  // MARK: - Private properties
  
  private var models: [TeamsScreenPlayerModel] = []
  private var defaultTeamsCount = Appearance().defaultTeamsCount
  
  // MARK: - Internal func
  
  func getContent() {
    output?.didRecive(players: models, teamsCount: defaultTeamsCount)
  }
  
  func updateContentWith(models: [TeamsScreenPlayerModel], teamsCount: Int) {
    self.models = models
    defaultTeamsCount = teamsCount
  }
  
  func updatePlayer(emoji: String, id: String) {
    let index = models.firstIndex{ $0.id == id }
    guard let index = index else {
      return
    }
    
    let player = TeamsScreenPlayerModel(
      id: models[index].id,
      name: models[index].name,
      avatar: models[index].avatar,
      emoji: emoji,
      state: models[index].state
    )
    
    models.remove(at: index)
    models.insert(player, at: index)
    
    output?.didRecive(players: models, teamsCount: defaultTeamsCount)
  }
  
  func updatePlayer(state: TeamsScreenPlayerModel.PlayerState, id: String) {
    let index = models.firstIndex{ $0.id == id }
    guard let index = index else {
      return
    }
    
    let player = TeamsScreenPlayerModel(
      id: models[index].id,
      name: models[index].name,
      avatar: models[index].avatar,
      emoji: models[index].emoji,
      state: state
    )
    
    models.remove(at: index)
    models.insert(player, at: index)
    
    output?.didRecive(players: models, teamsCount: defaultTeamsCount)
  }
  
  func playerAdd(name: String?) {
    guard
      let name = name,
      !name.isEmpty
    else {
      return
    }
    
    let player = TeamsScreenPlayerModel(
      id: UUID().uuidString,
      name: name,
      avatar: generationImagePlayer()?.pngData(),
      emoji: nil,
      state: .random
    )
    
    models.append(player)
    output?.didRecive(players: models, teamsCount: defaultTeamsCount)
  }
  
  func playerRemove(id: String) {
    let index = models.firstIndex{ $0.id == id }
    guard let index = index else {
      return
    }
    
    models.remove(at: index)
    output?.didRecive(players: models, teamsCount: defaultTeamsCount)
  }
  
  func removeAllPlayers() {
    models = []
    output?.didRecive(players: models, teamsCount: defaultTeamsCount)
  }
  
  func returnCurrentListPlayers() -> [TeamsScreenPlayerModel] {
    return models
  }
}

// MARK: - Private

private extension ListPlayersScreenInteractor {
  func generationImagePlayer() -> UIImage? {
    let randomNumberPlayers = Int.random(in: Appearance().rangeImagePlayer)
    return UIImage(named: "player\(randomNumberPlayers)")
  }
}

// MARK: - Appearance

private extension ListPlayersScreenInteractor {
  struct Appearance {
    let rangeImagePlayer = 1...15
    let defaultTeamsCount = 2
  }
}