module Assets exposing
    ( Asset(..)
    , CircleOutlineIcon(..)
    , ComponentType(..)
    , backgroundImageStyle
    , toString
    )

import Concourse.BuildStatus exposing (BuildStatus(..))
import Concourse.Cli exposing (Cli(..))
import Concourse.PipelineStatus exposing (PipelineStatus(..))
import Html
import Html.Attributes exposing (style)
import Url.Builder


type Asset
    = CliIcon Cli
    | ChevronLeft
    | ChevronRight
    | HighDensityIcon Bool
    | VisibilityToggleIcon Bool
    | BuildFavicon (Maybe BuildStatus)
    | PinIconWhite
    | PinIconGrey
    | CheckmarkIcon
    | BreadcrumbIcon ComponentType
    | PassportOfficerIcon
    | ConcourseLogoWhite
    | CircleOutlineIcon CircleOutlineIcon
    | CogsIcon
    | RunningLegend
    | NotBlockingCheckIcon
    | RerunIcon
    | PendingIcon
    | InterruptedIcon
    | CancelledIcon
    | SuccessCheckIcon
    | FailureTimesIcon
    | ExclamationTriangleIcon
    | PipelineStatusIcon PipelineStatus
    | ClippyIcon
    | UpArrow
    | DownArrow
    | RefreshIcon
    | MessageIcon
    | HamburgerMenuIcon
    | PeopleIcon
    | KeyboardArrowDown
    | KeyboardArrowRight
    | PlayIcon
    | PauseIcon


type ComponentType
    = PipelineComponent
    | JobComponent
    | ResourceComponent


type CircleOutlineIcon
    = PlayCircleIcon
    | PauseCircleIcon
    | AddCircleIcon
    | AbortCircleIcon


toString : Asset -> String
toString asset =
    Url.Builder.absolute (toPath asset) []


backgroundImageStyle : Maybe Asset -> Html.Attribute msg
backgroundImageStyle maybeAsset =
    style "background-image" <|
        case maybeAsset of
            Nothing ->
                "none"

            Just asset ->
                "url(" ++ toString asset ++ ")"


toPath : Asset -> List String
toPath asset =
    let
        basePath =
            [ "public", "images" ]
    in
    case asset of
        CliIcon cli ->
            let
                imageName =
                    case cli of
                        OSX ->
                            "apple"

                        Windows ->
                            "windows"

                        Linux ->
                            "linux"
            in
            basePath ++ [ imageName ++ "-logo.svg" ]

        ChevronLeft ->
            basePath ++ [ "baseline-chevron-left-24px.svg" ]

        ChevronRight ->
            basePath ++ [ "baseline-chevron-right-24px.svg" ]

        HighDensityIcon on ->
            let
                imageName =
                    if on then
                        "on"

                    else
                        "off"
            in
            basePath ++ [ "ic-hd-" ++ imageName ++ ".svg" ]

        VisibilityToggleIcon visible ->
            let
                imageName =
                    if visible then
                        ""

                    else
                        "off-"
            in
            basePath ++ [ "baseline-visibility-" ++ imageName ++ "24px.svg" ]

        BuildFavicon maybeStatus ->
            basePath
                ++ (case maybeStatus of
                        Just status ->
                            let
                                imageName =
                                    Concourse.BuildStatus.show status
                            in
                            [ "favicon-" ++ imageName ++ ".png" ]

                        Nothing ->
                            [ "favicon.png" ]
                   )

        PinIconWhite ->
            basePath ++ [ "pin-ic-white.svg" ]

        PinIconGrey ->
            basePath ++ [ "pin-ic-grey.svg" ]

        CheckmarkIcon ->
            basePath ++ [ "checkmark-ic.svg" ]

        BreadcrumbIcon component ->
            let
                imageName =
                    case component of
                        PipelineComponent ->
                            "pipeline"

                        JobComponent ->
                            "job"

                        ResourceComponent ->
                            "resource"
            in
            basePath ++ [ "ic-breadcrumb-" ++ imageName ++ ".svg" ]

        PassportOfficerIcon ->
            basePath ++ [ "passport-officer-ic.svg" ]

        ConcourseLogoWhite ->
            basePath ++ [ "concourse-logo-white.svg" ]

        CircleOutlineIcon icon ->
            let
                imageName =
                    case icon of
                        PlayCircleIcon ->
                            "play"

                        PauseCircleIcon ->
                            "pause"

                        AddCircleIcon ->
                            "add"

                        AbortCircleIcon ->
                            "abort"
            in
            basePath ++ [ "ic-" ++ imageName ++ "-circle-outline-white.svg" ]

        CogsIcon ->
            basePath ++ [ "ic-cogs.svg" ]

        RunningLegend ->
            basePath ++ [ "ic-running-legend.svg" ]

        NotBlockingCheckIcon ->
            basePath ++ [ "ic-not-blocking-check.svg" ]

        RerunIcon ->
            basePath ++ [ "ic-rerun.svg" ]

        PendingIcon ->
            basePath ++ [ "ic-pending.svg" ]

        InterruptedIcon ->
            basePath ++ [ "ic-interrupted.svg" ]

        CancelledIcon ->
            basePath ++ [ "ic-cancelled.svg" ]

        SuccessCheckIcon ->
            basePath ++ [ "ic-success-check.svg" ]

        FailureTimesIcon ->
            basePath ++ [ "ic-failure-times.svg" ]

        ExclamationTriangleIcon ->
            basePath ++ [ "ic-exclamation-triangle.svg" ]

        PipelineStatusIcon status ->
            let
                imageName =
                    case status of
                        PipelineStatusPaused ->
                            "ic-pause-blue.svg"

                        PipelineStatusPending _ ->
                            "ic-pending-grey.svg"

                        PipelineStatusSucceeded _ ->
                            "ic-running-green.svg"

                        PipelineStatusFailed _ ->
                            "ic-failing-red.svg"

                        PipelineStatusAborted _ ->
                            "ic-aborted-brown.svg"

                        PipelineStatusErrored _ ->
                            "ic-error-orange.svg"
            in
            basePath ++ [ imageName ]

        ClippyIcon ->
            basePath ++ [ "clippy.svg" ]

        UpArrow ->
            basePath ++ [ "ic-arrow-upward.svg" ]

        DownArrow ->
            basePath ++ [ "ic-arrow-downward.svg" ]

        RefreshIcon ->
            basePath ++ [ "baseline-refresh-24px.svg" ]

        MessageIcon ->
            basePath ++ [ "baseline-message.svg" ]

        HamburgerMenuIcon ->
            basePath ++ [ "baseline-menu-24px.svg" ]

        PeopleIcon ->
            basePath ++ [ "baseline-people-24px.svg" ]

        KeyboardArrowDown ->
            basePath ++ [ "baseline-keyboard-arrow-down-24px.svg" ]

        KeyboardArrowRight ->
            basePath ++ [ "baseline-keyboard-arrow-right-24px.svg" ]

        PlayIcon ->
            basePath ++ [ "ic-play-white.svg" ]

        PauseIcon ->
            basePath ++ [ "ic-pause-white.svg" ]
