module Faqs.Models exposing (..)


type alias FaqId =
    Int


type alias Faq =
    { id : FaqId
    , name : String
    , image : String
    , tags : List String
    }



-- ROUTING


type Route
    = FaqsRoute
    | FaqRoute FaqId
    | FaqEditRoute FaqId
    | NotFoundRoute


faqs : List Faq
faqs =
    [ { id = 1
      , name = "Elm"
      , image = "elm"
      , tags = [ "functional", "browser", "static" ]
      }
    , { id = 2
      , name = "JavaScript"
      , image = "js"
      , tags = [ "functional", "oo", "browser", "dynamic", "prototypical" ]
      }
    , { id = 3
      , name = "Go"
      , image = "go"
      , tags = [ "oo", "google", "static" ]
      }
    , { id = 4
      , name = "Rust"
      , image = "rust"
      , tags = [ "functional", "mozilla", "static" ]
      }
    , { id = 5
      , name = "Elixir"
      , image = "elixir"
      , tags = [ "functional", "erlang", "dynamic" ]
      }
    , { id = 6
      , name = "Ruby"
      , image = "ruby"
      , tags = [ "oo", "japan", "1996", "dynamic", "classical" ]
      }
    , { id = 7
      , name = "Python"
      , image = "python"
      , tags = [ "oo", "dynamic", "classical" ]
      }
    , { id = 8
      , name = "Swift"
      , image = "swift"
      , tags = [ "functional", "apple", "static", "classical" ]
      }
    , { id = 9
      , name = "Haskell"
      , image = "haskell"
      , tags = [ "functional", "static" ]
      }
    , { id = 10
      , name = "Java"
      , image = "java"
      , tags = [ "oo", "static", "classical" ]
      }
    , { id = 11
      , name = "C#"
      , image = "csharp"
      , tags = [ "oo", "microsoft", "static", "classical" ]
      }
    , { id = 12
      , name = "PHP"
      , image = "php"
      , tags = [ "oo", "server", "1994", "dynamic", "classical" ]
      }
    ]
