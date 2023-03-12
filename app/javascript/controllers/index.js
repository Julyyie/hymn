// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AnswersIndexSubscriptionController from "./answers_index_subscription_controller"
application.register("answers-index-subscription", AnswersIndexSubscriptionController)

import GamesController from "./games_controller"
application.register("games", GamesController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)
