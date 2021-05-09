module TerminusDb exposing
    ( Database(..)
    , Graph(..)
    , GraphType(..)
    , Reference(..)
    , RepoReference(..)
    , databasePath
    , graphPath
    , graphType
    , reference
    , withRef
    )


type Database
    = Terminus
    | System
    | Database String String


databasePath : Database -> List String
databasePath d =
    case d of
        Terminus ->
            []

        System ->
            [ "_system" ]

        Database org db ->
            [ org, db ]


type Graph
    = MainGraph GraphType
    | CustomGraph String GraphType


type GraphType
    = Instance
    | Schema
    | Inference


graphPath g =
    case g of
        MainGraph t ->
            [ "main", graphType t ]

        CustomGraph c t ->
            [ c, graphType t ]


graphType t =
    case t of
        Instance ->
            "instance"

        Schema ->
            "schema"

        Inference ->
            "inference"


type RepoReference
    = Local Reference
    | Remote String Reference


type Reference
    = Main
    | Branch String
    | Commit String


reference ref =
    case ref of
        Local Main ->
            [ "local", "branch", "main" ]

        Local (Branch b) ->
            [ "local", "branch", b ]

        Remote remote Main ->
            [ remote, "branch", "main" ]

        Remote remote (Branch b) ->
            [ remote, "branch", b ]

        Local (Commit c) ->
            [ "local", "commit", c ]

        Remote remote (Commit c) ->
            [ remote, "commit", c ]


withRef ref segments =
    segments ++ reference ref
