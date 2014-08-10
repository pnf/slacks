(ns slacks.routes.home
  (:require [compojure.core :refer :all]
            [slacks.views.layout :as layout]
            [slacks.quotes]))

(defn home []
  (layout/common [:h1 "Hello World!"]))


(defn slacks []
  (layout/common [:h1 (slacks.quotes/get-quote)]))

(defroutes home-routes
  (GET "/" [] (home))
  (GET "/slacks" [] (slacks))
)
