//
//  LabelsFeatureToggleModel.swift
//  Random Pro
//
//  Created by Vitalii Sosin on 02.01.2023.
//  Copyright © 2023 SosinVitalii.com. All rights reserved.
//

import Foundation

struct LabelsFeatureToggleModel {
  
  /// Раздел: `Команды`
  let teams: String
  
  /// Раздел: `Число`
  let number: String
  
  /// Раздел: `Да или Нет`
  let yesOrNo: String
  
  /// Раздел: `Буква`
  let letter: String
  
  /// Раздел: `Список`
  let list: String
  
  /// Раздел: `Монета`
  let coin: String
  
  /// Раздел: `Кубики`
  let cube: String
  
  /// Раздел: `Дата и Время`
  let dateAndTime: String
  
  /// Раздел: `Лотерея`
  let lottery: String
  
  /// Раздел: `Контакты`
  let contact: String
  
  /// Раздел: `Пароли`
  let password: String
  
  /// Раздел: `Цвета`
  let colors: String
  
  /// Раздел: `Бутылочка`
  let bottle: String
  
  /// Раздел `Камень, ножницы, бумага`
  let rockPaperScissors: String
  
  /// Раздел `Фильтры изображений`
  let imageFilters: String
  
  /// Раздел `Фильмы`
  let films: String
  
  // MARK: - Initialization
  
  /// - Parameters:
  ///   - dictionary: Словарь с фича тогглами
  init(dictionary: [String: Any]) {
    teams = (dictionary["teams"] as? String ?? "")
    number = (dictionary["number"] as? String ?? "")
    yesOrNo = (dictionary["yesOrNo"] as? String ?? "")
    letter = (dictionary["letter"] as? String ?? "")
    list = (dictionary["list"] as? String ?? "")
    coin = (dictionary["coin"] as? String ?? "")
    cube = (dictionary["cube"] as? String ?? "")
    dateAndTime = (dictionary["dateAndTime"] as? String ?? "")
    lottery = (dictionary["lottery"] as? String ?? "")
    contact = (dictionary["contact"] as? String ?? "")
    password = (dictionary["password"] as? String ?? "")
    colors = (dictionary["colors"] as? String ?? "")
    bottle = (dictionary["bottle"] as? String ?? "")
    rockPaperScissors = (dictionary["rockPaperScissors"] as? String ?? "")
    imageFilters = (dictionary["imageFilters"] as? String ?? "")
    films = (dictionary["films"] as? String ?? "")
  }
}
