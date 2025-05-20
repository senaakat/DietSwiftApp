import Foundation

struct FoodItem: Codable, Equatable {
    let id: UUID
        let name: String
        let mealType: String
        let calories: Int
        let carbs: Int
        let protein: Int
        let fat: Int
        let date: Date

        init(name: String, mealType: String, calories: Int, carbs: Int, protein: Int, fat: Int, date: Date = Date()) {
            self.id = UUID()
            self.name = name
            self.mealType = mealType
            self.calories = calories
            self.carbs = carbs
            self.protein = protein
            self.fat = fat
            self.date = date
        }

        static func ==(lhs: FoodItem, rhs: FoodItem) -> Bool {
            return lhs.id == rhs.id
        }
}

struct FoodDatabase {
    static let kahvaltiItems: [FoodItem] = [
        .init(name: "Menemen", mealType: "Kahvaltı", calories: 180, carbs: 8, protein: 9, fat: 12),
        .init(name: "Sucuklu Yumurta", mealType: "Kahvaltı", calories: 250, carbs: 1, protein: 14, fat: 21),
        .init(name: "Peynir Tabağı", mealType: "Kahvaltı", calories: 150, carbs: 1, protein: 10, fat: 12),
        .init(name: "Zeytin", mealType: "Kahvaltı", calories: 70, carbs: 1, protein: 0, fat: 7),
        .init(name: "Bal & Kaymak", mealType: "Kahvaltı", calories: 200, carbs: 20, protein: 2, fat: 15),
        .init(name: "Reçel", mealType: "Kahvaltı", calories: 90, carbs: 22, protein: 0, fat: 0),
        .init(name: "Simit", mealType: "Kahvaltı", calories: 320, carbs: 56, protein: 9, fat: 10),
        .init(name: "Poğaça", mealType: "Kahvaltı", calories: 280, carbs: 33, protein: 6, fat: 14),
        .init(name: "Börek", mealType: "Kahvaltı", calories: 350, carbs: 30, protein: 10, fat: 20),
        .init(name: "Yulaf Ezmesi", mealType: "Kahvaltı", calories: 200, carbs: 30, protein: 6, fat: 5),
        .init(name: "Krep", mealType: "Kahvaltı", calories: 180, carbs: 20, protein: 6, fat: 9),
        .init(name: "Omlet", mealType: "Kahvaltı", calories: 160, carbs: 1, protein: 10, fat: 13),
        .init(name: "Tahin & Pekmez", mealType: "Kahvaltı", calories: 210, carbs: 16, protein: 4, fat: 14),
        .init(name: "Çılbır", mealType: "Kahvaltı", calories: 190, carbs: 3, protein: 11, fat: 15),
        .init(name: "Bazlama", mealType: "Kahvaltı", calories: 260, carbs: 42, protein: 6, fat: 7)
    ]

    static let ogleItems: [FoodItem] = [
        .init(name: "İskender Kebap", mealType: "Öğle", calories: 600, carbs: 34, protein: 27, fat: 30),
        .init(name: "Adana Kebap", mealType: "Öğle", calories: 550, carbs: 5, protein: 35, fat: 40),
        .init(name: "Lahmacun", mealType: "Öğle", calories: 300, carbs: 35, protein: 15, fat: 12),
        .init(name: "Pide", mealType: "Öğle", calories: 450, carbs: 50, protein: 20, fat: 18),
        .init(name: "Döner", mealType: "Öğle", calories: 500, carbs: 20, protein: 30, fat: 25),
        .init(name: "Köfte", mealType: "Öğle", calories: 450, carbs: 10, protein: 25, fat: 30),
        .init(name: "Karnıyarık", mealType: "Öğle", calories: 400, carbs: 15, protein: 20, fat: 25),
        .init(name: "Mantı", mealType: "Öğle", calories: 650, carbs: 60, protein: 25, fat: 30),
        .init(name: "Yaprak Sarma", mealType: "Öğle", calories: 200, carbs: 30, protein: 5, fat: 8),
        .init(name: "Nohutlu Pilav", mealType: "Öğle", calories: 380, carbs: 50, protein: 10, fat: 12),
        .init(name: "Tavuk Şiş", mealType: "Öğle", calories: 480, carbs: 5, protein: 35, fat: 25),
        .init(name: "Mercimek Köftesi", mealType: "Öğle", calories: 220, carbs: 30, protein: 8, fat: 10),
        .init(name: "Etli Nohut", mealType: "Öğle", calories: 400, carbs: 35, protein: 20, fat: 15),
        .init(name: "Kuru Fasulye", mealType: "Öğle", calories: 390, carbs: 40, protein: 15, fat: 12)
    ]

    static let aksamItems: [FoodItem] = [
        .init(name: "Hünkar Beğendi", mealType: "Akşam", calories: 600, carbs: 20, protein: 30, fat: 40),
        .init(name: "Alinazik", mealType: "Akşam", calories: 550, carbs: 15, protein: 25, fat: 35),
        .init(name: "Testi Kebabı", mealType: "Akşam", calories: 580, carbs: 10, protein: 35, fat: 38),
        .init(name: "Musakka", mealType: "Akşam", calories: 450, carbs: 20, protein: 20, fat: 30),
        .init(name: "Taze Fasulye", mealType: "Akşam", calories: 200, carbs: 15, protein: 5, fat: 10),
        .init(name: "Enginar", mealType: "Akşam", calories: 180, carbs: 20, protein: 5, fat: 8),
        .init(name: "Fırın Makarna", mealType: "Akşam", calories: 420, carbs: 50, protein: 15, fat: 18),
        .init(name: "Etli Kabak Dolması", mealType: "Akşam", calories: 370, carbs: 25, protein: 20, fat: 20),
        .init(name: "Mücver", mealType: "Akşam", calories: 300, carbs: 20, protein: 10, fat: 18),
        .init(name: "Kuzu Tandır", mealType: "Akşam", calories: 600, carbs: 0, protein: 40, fat: 45),
        .init(name: "Zeytinyağlı Dolma", mealType: "Akşam", calories: 240, carbs: 30, protein: 5, fat: 12)
    ]

    static let araOgunItems: [FoodItem] = [
        .init(name: "Meyve Tabağı", mealType: "Ara Öğün", calories: 100, carbs: 25, protein: 1, fat: 0),
        .init(name: "Yoğurt", mealType: "Ara Öğün", calories: 150, carbs: 10, protein: 8, fat: 5),
        .init(name: "Ceviz", mealType: "Ara Öğün", calories: 180, carbs: 4, protein: 4, fat: 16),
        .init(name: "Badem", mealType: "Ara Öğün", calories: 170, carbs: 6, protein: 6, fat: 14),
        .init(name: "Fındık", mealType: "Ara Öğün", calories: 160, carbs: 5, protein: 4, fat: 13),
        .init(name: "Kuru Kayısı", mealType: "Ara Öğün", calories: 120, carbs: 30, protein: 1, fat: 0),
        .init(name: "Kuru İncir", mealType: "Ara Öğün", calories: 110, carbs: 28, protein: 1, fat: 0),
        .init(name: "Tam Buğday Kraker", mealType: "Ara Öğün", calories: 90, carbs: 15, protein: 2, fat: 3),
        .init(name: "Kefir", mealType: "Ara Öğün", calories: 130, carbs: 10, protein: 8, fat: 5),
        .init(name: "Yulaf Bar", mealType: "Ara Öğün", calories: 220, carbs: 30, protein: 5, fat: 8)
    ]
}
