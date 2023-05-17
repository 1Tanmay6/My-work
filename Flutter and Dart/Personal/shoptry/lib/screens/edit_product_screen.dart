import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/editScreen';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlcontroller = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  bool isInit = true;
  bool _isLoading = false;

  var _editedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');

  var _initValues = {
    'id': '',
    'title': '',
    'description': '',
    'imageUrl': '',
    'price': ''
  };

  @override
  void initState() {
    _imageFocusNode.addListener(() {
      _updateImageURL();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productID = ModalRoute.of(context)!.settings.arguments;
      if (productID != null) {
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findById(productID as String);

        _initValues = {
          'id': productID,
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'imageUrl': '',
          'price': _editedProduct.price.toString(),
        };
        _imageUrlcontroller.text = _editedProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(() {
      _updateImageURL();
    });
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlcontroller.dispose();
    super.dispose();
  }

  void _updateImageURL() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveform() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id as String, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProducts(_editedProduct);
      } catch (onError) {
        await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('An error occured!'),
                content: Text(
                  onError.toString(),
                ),
                actions: [
                  TextButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
              onPressed: (() {
                _saveform();
              }),
              icon: Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _initValues['title'],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value';
                            }
                          },
                          cursorColor: Theme.of(context).primaryColorDark,
                          onSaved: (newValue) {
                            _editedProduct = Product(
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                                title: newValue as String,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: _editedProduct.imageUrl);
                          },
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .primaryColorDark), //<-- SEE HERE
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_priceFocusNode);
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['price'],
                          cursorColor: Theme.of(context).primaryColorDark,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            if (double.parse(value) <= 0) {
                              return 'Please enter value greate than zero';
                            }
                          },
                          onSaved: (newValue) {
                            _editedProduct = Product(
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: double.parse(newValue as String),
                                imageUrl: _editedProduct.imageUrl);
                          },
                          decoration: InputDecoration(
                            labelText: 'Price',
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .primaryColorDark), //<-- SEE HERE
                            ),
                          ),
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _priceFocusNode,
                        ),
                        TextFormField(
                          initialValue: _initValues['description'],
                          cursorColor: Theme.of(context).primaryColorDark,
                          maxLines: 3,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a decription';
                            }
                            if (value.length < 10) {
                              return 'Should be at least 10 carachters';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _editedProduct = Product(
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: newValue as String,
                                price: _editedProduct.price,
                                imageUrl: _editedProduct.imageUrl);
                          },
                          focusNode: _descriptionFocusNode,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .primaryColorDark), //<-- SEE HERE
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 100,
                                margin: EdgeInsets.only(top: 8, right: 10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: _imageUrlcontroller.text.isEmpty
                                    ? Text('Enter a image URL')
                                    : FittedBox(
                                        child: Image.network(
                                          _imageUrlcontroller.text,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextFormField(
                                  controller: _imageUrlcontroller,
                                  onSaved: (newValue) {
                                    _editedProduct = Product(
                                        isFavorite: _editedProduct.isFavorite,
                                        id: _editedProduct.id,
                                        title: _editedProduct.title,
                                        description: _editedProduct.description,
                                        price: _editedProduct.price,
                                        imageUrl: newValue as String);
                                  },
                                  cursorColor:
                                      Theme.of(context).primaryColorDark,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please provide a image URL';
                                    }
                                    if (!value.startsWith('http') ||
                                        !value.startsWith('https')) {
                                      return 'Please enter a valid URL';
                                    }
                                    if (!value.endsWith('.jpg') &&
                                        !value.endsWith('.png') &&
                                        !value.endsWith('.jpeg')) {
                                      return 'Image should of format ".jpg, .png or .jpeg"';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Image URL',
                                    labelStyle: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorDark), //<-- SEE HERE
                                    ),
                                  ),
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  focusNode: _imageFocusNode,
                                  onFieldSubmitted: ((_) => _saveform()),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
    );
  }
}
