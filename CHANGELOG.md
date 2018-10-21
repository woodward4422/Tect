---
title: Changelog
---
Changelog for MapsIndoors for iOS. This document structure is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and the project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

<!---
## [Unreleased]
### Added
### Fixed
### Changed
### Removed
-->

## [2.1.2] 2018-10-10
### Fixed
- Fixed a Route Rendering issue causing it not to fit path shape properly
- Fixed bug that was causing an occasional malformatted url for the Google directions service.
- MapsPeople logo was misplaced on recent iPhone models. Now aligned to the Google Maps logo.
- Content type validations on some internal endpoints
- Improved the building selection triggered on camera change
- Fixed resetting marker map from non-ui thread that sometimes lead to a crash
- Fixed crash that was caused by GMSProjection occasionally not being in an operational state
### Added
- Support for multi-polygon floor geometry
- Respect larger (accessibility) font sizes, triggered automatically.
- Added some more internal data validation to the MPLocation


## [2.1.1] 2018-09-07
### Fixed
- Fixed an issue where occasionally rendered routes where not fitted properly inside the screen.
- Fixed an issue where occasionally the selected location and search results would fail to appear.
- Heading indicator on the "my position" marker is now only shown when heading data is available; would point straight north previously.

## [2.1.0] 2018-08-21
### Changed
- Changed how icons and labels are shown on the map, so that no labels or icons are shown on top of each other (Icon & label collision handling)
- Now supporting different icon sizes as recieved from CMS
- Now able to show outlines of rooms and areas if the dataset is prepared for this
### Added
- Basic voiceover/accessibility support.
### Fixed
- Fixed MPLocationQuery.orderBy was not respected.

## [2.0.4] 2018-06-27
### Fixed
- Fixed a major bug that caused the generated Swift interface in XCode to expose assumed nonnull properties in various areas of the interface
- Fixed an issue that was causing `MPDirectionsService` to return routes with duplicate legs for some routes between different venues
- Fixed an issue where in rare cases one of the internal callbacks in MapControl was not called causing the map to not fire the optional `[MPMapControlDelegate mapContentReady]`
### Changed
- A lot of properties have now become nullable because of the FIX needed above

## [2.0.3] 2018-06-15
### Fixed
- Fixed logic that selects the current building in focus
- POI Labels were not shown on the map
- Selected location not cleared after clearing map `-[MPMapControl clearMap]`.
- Fixed route animation graphics glitch
- Fixed casing intolerance when retrieving route networks for route calculation
- Fixed internal geometry calculation that could cause `MPDirectionsRenderer` to crash when rendering
- Fixed inconsistent map search state caused by passing zero length array to `MPMapControl.searchResult`
### Changed
- Improved map graphics used for cases when there are no bundled map graphics
- Improved Google Maps directions integration / handover from Google Maps to MapsIndoors
- Animation speed when showing directions is now adapting the the amount of movement and rotation needed for transitioning between steps.
- Moved MapsPeople logo to the lower right side of the map.

## [2.0.2-rc1] 2018-05-02
### Added
### Fixed
- Fixed logic that selects the current building in focus
### Changed
- Improved map graphics used for cases when there are no bundled map graphics
- Improved Google Maps directions integration / handover from Google Maps to MapsIndoors
### Removed

## [2.0.1-rc6] 2018-05-02
### Added
### Fixed
- POI Labels were not shown on the map.
- Selected location not cleared after clearing map `-[MPMapControl clearMap]`.
### Changed
- Animation speed when showing directions is now adapting the the amount of movement and rotation needed for transitioning between steps.
### Removed

## [2.0.0] 2018-04-10
### Added
- On-device route calculation optionally with routing-data embedded into the app.
- Fetching of all MapsIndoors content now possible using `[MapsIndoors synchroniseContent:]`
- Fetching and bundling of all MapsIndoors content now possible using build run script phase
- On-device route calculation optionally with routing-data embedded into the app.
- Fetching of all MapsIndoors content now possible using `[MapsIndoors synchroniseContent:]`

### Fixed
- Performance improvements by delegating image rendering to background queue.
- Improvements in CPU load and battery consumption.
- MPDirectionsRenderer: exposed a property to indicate whether a route is rendered or not.
- Less strict internal data parsing, ensuring that some location properties can be omitted
- Fixed an error where directions service would crash if no API key was properly set
- Fixed an error where map graphics was not loaded properly
- Fixed an error where updating of a display rule would unintentionally persist across initialisations of `MPMapControl`
- Fixed an error where fetching of messages failed because of mal-formatted language
- Fixed callback issues when calling multiple route requests simultaneously
- Fixed an error where directions service would crash if no API key was properly set
- Fixed an error where map graphics was not loaded properly
- Fixed an error where updating of a display rule was persistent across initialisations of `MPMapControl`
- Fixed an error where fetching of messages failed because of mal-formatted language
- Fixed callback issues when calling multiple route requests simultaneously

### Changed
- Changed initialisation steps, see [Getting Started](https://mapsindoors.github.io/ios/v2)
- Added `MPDirectionsQuery` and new method to query routes on `MPDirectionsService`
- Deprecations introduced on various methods
- Deprecations introduced on various UI controls
- Added `MPDirectionsQuery` and new method to query routes on `MPDirectionsService`
- Deprecations introduced on various UI controls
- Deprecations introduced on various methods

### Removed
- All beacon positioning related logic (moved to public app code)
- Made peripheral code private that was public before
- All beacon positioning related logic (moved to public app code)
- Made peripheral code private that was public before

