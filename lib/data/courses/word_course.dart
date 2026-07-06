import '../../models/models.dart';

final Course wordCourse = Course(
  id: 'word',
  title: 'Microsoft Word',
  description:
      'A deep, complete course on using Word non-visually — navigation, formatting, tables, styles, templates, and track changes — with NVDA, JAWS, and Narrator.',
  iconLabel: 'Microsoft Word course',
  lessons: [
    Lesson(
      id: 'word_navigation',
      title: 'Getting Started & Navigation',
      summary:
          'Learn how to move around a Word document, jump between headings, and understand where your cursor is, using each screen reader.',
      sections: [
        ScreenReaderSection(
          screenReaderName: 'NVDA',
          introText:
              'NVDA reads Word documents using its Browse Mode-like behaviour for reading, combined with normal editing keys for moving the cursor. '
              'Turn on Say All to have NVDA read continuously from your cursor position, and use the Elements List to jump straight to headings, tables, or links.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + Home / End', description: 'Move to the beginning or end of the document.'),
            ShortcutItem(keys: 'Ctrl + Down/Up Arrow', description: 'Move to the next or previous paragraph.'),
            ShortcutItem(keys: 'NVDA + Down Arrow', description: 'Say All — read continuously from the cursor.'),
            ShortcutItem(keys: 'NVDA + F7', description: 'Open the Elements List (headings, links, tables).'),
            ShortcutItem(keys: 'Ctrl + Page Up/Down', description: 'Move between browsed pages in the document.'),
            ShortcutItem(keys: 'NVDA + Ctrl + Down Arrow', description: 'Move to the next heading (Elements List heading tab).'),
            ShortcutItem(keys: 'Insert + T', description: 'Read the title of the current window.'),
            ShortcutItem(keys: 'Ctrl + G', description: 'Open Find and Replace / Go To dialog to jump to a page.'),
            ShortcutItem(keys: 'NVDA + Numpad 5 / NVDA + 5 (laptop)', description: 'Report the current line, useful when re-orienting yourself.'),
            ShortcutItem(keys: 'Ctrl + Alt + Home', description: 'Move to the very first cell if inside a table (context dependent).'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'JAWS',
          introText:
              'JAWS treats Word documents in a way similar to browsing a webpage, offering single-letter quick navigation for headings when the Virtual PC Cursor is active. '
              'It also announces formatting changes automatically as you type, which is very useful for proofreading.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + Home / End', description: 'Move to the start or end of the document.'),
            ShortcutItem(keys: 'H', description: 'Jump to the next heading (Virtual Cursor active).'),
            ShortcutItem(keys: 'Insert + Down Arrow', description: 'Say All — read the entire document aloud.'),
            ShortcutItem(keys: 'Insert + F6', description: 'Open a list of headings to jump to.'),
            ShortcutItem(keys: 'Insert + F7', description: 'Open a list of links in the document.'),
            ShortcutItem(keys: 'Ctrl + Page Up/Down', description: 'Move between pages.'),
            ShortcutItem(keys: 'Insert + T', description: 'Read the document title.'),
            ShortcutItem(keys: 'Ctrl + F', description: 'Open Find, then use JAWS to read the found text.'),
            ShortcutItem(keys: 'Insert + Ctrl + Home', description: 'Report the total number of pages in the document.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'Narrator',
          introText:
              'Narrator, built into Windows, uses Scan Mode to move through Word documents by headings, paragraphs, and tables. '
              'Toggle Scan Mode on to browse by structure, and off to type freely.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + Home / End', description: 'Move to the start or end of the document.'),
            ShortcutItem(keys: 'Caps Lock + Space', description: 'Toggle Scan Mode on or off.'),
            ShortcutItem(keys: 'Caps Lock + Down Arrow', description: 'Read the next line continuously (Say All-like reading).'),
            ShortcutItem(keys: 'H (in Scan Mode)', description: 'Jump to the next heading.'),
            ShortcutItem(keys: 'Ctrl + Page Up/Down', description: 'Move between pages.'),
            ShortcutItem(keys: 'Caps Lock + F1', description: 'Open the Narrator commands list.'),
            ShortcutItem(keys: 'Ctrl + G', description: 'Open Go To, to jump to a specific page.'),
          ],
        ),
      ],
    ),
    Lesson(
      id: 'word_formatting',
      title: 'Formatting, Editing & Proofing',
      summary:
          'Learn how each screen reader announces bold, italics, font changes, spelling errors, and how to use Find & Replace efficiently.',
      sections: [
        ScreenReaderSection(
          screenReaderName: 'NVDA',
          introText:
              'NVDA can be configured to announce formatting changes such as bold, italics, font name, and font size as you move through text. '
              'Enable this from NVDA\'s Document Formatting settings for the most detail while editing.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + B / I / U', description: 'Apply bold, italic, or underline.'),
            ShortcutItem(keys: 'NVDA + F', description: 'Report current character formatting at the cursor.'),
            ShortcutItem(keys: 'Ctrl + Alt + C', description: 'Move to the next spelling error and hear it announced.'),
            ShortcutItem(keys: 'Ctrl + H', description: 'Open Find and Replace.'),
            ShortcutItem(keys: 'NVDA + F12', description: 'Announce the current date/time — useful for timestamps.'),
            ShortcutItem(keys: 'F7', description: 'Start the full spelling and grammar check, read aloud by NVDA.'),
            ShortcutItem(keys: 'Ctrl + Shift + F', description: 'Open the Font dialog box directly.'),
            ShortcutItem(keys: 'Ctrl + ]  / Ctrl + [', description: 'Increase or decrease font size by one point.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'JAWS',
          introText:
              'JAWS automatically speaks "bold", "italic" or font changes as you arrow through text, if Say All Format Changes is enabled. '
              'It also has a dedicated Spelling Error navigation key.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + B / I / U', description: 'Apply bold, italic, or underline.'),
            ShortcutItem(keys: 'Insert + F', description: 'Report font and formatting information at the cursor.'),
            ShortcutItem(keys: 'Alt + Ctrl + Right/Left Arrow', description: 'Jump to next/previous spelling error underline.'),
            ShortcutItem(keys: 'Ctrl + H', description: 'Open Find and Replace.'),
            ShortcutItem(keys: 'F7', description: 'Start spelling and grammar check.'),
            ShortcutItem(keys: 'Ctrl + Shift + F', description: 'Open the Font dialog box.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'Narrator',
          introText:
              'Narrator announces basic formatting like bold and italic when "Hear formatting" style verbosity is turned up in Narrator settings.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + B / I / U', description: 'Apply bold, italic, or underline.'),
            ShortcutItem(keys: 'Ctrl + H', description: 'Open Find and Replace.'),
            ShortcutItem(keys: 'F7', description: 'Start spelling and grammar check.'),
            ShortcutItem(keys: 'Caps Lock + C', description: 'Announce formatting details of current text (context dependent).'),
          ],
        ),
      ],
    ),
    Lesson(
      id: 'word_tables_lists',
      title: 'Tables and Lists',
      summary:
          'Learn to insert and navigate tables, and to create bulleted or numbered lists confidently without seeing the layout.',
      sections: [
        ScreenReaderSection(
          screenReaderName: 'NVDA',
          introText:
              'Inside a table, NVDA announces row and column numbers as you move between cells with Tab or the arrow keys, and reads column headers automatically if you set them using NVDA\'s table header commands.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + F9 then type table dimensions, or Insert > Table', description: 'Insert a table (menu-driven; use the Ribbon via Alt then N, T).'),
            ShortcutItem(keys: 'Tab / Shift + Tab', description: 'Move to the next/previous cell in a table.'),
            ShortcutItem(keys: 'Alt + Home / End', description: 'Move to the first/last cell in the current table row.'),
            ShortcutItem(keys: 'Alt + Page Up/Down', description: 'Move to the top/bottom cell in the current table column.'),
            ShortcutItem(keys: 'NVDA + Ctrl + Alt + Arrow keys', description: 'Move through the table while hearing row/column headers (after setting headers).'),
            ShortcutItem(keys: 'Ctrl + Shift + L', description: 'Apply or remove a bulleted list on the current paragraph(s).'),
            ShortcutItem(keys: 'Tab (at start of a list line)', description: 'Increase list indent level; Shift + Tab decreases it.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'JAWS',
          introText:
              'JAWS reads table cell coordinates (e.g. "row 2, column 3") as you move, and its Set Column/Row Headers feature lets you hear header context automatically for long tables — extremely useful for data-heavy documents.',
          shortcuts: [
            ShortcutItem(keys: 'Tab / Shift + Tab', description: 'Move to the next/previous cell.'),
            ShortcutItem(keys: 'Alt + Home / End', description: 'Move to the first/last cell in the row.'),
            ShortcutItem(keys: 'Ctrl + Alt + Arrow keys', description: 'Move one cell at a time while hearing header context, once headers are set.'),
            ShortcutItem(keys: 'Insert + Ctrl + Space, then follow prompts', description: 'Set the current row/column as headers for the table.'),
            ShortcutItem(keys: 'Ctrl + Shift + L', description: 'Apply or remove a bulleted list.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'Narrator',
          introText:
              'Narrator announces row and column position when moving through a table with Tab or arrow keys, though it has fewer dedicated table-header commands than NVDA or JAWS.',
          shortcuts: [
            ShortcutItem(keys: 'Tab / Shift + Tab', description: 'Move to the next/previous cell.'),
            ShortcutItem(keys: 'Ctrl + Alt + Arrow keys', description: 'Move between cells while remaining in the table context.'),
            ShortcutItem(keys: 'Ctrl + Shift + L', description: 'Apply or remove a bulleted list.'),
          ],
        ),
      ],
    ),
    Lesson(
      id: 'word_styles_templates',
      title: 'Styles, Templates & Track Changes',
      summary:
          'Apply heading styles consistently, work with templates, and review or make edits others can see using Track Changes.',
      sections: [
        ScreenReaderSection(
          screenReaderName: 'NVDA',
          introText:
              'Using Style shortcuts (rather than just bold/font-size manually) keeps your document\'s headings navigable by every screen reader — this is why NVDA\'s Elements List works so well on well-structured documents.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + Alt + 1 / 2 / 3', description: 'Apply Heading 1, 2, or 3 style to the current paragraph.'),
            ShortcutItem(keys: 'Ctrl + Shift + N', description: 'Apply the Normal (body text) style.'),
            ShortcutItem(keys: 'Ctrl + Shift + S', description: 'Open the Apply Styles pane to pick any style by name.'),
            ShortcutItem(keys: 'Ctrl + Shift + E', description: 'Turn Track Changes on or off.'),
            ShortcutItem(keys: 'Alt + Shift + C then Ctrl + Shift + E (or Review tab)', description: 'Accept or reject tracked changes one at a time via the Review ribbon.'),
            ShortcutItem(keys: 'NVDA + F7 → Comments tab', description: 'List and jump between reviewer comments.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'JAWS',
          introText:
              'JAWS announces the applied style name when you move into a heading, and clearly reads out "insertion" or "deletion" when Track Changes marks are present, making review sessions much easier to follow.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + Alt + 1 / 2 / 3', description: 'Apply Heading 1, 2, or 3 style.'),
            ShortcutItem(keys: 'Ctrl + Shift + S', description: 'Open the Apply Styles pane.'),
            ShortcutItem(keys: 'Ctrl + Shift + E', description: 'Turn Track Changes on or off.'),
            ShortcutItem(keys: 'Alt + R, then G / J', description: 'Navigate to the next/previous tracked change via the Review ribbon.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'Narrator',
          introText:
              'Narrator reads style names similarly when verbosity settings include formatting/style announcements, and reads tracked-change markup as "inserted" or "deleted" text.',
          shortcuts: [
            ShortcutItem(keys: 'Ctrl + Alt + 1 / 2 / 3', description: 'Apply Heading 1, 2, or 3 style.'),
            ShortcutItem(keys: 'Ctrl + Shift + E', description: 'Turn Track Changes on or off.'),
          ],
        ),
      ],
    ),
  ],
  quizSets: _buildWordQuizzes(),
);

List<QuizSet> _buildWordQuizzes() {
  final sets = <QuizSet>[];

  // ---- BASIC ----
  final basicByReader = {
    ScreenReaderKind.nvda: [
      const QuizQuestion(
        question: 'Which NVDA command reads continuously from the cursor ("Say All")?',
        options: ['NVDA + Down Arrow', 'NVDA + F7', 'Ctrl + Home', 'Insert + T'],
        correctIndex: 0,
        explanation: 'NVDA + Down Arrow starts Say All, reading continuously until stopped.',
      ),
      const QuizQuestion(
        question: 'What does NVDA + F7 open in Word?',
        options: ['Spell check', 'Elements List', 'Font dialog', 'Print dialog'],
        correctIndex: 1,
        explanation: 'NVDA + F7 opens the Elements List, for jumping to headings, links, or tables.',
      ),
      const QuizQuestion(
        question: 'Which shortcut moves to the very end of a Word document?',
        options: ['Ctrl + End', 'End', 'Alt + End', 'Ctrl + Shift + End'],
        correctIndex: 0,
        explanation: 'Ctrl + End moves the cursor to the end of the document.',
      ),
    ],
    ScreenReaderKind.jaws: [
      const QuizQuestion(
        question: 'In JAWS, which single letter jumps to the next heading (Virtual Cursor active)?',
        options: ['P', 'H', 'T', 'L'],
        correctIndex: 1,
        explanation: '"H" moves to the next heading, like web browsing navigation.',
      ),
      const QuizQuestion(
        question: 'Which JAWS shortcut starts Say All in a Word document?',
        options: ['Insert + Down Arrow', 'Insert + F6', 'Ctrl + Home', 'Insert + F7'],
        correctIndex: 0,
        explanation: 'Insert + Down Arrow reads continuously from the current position.',
      ),
      const QuizQuestion(
        question: 'Insert + F6 in JAWS opens which list?',
        options: ['Links list', 'Headings list', 'Comments list', 'Fonts list'],
        correctIndex: 1,
        explanation: 'Insert + F6 opens a list of headings you can jump straight to.',
      ),
    ],
    ScreenReaderKind.narrator: [
      const QuizQuestion(
        question: 'What must you toggle in Narrator to browse a document by headings and structure?',
        options: ['Focus Mode', 'Scan Mode', 'Say All Mode', 'Ribbon Mode'],
        correctIndex: 1,
        explanation: 'Scan Mode (Caps Lock + Space) enables structural browsing.',
      ),
      const QuizQuestion(
        question: 'Which key combination reads continuously in Narrator?',
        options: ['Caps Lock + Down Arrow', 'Ctrl + Down Arrow', 'Alt + Down Arrow', 'Caps Lock + Up Arrow'],
        correctIndex: 0,
        explanation: 'Caps Lock + Down Arrow starts continuous reading in Narrator.',
      ),
      const QuizQuestion(
        question: 'Which key opens the Narrator commands list?',
        options: ['Caps Lock + F1', 'Caps Lock + H', 'Caps Lock + N', 'Caps Lock + C'],
        correctIndex: 0,
        explanation: 'Caps Lock + F1 opens a reference list of Narrator commands.',
      ),
    ],
  };

  // ---- INTERMEDIATE ----
  final intermediateByReader = {
    ScreenReaderKind.nvda: [
      const QuizQuestion(
        question: 'Which shortcut reports the current character formatting (font, size, bold) at the cursor in NVDA?',
        options: ['NVDA + F', 'Ctrl + F', 'NVDA + T', 'Ctrl + Shift + F'],
        correctIndex: 0,
        explanation: 'NVDA + F reports the formatting at the current cursor position.',
      ),
      const QuizQuestion(
        question: 'To move between cells in a table while hearing row/column headers in NVDA, which combination is used (after setting headers)?',
        options: ['Tab only', 'NVDA + Ctrl + Alt + Arrow keys', 'Ctrl + Arrow keys', 'Alt + Arrow keys'],
        correctIndex: 1,
        explanation: 'This combination announces header context while moving cell by cell.',
      ),
      const QuizQuestion(
        question: 'Which shortcut applies a Heading 2 style to a paragraph?',
        options: ['Ctrl + Alt + 2', 'Ctrl + 2', 'Ctrl + Shift + 2', 'Alt + 2'],
        correctIndex: 0,
        explanation: 'Ctrl + Alt + 2 applies the Heading 2 style.',
      ),
    ],
    ScreenReaderKind.jaws: [
      const QuizQuestion(
        question: 'Which JAWS feature lets it automatically announce column names as you move down a table?',
        options: ['AutoSum', 'Set Column/Row Headers', 'Say All', 'Virtual Ribbon'],
        correctIndex: 1,
        explanation: 'Setting row/column headers lets JAWS announce header context while navigating.',
      ),
      const QuizQuestion(
        question: 'Which shortcut jumps to the next spelling error underline in JAWS?',
        options: ['Alt + Ctrl + Right Arrow', 'F7', 'Ctrl + Right Arrow', 'Insert + F7'],
        correctIndex: 0,
        explanation: 'Alt + Ctrl + Right Arrow jumps to the next flagged spelling error.',
      ),
      const QuizQuestion(
        question: 'Which shortcut turns Track Changes on or off?',
        options: ['Ctrl + Shift + E', 'Ctrl + T', 'Ctrl + Alt + T', 'Alt + Shift + E'],
        correctIndex: 0,
        explanation: 'Ctrl + Shift + E toggles Track Changes.',
      ),
    ],
    ScreenReaderKind.narrator: [
      const QuizQuestion(
        question: 'When moving through a table in Narrator, what does it announce as you move?',
        options: ['Nothing at all', 'Row and column position', 'Only the cell color', 'The table\'s file size'],
        correctIndex: 1,
        explanation: 'Narrator announces row/column position as you move through table cells.',
      ),
      const QuizQuestion(
        question: 'Which shortcut applies the Heading 1 style in Word (works with Narrator too)?',
        options: ['Ctrl + Alt + 1', 'Ctrl + 1', 'Alt + 1', 'Ctrl + Shift + 1'],
        correctIndex: 0,
        explanation: 'Ctrl + Alt + 1 applies Heading 1 regardless of screen reader.',
      ),
      const QuizQuestion(
        question: 'What does Narrator read out when Track Changes marks are present in a document?',
        options: ['Nothing', '"Inserted" or "deleted" text', 'Only a beep', 'The author\'s name only'],
        correctIndex: 1,
        explanation: 'Narrator announces tracked edits as inserted or deleted text.',
      ),
    ],
  };

  // ---- ADVANCED ----
  final advancedByReader = {
    ScreenReaderKind.nvda: [
      const QuizQuestion(
        question: 'Which NVDA setting must be enabled to hear font/bold/italic changes automatically while arrowing through text?',
        options: [
          'Document Formatting settings',
          'Browse Mode settings',
          'Object Presentation settings',
          'Mouse settings',
        ],
        correctIndex: 0,
        explanation: 'NVDA\'s Document Formatting settings control whether formatting changes are announced automatically.',
      ),
      const QuizQuestion(
        question: 'In the Elements List (NVDA + F7), which tab lets you jump between reviewer comments?',
        options: ['Links tab', 'Comments tab', 'Tables tab', 'Headings tab'],
        correctIndex: 1,
        explanation: 'The Comments tab in the Elements List lists all reviewer comments for quick navigation.',
      ),
      const QuizQuestion(
        question: 'What is the effect of pressing Alt + Home while inside a Word table?',
        options: [
          'Moves to the first cell in the current row',
          'Moves to cell A1 of the whole document',
          'Deletes the current row',
          'Selects the entire table',
        ],
        correctIndex: 0,
        explanation: 'Alt + Home moves to the first cell in the current table row (Alt + End moves to the last).',
      ),
    ],
    ScreenReaderKind.jaws: [
      const QuizQuestion(
        question: 'Which sequence lets you assign the current row as column headers for a table in JAWS?',
        options: [
          'Insert + Ctrl + Space, then follow prompts',
          'Ctrl + Shift + H',
          'Insert + H',
          'Alt + Ctrl + H',
        ],
        correctIndex: 0,
        explanation: 'This JAWS command sequence starts the header-assignment prompts for the active table.',
      ),
      const QuizQuestion(
        question: 'Which ribbon-based sequence moves to the next tracked change in JAWS?',
        options: ['Alt + R, then G', 'Alt + H, then G', 'Ctrl + Alt + G', 'Insert + G'],
        correctIndex: 0,
        explanation: 'Alt + R opens the Review ribbon tab, and G/J step through tracked changes.',
      ),
      const QuizQuestion(
        question: 'What does JAWS do automatically as you type, if Say All Format Changes is enabled?',
        options: [
          'Announces bold/italic/font changes as they occur',
          'Automatically fixes typos',
          'Disables the spell checker',
          'Switches to Braille output only',
        ],
        correctIndex: 0,
        explanation: 'With this setting on, JAWS speaks formatting changes like "bold" as you type or move through text.',
      ),
    ],
    ScreenReaderKind.narrator: [
      const QuizQuestion(
        question: 'Which Narrator verbosity setting controls whether style names like "Heading 1" are announced?',
        options: [
          'Formatting/style verbosity in Narrator settings',
          'Mouse tracking mode',
          'Scan Mode toggle',
          'Text cursor indicator size',
        ],
        correctIndex: 0,
        explanation: 'Turning up formatting/style verbosity is what makes Narrator announce style names.',
      ),
      const QuizQuestion(
        question: 'What is a key limitation of Narrator compared to NVDA/JAWS when working with long tables?',
        options: [
          'It has fewer dedicated table-header commands',
          'It cannot open Word at all',
          'It cannot read any text',
          'It disables Track Changes entirely',
        ],
        correctIndex: 0,
        explanation: 'Narrator has fewer built-in commands for announcing table header context than NVDA or JAWS.',
      ),
      const QuizQuestion(
        question: 'Which shortcut toggles Scan Mode, needed to browse Word documents structurally in Narrator?',
        options: ['Caps Lock + Space', 'Ctrl + Space', 'Alt + Space', 'Caps Lock + Enter'],
        correctIndex: 0,
        explanation: 'Caps Lock + Space is the standard Narrator toggle for Scan Mode.',
      ),
    ],
  };

  final byDifficulty = {
    QuizDifficulty.basic: basicByReader,
    QuizDifficulty.intermediate: intermediateByReader,
    QuizDifficulty.advanced: advancedByReader,
  };

  for (final difficulty in QuizDifficulty.values) {
    for (final reader in ScreenReaderKind.values) {
      sets.add(QuizSet(
        difficulty: difficulty,
        screenReader: reader,
        questions: byDifficulty[difficulty]![reader]!,
      ));
    }
  }
  return sets;
}
