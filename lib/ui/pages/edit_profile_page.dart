import 'dart:io';
import 'package:catatudo_app/core/models/user.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:catatudo_app/ui/widgets/profile_page/edit_profile_form.dart';
import 'package:catatudo_app/ui/widgets/shared/default_app_bar.dart';
import 'package:catatudo_app/ui/widgets/shared/default_button.dart';
import 'package:catatudo_app/ui/widgets/shared/widget_loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  var _ctlName = new TextEditingController();
  var _ctlEmail = new TextEditingController();
  var _ctlPhone = new TextEditingController();

  User user;

  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  String _retrieveDataError;
  bool _isPicked = false;
  dynamic _pickImageError;
  File _image;

  /// Função para pegar a nova imagem
  Future _getNewImage(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setState(() {
        _image = File(pickedFile.path);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  /// carregar a imagem Selecionada
  Widget _imagePerfil() {
    return Center(
      child: _image == null
          ? Text('Nenhuma imagem selecionada')
          : Image.file(_image),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);

    this.user = userModel.user;

    _ctlName.text = user.name;
    _ctlEmail.text = user.email;
    _ctlPhone.text = user.phone;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: <Widget>[
            DefaultAppBar(
              title: 'Editar Perfil',
              subTitle: 'Atualize suas informações',
            ),
            Expanded(
              child: Visibility(
                visible: !userModel.busy,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10),
                            Container(
                              height: 250.0,
                              width: 250.0,
                              child: (user.image == null || _image != null)
                                  ? _imagePerfil()
                                  : Image.network(user.image),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Editar imagem',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).primaryColor),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    _getNewImage(ImageSource.gallery,
                                        context: context);
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(Icons.photo_library),
                                      Text('Galeria')
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                FlatButton(
                                  onPressed: () {
                                    _getNewImage(ImageSource.camera,
                                        context: context);
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(Icons.camera_alt),
                                      Text('Foto')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            EditProfileForm(
                              formKey: this._formKey,
                              ctlName: this._ctlName,
                              ctlEmail: this._ctlEmail,
                              ctlPhone: this._ctlPhone,
                            ),
                            SizedBox(height: 40),
                            OutlineButton.icon(
                                label: new Text('Excluir conta'),
                                icon: Icon(Icons.delete),
                                textColor: Colors.red,
                                color: Colors.red,
                                highlightedBorderColor: Colors.red[900],
                                borderSide: new BorderSide(color: Colors.red),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                                onPressed: () {
                                  print('Apagar Perfil');
                                }),
                            SizedBox(height: 210),
                          ],
                        ),
                      ),
                    ),
                    DefaultButton(
                        texto: 'Salvar',
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            userModel
                                .editUserProfile(
                                    name: _ctlName.text,
                                    email: _ctlEmail.text,
                                    phone: _ctlPhone.text,
                                    image: (_image == null)
                                        ? null
                                        : File(_image.path))
                                .then((edited) {
                              if (edited) {
                                Navigator.pop(context);
                              } else {
                                ///FIXME:Ajustar o retorno dos erros
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text(userModel.error.message),
                                    content: Text(userModel.error.description),
                                  ),
                                );
                              }
                            });
                          }
                        }),
                  ],
                ),
                replacement: Loading(
                  texto: 'Salvando o perfil...',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImage() {
    print('PREVIW IMAGE');
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      if (kIsWeb) {
        return Image.network(_imageFile.path);
      } else {
        return Image.file(File(_imageFile.path));
      }
    } else if (_pickImageError != null) {
      return Text(
        'erro ao pegar image: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'Nenhuma imagem foi selecionada.',
        textAlign: TextAlign.center,
      );
    }
  }
}
