import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NodesScreen extends StatefulWidget {
  final String slotID;
  final String nodeTypeDisplayName;
  final String nodeType;

  NodesScreen(
      {required this.slotID,
      required this.nodeTypeDisplayName,
      required this.nodeType});

  @override
  State<NodesScreen> createState() => _NodesScreenState();
}

class _NodesScreenState extends State<NodesScreen> {
  bool nodesLoaded = false;

  List<GridViewNode> gridViewChildren = [];

  void getNodes() async {
    final queryParameters = {'SlotID': widget.slotID, 'Type': widget.nodeType};

    var dio = Dio();
    var response = await dio.get(
        'http://node-js-new.herokuapp.com/api/warehouses/slots/nodes',
        queryParameters: queryParameters);

    deserializeSlots(response.data);

    await Future.delayed(
      Duration(
        seconds: 1,
      ),
    );

    // deserializeSlots(json.decode(response.body));
    setState(() {
      nodesLoaded = true;
    });
  }

  void deserializeSlots(List slotList) {
    for (int i = 0; i < slotList.length; i++) {
      gridViewChildren.add(
        GridViewNode(
          status: slotList[i]['NodeStatus']!,
          nodeID: slotList[i]['NodeID']!,
        ),
      );
    }
  }

  @override
  void initState() {
    getNodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF92A65F),
        centerTitle: true,
        title: Text(
          widget.slotID + " - " + widget.nodeTypeDisplayName,
          style: TextStyle(
            fontFamily: "NunitoSans",
            color: Color(0xFF323232),
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF323232),
        ),
      ),
      body: nodesLoaded
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: getGridViewNodes(context),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  List<Widget> getGridViewNodes(BuildContext context) {
    return List.generate(
      gridViewChildren.length,
      (index) {
        return GestureDetector(
          onTap: () {},
          child: CustomStatusColorContainer(
              gridViewChildren: gridViewChildren, index: index),
        );
      },
    );
  }
}

class GridViewNode {
  late final String nodeID;
  late final Widget child;
  late final Color statusColor;
  late final String status;

  GridViewNode({required String status, required String nodeID}) {
    this.nodeID = nodeID;

    this.status = status;
    if (this.status.length < 4) {
      this.statusColor = Colors.orange;
    } else if (this.status.toLowerCase().substring(0, 4) == "good") {
      this.statusColor = Colors.green;
    } else if (this.status.toLowerCase() == "degraded") {
      this.statusColor = Colors.red;
    } else {
      this.statusColor = Colors.orange;
    }
    this.child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          nodeID,
          style: TextStyle(
            fontFamily: "NunitoSans",
            color: Color(0xFF323232),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Container(
          decoration: BoxDecoration(
            color: this.statusColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          height: 3,
          width: 25,
        ),
      ],
    );
  }
}

class CustomStatusColorContainer extends StatelessWidget {
  const CustomStatusColorContainer(
      {required this.gridViewChildren, required this.index});

  final List<GridViewNode> gridViewChildren;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
        border: Border.all(
          width: 1,
          color: Color(0xFF92A65F),
        ),
        color: Color(0xFFE5EAD9),
      ),
      child: Center(
        child: gridViewChildren[index].child,
      ),
    );
  }
}
