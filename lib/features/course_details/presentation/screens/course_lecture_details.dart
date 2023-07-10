import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../widgets/custom_app_bar_widget.dart';
import '../../domain/entities/course_lecture_details_entity.dart';

const String courseLectureDetails = 'courseLectureDetails';

class CourseLecturesScreen extends StatefulWidget {
  final CourseLectureDetailsEntity courseLectureDetails;
  final String initVideoID;

  const CourseLecturesScreen(
      {Key? key, required this.courseLectureDetails, required this.initVideoID})
      : super(key: key);

  @override
  State<CourseLecturesScreen> createState() => _CourseLecturesScreenState();
}

class _CourseLecturesScreenState extends State<CourseLecturesScreen> {
  late YoutubePlayerController _controller;
  late YoutubeMetaData _videoMetaData;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();

    var id = YoutubePlayer.convertUrlToId(
        (widget.courseLectureDetails.videos.isNotEmpty)
            ? widget.courseLectureDetails.videos.first.youtubeID
            : widget.initVideoID);
    _controller = YoutubePlayerController(
      initialVideoId: id!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    )..addListener(_listener);
    _videoMetaData = const YoutubeMetaData();
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    // print("Deactivated");
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: _topActions(),
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          // List<String> videos = [];
          //
          // for (var element in widget.courseLectureDetails.videos) {
          //   videos.add(element.youtubeID);
          // }
          // _controller
          //     .load(videos[(videos.indexOf(data.videoId) + 1) % videos.length]);
          // // _showSnackBar('Next Video Started!');
          // // _controller.load(data.videoId);
          // _controller.pause();
        },
        actionsPadding: const EdgeInsets.only(top: 8.0),
        controlsTimeOut: _videoMetaData.duration,
        bottomActions: _bottomActions(),
      ),
      builder: (context, player) {
        return BodyScreen(
          lectureDetailsEntity: widget.courseLectureDetails,
          player: player,
          playerController: _controller,
        );
      },
    );
  }

  List<Widget> _topActions() {
    return <Widget>[
      const SizedBox(width: 8.0),
      Expanded(
        child: Text(
          _controller.metadata.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    ];
  }

  List<Widget> _bottomActions() {
    return [
      const SizedBox(width: 8.0),

      // const SizedBox(width: 14.0),
      SizedBox(
        // width: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              _durationFormatter(
                _videoMetaData.duration.inMilliseconds,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
            const Text(
              ' / ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
            CurrentPosition(),
          ],
        ),
      ),
      // const SizedBox(width: 8.0),
      ProgressBar(
        isExpanded: true,
        colors: const ProgressBarColors(),
      ),
      IconButton(
        icon: Icon(
          _muted ? Icons.volume_off : Icons.volume_up,
          color: Colors.white,
        ),
        padding: EdgeInsets.zero,
        onPressed: _isPlayerReady
            ? () {
                _muted ? _controller.unMute() : _controller.mute();
                setState(() {
                  _muted = !_muted;
                });
              }
            : null,
      ),
      const PlaybackSpeedButton(),
      FullScreenButton(),
    ];
  }

  /// Formats duration in milliseconds to xx:xx:xx format.
  String _durationFormatter(int milliSeconds) {
    var seconds = milliSeconds ~/ 1000;
    final hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    var minutes = seconds ~/ 60;
    seconds = seconds % 60;
    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
            ? '00'
            : '0$hours';
    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
            ? '00'
            : '0$minutes';
    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
            ? '00'
            : '0$seconds';
    final formattedTime =
        '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';
    return formattedTime;
  }
}

///
class BodyScreen extends StatelessWidget {
  final Widget player;
  final CourseLectureDetailsEntity lectureDetailsEntity;
  final YoutubePlayerController playerController;

  const BodyScreen({
    super.key,
    required this.player,
    required this.lectureDetailsEntity,
    required this.playerController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: lectureDetailsEntity.courseName),
      body: ListView(children: [
        player,
        CardViewMainDataCourseLectureWidget(
            lectureDetailsEntity: lectureDetailsEntity),
        // const SizedBox(height: 40.0),
        CardViewVideosCourseLectureWidget(
          lectureDetailsEntity: lectureDetailsEntity,
          playerController: playerController,
        )
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        onPressed: () => _buildShowBottomSheetContentAndExamsCourses(context),
        isExtended: true,
        label: const Text('المحتوى العلمى | الامتحانات'),
      ),
    );
  }

  _buildShowBottomSheetContentAndExamsCourses(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // enableDrag: true,
      builder: (context) =>
          ContentAndExamsCourses(lectureDetailsEntity: lectureDetailsEntity),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    );
  }
}

class ContentAndExamsCourses extends StatefulWidget {
  const ContentAndExamsCourses({
    super.key,
    required this.lectureDetailsEntity,
  });

  final CourseLectureDetailsEntity lectureDetailsEntity;

  @override
  State<ContentAndExamsCourses> createState() => _ContentAndExamsCoursesState();
}

class _ContentAndExamsCoursesState extends State<ContentAndExamsCourses> {
  bool _progress = false;
  int? _progressLoading;

  final List<String> _fileNamesDownloaded = [];
  String? _fileName;

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');

    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus(data[1]);
      _progressLoading = data[2];
      setState(() {});
      print(_progressLoading);
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(String id, int status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: context.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              Container(
                height: 6.0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('تحميل المحتوى العلمى',
                    style: context.bodyMedium.copyWith(
                      color: ColorManager.primary,
                    )),
              ),
              const SizedBox(height: 10.0),
              ...List.generate(
                widget.lectureDetailsEntity.files.length,
                (index) => Card(
                  // elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    child: TextButton(
                      onPressed: () async {
                        late String appStorage;
                        final status = await Permission.storage.request();
                        if (status.isGranted) {
                          final externalDirectory =
                              await getExternalStorageDirectory();

                          if (Platform.isAndroid) {
                            appStorage = (await ExternalPath
                                .getExternalStoragePublicDirectory(
                                    ExternalPath.DIRECTORY_DOWNLOADS));
                          } else if (Platform.isIOS) {
                            Directory appDocDir =
                                (await getApplicationDocumentsDirectory());
                            appStorage = appDocDir.path;
                          }
                          final res = await FlutterDownloader.enqueue(
                            url: widget
                                .lectureDetailsEntity.files[index].filePath,
                            savedDir: appStorage,
                            fileName:
                                '${widget.lectureDetailsEntity.files[index].fileName}.${widget.lectureDetailsEntity.files[index].filePath.split('.').last}',
                            showNotification: true,
                            openFileFromNotification: true,
                          );
                          _fileName =
                              widget.lectureDetailsEntity.files[index].fileName;
                          _fileNamesDownloaded.add(widget
                              .lectureDetailsEntity.files[index].fileName);
                        } else {}

                        ///
                        // _downloadFile(
                        //   path:
                        //       widget.lectureDetailsEntity.files[index].filePath,
                        //   name:
                        //       widget.lectureDetailsEntity.files[index].fileName,
                        // );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor:
                            ColorManager.secondary.withOpacity(0.9),
                        // elevation: 0.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                widget
                                    .lectureDetailsEntity.files[index].fileName,
                                style: context.bodyMedium),
                          ),
                          (_progressLoading != null &&
                                  _progressLoading != 100 &&
                                  _fileName ==
                                      widget.lectureDetailsEntity.files[index]
                                          .fileName)
                              ? /*CircularProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.green),
                                  value: double.tryParse(
                                      _progressLoading.toString()),
                                )*/
                              Text(
                                  '$_progressLoading',
                                  style: context.bodyMedium,
                                )
                              : (_fileNamesDownloaded.contains(widget
                                      .lectureDetailsEntity
                                      .files[index]
                                      .fileName))
                                  ? const Icon(
                                      Icons.check,
                                      size: 25,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.download,
                                      size: 25,
                                      color: ColorManager.primary,
                                    ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.lectureDetailsEntity.files.isEmpty)
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(AppStrings.nosDataAvailable.tr(),
                      textAlign: TextAlign.center,
                      style: context.bodyMedium
                          .copyWith(color: ColorManager.textGray)),
                ),
              const SizedBox(height: 20.0),
              const Divider(
                height: 10.0,
                thickness: 2,
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('الامتحانات',
                    style: context.bodyMedium.copyWith(
                      color: ColorManager.primary,
                    )),
              ),
              const SizedBox(height: 10.0),
              ...List.generate(
                widget.lectureDetailsEntity.exams.length,
                (index) => Card(
                  // elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    child: TextButton(
                      onPressed: () {
                        // playerController.load(lectureDetailsEntity
                        //     .videos[index].youtubeID);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor:
                            ColorManager.secondary.withOpacity(0.9),
                        // elevation: 0.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                'lectureDetailsEntity.exams[index].examsName',
                                style: context.bodyMedium),
                          ),
                          const Icon(
                            Icons.download,
                            size: 25,
                            color: ColorManager.primary,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.lectureDetailsEntity.exams.isEmpty)
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(AppStrings.nosDataAvailable.tr(),
                      textAlign: TextAlign.center,
                      style: context.bodyMedium
                          .copyWith(color: ColorManager.textGray)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _downloadFile({required String path, required String name}) async {
    late String appStorage;
    if (await Permission.storage.request().isGranted) {
      if (Platform.isAndroid) {
        appStorage = (await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS));
      } else if (Platform.isIOS) {
        Directory appDocDir = (await getApplicationDocumentsDirectory());
        appStorage = appDocDir.path;
      }
      setState(() {
        _progress = true;
        _fileName = name;
        // _fileNamesDownloaded.add(name);
      });
      // final appStorage = await getExternalStorageDirectory();
      final file = File('$appStorage/$name.${path.split('.').last}');
      print(file.path);
      final response = await Dio().get(
        path,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
      print(response.data);
      final ref = file.openSync(mode: FileMode.write);
      ref.writeFromSync(response.data);
      await ref.close();

      setState(() {
        _progress = false;
        _fileName = name;
        _fileNamesDownloaded.add(name);
      });
      return file;
    }
  }
}

///
///
class CardViewMainDataCourseLectureWidget extends StatelessWidget {
  final CourseLectureDetailsEntity lectureDetailsEntity;

  const CardViewMainDataCourseLectureWidget({
    super.key,
    required this.lectureDetailsEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Text(lectureDetailsEntity.lectureName,
                style: context.bodyLarge.copyWith(color: ColorManager.primary)),
            const SizedBox(height: 20.0),
            Text(lectureDetailsEntity.courseName, style: context.bodyMedium),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}

class CardViewVideosCourseLectureWidget extends StatelessWidget {
  final CourseLectureDetailsEntity lectureDetailsEntity;
  final YoutubePlayerController playerController;

  const CardViewVideosCourseLectureWidget({
    super.key,
    required this.lectureDetailsEntity,
    required this.playerController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            ...List.generate(
                lectureDetailsEntity.videos.length,
                (index) => Column(
                      children: [
                        Card(
                          color: lectureDetailsEntity.videos[index].youtubeID ==
                                  playerController.value.metaData.videoId
                              ? ColorManager.secondary_2
                              : null,
                          // elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            child: TextButton(
                              onPressed: lectureDetailsEntity
                                          .videos[index].youtubeID !=
                                      playerController.value.metaData.videoId
                                  ? () {
                                      playerController.load(lectureDetailsEntity
                                          .videos[index].youtubeID);
                                    }
                                  : null,
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    ColorManager.secondary.withOpacity(0.9),
                                // elevation: 0.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        lectureDetailsEntity
                                            .videos[index].videoName,
                                        style: context.bodyLarge.copyWith(
                                            color: ColorManager.primary)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(
                          height: 10.0,
                          thickness: 2,
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    )),
            if (lectureDetailsEntity.videos.isEmpty)
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(AppStrings.nosDataAvailable.tr(),
                    textAlign: TextAlign.center,
                    style: context.bodyLarge
                        .copyWith(color: ColorManager.textGray)),
              ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
