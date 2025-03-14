# Changelog

All notable changes to this project will be documented in this file. See [commit-and-tag-version](https://github.com/absolute-version/commit-and-tag-version) for commit guidelines.

## [4.0.0](https://github.com/mcquenji/mcquenji_core/compare/v3.0.0...v4.0.0) (2025-03-14)


### ⚠ BREAKING CHANGES

* ILoggable has been renamed to Loggable
* BuildTrigger has been renamed to Trigger

### Features

* add async repo completers ([3c10380](https://github.com/mcquenji/mcquenji_core/commit/3c10380e2a7c2c07d4eeed1ed68295843f3854a3))
* add middleware logging ([91146d6](https://github.com/mcquenji/mcquenji_core/commit/91146d676061811f7c920c043247f79b253e9ab7))
* implement async completers ([51467d9](https://github.com/mcquenji/mcquenji_core/commit/51467d9bb2522db0fc1a711246dcbf67a606331a))

## [3.0.0](https://github.com/mcquenji/mcquenji_core/compare/v2.0.0...v3.0.0) (2025-02-18)


### ⚠ BREAKING CHANGES

* deprecate NwtkService.timout

### Features

* **core:** add initialization callback for Dio instance configuration ([1f9fa85](https://github.com/mcquenji/mcquenji_core/commit/1f9fa85b9722c7cac7809fa7931c26e48671672d))


### Bug Fixes

* deprecate NwtkService.timout ([411818b](https://github.com/mcquenji/mcquenji_core/commit/411818bdf84f51a989eb685b29042f053353cb32))

## [2.0.0](https://github.com/mcquenji/mcquenji_core/compare/v1.2.0...v2.0.0) (2025-02-06)


### ⚠ BREAKING CHANGES

* use a dedicated class as build trigger

### Features

* **repository:** refine refresh optimization algorithm and make it opt in ([2b44bae](https://github.com/mcquenji/mcquenji_core/commit/2b44baeb64364f1c7c33655a5b8c985b2db79453))
* use a dedicated class as build trigger ([21221e7](https://github.com/mcquenji/mcquenji_core/commit/21221e723619f2774650d852cb29a1b5b2217f31))


### Bug Fixes

* prevent automatic updates if the last update was too recent ([d76a86b](https://github.com/mcquenji/mcquenji_core/commit/d76a86b3d8b94270d3b7581f1132977ca8d8ae1f))

## [1.2.0](https://github.com/mcquenji/mcquenji_core/compare/v1.1.0...v1.2.0) (2025-01-02)


### Features

* add AsyncValue class inspired by riverpod ([0e0ecf8](https://github.com/mcquenji/mcquenji_core/commit/0e0ecf8a33647f5a6f5c2714fb04195469766dcc))
* add colored debug messages ([b4e7657](https://github.com/mcquenji/mcquenji_core/commit/b4e7657e0960dc6a9319bdd90a237a5bb443a606))
* add cubit config ([c20627b](https://github.com/mcquenji/mcquenji_core/commit/c20627b63ba2751c2aefedf8a77854739d9b2100))
* add debug log handler ([0584e7c](https://github.com/mcquenji/mcquenji_core/commit/0584e7c8353209703aff50f8fe4188f685080b1c))
* add declrataive padding ([09bf45f](https://github.com/mcquenji/mcquenji_core/commit/09bf45f49afff62a6f0fa6ea96ac36455d64e2d5))
* add expressive text and spacing ([8a1760c](https://github.com/mcquenji/mcquenji_core/commit/8a1760c133d75477212680b3c9b4f648dda58e6c))
* add hooks to AsyncValue.guard ([7861954](https://github.com/mcquenji/mcquenji_core/commit/786195449d80e9ab064c79018fb9dd14ed32db04))
* add IGenericJsonSerializer ([35cf12b](https://github.com/mcquenji/mcquenji_core/commit/35cf12b88e50f1e4945bb2ba1fd9e51498666ffa))
* add IGenericSerializer ([b1158ab](https://github.com/mcquenji/mcquenji_core/commit/b1158abe332fd05f31aed575fffbf8e67a0d73c7))
* add join to AsyncValue ([d00a080](https://github.com/mcquenji/mcquenji_core/commit/d00a080030dd0f4c816c5914e9ec0c5a6949fe44))
* add json typedef ([e1d577b](https://github.com/mcquenji/mcquenji_core/commit/e1d577b5b7cf2d386e4c57c5d9b32cb696b685f1))
* add requireData to AsyncValue ([fb59fa1](https://github.com/mcquenji/mcquenji_core/commit/fb59fa189def57649a72c2a0335e2a7d582df51b))
* **connectivity:** add updateInterval to ConnectivityService and update references ([a6a21fb](https://github.com/mcquenji/mcquenji_core/commit/a6a21fb752a5e123e2897e56f226b8d7e7e02437))
* implement JsonConverter in IGenericSerializer ([f1cf656](https://github.com/mcquenji/mcquenji_core/commit/f1cf6563c598451ddd04060f9190c29fab58cc6f))
* **logging:** implement and add debug/release log handlers ([fe26fed](https://github.com/mcquenji/mcquenji_core/commit/fe26fed7d9201b18982dad81c2d93ab1f87e5a8d))
* **presentation:** add hoverable widgets ([c907e41](https://github.com/mcquenji/mcquenji_core/commit/c907e41d9ffe273d952751c3f948f2997d92cabc))
* **presentation:** add InitialRouterOutlet ([b2e32a6](https://github.com/mcquenji/mcquenji_core/commit/b2e32a66dfc5659778cf1ed9cf2c68313b96fe76))
* **presentation:** add more widget utils ([428e646](https://github.com/mcquenji/mcquenji_core/commit/428e646d2a4ce3f180c1f34de9014ba4023b69e8))
* **presentation:** add padding to stretch method ([6a40bbe](https://github.com/mcquenji/mcquenji_core/commit/6a40bbe172a51a019e168929e24f882ee57ad0bd))
* remove flutter specific utils & widgets ([bf83bf6](https://github.com/mcquenji/mcquenji_core/commit/bf83bf64856736f259e39af0586e3b1811c0b1f1))
* **repositories:** add AsyncRepoExt ([9c5bb17](https://github.com/mcquenji/mcquenji_core/commit/9c5bb177534289131bfb0c899751bb67007f7b0a))
* **repositories:** add guard util method ([919dd15](https://github.com/mcquenji/mcquenji_core/commit/919dd15bc1bf7b38a44fe1c0a3ae1d47f8df8028))
* **repositories:** add utility methods for watching repositories ([961462b](https://github.com/mcquenji/mcquenji_core/commit/961462bb314ad07e86cbd16fc68f33ec60781ffa))
* **repositories:** add utils for working with repos ([e37be71](https://github.com/mcquenji/mcquenji_core/commit/e37be71c7af2717d875b0959c17f4467043cc859))
* **repository:** add updateInterval support for automatic updates and deprecate TickRepository ([4013559](https://github.com/mcquenji/mcquenji_core/commit/4013559c5b4635a83ade663a189b34f6469e297b))
* **repository:** enhance automatic update logging in update loop ([a37ed98](https://github.com/mcquenji/mcquenji_core/commit/a37ed988ef62ccccad3dafd08eb910e5bb3512cf))
* **services:** add interceptor support to network service ([904e7cb](https://github.com/mcquenji/mcquenji_core/commit/904e7cb09b6f138402db7ad9d6c9fd5ec988247c))
* **services:** add logging to dispsose method ([3e4400a](https://github.com/mcquenji/mcquenji_core/commit/3e4400a0c37515e2dbfb934b186dc5b09673da9b))
* **services:** add network service timeout ([da3b997](https://github.com/mcquenji/mcquenji_core/commit/da3b99775c14050b6cef8301752423ced5400d9d))
* **utils:** add insert between to iterable ([8c44f4a](https://github.com/mcquenji/mcquenji_core/commit/8c44f4ae3a418fc1338df8757548bd9b7ac8b309))
* **utils:** add spacing util to widget list ([4956abe](https://github.com/mcquenji/mcquenji_core/commit/4956abee01a5153d10af3b1919ac5ddc1237f309))


### Bug Fixes

* add body to exception in raiseForStatusCode ([a03dfb7](https://github.com/mcquenji/mcquenji_core/commit/a03dfb798a1df9437433a094f2c6e38a00393814))
* add SpacingIntExt ([cda1267](https://github.com/mcquenji/mcquenji_core/commit/cda126741926ad7ef1e4e67583b2c9aaa4400a25))
* change log levels ([c3ea987](https://github.com/mcquenji/mcquenji_core/commit/c3ea987be1416952cc2d8b8087ab4260ca5ef938))
* change log levels ([54f09c0](https://github.com/mcquenji/mcquenji_core/commit/54f09c0fd16d55d48373ddef46ad719cbb2cbd0e))
* change logging colors ([2422b75](https://github.com/mcquenji/mcquenji_core/commit/2422b75be76fccd6bbe07fb3a9abdeff74334867))
* export widget_utils ([e04958f](https://github.com/mcquenji/mcquenji_core/commit/e04958f6dd33cffc0abe0eedc35d85c61a8e3c48))
* **logging:** adjust RGB values for log level colors ([832d9fd](https://github.com/mcquenji/mcquenji_core/commit/832d9fd869109c17a7bfcbc12081738531151a42))
* **logging:** update color for INFO log level and enhance SHOUT log level styling ([7522ab9](https://github.com/mcquenji/mcquenji_core/commit/7522ab9019a9bab45908a47513b1ff43f2cb917d))
* **logging:** update RGB values for FINEST and FINE log levels ([0990243](https://github.com/mcquenji/mcquenji_core/commit/099024327f6584fa7c3808e8628503f0c177f1b3))
* **logging:** update RGB values for INFO, WARNING, and SEVERE log levels ([8e6f7cb](https://github.com/mcquenji/mcquenji_core/commit/8e6f7cbab53b6b47ec5e3e699a670a7e5ed3531a))
* **logging:** update RGB values for log level colors II ([56fff46](https://github.com/mcquenji/mcquenji_core/commit/56fff46f956ac81a423f87a13827dacbf8a83c4d))
* make base class for declarative padding public ([096df94](https://github.com/mcquenji/mcquenji_core/commit/096df94c1549f2d0b5e6ed8cc6bd052979758f2d))
* make data sources and repositories disposable ([40bd388](https://github.com/mcquenji/mcquenji_core/commit/40bd388cbb391a7f32ae7643980e6f5a144db4ba))
* make ILoggable const ([2ff9253](https://github.com/mcquenji/mcquenji_core/commit/2ff92532a3a78f7cd6d9349cf3693ae4bf24cb2f))
* **presentation:** export routing_utils.dart ([367f78b](https://github.com/mcquenji/mcquenji_core/commit/367f78bc379f752fd5fd3ba93d55c6d0faed5e2c))
* **presentation:** sanitize paths for InitialRouterOutlet ([5e04db6](https://github.com/mcquenji/mcquenji_core/commit/5e04db6ad6dc3d1f452bfcfe478638f19d4c85ff))
* remove flutter from dependencies ([308f55c](https://github.com/mcquenji/mcquenji_core/commit/308f55cc8634162f3c9d50f42e9f40e515c3ddbb))
* remove newlines from debug log messages ([9668270](https://github.com/mcquenji/mcquenji_core/commit/96682701432810b3aaa667cd24213eb4855c995e))
* **repositories:** accept repositories with parameters ([8f53f5d](https://github.com/mcquenji/mcquenji_core/commit/8f53f5dbbe150d3ab2d594eee237ffa28f0f5ecb))
* **repositories:** add logging hooks ([eda7f3a](https://github.com/mcquenji/mcquenji_core/commit/eda7f3a34505a82a7880653608761323b42d7a46))
* **repositories:** add proper name of cubitConfig replacement ([d818821](https://github.com/mcquenji/mcquenji_core/commit/d8188216aa86c7504bd8269b92c1b5d463c1c80f))
* **repositories:** add stream to bind config ([bf88af8](https://github.com/mcquenji/mcquenji_core/commit/bf88af8dc622a32290f31e923bd3c01b1892addd))
* **repositories:** adjust repo log levels ([74ca3e4](https://github.com/mcquenji/mcquenji_core/commit/74ca3e4d786d4fbf2cc70f0e1331c68af4049290))
* **repositories:** change deprecation notice of cubitConfig ([d09f066](https://github.com/mcquenji/mcquenji_core/commit/d09f0662a066d61baed5fe85d5b6bbfe4ead422d))
* **repositories:** Change Repository from mixin to cubit ([8158164](https://github.com/mcquenji/mcquenji_core/commit/8158164b138aa4b3ca97f7d59045e2f4f62c44e9))
* **repositories:** register type of concrete repo ([8adba7c](https://github.com/mcquenji/mcquenji_core/commit/8adba7c8d0b86499b9146cba0eacc6d5d17ca236))
* **repositories:** remove state type from addRepository ([cd355e8](https://github.com/mcquenji/mcquenji_core/commit/cd355e8c4db560e3d7ad68a65f2347b7dcf4d318))
* **repository:** handle exceptions during repository build process ([3ef0255](https://github.com/mcquenji/mcquenji_core/commit/3ef02558e7b2f4bae998a9508ba271d11571cf49))
* **repository:** log updateInterval in milliseconds for automatic updates ([f0bc65b](https://github.com/mcquenji/mcquenji_core/commit/f0bc65b08a945b94b0576563f664b571f2b861e6))
* **services:** add dio base options ([acd8a34](https://github.com/mcquenji/mcquenji_core/commit/acd8a340b56ce93f4acab0c3403bdd02a65a9776))
* **services:** assume online when WebConnectivitiyService boots up ([4b51df4](https://github.com/mcquenji/mcquenji_core/commit/4b51df46344a9b11c545a3b0a459c45948853826))
* **services:** assume user is online on creation ([593561d](https://github.com/mcquenji/mcquenji_core/commit/593561d603870820bca1be7b7819cfe9c5c72933))
* **services:** change type of base options for dio ([2a39623](https://github.com/mcquenji/mcquenji_core/commit/2a396233fb8139fc56938477088454c6776f1cd5))
* **services:** fix connectivitiy service for web ([3d5e160](https://github.com/mcquenji/mcquenji_core/commit/3d5e160d7c7029866556d5728be97bc47a4727d8))
* **services:** make base options non null ([aca9012](https://github.com/mcquenji/mcquenji_core/commit/aca901270b1461012999d88d5a54240b243976a2))
* **services:** remove dio base options ([3b99298](https://github.com/mcquenji/mcquenji_core/commit/3b99298fe2cb517a928300927d88cdda09003c4c))
* stop dio from throwing errors for status codes ([a2b1057](https://github.com/mcquenji/mcquenji_core/commit/a2b1057ac13ab75b2526101dc59ebeb8d8262af6))
* the second ([b615144](https://github.com/mcquenji/mcquenji_core/commit/b61514443aecd77c2d5672ca2091b20364c7f8a9))
* the third ([39c9cd3](https://github.com/mcquenji/mcquenji_core/commit/39c9cd3aaf055224165a91f6b695aef3cb71d98e))
* update documentation URL in dartdoc_options ([1521f33](https://github.com/mcquenji/mcquenji_core/commit/1521f3353212aa47079dc314a3df119a45abd2fd))
* use lambda expression for base options ([503fb78](https://github.com/mcquenji/mcquenji_core/commit/503fb787aee19d239f255ee03eb5d76c7ed289a1))
* **web_connectivity:** change pingAddress to root path for connectivity checks ([b7c71ff](https://github.com/mcquenji/mcquenji_core/commit/b7c71ffc6a1000c8b402558f371ae24eec0d4f5c))
* wrong return types in IGenericSerializer ([9ddce3d](https://github.com/mcquenji/mcquenji_core/commit/9ddce3d76f3e42d9a122bf0862731a4a455e6801))

### [1.1.3](https://github.com/mcquenji/mcquenji_core/compare/v1.1.2...v1.1.3) (2024-05-13)


### Bug Fixes

* make data sources and repositories disposable ([40bd388](https://github.com/mcquenji/mcquenji_core/commit/40bd388cbb391a7f32ae7643980e6f5a144db4ba))

### [1.1.2](https://github.com/mcquenji/core/compare/v1.1.1...v1.1.2) (2024-05-11)

### [1.1.1](https://github.com/mcquenji/core/compare/v1.1.0...v1.1.1) (2024-05-11)


### Bug Fixes

* **repositories:** Change Repository from mixin to cubit ([8158164](https://github.com/mcquenji/core/commit/8158164b138aa4b3ca97f7d59045e2f4f62c44e9))

## 1.1.0 (2024-05-11)


### Features

* Add infrastructure for logging ([d8628e6](https://github.com/mcquenji/core/commit/d8628e6b3e26a337f032b3c0605bd6beb56c102d))
* **services:** Add NetworkService ([036b3a3](https://github.com/mcquenji/core/commit/036b3a377884075fced2e936eee9d7d774851368))
* **services:** Impement ConnectivityService ([8902a8a](https://github.com/mcquenji/core/commit/8902a8ae2acd9bdda398a6646bf7bf926019fab4))


### Bug Fixes

* **services:** Export services in core module ([e6bf55b](https://github.com/mcquenji/core/commit/e6bf55b48cc08e9461a21b14516d0ceceb052e0f))
