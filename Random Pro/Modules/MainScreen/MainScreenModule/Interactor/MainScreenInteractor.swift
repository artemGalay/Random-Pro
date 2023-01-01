//
//  MainScreenInteractor.swift
//  Random Pro
//
//  Created by Vitalii Sosin on 02.05.2022.
//

import UIKit

/// События которые отправляем из Interactor в Presenter
protocol MainScreenInteractorOutput: AnyObject {
  
  /// Были получены данные
  ///  - Parameter model: результат генерации
  func didReceive(model: MainScreenModel)
}

/// События которые отправляем от Presenter к Interactor
protocol MainScreenInteractorInput {
  
  /// Обновить секции главного экрана
  /// - Parameter models: Список секция
  func updateSectionsWith(models: [MainScreenModel.Section])
  
  /// Получаем список ячеек
  func getContent()
  
  /// Возвращает модель
  func returnModel() -> MainScreenModel
  
  /// Сохранить темную тему
  /// - Parameter isEnabled: Темная тема включена
  func saveDarkModeStatus(_ isEnabled: Bool)
  
  /// Убрать лайбл с секции
  /// - Parameter type: Тип сеции
  func removeLabelFromSection(type: MainScreenModel.SectionType)
  
  /// Добавить лайбл к секции
  /// - Parameters:
  ///  - label: Лайбл
  ///  - for: Тип сеции
  func addLabel(_ label: MainScreenModel.ADVLabel,
                for sectionType: MainScreenModel.SectionType)
  
  /// Обновить модель с фича тогглами
  func updatesSectionsIsHiddenFT()
}

/// Интерактор
final class MainScreenInteractor: MainScreenInteractorInput {
  
  // MARK: - Private properties
  
  @ObjectCustomUserDefaultsWrapper<MainScreenModel>(key: Appearance().keyUserDefaults)
  private var model: MainScreenModel?
  private let services: ApplicationServices
  
  // MARK: - Internal properties
  
  weak var output: MainScreenInteractorOutput?
  
  // MARK: - Initialization
  
  /// - Parameters:
  ///   - services: Сервисы приложения
  init(services: ApplicationServices) {
    self.services = services
  }
  
  // MARK: - Internal func
  
  func updateSectionsWith(models: [MainScreenModel.Section]) {
    let models = MainScreenFactory.updatesLocalizationTitleSectionForModel(models: models)
    
    if let model = model {
      let newModel = MainScreenModel(
        isDarkMode: model.isDarkMode,
        allSections: models
      )
      self.model = newModel
      output?.didReceive(model: newModel)
    } else {
      let newModel = MainScreenModel(
        isDarkMode: nil,
        allSections: models
      )
      self.model = newModel
      output?.didReceive(model: newModel)
    }
  }
  
  func getContent() {
    if let model = model {
      let newModel = MainScreenModel(
        isDarkMode: model.isDarkMode,
        allSections: MainScreenFactory.updatesLocalizationTitleSectionForModel(models: model.allSections)
      )
      self.model = newModel
      output?.didReceive(model: newModel)
    } else {
      let newModel = MainScreenFactory.createBaseModel()
      model = newModel
      output?.didReceive(model: newModel)
    }
  }
  
  func returnModel() -> MainScreenModel {
    if let model = model {
      return model
    } else {
      let newModel = MainScreenFactory.createBaseModel()
      return newModel
    }
  }
  
  func saveDarkModeStatus(_ isEnabled: Bool) {
    guard let model = model else {
      return
    }
    let newModel = MainScreenModel(
      isDarkMode: isEnabled,
      allSections: model.allSections
    )
    self.model = newModel
  }
  
  func removeLabelFromSection(type: MainScreenModel.SectionType) {
    guard let model = model else {
      return
    }
    
    let newModel = MainScreenModel(
      isDarkMode: model.isDarkMode,
      allSections: updatesLabelFromSection(type: type,
                                           models: model.allSections,
                                           advLabel: .none)
    )
    output?.didReceive(model: newModel)
    self.model = newModel
  }
  
  func addLabel(_ label: MainScreenModel.ADVLabel,
                for sectionType: MainScreenModel.SectionType) {
    guard let model = model else {
      return
    }
    
    let newModel = MainScreenModel(
      isDarkMode: model.isDarkMode,
      allSections: updatesLabelFromSection(type: sectionType,
                                           models: model.allSections,
                                           advLabel: label)
    )
    output?.didReceive(model: newModel)
    self.model = newModel
  }
  
  func updatesSectionsIsHiddenFT() {
    guard let model = model else {
      return
    }
    
    services.featureToggleServices.getSectionsIsHiddenFT { [weak self] sectionsIsHiddenFTModel in
      guard let sectionsIsHiddenFTModel else {
        return
      }
      let newAllSectionsModel = MainScreenFactory.updatesSectionsIsHiddenFTForModel(models: model.allSections,
                                                                                    featureToggleModel: sectionsIsHiddenFTModel)
      let newModel = MainScreenModel(isDarkMode: model.isDarkMode,
                                     allSections: newAllSectionsModel)
      self?.model = newModel
      self?.output?.didReceive(model: newModel)
    }
  }
}

// MARK: - Private

private extension MainScreenInteractor {
  func updatesLabelFromSection(type: MainScreenModel.SectionType,
                               models: [MainScreenModel.Section],
                               advLabel: MainScreenModel.ADVLabel) -> [MainScreenModel.Section] {
    return models.map {
      if $0.type == type {
        return MainScreenModel.Section(type: $0.type,
                                       isEnabled: $0.isEnabled,
                                       isHidden: $0.isHidden,
                                       titleSection: $0.titleSection,
                                       imageSection: $0.imageSection,
                                       advLabel: advLabel)
      } else {
        return $0
      }
    }
  }
}

// MARK: - Appearance

private extension MainScreenInteractor {
  struct Appearance {
    let keyUserDefaults = "main_screen_user_defaults_key"
  }
}
