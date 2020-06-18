import 'package:catatudo_app/core/services/api.dart';
import 'package:catatudo_app/core/services/authentication.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  Provider(create: (_) => Api()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(
      update: (context, api, authenticationService) =>
          AuthenticationService(api: api)),
  ChangeNotifierProvider<UserModel>(
      create: (context) =>
          UserModel(api: Provider.of<Api>(context, listen: false))),
];
