import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:prosto/helpers/offers.dart';
import 'package:prosto/helpers/tasks.dart';
import 'package:prosto/helpers/users.dart';
import 'package:prosto/models/offer.dart';
import 'package:prosto/models/task.dart';
import 'package:prosto/models/user.dart';
import 'package:prosto/widgets/card.dart';
import 'package:prosto/widgets/offer_modal.dart';

class TaskScreen extends StatefulWidget {
  final int taskId;
  TaskScreen({this.taskId});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  FixedExtentScrollController fixedExtentScrollController =
      new FixedExtentScrollController();
  bool _isLoading = false;
  Future<Task> futureTask;
  bool hasOffered = false;
  User currentUser;
  @override
  void initState() {
    super.initState();
    futureTask = getTask({'id': widget.taskId});
    getLocalCurrentUser().then((user) {
      currentUser = user;
    });
  }

  void _canCreate() async {
    setState(() {
      _isLoading = true;
    });
    bool _canCreate = await canCreate({});
    if (_canCreate) {
      showDialog(
        context: context,
        builder: (BuildContext context) => ProstoNewOfferModal(widget.taskId),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Text('Ваш счет замарожен. Ожидайте размарозки'),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  List<Widget> buildTaskOffers(List<Offer> offers, Offer selectedOffer) {
    List<Widget> offerWidgets = List();
    offerWidgets.add(
      ListTile(
        title: Text('Откликнулись:'),
        trailing: Text(
          '${offers.length} исполнителя(ей)',
          style: TextStyle(fontSize: 14),
        ),
        dense: true,
      ),
    );
    for (final offer in offers) {
      offerWidgets.add(ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(offer.executor.name),
            Text(
              '${offer.price} сум',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        initiallyExpanded: selectedOffer.id == offer.id,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Тип оплаты:'),
                Text(
                  offer.paymentType != null
                      ? offer.paymentType.name
                      : 'Не выбран',
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text('Комментарий:')),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text(offer.comment),
          ),
          offer.deletedAt != null
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Text('Отказано'),
                )
              : selectedOffer == null
                  ? ButtonBar(
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {},
                          child: Text('Просмотреть профиль'),
                        ),
                        RaisedButton(
                          onPressed: offer.acceptance
                              ? null
                              : () async {
                                  setState(() {
                                    offer.acceptance = true;
                                  });
                                  if ((await updateTask({
                                    "id": widget.taskId,
                                    "offer_id": offer.id
                                  })) is Task) {
                                    setState(() {
                                      futureTask =
                                          getTask({"id": widget.taskId});
                                    });
                                  }
                                  setState(() {
                                    offer.acceptance = false;
                                  });
                                },
                          child: offer.acceptance
                              ? Transform.scale(
                                  scale: .5, child: CircularProgressIndicator())
                              : Icon(
                                  Icons.check_box,
                                  color: Colors.white,
                                ),
                        ),
                        RaisedButton(
                          onPressed: offer.deletion
                              ? null
                              : () async {
                                  setState(() {
                                    offer.deletion = true;
                                  });
                                  if (await deleteOffer({"id": offer.id})) {
                                    setState(() {
                                      offer.deletedAt = DateTime.now();
                                    });
                                  }
                                  setState(() {
                                    offer.deletion = false;
                                  });
                                },
                          color: Colors.black,
                          child: offer.deletion
                              ? Transform.scale(
                                  scale: .5, child: CircularProgressIndicator())
                              : Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                        ),
                      ],
                    )
                  : selectedOffer.id == offer.id
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: Text(
                            'Вы выбрали этого исполнителя',
                            style: TextStyle(
                              color: Theme.of(context).accentColor
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: Text(
                            'Вы выбрали другого исполнителя',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
        ],
      ));
    }
    return offerWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Задание №${widget.taskId}'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: futureTask,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Task task = snapshot.data;
              Completer<GoogleMapController> _controller = Completer();
              List<Marker> _markers = [
                Marker(
                  markerId: MarkerId('marker'),
                  position: LatLng(task.coorLat, task.coorLong),
                  draggable: true,
                ),
              ];
              final CameraPosition _kGooglePlex = CameraPosition(
                target: LatLng(task.coorLat, task.coorLong),
                zoom: 10,
              );
              for (final offer in task.offers) {
                print(offer.executor);
                if (offer.executor.id == currentUser.id) {
                  hasOffered = true;
                }
              }
              return ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ProstoCard(
                        tapHandler: null,
                        task: task,
                        showUser: false,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Тип оплаты:"),
                                  Text(task.paymentType.name),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Заказ создан:"),
                                  Text(DateFormat('dd.mm.yyyy hh:mm')
                                      .format(task.createdAt)),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Предложений:"),
                                  Text(
                                      '${task.offers != null ? task.offers.length : 0}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Статус:"),
                                  Text('${task.status.name}'),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.person_outline,
                                    size: 16,
                                    color: Color(0xFF68BB49),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      task.user.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.phone,
                                    size: 16,
                                    color: Color(0xFF68BB49),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    task.user.username,
                                    style: TextStyle(
                                      color: Color(0xFF68BB49),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Детали:"),
                              Container(
                                height: 28,
                                child: Text(
                                  task.description,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                                child: InkWell(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      'Показать',
                                      style: TextStyle(
                                        color: Color(0xFF68BB49),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 400,
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: GoogleMap(
                              compassEnabled: true,
                              mapToolbarEnabled: true,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: false,
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              markers:
                                  _markers.length > 0 ? _markers.toSet() : null,
                              onCameraMove: (cameraPosition) {},
                            ),
                          ),
                        ),
                      ),
                      currentUser != null &&
                              currentUser.id == task.user.id &&
                              task.status.code == 'new'
                          ? Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 10),
                              child: Column(
                                children: buildTaskOffers(task.offers,
                                    task.offer is Offer ? task.offer : null),
                              ),
                            )
                          : Container(),
                      currentUser != null &&
                              currentUser.id != task.user.id &&
                              task.status.code == 'new' &&
                              !hasOffered
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                padding: EdgeInsets.all(16),
                                onPressed: !_isLoading ? _canCreate : null,
                                child: Text(
                                  'Подать предложение',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : hasOffered
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  width: MediaQuery.of(context).size.width,
                                  child: RaisedButton(
                                    padding: EdgeInsets.all(16),
                                    onPressed: null,
                                    child: Text(
                                      'Предложение подано',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container(),
                    ],
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
