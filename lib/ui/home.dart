import '../model/item.dart';
import '../util/database_item_client.dart';
import '../util/database_category_client.dart';
import 'category.dart';

import '../util/date_formatter.dart';
import '../model/category.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController itemController = new TextEditingController();
  var dbi = new DatabaseItemHelper();
  var dbc = new DatabaseCategoryHelper();
  final List<Item> _itemList = <Item>[];
  final List<Category> _categoryList = <Category>[];

  @override
  void initState() {
    _readItemList();
    _readCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            elevation: 0,
            child: Icon(
              Icons.create_new_folder,
              color: Colors.white,
            ),
            onPressed: _addCategoryForm,
            backgroundColor: Color(0xff020E38),
          ),
          SizedBox(
            height: 10,
            width: 10,
          ),
          FloatingActionButton(
            heroTag: null,
            elevation: 0,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: _addTaskForm,
            backgroundColor: Color(0xff020E38),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Color(0xFF020E38),
            child: Container(
              height: 140.0,
              width: 1000,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius:
                    new BorderRadius.only(bottomLeft: Radius.circular(70)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Text(
                  "Tasks.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 70,
                    fontFamily: 'Futura',
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Color(0xFF020E38),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
              ),
            ),
            child: _categoryList.isEmpty
                ? Container(
                    height: 10000,
                    width: 10000,
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 60,
                    ),
                    child: Text(
                      'Empty.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                        fontFamily: 'Futura',
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    itemCount: _categoryList.length,
                    itemBuilder: (_, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryPage()),
                          );
                        },
                        onLongPress: () =>
                            _updateCategoryForm(_categoryList[index], index),
                        child: Container(
                          width: 250.0,
                          height: 250.0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 25),
                          child: DecoratedBox(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: new LinearGradient(
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  const Color(0xff007ECE),
                                  const Color(0xffC418F7),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 30),
                                    child: Text(
                                      _categoryList[index].categoryName,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Futura',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
          ),
          Flexible(
            child: _itemList.isEmpty
                ? Container(
                    width: 10000,
                    height: 10000,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Text(
                      'Empty.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 70,
                        fontFamily: 'Futura',
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(1),
                    reverse: false,
                    itemCount: _itemList.length,
                    itemBuilder: (_, int index) {
                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        child: ListTile(
                          title: _itemList[index],
                          subtitle: Text(_itemList[index].dateCreated),
                          leading: IconButton(
                            icon: _itemList[index].itemDone == 0
                                ? Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.check_circle,
                                    color: Colors.purple,
                                  ),
                            onPressed: () async {
                              if (_itemList[index].itemDone == 0) {
                                Item newItem = _itemList[index];
                                Item oldItem = _itemList[index];
                                newItem.itemDone = 1;
                                _handleSubmittedUpdateItem(index, oldItem);
                                await dbi.updateItem(newItem);
                                setState(() {
                                  _readItemList();
                                });
                              } else {
                                Item newItem = _itemList[index];
                                Item oldItem = _itemList[index];

                                newItem.itemDone = 0;
                                await dbi.updateItem(newItem);
                                _handleSubmittedUpdateItem(index, oldItem);
                                setState(() {
                                  _readItemList();
                                });
                              }
                              // print(_itemList[index].itemDone);
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          onLongPress: () =>
                              _updateTaskForm(_itemList[index], index),
                        ),
                      );
                    },
                  ),
          ),
          Divider(
            height: 1.0,
          )
        ],
      ),
    );
  }

  _readItemList() async {
    List items = await dbi.getItems();
    items.forEach((item) {
      setState(() {
        _itemList.add(Item.map(item));
      });
    });
  }

  _readCategoryList() async {
    List categorys = await dbc.getCategorys();
    categorys.forEach((category) {
      setState(() {
        _categoryList.add(Category.map(category));
      });
    });
  }

  _deleteListItem(int id, int index) async {
    await dbi.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }

  _deleteListCategory(int id, int index) async {
    await dbc.deleteCategory(id);
    setState(() {
      _categoryList.removeAt(index);
    });
  }

  void _addTaskForm() {
    var alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Color(0xFF020E38),
      elevation: 0,
      contentTextStyle: TextStyle(color: Colors.white, fontFamily: 'Futura'),
      title: Center(
        child: Text(
          'Add new task',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Futura',
          ),
        ),
      ),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              style: new TextStyle(color: Colors.white, fontFamily: 'Futura'),
              controller: itemController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Task description here",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Futura',
                ),
                hintStyle: TextStyle(
                  color: Color(0x44FFFFFF),
                ),
                suffixStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Futura',
                ),
                fillColor: Colors.white,
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Futura',
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            if (itemController.text != '') {
              _handleSubmittedItem(itemController.text);
            }
            itemController.clear();
            Navigator.pop(context);
          },
          child: Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Futura',
            ),
          ),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _addCategoryForm() {
    var alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Color(0xFF020E38),
      elevation: 0,
      contentTextStyle: TextStyle(color: Colors.white, fontFamily: 'Futura'),
      title: Center(
        child: Text(
          'Add new category',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Futura',
          ),
        ),
      ),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              style: new TextStyle(color: Colors.white, fontFamily: 'Futura'),
              controller: itemController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Category name here",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Futura',
                ),
                hintStyle: TextStyle(
                  color: Color(0x44FFFFFF),
                ),
                suffixStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Futura',
                ),
                fillColor: Colors.white,
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Futura',
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            if (itemController.text != '') {
              _handleSubmittedCategory(itemController.text);
            }
            itemController.clear();
            Navigator.pop(context);
          },
          child: Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Futura',
            ),
          ),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _updateTaskForm(Item item, int index) {
    itemController.text = item.itemName;
    var alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Color(0xFF020E38),
      elevation: 0,
      contentTextStyle: TextStyle(color: Colors.white, fontFamily: 'Futura'),
      title: Center(
        child: Text(
          'Update task',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Futura',
          ),
        ),
      ),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              style: new TextStyle(color: Colors.white, fontFamily: 'Futura'),
              controller: itemController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Task description here",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Futura',
                ),
                hintStyle: TextStyle(
                  color: Color(0x44FFFFFF),
                ),
                suffixStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Futura',
                ),
                fillColor: Colors.white,
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _deleteListItem(item.id, index);
            Navigator.pop(context);
          },
          child: Text(
            "Delete",
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'Futura',
            ),
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Futura',
            ),
          ),
        ),
        FlatButton(
            onPressed: () async {
              Item newItemUpdated = Item.fromMap(
                {
                  "item_name": itemController.text,
                  "date_created": dateFormatted(),
                  //Kan være problemet med denne under
                  "item_done": item.itemDone,
                  "id": item.id
                },
              );

              _handleSubmittedUpdateItem(index, item);
              await dbi.updateItem(newItemUpdated);
              setState(() {
                _readItemList();
              });

              itemController.clear();
              Navigator.pop(context);
            },
            child: Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Futura',
              ),
            )),
      ],
    );

    showDialog(
      context: context,
      builder: (_) {
        return alert;
      },
    );
  }

  _updateCategoryForm(Category category, int index) {
    itemController.text = category.categoryName;

    var alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Color(0xFF020E38),
      elevation: 0,
      contentTextStyle: TextStyle(color: Colors.white, fontFamily: 'Futura'),
      title: Center(
        child: Text(
          'Update category',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Futura',
          ),
        ),
      ),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              style: new TextStyle(color: Colors.white, fontFamily: 'Futura'),
              controller: itemController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Category name here",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Futura',
                ),
                hintStyle: TextStyle(
                  color: Color(0x44FFFFFF),
                ),
                suffixStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Futura',
                ),
                fillColor: Colors.white,
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _deleteListCategory(category.id, index);
            Navigator.pop(context);
          },
          child: Text(
            "Delete",
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'Futura',
            ),
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Futura',
            ),
          ),
        ),

        /*
Item newItemUpdated = Item.fromMap(
                {
                  "item_name": itemController.text,
                  "date_created": dateFormatted(),
                  "id": item.id
                },
              );

              _handleSubmittedUpdateItem(index, item);
              await dbi.updateItem(newItemUpdated);
              setState(() {
                _readItemList();
              });

              itemController.clear();
              Navigator.pop(context);
        */
        FlatButton(
            onPressed: () async {
              Category newCategoryUpdated = Category.fromMap(
                {
                  "category_name": itemController.text,
                  "id": category.id,
                },
              );

              _handleSubmittedUpdatedCategory(index, category);
              await dbc.updateCategory(newCategoryUpdated);
              setState(() {
                _readCategoryList();
              });
              itemController.clear();
              Navigator.pop(context);
            },
            child: Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Futura',
              ),
            )),
      ],
    );

    showDialog(
      context: context,
      builder: (_) {
        return alert;
      },
    );
  }

  void _handleSubmittedUpdateItem(int index, Item item) {
    setState(() {
      _itemList.removeWhere((element) {
        //   _itemList[index].itemName = item.itemName;
      });
    });
  }

  void _handleSubmittedUpdatedCategory(int index, Category category) {
    setState(() {
      _categoryList.removeWhere((element) {
        //  _categoryList[index].categoryName = category.categoryName;
      });
    });
  }

  void _handleSubmittedItem(String text) async {
    Item item = new Item(text, dateFormatted());
    int savedItemId = await dbi.saveItem(item);
    Item addedItem = await dbi.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
    });
  }

  void _handleSubmittedCategory(String text) async {
    Category category = new Category(text);
    int savedCategoryId = await dbc.saveCategory(category);
    Category addedCategory = await dbc.getCategory(savedCategoryId);

    setState(() {
      _categoryList.insert(0, addedCategory);
    });
  }
}
