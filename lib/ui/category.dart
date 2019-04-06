import 'package:flutter/material.dart';

import '../model/category.dart';

class CategoryPage extends StatefulWidget {
  final Category category;
  CategoryPage(this.category);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
        onPressed: () {},
        backgroundColor: Color(0xff020E38),
      ),
      body: Column(children: <Widget>[
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
          decoration: BoxDecoration(
            color: Color(0xFF020E38),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70),
            ),
          ),
        )
      ]),
    );
  }

/*
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
*/

  /*
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
  */

  /*
 _deleteListItem(int id, int index) async {
    await dbi.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }
  */

/*
 _readItemList() async {
    List items = await dbi.getItems();
    items.forEach((item) {
      setState(() {
        _itemList.add(Item.map(item));
      });
    });
  }
*/

/*
void _handleSubmittedUpdateItem(int index, Item item) {
    setState(() {
      _itemList.removeWhere((element) {
        //   _itemList[index].itemName = item.itemName;
      });
    });
  }
*/

/*
void _handleSubmittedItem(String text) async {
    Item item = new Item(text, dateFormatted());
    int savedItemId = await dbi.saveItem(item);
    Item addedItem = await dbi.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
    });
  }
*/

}
