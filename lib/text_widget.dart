import 'package:flutter/material.dart';

class TextDialog extends StatefulWidget {
  const TextDialog({Key? key}) : super(key: key);

  @override
  State<TextDialog> createState() => _TextDialogState();
}

class _TextDialogState extends State<TextDialog> {
  final _scrollController = ScrollController();
  int pos = 0;
  bool scrollBottom = false;
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(listenScrolling);
  }

  void listenScrolling() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          scrollBottom = true;
        });
      }
    } else {
      if (scrollBottom) {
        setState(() {
          scrollBottom = false;
        });
      }
    }
  }

  Future<String> getTextFromFile(BuildContext context) async {
    return await DefaultAssetBundle.of(context)
        .loadString('assets/applecare_agreement.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      width: double.infinity,
      height: 550,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  width: double.infinity,
                  height: 380,
                  child: textContent(),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                displayButton(),
              ],
            ),
          ),
          closeButton(),
        ],
      ),
    );
  }

  Widget closeButton() {
    return Positioned(
      top: 0,
      left: 0,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.close, color: Colors.black),
      ),
    );
  }

  Widget displayButton() {
    if (scrollBottom) {
      return InkWell(
        onTap: () {
          const popUpText = SnackBar(
            content: Text(
                "Thanks for your collaboration, a copy of Term of Agreement has been sent to your email"),
          );
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(popUpText);
        },
        child: Container(
          margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          width: 200,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7, // changes position of shadow
              ),
            ],
          ),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              "Agree",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        child: Container(
          margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          width: 200,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7, // changes position of shadow
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Agree",
              style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      );
    }
  }

  Widget textContent() {
    return FutureBuilder(
      future: getTextFromFile(context),
      initialData: "Loading text..",
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            snapshot.data ?? 'Text Loading Fail',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
