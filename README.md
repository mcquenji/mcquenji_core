# McQuenji's Core Module

This is the core module for all my flutter projects. It contains all the basic functionalities that I use in all my projects. It is a work in progress and I will keep updating it as I go along.

## Usage

To use this module in your project, add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  mcquenji_core:
    git:
      url: git://github.com/mcquenji/mcquenji_core.git
```

Then run `flutter pub get` to install the package.

After that, import the module in your app's main module this:

```dart
import 'package:mcquenji_core/mcquenji_core.dart';

class AppModule extends Module {
    @override
    List<Module> get imports => [McQuenjiCore()];
}
```

Now you can use all services and utilities provided by the module in your app.

```dart
final networkService = Modular.get<NetworkService>();

networkService.get('https://api.example.com').then((response) {
    print(response.body);
});
```

## Services

Services are classes that complete the most low-level tasks in the app. They are the only classes that can interact with the outside world. All other classes should depend on services to get their work done.

### Defining a new service

To define a new service, create a new abstract class that extends the `Service` class.

```dart
abstract class MyService extends Service {
    @override
    String get name => 'MyService';

    // Your service implementation here
}
```

After that, create a new class that extends the abstract class and implements the required methods.

```dart
class MyServiceImpl extends MyService {
    @override
    Future<void> init() async {
        // Initialize your service here
    }

    // Implement other methods here
}
```

Finally, register the service in the module the service is used in. If the service is also used in other modules, export it.

```dart
class MyModule extends Module {
    @override
    List<Module> get imports => [McQuenjiCore()];

    @override
    void binds(i){
        i.add<MyService>(MyServiceImpl.new);
    }

    @override
    exportBinds(i) {
        i.add<MyService>(MyServiceImpl.new);
    }
}
```

## Datasources

Datasources are classes that interact with the data layer of the app. They are responsible for fetching and storing data from and to the data layer.

### Defining a new datasource

To define a new datasource, create a new abstract class that extends the `Datasource` class.

```dart
abstract class MyDatasource extends Datasource {
    @override
    String get name => 'MyDatasource';

    MyDatasource(MyService service);

    // Your datasource implementation here
}
```

After that, the steps are the same as defining a new service.

## Repositories

Repositories are classes that provide tailored methods for a specific UI screen or feature. They are also responsible for state management and as extend `Cubit`.

### Defining a new repository

To define a new repository, create a new abstract class that extends the `Repository` class.

```dart
abstract class MyRepository<MyState> extends Repository<MyState> {
    MyRepository(MyService service, MyDatasource datasource) : super(myIntialState);

    // Your repository implementation here
}
```

After that, the steps are the same as defining a new service.
