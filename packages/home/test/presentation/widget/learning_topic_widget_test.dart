// Widget builds without errors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/presentation/widgets/learning_topic_widget.dart';

void main() {
  testWidgets('widget builds without errors', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: Scaffold(
          body: LearningTopicGridWidget(
            image: 'assets/icons/english.png',
            learningTopicName: 'Bahasa Inggris',
            onTap: () {},
          ),
        ),
      ),
    ));
    expect(find.byType(LearningTopicGridWidget), findsOneWidget);
  });

  testWidgets('Widget Show Correct Image And Text',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: Scaffold(
          body: LearningTopicGridWidget(
            image: 'assets/icons/english.png',
            learningTopicName: 'Bahasa Inggris',
            onTap: () {},
          ),
        ),
      ),
    ));
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Bahasa Inggris'), findsOneWidget);
  });

  testWidgets("Widget should call onTap if inkwell tapped",
      (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: Scaffold(
          body: LearningTopicGridWidget(
            image: 'assets/icons/english.png',
            learningTopicName: 'Bahasa Inggris',
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    ));

    expect(tapped, false);
    await tester.tap(find.byType(InkWell));
    expect(tapped, true);
  });

  testWidgets(
      'widget handles an empty string for the learningTopicName gracefully',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: Scaffold(
          body: LearningTopicGridWidget(
            image: 'assets/icons/topic.png',
            learningTopicName: '',
            onTap: () {},
          ),
        ),
      ),
    ));
    expect(find.text(''), findsOneWidget);
  });

  testWidgets('Text displays the correct learning topic name',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: Scaffold(
          body: LearningTopicGridWidget(
            image: 'assets/icons/english.png',
            learningTopicName: 'Bahasa Inggris',
            onTap: () {},
          ),
        ),
      ),
    ));
    expect(find.text('Bahasa Inggris'), findsOneWidget);
  });

  testWidgets('Container respects the specified width and borderRadius',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: Scaffold(
          body: LearningTopicGridWidget(
            image: 'assets/icons/english.png',
            learningTopicName: 'Bahasa Inggris',
            onTap: () {},
          ),
        ),
      ),
    ));

    final container = tester.widget<Container>(find.byType(Container));
    final BoxDecoration decoration = container.decoration as BoxDecoration;

    expect(container.constraints?.maxWidth, equals(157.5.w));
    expect(decoration.borderRadius, equals(BorderRadius.circular(12.r)));
  });

  testWidgets(
      'Widget handles an invalid or non-existent image path without crashing',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: Scaffold(
          body: LearningTopicGridWidget(
            image: 'invalid_image_path.png',
            learningTopicName: 'Invalid Image',
            onTap: () {},
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(LearningTopicGridWidget), findsOneWidget);
    expect(find.byIcon(Icons.error), findsOneWidget);
  });

  testWidgets('onTap callback does nothing if it is an empty function',
      (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: Scaffold(
          body: LearningTopicGridWidget(
            image: 'assets/icons/english.png',
            learningTopicName: 'Bahasa Inggris',
            onTap: () {},
          ),
        ),
      ),
    ));

    expect(tapped, false);
    await tester.tap(find.byType(InkWell));
    expect(tapped, false);
  });

  // Handles extreme values for width and height gracefully
  testWidgets('Handles extreme values for width and height gracefully',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: Scaffold(
          body: LearningTopicGridWidget(
            image: 'assets/icons/english.png',
            learningTopicName: 'Bahasa Inggris',
            onTap: () {},
          ),
        ),
      ),
    ));

    expect(find.byType(LearningTopicGridWidget), findsOneWidget);

    // Test with extreme width and height values
    await tester.pumpWidget(MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(2000, 4000),
        child: Scaffold(
          body: LearningTopicGridWidget(
            image: 'assets/icons/english.png',
            learningTopicName: 'Bahasa Inggris',
            onTap: () {},
          ),
        ),
      ),
    ));

    expect(find.byType(LearningTopicGridWidget), findsOneWidget);
  });
}
