import 'dart:io';
import 'package:catatudo_app/core/models/user.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:catatudo_app/ui/widgets/profile_page/edit_profile_form.dart';
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

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);

    this.user = userModel.user;

    _ctlName.text = user.name;
    _ctlEmail.text = user.email;
    _ctlPhone.text = user.phone;

    // print(widget.address.toJson());
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Editar Perfil'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              iconSize: 30,
              onPressed: () {
                // userModel.deleteAddress(address);
                Navigator.pop(context);
              }),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Visibility(
        visible: !userModel.busy,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _imagePerfil(),
                    Text(
                      'Editar imagem',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13, color: Theme.of(context).primaryColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            _getNewImage(ImageSource.gallery, context: context);
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
                            _getNewImage(ImageSource.camera, context: context);
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
                            image: (_imageFile == null)
                                ? null
                                : File(_imageFile.path))
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
    );
  }

  Widget _appBar(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(55)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 0.5),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top),
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          Padding(
            padding: EdgeInsets.only(left: 35, right: 20),
            child: Text(
              'Editar Perfil',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePerfil() {
    if (user.image == null) {
      return Text('No Image Selected');
    } else if (_isPicked) {
      return Container(
        alignment: Alignment.center,
        width: 180,
        height: 180,
        child: _previewImage(),
      );
    } else {
      return Container(
        width: 180,
        height: 180,
        child: Image.network(user.image),
      );
    }
  }

  void _getNewImage(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
        maxWidth: 200.0,
        maxHeight: 200.0,
      );
      setState(() {
        _imageFile = pickedFile;
        _isPicked = true;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
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
