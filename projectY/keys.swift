//
//  keys.swift
//  projectY
//
//  Created by Philip Ondrejack on 8/30/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation


//QuestionClass Keys
let QuestionClass: String = "QuestionMaster"
let objectId: String = "objectId"
let questionAskKey: String = "questionAsk"
let questionImageKey: String = "questionImage"
let questionCategoryKey: String = "category"

let questionChoicesKey: String = "questionChoices"
let scaleLabelTop: String = "scaleLabelTop"
let scaleLabelBottom: String = "scaleLabelBottom"

let questionType: String = "questionType"
let numberOfAnswersKey = "numberOfAnswers"
let questionAnswersKey = "questionAnswers"
let questionAnswersOne = "qAnswers1"
let questionAnswersTwo = "qAnswers2"
let questionAnswersThree = "qAnswers3"
let questionAnswersFour = "qAnswers4"
let questionAnswersFive = "qAnswers5"
let questionAnswersSix = "qAnswers6"
let questionAnswersSeven = "qAnswers7"

//MatchClass Keys

let MatchClassKey = "LiveMatches"
let player1IdKey = "player1ID"
let player2IdKey = "player2ID"
let player1UserName = "player1UserName"
let player2UserName = "player2UserName"
let whosTurnKey = "turn"
let player1HelpsKey = "player1Helps"
let player2HelpsKey = "player2Helps"
let player1CategoryWinsKey = "player1CategoryWins"
let player2CategoryWinsKey = "player2CategoryWins"



//LocationClass Keys
let LocationClass = "Locations"
let locality = "Locality"
let locationObjectID = "objectId"
let totalUserCount = "totalUserCount"
let totalGuessesCount = "totalGuessesCount"
let usersLoggedInAtLocationCount = "currentUsersAtLocation"
let usersLoggedInAtLocationArray = "currentUsersAtLocationArray"
let allVisitedUsers = "allVisitedUsers"
let defaultLocationObject = "G1ZjIWqVmp"
let usedQuestionObjects = "usedQuestionObjects"
let scoreRankingsKey = "scoreRankings"
let geoPoint = "geoPoint"
let topPlayersForArea = "topPlayersForArea"
let opponentsQuestionsAnswered = "opponentSubmitted"


//UserClass Keys
let visitedLocations = "visitedLocations"
let usersOldLocation = "usersOldLocation"
let userGuesses = "guesses"
let questionsAnswered = "questionsAnswered"
let displayName = "displayName"
let profilePic = "profilePicture"
let whereUserAnswered = "locationOfAnswers"


//Question Categories
let geographyCategory = "geography"
let sportsCategory = "sports"
let scienceCategory = "science"
let moviesCategory = "movies"
let musicCategory = "music"
let historyCategory = "history"
let moneyCategory = "money"
let productsCategory = "products"
let peopleCategory = "people"
let questionWithImageCategory = "imageType"
let questionJustTextCategory = "textType"


//ColorPalette
let lowestColor = UIColor(hex: "4A90E2")
let lowColor = UIColor(hex: "75CAEF")
let midColor = UIColor(hex:"50E3C2")
let highColor = UIColor(hex: "02F87B")
let highestColor = UIColor(hex: "09E136")
let backgroundColor = UIColor(hex: "282B35")
let lightColoredFont = UIColor(hex: "E9E8E8")
let orangeColor = UIColor(hex: "F5A623")
let whiteColor = UIColor(hex: "FFFFFF")
let paleGreenColor = UIColor(hex: "B8E986")
let lightPurpleColor = UIColor(hex: "D67FE8")
let yellowColor = UIColor(hex: "F8E71C")
let facebookColor = UIColor(hex: "3B5998")
let redColor = UIColor(hex: "E34538")

let userColor = UIColor(hex: "45F5FF")
let opponentColor = UIColor(hex: "FF9A44")

//Image Assets

let answeredCorrectHighest = "correctAnswerHighest"
let answeredCorrectHigh = "correctAnswerHigh"
let answeredCorrectMid = "correctAnswerMid"
let answeredCorrectLow = "correctAnswerLow"
let answeredCorrectLowest = "correctAnswerLowest"

let noQuestionImage = "textQuestion"
let lowestCountOverlay = "lowestCountOverlay"
let lowCountOverlay = "lowCountOverlay"
let midCountOverlay = "midCountOverlay"
let highCountOverlay = "highCountOverlay"
let highestCountOverlay = "highestCountOverlay"
let allDone = "allDone"

let logoutNotification = "logoutNotification"
let defaultProfilePic = "defaultProfilePic"

let facebookSignInImage = "facebookSignin"
let twitterSignInImage = "twitterSignin"
let loginSpacerImage = "loginSpacerImage"
let loginTextFieldBackground = "loginTextFieldBackground"

let science = UIImage(named: "science")
let history = UIImage(named: "history")
let geography = UIImage(named: "geography")
let money = UIImage(named: "money")
let movies = UIImage(named: "movies")
let music = UIImage(named: "music")
let people = UIImage(named: "people")
let products = UIImage(named: "products")
let sports = UIImage(named: "sports")

let leaderScience = UIImage(named: "leaderscience")
let leaderHistory = UIImage(named: "leaderhistory")
let leaderGeography = UIImage(named: "leadergeopgraphy")
let leaderMoney = UIImage(named: "leadermoney")
let leaderMovies = UIImage(named: "leadermovies")
let leaderMusic = UIImage(named: "leadermusic")
let leaderPeople = UIImage(named: "leaderpeople")
let leaderProducts = UIImage(named: "leaderproducts")
let leaderSports = UIImage(named: "leadersports")

let rangeTriangleCorrect = UIImage(named: "correctTriangle")
let rangeTriangleUser = UIImage(named: "userTriangle")
let rangeTriangleOpponent = UIImage(named: "opponentTriangle")

let opponentHelperZoom = UIImage(named: "opponentHelperZoom")
let opponentHelperTakeTwo = UIImage(named: "opponentHelperTakeTwo")
let opponentHelperStopper = UIImage(named: "opponentHelperStopper")

let userHelperZoom = UIImage(named: "userHelperZoom")
let userHelperTakeTwo = UIImage(named: "userHelperTakeTwo")
let userHelperStopper = UIImage(named: "userHelperStopper")

//Map Markers

let markerCurrentLeader = UIImage(named: "markerCurrentLeader")
let markerCurrentLeader2 = UIImage(named: "markerCurrentLeader2")
let markerCurrentRunnerUp = UIImage(named: "markerCurrentLeader")
let markerCurrentThirdPlace = UIImage(named: "markerCurrentLeader")
let markerNine = UIImage(named: "mapMarkerNine")
let markerEight = UIImage(named: "mapMarkerEight")
let markerSeven = UIImage(named: "mapMarkerEight")
let markerSix = UIImage(named: "mapMarkerSix")
let markerFive = UIImage(named: "mapMarkerFive")
let markerFour = UIImage(named: "mapMarkerFive")
let markerThree = UIImage(named: "mapMarkerFive")
let markerTwo = UIImage(named: "mapMarkerFive")
let markerOne = UIImage(named: "mapMarkerFive")
let markerZero = UIImage(named: "mapMarkerFive")


//Fonts
let robotoLight8 = UIFont(name: "Roboto-Light", size: 8.0)
let robotoLight10 = UIFont(name: "Roboto-Light", size: 10.0)
let robotoLight12 = UIFont(name: "Roboto-Light", size: 12.0)
let robotoLight14 = UIFont(name: "Roboto-Light", size: 14.0)
let robotoLight16 = UIFont(name: "Roboto-Light", size: 16.0)
let robotoLight18 = UIFont(name: "Roboto-Light", size: 18.0)
let robotoLight20 = UIFont(name: "Roboto-Light", size: 20.0)
let robotoLight22 = UIFont(name: "Roboto-Light", size: 22.0)
let robotoLight24 = UIFont(name: "Roboto-Light", size: 24.0)
let robotoLight26 = UIFont(name: "Roboto-Light", size: 26.0)
let robotoLight28 = UIFont(name: "Roboto-Light", size: 28.0)
let robotoLight29 = UIFont(name: "Roboto-Light", size: 29.0)
let robotoLight30 = UIFont(name: "Roboto-Light", size: 30.0)
let robotoLight32 = UIFont(name: "Roboto-Light", size: 32.0)

let robotoRegular14 = UIFont(name: "Roboto-Regular", size: 14.0)
let robotoRegular16 = UIFont(name: "Roboto-Regular", size: 16.0)
let robotoRegular18 = UIFont(name: "Roboto-Regular", size: 18.0)
let robotoRegular20 = UIFont(name: "Roboto-Regular", size: 20.0)
let robotoRegular22 = UIFont(name: "Roboto-Regular", size: 22.0)
let robotoRegular24 = UIFont(name: "Roboto-Regular", size: 24.0)
let robotoRegular26 = UIFont(name: "Roboto-Regular", size: 26.0)
let robotoRegular28 = UIFont(name: "Roboto-Regular", size: 28.0)
let robotoRegular30 = UIFont(name: "Roboto-Regular", size: 30.0)
let robotoRegular32 = UIFont(name: "Roboto-Regular", size: 32.0)

let robotoMedium16 = UIFont(name: "Roboto-Medium", size: 16.0)
let robotoMedium18 = UIFont(name: "Roboto-Medium", size: 18.0)
let robotoMedium20 = UIFont(name: "Roboto-Medium", size: 20.0)
let robotoMedium22 = UIFont(name: "Roboto-Medium", size: 22.0)
let robotoMedium24 = UIFont(name: "Roboto-Medium", size: 24.0)
let robotoMedium26 = UIFont(name: "Roboto-Medium", size: 26.0)
let robotoMedium28 = UIFont(name: "Roboto-Medium", size: 28.0)
let robotoMedium30 = UIFont(name: "Roboto-Medium", size: 30.0)
let robotoMedium32 = UIFont(name: "Roboto-Medium", size: 32.0)
let robotoMedium34 = UIFont(name: "Roboto-Medium", size: 34.0)

var fontBottom = UIFont()
var fontTiny = UIFont()
var fontSmallest = UIFont()
var fontSmaller = UIFont()
var fontSmall = UIFont()
var fontMedium = UIFont()
var fontLarge = UIFont()
var fontExtraLarge = UIFont()

var fontSmallestRegular = UIFont()
var fontSmallerRegular = UIFont()
var fontSmallRegular = UIFont()
var fontMediumRegular = UIFont()
var fontLargeRegular = UIFont()
var fontExtraLargeRegular = UIFont()

var fontSmallestMedium = UIFont()
var fontSmallerMedium = UIFont()
var fontSmallMedium = UIFont()
var fontMediumMedium = UIFont()
var fontLargeMedium = UIFont()
var fontExtraLargeMedium = UIFont()

//API Keys


//Segues













