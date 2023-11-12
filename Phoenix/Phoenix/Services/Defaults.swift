//
//  Defaults.swift
//  Phoenix
//
//  Created by James Hughes on 10/25/23.
//

import Defaults
import Foundation

typealias Defaults = _Defaults
typealias Default = _Default

extension Defaults.Keys {
    //app
    static let selectedGame = Key<UUID>("selectedGame", default: UUID())
    static let sortBy = Key<PhoenixApp.SortBy>("sortBy", default: .platform)
    
    //general
    static let isGameDetectionEnabled = Key<Bool>("isGameDetectionEnabled", default: false)
    static let isCrossOverDetectionEnabled = Key<Bool>("isCrossOverDetectionEnabled", default: false)
    static let steamFolder = Key<URL>("steamFolder", default: URL(fileURLWithPath: "~/Library/Application Support/steam/steamapps"))
    static let isMetaDataFetchingEnabled = Key<Bool>("isMetaDataFetchingEnabled", default: true)
    
    //appearance
    static let accentColorUI = Key<Bool>("accentColorUI", default: true)
    static let gradientUI = Key<Bool>("gradientUI", default: true)
    static let showStarRating = Key<Bool>("showStarRating", default: true)
    
    static let listIconsHidden = Key<Bool>("listIconsHidden", default: false)
    static let listIconSize = Key<Double>("listIconSize", default: 24.0)
    static let showPickerText = Key<Bool>("showPickerText", default: false)
    static let showSortByNumber = Key<Bool>("showSortByNumber", default: true)
    
    static let showSidebarAddGameButton = Key<Bool>("showSidebarAddGameButton", default: false)
    static let showAnimationOfSortByIcon = Key<Bool>("showAnimationOfSortByIcon", default: false)
}
