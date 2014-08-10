(ns yowsa.routes.home
  (:require [compojure.core :refer :all]
            [yowsa.views.layout :as layout]
            [yowsa.quotes]))

(defn home []
  (layout/common [:h1 "Hello World!"]))


(defn yowsa []
  (layout/common [:h1 (yowsa.quotes/get-quote)]))

(defroutes home-routes
  (GET "/" [] (home))
  (GET "/yowsa" [] (yowsa))
)
