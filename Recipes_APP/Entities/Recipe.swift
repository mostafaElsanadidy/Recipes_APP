//
//  Recipe.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import SwiftyJSON

class Recipe{

    var calories : Float!
    var cautions : [String]!
    var cuisineType : [String]!
    var dietLabels : [String]!
    var digest : [Digest]!
    var dishType : [String]!
    var healthLabels : [String]!
    var image : String!
    var images : Image!
    var ingredientLines : [String]!
    var ingredients : [Ingredient]!
    var label : String!
    var mealType : [String]!
    var shareAs : String!
    var source : String!
    var totalDaily : TotalDaily!
    var totalNutrients : TotalNutrient!
    var totalTime : Float!
    var totalWeight : Float!
    var uri : String!
    var url : String!
    var yield : Float!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        calories = json["calories"].floatValue
        cautions = [String]()
        let cautionsArray = json["cautions"].arrayValue
        for cautionsJson in cautionsArray{
            cautions.append(cautionsJson.stringValue)
        }
        cuisineType = [String]()
        let cuisineTypeArray = json["cuisineType"].arrayValue
        for cuisineTypeJson in cuisineTypeArray{
            cuisineType.append(cuisineTypeJson.stringValue)
        }
        dietLabels = [String]()
        let dietLabelsArray = json["dietLabels"].arrayValue
        for dietLabelsJson in dietLabelsArray{
            dietLabels.append(dietLabelsJson.stringValue)
        }
        digest = [Digest]()
        let digestArray = json["digest"].arrayValue
        for digestJson in digestArray{
            let value = Digest(fromJson: digestJson)
            digest.append(value)
        }
        dishType = [String]()
        let dishTypeArray = json["dishType"].arrayValue
        for dishTypeJson in dishTypeArray{
            dishType.append(dishTypeJson.stringValue)
        }
        healthLabels = [String]()
        let healthLabelsArray = json["healthLabels"].arrayValue
        for healthLabelsJson in healthLabelsArray{
            healthLabels.append(healthLabelsJson.stringValue)
        }
        image = json["image"].stringValue
        let imagesJson = json["images"]
        if !imagesJson.isEmpty{
            images = Image(fromJson: imagesJson)
        }
        ingredientLines = [String]()
        let ingredientLinesArray = json["ingredientLines"].arrayValue
        for ingredientLinesJson in ingredientLinesArray{
            ingredientLines.append(ingredientLinesJson.stringValue)
        }
        ingredients = [Ingredient]()
        let ingredientsArray = json["ingredients"].arrayValue
        for ingredientsJson in ingredientsArray{
            let value = Ingredient(fromJson: ingredientsJson)
            ingredients.append(value)
        }
        label = json["label"].stringValue
        mealType = [String]()
        let mealTypeArray = json["mealType"].arrayValue
        for mealTypeJson in mealTypeArray{
            mealType.append(mealTypeJson.stringValue)
        }
        shareAs = json["shareAs"].stringValue
        source = json["source"].stringValue
        let totalDailyJson = json["totalDaily"]
        if !totalDailyJson.isEmpty{
            totalDaily = TotalDaily(fromJson: totalDailyJson)
        }
        let totalNutrientsJson = json["totalNutrients"]
        if !totalNutrientsJson.isEmpty{
            totalNutrients = TotalNutrient(fromJson: totalNutrientsJson)
        }
        totalTime = json["totalTime"].floatValue
        totalWeight = json["totalWeight"].floatValue
        uri = json["uri"].stringValue
        url = json["url"].stringValue
        yield = json["yield"].floatValue
    }

}
