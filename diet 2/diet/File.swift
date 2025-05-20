import Foundation

struct StaticFoodItem {
    let name: String
    let calories: Int
}

struct StaticFoodDatabase {
    static let kahvaltiItems = [
        StaticFoodItem(name: "Yumurta", calories: 150),
        StaticFoodItem(name: "Peynir", calories: 120),
        StaticFoodItem(name: "Ekmek", calories: 80)
    ]
    
    static let ogleItems = [
        StaticFoodItem(name: "Tavuk", calories: 500),
        StaticFoodItem(name: "Pilav", calories: 300)
    ]
    
    static let aksamItems = [
        StaticFoodItem(name: "Kebap", calories: 700),
        StaticFoodItem(name: "Çorba", calories: 200)
    ]
    
    static let araOgunItems = [
        StaticFoodItem(name: "Meyve", calories: 100),
        StaticFoodItem(name: "Yoğurt", calories: 150)
    ]
}
