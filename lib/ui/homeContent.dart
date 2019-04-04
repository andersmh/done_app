import '../model/item.dart';
import '../util/database_client.dart';
import '../util/date_formatter.dart';
import 'package:flutter/material.dart';

class HomeContentPage extends StatefulWidget {
  @override
  _HomeContentPageState createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  final _textEditingController = new TextEditingController();
  var db = new DatabaseHelper();
  final List<Item> _itemList = <Item>[];

  @override
  void initState() {
    _readItemList();
  }

  void _handleSubmitted(String text) async {
    Item item = new Item(text, dateFormatted());
    int savedItemId = await db.saveItem(item);
    Item addedItem = await db.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            color: Color(0xFF020E38),
            child: Container(
              height: 110.0,
              width: 1000,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius:
                    new BorderRadius.only(bottomLeft: Radius.circular(70)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              children: <Widget>[
                myCategory('Physics Assignemt Questions'),
                myCategory('Clean The House Tasks By Room'),
                myCategory('Fix The Car One Part At The Time'),
                myCategory('Countrys To Visit Before I Die'),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
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
                      icon: Icon(
                        Icons.check_circle_outline,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    onLongPress: () => _updateItem(_itemList[index], index),
                    trailing: Listener(
                      key: Key(_itemList[index].itemName),
                      child: Icon(Icons.delete, color: Colors.black),
                      onPointerDown: (pointerEvent) =>
                          _deleteListItem(_itemList[index].id, index),
                    ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showFormDialog,
        tooltip: "Add Task",
        backgroundColor: Color(0xff020E38),
        child: ListTile(
          title: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  void _showFormDialog() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "Task",
                  hintText: "Task description here",
                  icon: Icon(Icons.note_add)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (_textEditingController.text != '') {
              _handleSubmitted(_textEditingController.text);
            }
            _textEditingController.clear();
            Navigator.pop(context);
          },
          child: Text("Save"),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _readItemList() async {
    List items = await db.getAllItems();
    items.forEach((item) {
      setState(() {
        _itemList.add(Item.map(item));
      });
    });
  }

  _deleteListItem(int id, int index) async {
    await db.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }

  _updateItem(Item item, int index) {
    var alert = AlertDialog(
      title: Text("Update Item"),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "Task",
                  hintText: "Task description here",
                  icon: Icon(Icons.update)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () async {
              Item newItemUpdated = Item.fromMap(
                {
                  "itemName": _textEditingController.text,
                  "dateCreated": dateFormatted(),
                  "id": item.id
                },
              );

              _handleSubmittedUpdate(index, item);
              await db.updateItem(newItemUpdated);
              setState(() {
                _readItemList();
              });
              Navigator.pop(context);
            },
            child: Text("Update")),
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel"))
      ],
    );

    showDialog(
      context: context,
      builder: (_) {
        return alert;
      },
    );
  }

  void _handleSubmittedUpdate(int index, Item item) {
    setState(() {
      _itemList.removeWhere((element) {
        _itemList[index].itemName = item.itemName;
      });
    });
  }

  Container myCategory(String categoryName) {
    return Container(
      width: 250.0,
      height: 250.0,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
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
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Text(
                categoryName,
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Futura',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
