import '../../models/models.dart';

final Course powerPointCourse = Course(
  id: 'powerpoint',
  title: 'Microsoft PowerPoint',
  description:
      'A deep, complete course on building and reviewing slide decks non-visually — objects, notes, design, and media — with NVDA, JAWS, and Narrator.',
  iconLabel: 'Microsoft PowerPoint course',
  lessons: [
    Lesson(
      id: 'ppt_navigation',
      title: 'Navigating Slides & Objects',
      summary: 'Learn how to move between slides, tab through objects on a slide, and understand what is on screen without seeing it.',
      sections: [
        ScreenReaderSection(
          screenReaderName: 'NVDA',
          introText:
              'In the Normal view editing area, NVDA announces each slide\'s title as you move between slides, and Tab moves you through objects placed on the current slide, announcing their type (text box, picture, chart, etc.).',
          shortcuts: [
            ShortcutItem(keys: 'Page Up/Down', description: 'Move to the previous or next slide in the editor.'),
            ShortcutItem(keys: 'Tab', description: 'Move to the next object on the current slide.'),
            ShortcutItem(keys: 'Shift + Tab', description: 'Move to the previous object on the current slide.'),
            ShortcutItem(keys: 'Enter (on an object)', description: 'Enter edit mode for that object, e.g. to edit text.'),
            ShortcutItem(keys: 'Esc', description: 'Exit edit mode for the current object.'),
            ShortcutItem(keys: 'NVDA + F7', description: 'Open Elements List to review text/objects in some views.'),
            ShortcutItem(keys: 'Ctrl + Home', description: 'Move to the first slide in the deck (from the slide list).'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'JAWS',
          introText:
              'JAWS announces slide numbers and titles as you move between slides, and provides a virtual cursor mode over the slide thumbnail pane for quicker overview scanning.',
          shortcuts: [
            ShortcutItem(keys: 'Page Up/Down', description: 'Move between slides.'),
            ShortcutItem(keys: 'Tab', description: 'Move to the next object on the slide.'),
            ShortcutItem(keys: 'Shift + Tab', description: 'Move to the previous object.'),
            ShortcutItem(keys: 'Enter', description: 'Enter edit mode on the selected object.'),
            ShortcutItem(keys: 'Insert + F6', description: 'List headings/titles for quicker navigation, where supported.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'Narrator',
          introText: 'Narrator announces the slide title and object type as focus changes, similar to the other readers, though with slightly less detail on complex object types like SmartArt.',
          shortcuts: [
            ShortcutItem(keys: 'Page Up/Down', description: 'Move between slides.'),
            ShortcutItem(keys: 'Tab', description: 'Move to the next object.'),
            ShortcutItem(keys: 'Shift + Tab', description: 'Move to the previous object.'),
            ShortcutItem(keys: 'Enter', description: 'Enter edit mode for the selected object.'),
          ],
        ),
      ],
    ),
    Lesson(
      id: 'ppt_notes_and_presenting',
      title: 'Speaker Notes & Presenting',
      summary: 'Learn to read and add speaker notes, and to run a presentation confidently with a screen reader active.',
      sections: [
        ScreenReaderSection(
          screenReaderName: 'NVDA',
          introText: 'Switch to Notes view (or use the Notes pane) to read or dictate speaker notes; NVDA reads this pane like a normal text box.',
          shortcuts: [
            ShortcutItem(keys: 'F5', description: 'Start the slideshow from the beginning.'),
            ShortcutItem(keys: 'Shift + F5', description: 'Start the slideshow from the current slide.'),
            ShortcutItem(keys: 'Esc', description: 'End the slideshow.'),
            ShortcutItem(keys: 'Alt + Shift + Tab (Notes pane focus)', description: 'Move focus into/out of the speaker notes pane.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'JAWS',
          introText: 'JAWS reads the speaker notes pane the same as any editable text region, and clearly announces when the slideshow starts and ends.',
          shortcuts: [
            ShortcutItem(keys: 'F5', description: 'Start the slideshow from the beginning.'),
            ShortcutItem(keys: 'Shift + F5', description: 'Start from the current slide.'),
            ShortcutItem(keys: 'Esc', description: 'End the slideshow.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'Narrator',
          introText: 'Narrator supports the same slideshow shortcuts and reads speaker notes text normally when the notes pane has focus.',
          shortcuts: [
            ShortcutItem(keys: 'F5', description: 'Start the slideshow from the beginning.'),
            ShortcutItem(keys: 'Shift + F5', description: 'Start from the current slide.'),
            ShortcutItem(keys: 'Esc', description: 'End the slideshow.'),
          ],
        ),
      ],
    ),
    Lesson(
      id: 'ppt_design_animations',
      title: 'Design, Themes & Animations',
      summary: 'Apply a consistent design theme and add simple animations without needing to see slide previews.',
      sections: [
        ScreenReaderSection(
          screenReaderName: 'NVDA',
          introText:
              'The Design tab lets you apply a theme to the whole deck at once, which keeps fonts and colors consistent — NVDA announces each theme\'s name as you arrow through the gallery so you can pick by description rather than appearance.',
          shortcuts: [
            ShortcutItem(keys: 'Alt + G', description: 'Open the Design tab via Ribbon access keys.'),
            ShortcutItem(keys: 'Arrow keys (in theme gallery)', description: 'Move between theme options, hearing each theme\'s name announced.'),
            ShortcutItem(keys: 'Alt + A (Animations tab)', description: 'Open the Animations tab to add an entrance/exit effect.'),
            ShortcutItem(keys: 'Alt + A, then B', description: 'Open Animation Pane to review the order of effects on the slide.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'JAWS',
          introText:
              'JAWS reads the theme name and a short description as you move through the Design gallery, and announces each animation effect\'s name and its play order in the Animation Pane.',
          shortcuts: [
            ShortcutItem(keys: 'Alt + G', description: 'Open the Design tab.'),
            ShortcutItem(keys: 'Arrow keys (theme gallery)', description: 'Move between themes, hearing each name.'),
            ShortcutItem(keys: 'Alt + A', description: 'Open the Animations tab.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'Narrator',
          introText: 'Narrator announces theme names in the gallery similarly, though with slightly less descriptive detail about each animation\'s exact timing.',
          shortcuts: [
            ShortcutItem(keys: 'Alt + G', description: 'Open the Design tab.'),
            ShortcutItem(keys: 'Alt + A', description: 'Open the Animations tab.'),
          ],
        ),
      ],
    ),
    Lesson(
      id: 'ppt_tables_charts_media',
      title: 'Working with Tables, Charts & Media',
      summary: 'Insert and describe tables, charts, images, and video on a slide so the content stays accessible to everyone.',
      sections: [
        ScreenReaderSection(
          screenReaderName: 'NVDA',
          introText:
              'Every image, chart, or video you add should have Alt Text describing its content — NVDA reads this Alt Text aloud when the object receives focus, so a missing description means the object is effectively invisible to a screen reader user.',
          shortcuts: [
            ShortcutItem(keys: 'Alt + N, T (Insert tab)', description: 'Insert a table onto the current slide.'),
            ShortcutItem(keys: 'Right-click object → Edit Alt Text (or Format pane)', description: 'Add a description that NVDA will read for that object.'),
            ShortcutItem(keys: 'Tab (to reach the object) then Enter', description: 'Enter a table to navigate its cells with arrow keys.'),
            ShortcutItem(keys: 'Alt + N, M', description: 'Insert a video or audio clip via the Insert tab.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'JAWS',
          introText:
              'JAWS reads Alt Text the same way, and additionally announces "table" with row/column counts when you tab onto a table object, helping you understand its size before diving in.',
          shortcuts: [
            ShortcutItem(keys: 'Alt + N, T', description: 'Insert a table onto the current slide.'),
            ShortcutItem(keys: 'Right-click object → Edit Alt Text', description: 'Add a description JAWS will read for that object.'),
            ShortcutItem(keys: 'Tab then Enter (on a table)', description: 'Enter the table to navigate cells with arrow keys.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'Narrator',
          introText: 'Narrator also reads Alt Text on objects, though it\'s especially important to add it manually since Narrator infers less contextual detail automatically than NVDA or JAWS for complex objects like SmartArt.',
          shortcuts: [
            ShortcutItem(keys: 'Alt + N, T', description: 'Insert a table onto the current slide.'),
            ShortcutItem(keys: 'Right-click object → Edit Alt Text', description: 'Add a description Narrator will read for that object.'),
          ],
        ),
      ],
    ),
  ],
  quizSets: _buildPowerPointQuizzes(),
);

List<QuizSet> _buildPowerPointQuizzes() {
  final basicByReader = {
    ScreenReaderKind.nvda: [
      const QuizQuestion(
        question: 'Which key moves you to the next object on the current slide?',
        options: ['Page Down', 'Tab', 'Ctrl + N', 'Enter'],
        correctIndex: 1,
        explanation: 'Tab moves focus to the next object on the slide; Shift + Tab goes back.',
      ),
      const QuizQuestion(
        question: 'Which shortcut starts a slideshow from the very beginning?',
        options: ['Shift + F5', 'F5', 'Ctrl + F5', 'Alt + F5'],
        correctIndex: 1,
        explanation: 'F5 starts the presentation from slide one.',
      ),
      const QuizQuestion(
        question: 'What do Page Up and Page Down do while editing a deck?',
        options: ['Zoom in and out', 'Move to the previous/next slide', 'Move to the previous/next object', 'Nothing'],
        correctIndex: 1,
        explanation: 'They move between slides in the slide list/editor.',
      ),
    ],
    ScreenReaderKind.jaws: [
      const QuizQuestion(
        question: 'Which key ends a running slideshow, usable in JAWS?',
        options: ['Esc', 'F5', 'Alt + F4', 'Backspace'],
        correctIndex: 0,
        explanation: 'Esc exits the presentation and returns to the editing view.',
      ),
      const QuizQuestion(
        question: 'What does JAWS announce as you move between slides?',
        options: ['Slide number and title', 'Nothing', 'Only the file name', 'Only the theme color'],
        correctIndex: 0,
        explanation: 'JAWS announces both the slide number and its title text.',
      ),
      const QuizQuestion(
        question: 'What does Enter do on a focused object like a text box?',
        options: ['Deletes the object', 'Enters edit mode for that object', 'Duplicates the object', 'Moves to the next slide'],
        correctIndex: 1,
        explanation: 'Enter lets you start editing the content of the selected object.',
      ),
    ],
    ScreenReaderKind.narrator: [
      const QuizQuestion(
        question: 'Which shortcut starts a slideshow from the current slide (not the beginning)?',
        options: ['Shift + F5', 'F5', 'Ctrl + F5', 'Alt + Shift + F5'],
        correctIndex: 0,
        explanation: 'Shift + F5 starts the presentation from wherever you currently are.',
      ),
      const QuizQuestion(
        question: 'What does Narrator announce when focus moves to a new object on a slide?',
        options: ['The object type, like text box or picture', 'Nothing at all', 'Only a beep', 'The file size'],
        correctIndex: 0,
        explanation: 'Narrator announces the object type similarly to NVDA and JAWS.',
      ),
      const QuizQuestion(
        question: 'Which key moves to the previous object on a slide?',
        options: ['Shift + Tab', 'Page Up', 'Backspace', 'Ctrl + Tab'],
        correctIndex: 0,
        explanation: 'Shift + Tab moves backward through the objects on a slide.',
      ),
    ],
  };

  final intermediateByReader = {
    ScreenReaderKind.nvda: [
      const QuizQuestion(
        question: 'Which Ribbon access-key sequence opens the Design tab in NVDA?',
        options: ['Alt + G', 'Alt + D', 'Alt + H', 'Alt + N'],
        correctIndex: 0,
        explanation: 'Alt + G opens the Design tab, where themes live.',
      ),
      const QuizQuestion(
        question: 'What does NVDA announce as you arrow through the theme gallery?',
        options: ['Each theme\'s name', 'Only a beep', 'Nothing', 'Only the slide number'],
        correctIndex: 0,
        explanation: 'NVDA announces each theme\'s name so you can choose by description.',
      ),
      const QuizQuestion(
        question: 'What happens if an image on a slide has no Alt Text, when NVDA is active?',
        options: [
          'NVDA announces it as an unlabeled/blank object',
          'NVDA describes the image automatically using AI',
          'NVDA skips the slide entirely',
          'PowerPoint refuses to save the file',
        ],
        correctIndex: 0,
        explanation: 'Without Alt Text, there is no description for NVDA to read — the image is effectively invisible to a screen reader user.',
      ),
    ],
    ScreenReaderKind.jaws: [
      const QuizQuestion(
        question: 'What extra detail does JAWS announce when you tab onto a table on a slide?',
        options: ['Row and column counts', 'The table\'s file size only', 'Nothing extra', 'Only the table\'s border color'],
        correctIndex: 0,
        explanation: 'JAWS announces "table" along with its row/column counts, helping you gauge its size.',
      ),
      const QuizQuestion(
        question: 'Which tab do you open to add an entrance/exit effect to an object in JAWS?',
        options: ['Animations tab', 'Design tab', 'Review tab', 'View tab'],
        correctIndex: 0,
        explanation: 'The Animations tab (Alt + A) is where entrance, emphasis, and exit effects are added.',
      ),
      const QuizQuestion(
        question: 'How do you add a description that JAWS will read for a picture on a slide?',
        options: ['Right-click the object → Edit Alt Text', 'Rename the file', 'Change the picture color', 'Resize the picture'],
        correctIndex: 0,
        explanation: 'Edit Alt Text is where you add the description screen readers will announce.',
      ),
    ],
    ScreenReaderKind.narrator: [
      const QuizQuestion(
        question: 'How complete is Narrator\'s detail on animation timing compared to JAWS/NVDA?',
        options: [
          'Slightly less descriptive detail about exact timing',
          'Identical, no differences',
          'Narrator cannot access animations at all',
          'Narrator only works with animations disabled',
        ],
        correctIndex: 0,
        explanation: 'Narrator announces animation names but with somewhat less descriptive timing detail than NVDA or JAWS.',
      ),
      const QuizQuestion(
        question: 'Which access-key sequence opens the Animations tab, usable with Narrator?',
        options: ['Alt + A', 'Alt + G', 'Alt + N', 'Alt + H'],
        correctIndex: 0,
        explanation: 'Alt + A opens the Animations tab regardless of the active screen reader.',
      ),
      const QuizQuestion(
        question: 'Why is adding Alt Text manually especially important with Narrator?',
        options: [
          'Narrator infers less contextual detail automatically for complex objects like SmartArt',
          'Narrator ignores Alt Text completely',
          'Narrator requires Alt Text to open the file',
          'Narrator only supports Alt Text in Word, not PowerPoint',
        ],
        correctIndex: 0,
        explanation: 'Since Narrator gives less automatic context for complex objects, explicit Alt Text matters even more.',
      ),
    ],
  };

  final advancedByReader = {
    ScreenReaderKind.nvda: [
      const QuizQuestion(
        question: 'Where can you review the play order of multiple animation effects on a slide in NVDA?',
        options: ['The Animation Pane (Alt + A, then B)', 'The Notes pane', 'The Slide Sorter only', 'The Outline view'],
        correctIndex: 0,
        explanation: 'The Animation Pane lists every effect in play order, which NVDA reads as a normal list.',
      ),
      const QuizQuestion(
        question: 'Why might NVDA announce a table\'s row/column counts less explicitly than JAWS?',
        options: [
          'NVDA and JAWS differ slightly in how verbosely they describe table objects by default',
          'NVDA cannot read tables at all',
          'NVDA requires a paid add-on for tables',
          'Tables are not supported in PowerPoint',
        ],
        correctIndex: 0,
        explanation: 'Both can read tables, but their default verbosity and phrasing for object metadata differs somewhat.',
      ),
      const QuizQuestion(
        question: 'What is the correct sequence to enter a table on a slide and navigate its cells in NVDA?',
        options: [
          'Tab to reach the table, then Enter, then use arrow keys',
          'Press Ctrl + T only',
          'Double-click is required; no keyboard method exists',
          'Press F2 immediately without tabbing',
        ],
        correctIndex: 0,
        explanation: 'You tab to the table object, press Enter to go inside it, then arrow keys move cell by cell.',
      ),
    ],
    ScreenReaderKind.jaws: [
      const QuizQuestion(
        question: 'What is the recommended workflow for reviewing complex SmartArt with JAWS?',
        options: [
          'Ensure thorough Alt Text is set, since SmartArt structure itself is hard to convey via speech',
          'Ignore SmartArt entirely, it is never accessible',
          'Convert SmartArt to a video first',
          'JAWS reads SmartArt exactly like a bulleted list automatically',
        ],
        correctIndex: 0,
        explanation: 'SmartArt\'s visual layout doesn\'t translate well to speech, so a clear Alt Text description is the most reliable approach.',
      ),
      const QuizQuestion(
        question: 'Which Ribbon sequence inserts a video or audio clip via the Insert tab?',
        options: ['Alt + N, M', 'Alt + G, M', 'Alt + A, M', 'Alt + H, M'],
        correctIndex: 0,
        explanation: 'Alt + N opens Insert, and M is the access key for media in that tab.',
      ),
      const QuizQuestion(
        question: 'What should you check first if a picture seems to produce no announcement at all in JAWS?',
        options: [
          'Whether it has Alt Text set',
          'Whether the file is a .pptx or .ppt',
          'Whether JAWS is updated',
          'Whether the picture is JPG or PNG',
        ],
        correctIndex: 0,
        explanation: 'A picture with no Alt Text has nothing for JAWS to announce beyond "picture," so checking Alt Text is the first step.',
      ),
    ],
    ScreenReaderKind.narrator: [
      const QuizQuestion(
        question: 'Given Narrator\'s more limited handling of complex objects, what practice best protects accessibility?',
        options: [
          'Writing clear, complete Alt Text for every non-text object',
          'Avoiding images altogether',
          'Only using Narrator for review, never for authoring',
          'Disabling all animations',
        ],
        correctIndex: 0,
        explanation: 'Thorough Alt Text compensates for Narrator giving less automatic contextual detail on complex objects.',
      ),
      const QuizQuestion(
        question: 'Which access-key sequence opens the Design tab, consistent across screen readers including Narrator?',
        options: ['Alt + G', 'Alt + D', 'Alt + T', 'Alt + S'],
        correctIndex: 0,
        explanation: 'Alt + G is the PowerPoint Ribbon access key for the Design tab regardless of screen reader.',
      ),
      const QuizQuestion(
        question: 'What is a reasonable strategy when reviewing an animation-heavy deck with Narrator?',
        options: [
          'Cross-check timing/order details against the Animation Pane rather than relying on the live preview alone',
          'Assume all effects play instantly with no order',
          'Never use Narrator with animated decks',
          'Turn off all sound in Windows first',
        ],
        correctIndex: 0,
        explanation: 'Since Narrator gives less detailed timing feedback in the live preview, checking the Animation Pane directly is more reliable.',
      ),
    ],
  };

  final byDifficulty = {
    QuizDifficulty.basic: basicByReader,
    QuizDifficulty.intermediate: intermediateByReader,
    QuizDifficulty.advanced: advancedByReader,
  };

  final sets = <QuizSet>[];
  for (final difficulty in QuizDifficulty.values) {
    for (final reader in ScreenReaderKind.values) {
      sets.add(QuizSet(difficulty: difficulty, screenReader: reader, questions: byDifficulty[difficulty]![reader]!));
    }
  }
  return sets;
}
