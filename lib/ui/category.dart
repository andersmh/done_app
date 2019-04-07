import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../util/database_category_item_client.dart';
import '../model/category_item.dart';
import '../model/category.dart';
import '../util/date_formatter.dart';

class CategoryPage extends StatefulWidget {
  final Category categoryObject;

  const CategoryPage(this.categoryObject);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController itemController = new TextEditingController();
  var dbci = new DatabaseCategoryItemHelper();
  final List<CategoryItem> _categoryItemList = <CategoryItem>[];

  @override
  void initState() {
    _readCategoryItemList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        elevation: 0,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          _addCategoryItemForm();
        },
        backgroundColor: Color(0xff020E38),
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
            height: 140,
            width: 1000,
            decoration: BoxDecoration(
              color: Color(0xFF020E38),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 30,
              ),
              child: AutoSizeText(
                widget.categoryObject.categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                  fontFamily: 'Futura',
                ),
                maxLines: 2,
              ),
            ),
          ),
          Flexible(
            child: _categoryItemList.isEmpty
                ? Container(
                    width: 10000,
                    height: 10000,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                    itemCount: _categoryItemList.length,
                    itemBuilder: (_, int index) {
                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        child: ListTile(
                          title: _categoryItemList[index],
                          subtitle: Text(_categoryItemList[index].dateCreated),
                          leading: IconButton(
                            icon: _categoryItemList[index].categoryItemDone == 0
                                ? Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.check_circle,
                                    color: Colors.purple,
                                  ),
                            onPressed: () async {
                              if (_categoryItemList[index].categoryItemDone ==
                                  0) {
                                CategoryItem newItem = _categoryItemList[index];
                                CategoryItem oldItem = _categoryItemList[index];
                                newItem.categoryItemDone = 1;
                                _handleSubmittedUpdateCategoryItem(
                                    index, oldItem);
                                await dbci.updateCategoryItem(newItem);
                                setState(() {
                                  _readCategoryItemList();
                                });
                              } else {
                                CategoryItem newItem = _categoryItemList[index];
                                CategoryItem oldItem = _categoryItemList[index];

                                newItem.categoryItemDone = 0;
                                await dbci.updateCategoryItem(newItem);
                                _handleSubmittedUpdateCategoryItem(
                                    index, oldItem);
                                setState(() {
                                  _readCategoryItemList();
                                });
                              }
                              // print(_itemList[index].itemDone);
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          onLongPress: () => _updateCategoryItemForm(
                              _categoryItemList[index], index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _addCategoryItemForm() {
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
              _handleSubmittedCategoryItem(itemController.text);
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

  _updateCategoryItemForm(CategoryItem item, int index) {
    itemController.text = item.categoryItemName;
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
            _deleteListCategoryItem(item.id, index);
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
              CategoryItem newItemUpdated = CategoryItem.fromMap(
                {
                  "category_item_name": itemController.text,
                  "date_created": dateFormatted(),
                  //Kan være problemet med denne under
                  "category_item_done": item.categoryItemDone,
                  "category_nr": widget.categoryObject.id,
                  "id": item.id
                },
              );

              _handleSubmittedUpdateCategoryItem(index, item);
              await dbci.updateCategoryItem(newItemUpdated);
              setState(() {
                _readCategoryItemList();
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

  _deleteListCategoryItem(int id, int index) async {
    await dbci.deleteCategoryItem(id);
    setState(() {
      _categoryItemList.removeAt(index);
    });
  }

  _readCategoryItemList() async {
    List items = await dbci.getCategoryItems(widget.categoryObject.id);
    items.forEach((item) {
      setState(() {
        _categoryItemList.add(CategoryItem.map(item));
      });
    });
  }

  void _handleSubmittedUpdateCategoryItem(int index, CategoryItem item) {
    setState(() {
      _categoryItemList.removeWhere((element) {
        //   _itemList[index].itemName = item.itemName;
      });
    });
  }

  void _handleSubmittedCategoryItem(String text) async {
    CategoryItem item =
        new CategoryItem(text, dateFormatted(), widget.categoryObject.id);
    int savedItemId = await dbci.saveCategoryItem(item);
    CategoryItem addedItem = await dbci.getCategoryItem(savedItemId);

    setState(() {
      _categoryItemList.insert(0, addedItem);
    });
  }
}
