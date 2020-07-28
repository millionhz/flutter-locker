import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:provider/provider.dart';
import 'model.dart';

class MyRoundedButton extends StatelessWidget {
  final String lockerOpenMessage =
      'You Did It! Now Try Again Because I Changed The Code...';
  final String lockerStillLockedMessage = 'Incorrect Code!';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      // TODO: Implement lock unlock animation for the button
      child: RawMaterialButton(
        elevation: 0,
        enableFeedback: false,
        onPressed: () {
          LockerState lockerState =
              Provider.of<Locker>(context, listen: false).unlock();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                (lockerState == LockerState.locked)
                    ? lockerStillLockedMessage
                    : lockerOpenMessage,
                style: TextStyle(
                    color: kLight,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Quicksand'),
              ),
              backgroundColor: kDark,
              duration: (lockerState == LockerState.locked)
                  ? Duration(milliseconds: 650)
                  : Duration(milliseconds: 3500),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
            ),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
        fillColor: kDark,
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          height: 80,
          child: Center(
            child: Icon(Icons.lock, color: kLight, size: 42),
          ),
        ),
      ),
    );
  }
}
