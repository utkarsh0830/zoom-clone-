import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom/resources/auth_method.dart';
import 'package:zoom/resources/jitsi_meet_methods.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/widgets/meeting_options.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController nameController;
  late TextEditingController meetingIdController;
  bool isAudioMuted = true;
  bool isVideoMuted = true;
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  @override
  void initState() {
    // TODO: implement initState
    meetingIdController = TextEditingController();
    nameController = TextEditingController(
        text: _authMethods.user.displayName
    );
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  _joinMeeting(){
    _jitsiMeetMethods.createMeeting(
        roomName: meetingIdController.text,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
        username: nameController.text,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text('Join a Meeting',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          TextField(
            controller: meetingIdController,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              fillColor: secondaryBackgroundColor,
              filled: true,
              border: InputBorder.none,
              hintText: 'Room ID',
              contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          TextField(
            controller: nameController,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              fillColor: secondaryBackgroundColor,
              filled: true,
              border: InputBorder.none,
              hintText: 'Name',
              contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
            ),
          ),
          const SizedBox(height: 20,),
          InkWell(
            onTap: _joinMeeting,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Join',style: TextStyle(
                fontSize: 16
              ),),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MeetingOption(text: 'Mute Audio', isMute: isAudioMuted, onChange: onAudioMuted),
          MeetingOption(text: 'Mute Video', isMute: isAudioMuted, onChange: onVideoMuted),

        ],
      ),
    );
  }
  onAudioMuted(bool val){
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val){
    setState(() {
      isVideoMuted = val;
    });
  }

}
