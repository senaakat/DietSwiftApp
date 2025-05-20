import Foundation

struct FoodItem: Codable, Equatable {
    let id: UUID
        let name: String
        let mealType: String
        let calories: Int
        let date: Date
        let carbs: Double
        let protein: Double
        let fat: Double

        init(name: String, mealType: String, calories: Int, carbs: Double, protein: Double, fat: Double, date: Date = Date()) {
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
            .init(name: "Menemen", mealType: "Kahvaltı", calories: 280, carbs: 15, protein: 18, fat: 15),
            .init(name: "Sucuklu Yumurta", mealType: "Kahvaltı", calories: 333, carbs: 1, protein: 12, fat: 30),
            .init(name: "Peynir Tabağı", mealType: "Kahvaltı", calories: 150, carbs: 2, protein: 12, fat: 11),
            .init(name: "Zeytin", mealType: "Kahvaltı", calories: 24, carbs: 1, protein: 0, fat: 2.3),
            .init(name: "Bal & Kaymak", mealType: "Kahvaltı", calories: 490, carbs: 4, protein: 2, fat: 52.3),
            .init(name: "Reçel", mealType: "Kahvaltı", calories: 57, carbs: 14, protein: 0, fat: 0),
            .init(name: "Simit", mealType: "Kahvaltı", calories: 290, carbs: 51, protein: 10, fat: 3.5),
            .init(name: "Poğaça", mealType: "Kahvaltı", calories: 216, carbs: 24.65, protein: 5, fat: 10.93),
            .init(name: "Börek", mealType: "Kahvaltı", calories: 451, carbs: 23, protein: 19, fat: 32),
            .init(name: "Yulaf Ezmesi", mealType: "Kahvaltı", calories: 360, carbs: 53, protein: 14, fat: 7.5),
            .init(name: "Krep", mealType: "Kahvaltı", calories: 120, carbs: 14, protein: 2, fat: 6),
            .init(name: "Omlet", mealType: "Kahvaltı", calories: 221, carbs: 1.4, protein: 21, fat: 17),
            .init(name: "Tahin & Pekmez", mealType: "Kahvaltı", calories: 449, carbs: 43, protein: 10.1, fat: 25.6),
            .init(name: "Çılbır", mealType: "Kahvaltı", calories: 457, carbs: 36, protein: 31, fat: 21),
            .init(name: "Bazlama", mealType: "Kahvaltı", calories: 228, carbs: 44.6, protein: 8.28, fat: 1.24)
        ]

    static let ogleItems: [FoodItem] = [
            .init(name: "İskender Kebap", mealType: "Öğle", calories: 600, carbs: 45, protein: 35, fat: 30),
            .init(name: "Adana Kebap", mealType: "Öğle", calories: 550, carbs: 5, protein: 40, fat: 40),
            .init(name: "Lahmacun", mealType: "Öğle", calories: 300, carbs: 30, protein: 15, fat: 10),
            .init(name: "Pide", mealType: "Öğle", calories: 450, carbs: 50, protein: 20, fat: 15),
            .init(name: "Döner", mealType: "Öğle", calories: 500, carbs: 10, protein: 35, fat: 35),
            .init(name: "Köfte", mealType: "Öğle", calories: 450, carbs: 5, protein: 30, fat: 35),
            .init(name: "Karnıyarık", mealType: "Öğle", calories: 400, carbs: 10, protein: 20, fat: 30),
            .init(name: "Mantı", mealType: "Öğle", calories: 650, carbs: 60, protein: 25, fat: 30),
            .init(name: "Yaprak Sarma", mealType: "Öğle", calories: 200, carbs: 25, protein: 5, fat: 10),
            .init(name: "Nohutlu Pilav", mealType: "Öğle", calories: 380, carbs: 50, protein: 10, fat: 10),
            .init(name: "Tavuk Şiş", mealType: "Öğle", calories: 480, carbs: 5, protein: 40, fat: 30),
            .init(name: "Mercimek Köftesi", mealType: "Öğle", calories: 220, carbs: 30, protein: 10, fat: 5),
            .init(name: "Etli Nohut", mealType: "Öğle", calories: 400, carbs: 30, protein: 25, fat: 20),
            .init(name: "Kuru Fasulye", mealType: "Öğle", calories: 390, carbs: 35, protein: 20, fat: 15)
        ]

    static let aksamItems: [FoodItem] = [
           .init(name: "Hünkar Beğendi", mealType: "Akşam", calories: 600, carbs: 35, protein: 30, fat: 32),
           .init(name: "Alinazik", mealType: "Akşam", calories: 550, carbs: 20, protein: 35, fat: 35),
           .init(name: "Testi Kebabı", mealType: "Akşam", calories: 580, carbs: 25, protein: 40, fat: 30),
           .init(name: "Musakka", mealType: "Akşam", calories: 450, carbs: 15, protein: 25, fat: 30),
           .init(name: "Taze Fasulye", mealType: "Akşam", calories: 200, carbs: 20, protein: 5, fat: 10),
           .init(name: "Enginar", mealType: "Akşam", calories: 180, carbs: 15, protein: 5, fat: 10),
           .init(name: "Fırın Makarna", mealType: "Akşam", calories: 420, carbs: 50, protein: 15, fat: 15),
           .init(name: "Etli Kabak Dolması", mealType: "Akşam", calories: 370, carbs: 20, protein: 20, fat: 20),
           .init(name: "Mücver", mealType: "Akşam", calories: 300, carbs: 25, protein: 10, fat: 15),
           .init(name: "Kuzu Tandır", mealType: "Akşam", calories: 600, carbs: 0, protein: 40, fat: 45),
           .init(name: "Zeytinyağlı Dolma", mealType: "Akşam", calories: 240, carbs: 30, protein: 5, fat: 10)
       ]

    static let araOgunItems: [FoodItem] = [
           .init(name: "Meyve Tabağı", mealType: "Ara Öğün", calories: 100, carbs: 25, protein: 1, fat: 0.5),
           .init(name: "Yoğurt", mealType: "Ara Öğün", calories: 150, carbs: 10, protein: 8, fat: 8),
           .init(name: "Ceviz", mealType: "Ara Öğün", calories: 180, carbs: 4, protein: 4, fat: 16),
           .init(name: "Badem", mealType: "Ara Öğün", calories: 170, carbs: 6, protein: 6, fat: 14),
           .init(name: "Fındık", mealType: "Ara Öğün", calories: 160, carbs: 5, protein: 4, fat: 13),
           .init(name: "Kuru Kayısı", mealType: "Ara Öğün", calories: 120, carbs: 31, protein: 1, fat: 0),
           .init(name: "Kuru İncir", mealType: "Ara Öğün", calories: 150, carbs: 20, protein: 3, fat: 0),
           
    ]
}
