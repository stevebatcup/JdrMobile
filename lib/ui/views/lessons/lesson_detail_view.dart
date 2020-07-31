import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/datamodels/lesson.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jdr/ui/components/jdr_app_bar.dart';
import 'package:jdr/ui/components/jdr_video_player.dart';
import 'package:jdr/ui/components/lesson_intro.dart';
import 'package:jdr/ui/components/pdf_list_item.dart';
import 'package:stacked/stacked.dart';
import 'lesson_detail_viewmodel.dart';
import 'package:expandable/expandable.dart';

class LessonDetailView extends StatelessWidget {
  final AuthService _authService = locator<AuthService>();

  final String path;
  LessonDetailView({this.path});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LessonDetailViewModel>.reactive(
      viewModelBuilder: () => LessonDetailViewModel(),
      disposeViewModel: true,
      fireOnModelReadyOnce: true,
      onModelReady: (model) {
        if (_authService.currentUser != null) {
          model.loadLessonDetails(path);
        }
      },
      builder: (context, model, child) => Scaffold(
        appBar: JdrAppBar(),
        body: FutureBuilder<Lesson>(
          future: model.lessonFuture,
          builder: (context, AsyncSnapshot<Lesson> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              ); // add shimmer text
            }

            Lesson lesson = snapshot.data;
            return LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return ConstrainedBox(
                  constraints:
                      BoxConstraints(maxHeight: viewportConstraints.maxHeight),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      JdrVideoPlayer(
                        fileUrl: lesson.mainVideo.fileUrl,
                        placeholderImgUrl: lesson.image,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  lesson.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                    fontSize: 21,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.clock,
                                    size: 15,
                                    color: Colors.blueGrey,
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    'Published ${lesson.publishedAt} ago',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      height: 1.5,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 18),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: lesson.content.length > 0
                                    ? ExpandablePanel(
                                        header: LessonIntro(lesson: lesson),
                                        theme: ExpandableThemeData(
                                          iconColor: Colors.blueGrey,
                                        ),
                                        expanded: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 12.0),
                                          child: Html(
                                            data: lesson.content,
                                            style: {
                                              "p": Style(
                                                margin: EdgeInsets.zero,
                                                fontSize: FontSize(16),
                                              ),
                                            },
                                          ),
                                        ),
                                      )
                                    : LessonIntro(lesson: lesson),
                              ),
                              if (lesson.downloadables.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.black87,
                                      height: 40,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(
                                        "PDFs",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                          fontSize: 18,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 25.0,
                                        right: 25.0,
                                        bottom: 25.0,
                                        top: 5,
                                      ),
                                      child: Column(
                                        children: lesson.downloadables
                                            .map((item) =>
                                                PdfListItem(downloadable: item))
                                            .toList(),
                                      ),
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
