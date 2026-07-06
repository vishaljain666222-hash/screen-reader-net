import '../../models/models.dart';

final Course chromeCourse = Course(
  id: 'chrome',
  title: 'Google Chrome',
  description: 'Browse the web confidently — links, headings, forms, and tabs — using NVDA, JAWS, and Narrator inside Chrome.',
  iconLabel: 'Google Chrome course',
  lessons: [
    Lesson(
      id: 'chrome_page_navigation',
      title: 'Reading & Navigating a Web Page',
      summary: 'Learn how to move through headings, links, and landmarks on a page, and how to use Say All to read a whole article.',
      sections: [
        ScreenReaderSection(
          screenReaderName: 'NVDA',
          introText:
              'NVDA uses Browse Mode in Chrome, giving you single-letter quick navigation through headings, links, form fields, and landmarks, plus a full Elements List for a structured overview of the page.',
          shortcuts: [
            ShortcutItem(keys: 'H', description: 'Move to the next heading.'),
            ShortcutItem(keys: 'Shift + H', description: 'Move to the previous heading.'),
            ShortcutItem(keys: '1-6', description: 'Jump to the next heading of that specific level (e.g. press 2 for next H2).'),
            ShortcutItem(keys: 'K', description: 'Move to the next link.'),
            ShortcutItem(keys: 'F', description: 'Move to the next form field.'),
            ShortcutItem(keys: 'D', description: 'Move to the next landmark region.'),
            ShortcutItem(keys: 'NVDA + F7', description: 'Open the Elements List for headings, links, or landmarks.'),
            ShortcutItem(keys: 'NVDA + Down Arrow', description: 'Say All — read the whole page continuously.'),
            ShortcutItem(keys: 'Ctrl + L', description: 'Move focus to the browser address bar.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'JAWS',
          introText:
              'JAWS provides the same style of single-letter quick keys as NVDA in Chrome, plus its own Virtual Cursor and a very detailed Links List and Headings List for scanning a page fast.',
          shortcuts: [
            ShortcutItem(keys: 'H', description: 'Move to the next heading.'),
            ShortcutItem(keys: 'Shift + H', description: 'Move to the previous heading.'),
            ShortcutItem(keys: 'Insert + F6', description: 'Open the Headings List for the page.'),
            ShortcutItem(keys: 'Insert + F7', description: 'Open the Links List for the page.'),
            ShortcutItem(keys: 'Tab', description: 'Move to the next focusable element (links, buttons, fields).'),
            ShortcutItem(keys: 'Insert + Down Arrow', description: 'Say All — read the entire page.'),
            ShortcutItem(keys: 'Ctrl + L', description: 'Move focus to the address bar.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'Narrator',
          introText:
              'Narrator uses Scan Mode in Chrome for structural browsing, offering heading and landmark navigation similar to NVDA/JAWS, though with a smaller command set overall.',
          shortcuts: [
            ShortcutItem(keys: 'Caps Lock + Space', description: 'Toggle Scan Mode on/off.'),
            ShortcutItem(keys: 'H (Scan Mode)', description: 'Move to the next heading.'),
            ShortcutItem(keys: 'Tab', description: 'Move to the next focusable element.'),
            ShortcutItem(keys: 'Caps Lock + Down Arrow', description: 'Read continuously from the current position.'),
            ShortcutItem(keys: 'Ctrl + L', description: 'Move focus to the address bar.'),
          ],
        ),
      ],
    ),
    Lesson(
      id: 'chrome_tabs_and_forms',
      title: 'Tabs, Forms & Everyday Browsing',
      summary: 'Manage multiple tabs and fill in web forms accurately and efficiently with a screen reader.',
      sections: [
        ScreenReaderSection(
          screenReaderName: 'NVDA',
          introText:
              'NVDA announces the field type (edit box, checkbox, combo box) and its label as you Tab through a form. Use Forms Mode automatically or press Enter on a field to start typing.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + Tab', description: 'Move to the next open browser tab.'),
            ShortcutItem(keys: 'Ctrl + Shift + Tab', description: 'Move to the previous open tab.'),
            ShortcutItem(keys: 'Ctrl + T', description: 'Open a new tab.'),
            ShortcutItem(keys: 'Ctrl + W', description: 'Close the current tab.'),
            ShortcutItem(keys: 'F', description: 'Jump to the next form field in Browse Mode.'),
            ShortcutItem(keys: 'Space (on checkbox)', description: 'Toggle a checkbox on or off.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'JAWS',
          introText:
              'JAWS switches automatically between Virtual Cursor (browsing) and Forms Mode (typing) as you Tab into editable fields, announcing the change so you always know which mode you are in.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + Tab', description: 'Move to the next open browser tab.'),
            ShortcutItem(keys: 'Ctrl + Shift + Tab', description: 'Move to the previous open tab.'),
            ShortcutItem(keys: 'Ctrl + T', description: 'Open a new tab.'),
            ShortcutItem(keys: 'Ctrl + W', description: 'Close the current tab.'),
            ShortcutItem(keys: 'Tab', description: 'Move between form fields.'),
            ShortcutItem(keys: 'Space (on checkbox)', description: 'Toggle a checkbox.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'Narrator',
          introText: 'Narrator announces field type and label as you Tab through forms, and requires Scan Mode to be off while actively typing into a field.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + Tab', description: 'Move to the next open browser tab.'),
            ShortcutItem(keys: 'Ctrl + T', description: 'Open a new tab.'),
            ShortcutItem(keys: 'Ctrl + W', description: 'Close the current tab.'),
            ShortcutItem(keys: 'Tab', description: 'Move between form fields.'),
            ShortcutItem(keys: 'Space (on checkbox)', description: 'Toggle a checkbox.'),
          ],
        ),
      ],
    ),
  ],
  quizSets: _buildChromeQuizzes(),
);

List<QuizSet> _buildChromeQuizzes() {
  final basicByReader = {
    ScreenReaderKind.nvda: [
      const QuizQuestion(
        question: 'Which single key moves you to the next heading in NVDA Browse Mode?',
        options: ['N', 'H', 'G', 'B'],
        correctIndex: 1,
        explanation: '"H" is the standard quick key for the next heading.',
      ),
      const QuizQuestion(
        question: 'Which shortcut opens a new browser tab?',
        options: ['Ctrl + N', 'Ctrl + T', 'Ctrl + Tab', 'Ctrl + W'],
        correctIndex: 1,
        explanation: 'Ctrl + T opens a new tab; Ctrl + Tab switches between open tabs.',
      ),
      const QuizQuestion(
        question: 'What does pressing "F" do while browsing a page in NVDA?',
        options: ['Finds text on the page', 'Moves to the next form field', 'Refreshes the page', 'Opens Favorites'],
        correctIndex: 1,
        explanation: '"F" is the quick key for jumping between form fields.',
      ),
    ],
    ScreenReaderKind.jaws: [
      const QuizQuestion(
        question: 'Which shortcut opens the Headings List in JAWS?',
        options: ['Insert + F6', 'Insert + F7', 'Ctrl + H', 'Alt + H'],
        correctIndex: 0,
        explanation: 'Insert + F6 opens a list of headings on the current page.',
      ),
      const QuizQuestion(
        question: 'Which shortcut opens the Links List in JAWS?',
        options: ['Insert + F7', 'Insert + F6', 'Ctrl + L', 'Alt + L'],
        correctIndex: 0,
        explanation: 'Insert + F7 opens a list of links on the page.',
      ),
      const QuizQuestion(
        question: 'Which shortcut starts Say All in JAWS?',
        options: ['Insert + Down Arrow', 'Ctrl + Down Arrow', 'Alt + Down Arrow', 'Insert + Up Arrow'],
        correctIndex: 0,
        explanation: 'Insert + Down Arrow reads the whole page continuously.',
      ),
    ],
    ScreenReaderKind.narrator: [
      const QuizQuestion(
        question: 'Which key toggles Scan Mode in Narrator?',
        options: ['Caps Lock + Space', 'Ctrl + Space', 'Alt + Space', 'Tab'],
        correctIndex: 0,
        explanation: 'Caps Lock + Space toggles Scan Mode for structural browsing.',
      ),
      const QuizQuestion(
        question: 'Which shortcut moves focus to the Chrome address bar?',
        options: ['Ctrl + L', 'Ctrl + A', 'Alt + L', 'Ctrl + Shift + L'],
        correctIndex: 0,
        explanation: 'Ctrl + L moves keyboard focus to the address bar.',
      ),
      const QuizQuestion(
        question: 'Which key moves between focusable elements like links and buttons?',
        options: ['Tab', 'Ctrl + Tab', 'Shift + Enter', 'Ctrl + F'],
        correctIndex: 0,
        explanation: 'Tab moves through the focusable elements on a page.',
      ),
    ],
  };

  final intermediateByReader = {
    ScreenReaderKind.nvda: [
      const QuizQuestion(
        question: 'Pressing the number "2" while browsing with NVDA jumps to which element?',
        options: ['The 2nd link on the page', 'The next Heading level 2 (H2)', 'The 2nd open tab', 'The 2nd form field'],
        correctIndex: 1,
        explanation: 'Number keys 1–6 jump to the next heading of that specific level.',
      ),
      const QuizQuestion(
        question: 'What does the "D" quick key do while browsing with NVDA?',
        options: ['Deletes the current element', 'Moves to the next landmark region', 'Downloads the page', 'Opens dev tools'],
        correctIndex: 1,
        explanation: '"D" moves between landmark regions such as navigation, main, and footer.',
      ),
      const QuizQuestion(
        question: 'Which shortcut toggles a checkbox on a web form?',
        options: ['Space', 'Enter', 'Tab', 'Ctrl + Space'],
        correctIndex: 0,
        explanation: 'Space toggles the checkbox once it has focus.',
      ),
    ],
    ScreenReaderKind.jaws: [
      const QuizQuestion(
        question: 'What happens automatically in JAWS when you Tab into an editable form field?',
        options: [
          'It switches to Forms Mode and announces the change',
          'It closes the browser tab',
          'It mutes all speech',
          'Nothing changes',
        ],
        correctIndex: 0,
        explanation: 'JAWS switches to Forms Mode for typing and announces the mode change so you know what to expect.',
      ),
      const QuizQuestion(
        question: 'Which shortcut moves to the previous open browser tab in JAWS?',
        options: ['Ctrl + Shift + Tab', 'Ctrl + Tab', 'Alt + Tab', 'Shift + Tab'],
        correctIndex: 0,
        explanation: 'Ctrl + Shift + Tab moves to the previous tab; Ctrl + Tab moves to the next.',
      ),
      const QuizQuestion(
        question: 'Which shortcut closes the current browser tab in JAWS?',
        options: ['Ctrl + W', 'Ctrl + Q', 'Alt + F4', 'Ctrl + X'],
        correctIndex: 0,
        explanation: 'Ctrl + W closes just the current tab (not the whole browser).',
      ),
    ],
    ScreenReaderKind.narrator: [
      const QuizQuestion(
        question: 'What must be true for Narrator to let you type into a focused text field on a page?',
        options: [
          'Scan Mode must be off for that field',
          'Scan Mode must always stay on',
          'The page must be reloaded first',
          'JAWS must be running simultaneously',
        ],
        correctIndex: 0,
        explanation: 'Scan Mode needs to be off (or the field auto-exits it) so keystrokes go into the field as text.',
      ),
      const QuizQuestion(
        question: 'Which shortcut moves to the next heading while Narrator\'s Scan Mode is active?',
        options: ['H', 'N', 'G', 'T'],
        correctIndex: 0,
        explanation: '"H" moves to the next heading in Scan Mode, consistent with NVDA and JAWS.',
      ),
      const QuizQuestion(
        question: 'What does Narrator announce as you Tab through a web form?',
        options: ['Field type and label', 'Only the page title', 'Nothing', 'Only the tab number'],
        correctIndex: 0,
        explanation: 'Narrator announces both the type of field (e.g. edit box) and its label.',
      ),
    ],
  };

  final advancedByReader = {
    ScreenReaderKind.nvda: [
      const QuizQuestion(
        question: 'What is the benefit of the "D" landmark navigation key over just reading the whole page top to bottom?',
        options: [
          'It lets you jump straight to major page regions like navigation or main content, saving time',
          'It disables all other navigation',
          'It only works on Chrome\'s own settings pages',
          'It skips reading entirely',
        ],
        correctIndex: 0,
        explanation: 'Landmark navigation is a shortcut past repetitive page chrome straight to meaningful regions.',
      ),
      const QuizQuestion(
        question: 'In the Elements List (NVDA + F7), what are the three main categories typically available?',
        options: [
          'Headings, links, and landmarks/form fields',
          'Fonts, colors, and images',
          'Tabs, windows, and extensions',
          'Cookies, history, and bookmarks',
        ],
        correctIndex: 0,
        explanation: 'The Elements List organizes the page into headings, links, and landmarks (with form fields sometimes included).',
      ),
      const QuizQuestion(
        question: 'Why might a heading-level jump (pressing "3" for next H3) fail to find anything on a poorly built page?',
        options: [
          'The page may skip heading levels or not use real heading markup at all',
          'NVDA only supports up to H2',
          'Chrome blocks heading navigation by default',
          'JAWS must be installed for heading levels to work',
        ],
        correctIndex: 0,
        explanation: 'If a site uses styled text instead of real heading tags, or skips levels, level-specific navigation can come up empty.',
      ),
    ],
    ScreenReaderKind.jaws: [
      const QuizQuestion(
        question: 'What is a good verification step after using Insert + F6 to jump to a heading, to confirm you\'re in the right section?',
        options: [
          'Read a line or two of body text after landing to confirm context',
          'Assume it is always correct without checking',
          'Restart JAWS',
          'Reload the entire page',
        ],
        correctIndex: 0,
        explanation: 'Headings lists can be inconsistent on poorly structured pages, so a quick context check helps confirm you landed correctly.',
      ),
      const QuizQuestion(
        question: 'Why does JAWS announcing the Forms Mode switch matter for efficient form filling?',
        options: [
          'It confirms your keystrokes will now go into the field as text, not be interpreted as navigation commands',
          'It has no practical effect',
          'It only matters for checkboxes',
          'It automatically submits the form',
        ],
        correctIndex: 0,
        explanation: 'Without that confirmation, a user might type letters that get interpreted as quick-navigation keys instead of field text.',
      ),
      const QuizQuestion(
        question: 'What is a likely cause if JAWS never announces a "combo box" for a dropdown you know exists on a page?',
        options: [
          'The dropdown may be built with custom code that lacks proper accessibility markup',
          'JAWS does not support dropdowns',
          'The website is using an unsupported font',
          'The page has too many images',
        ],
        correctIndex: 0,
        explanation: 'Custom-built dropdowns without proper ARIA roles can fail to announce as a combo box even though they look like one visually.',
      ),
    ],
    ScreenReaderKind.narrator: [
      const QuizQuestion(
        question: 'Given Narrator\'s smaller command set, what is a practical strategy for complex, unfamiliar websites?',
        options: [
          'Rely more on Tab and heading navigation, and consider NVDA for heavier accessibility auditing',
          'Avoid using Narrator for browsing entirely',
          'Disable JavaScript on every site',
          'Only use Narrator on Microsoft\'s own websites',
        ],
        correctIndex: 0,
        explanation: 'Narrator covers the essentials well, but power users auditing complex pages sometimes reach for NVDA\'s deeper toolset too.',
      ),
      const QuizQuestion(
        question: 'What might explain Narrator giving less landmark detail than NVDA/JAWS on some pages?',
        options: [
          'Narrator\'s overall command set for landmark regions is smaller',
          'Narrator cannot read HTML at all',
          'Windows blocks landmark reading by policy',
          'Landmarks do not exist in Chrome',
        ],
        correctIndex: 0,
        explanation: 'This course notes Narrator\'s smaller overall command set compared to NVDA and JAWS for structural browsing.',
      ),
      const QuizQuestion(
        question: 'If Scan Mode keeps re-enabling itself while trying to fill a form field with Narrator, what is a reasonable troubleshooting step?',
        options: [
          'Manually toggle Scan Mode off again with Caps Lock + Space right before typing',
          'Restart the computer every time',
          'Switch web browsers only',
          'Disable the keyboard driver',
        ],
        correctIndex: 0,
        explanation: 'Manually toggling Scan Mode off is the direct fix when a field does not automatically hand off to typing mode.',
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
