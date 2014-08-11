(ns slacks.routes.home
  (:require [compojure.core :refer :all]
            [slacks.views.layout :as layout]
            [slacks.quotes]
            [clj-json.core :as json]))

(defn home []
  (layout/common [:h1 "Hello World!"]))


;; token=igPFPyjvpKR6bWwK8v8u3maV
;; team_id=T0001
;; channel_id=C2147483705
;; channel_name=test
;; timestamp=1355517523.000005
;; user_id=U2147483697
;; user_name=Steve
;; text=googlebot: What is the air-speed velocity of an unladen swallow?
;; trigger_word=googlebot:

(def ^:dynamic *testing?* false)

(defn slacks [] 
  (if *testing?* 
    (do 
      (println "Hitting boring old slacks")
      (layout/common [:h1 (slacks.quotes/get-quote)]))
    {:status 403
     :body "Buzz off"}))

(defn slacks-json [params]
  (println params)
  (if (slacks.quotes/request-ok? params)
    {:status 200
     :headers {"Content-Type" "application/json"}
     :body (json/generate-string {"text" (slacks.quotes/get-quote)})}
    {:status 403
     :body "Buzz off"}))


(defroutes home-routes
  (GET "/" [] (slacks))
  (GET "/slacks" [] (slacks))
  (POST "/slacks" {params :params} (slacks-json params))
)
