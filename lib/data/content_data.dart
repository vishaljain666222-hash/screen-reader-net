import '../models/models.dart';

/// All course content lives here. This is plain Dart data, so adding a new
/// course/lesson/screen-reader-section/quiz question is just adding another
/// object to these lists — no UI code needs to change.
class ContentData {
  static final List<Course> courses = [
    _wordCourse,
    _excelCourse,
    _powerPointCourse,
    _chromeCourse,
  ];

  // ---------------------------------------------------------------------
  // MICROSOFT WORD
  // ---------------------------------------------------------------------
  static final Course _wordCourse = Course(
    id: 'word',
    title: 'Microsoft Word',
    description:
        'Navigate documents, format text, and use Word efficiently with NVDA, JAWS, and Narrator.',
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
              ShortcutItem(keys: 'NVDA + Ctrl + Down Arrow', description: 'Move to the next heading (when in the Elements List heading tab).'),
              ShortcutItem(keys: 'Insert + T', description: 'Read the title of the current window.'),
              ShortcutItem(keys: 'Ctrl + G', description: 'Open Find and Replace / Go To dialog to jump to a page.'),
            ],
          ),
          ScreenReaderSection(
            screenReaderName: 'JAWS',
            introText:
                'JAWS treats Word documents in a way similar to browsing a webpage, offering single-letter quick navigation for headings when Virtual Ribbon Menu / Virtual PC Cursor features are active. '
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
              ShortcutItem(keys: 'Ctrl + B / I / U', description: 'Apply bold, italic, or underline (standard Word shortcut, announced by NVDA).'),
              ShortcutItem(keys: 'NVDA + F', description: 'Report current character formatting at the cursor.'),
              ShortcutItem(keys: 'Ctrl + Alt + C', description: 'Move to the next spelling error and hear it announced.'),
              ShortcutItem(keys: 'Ctrl + H', description: 'Open Find and Replace.'),
              ShortcutItem(keys: 'NVDA + F12', description: 'Announce the current date/time — useful for timestamps.'),
              ShortcutItem(keys: 'F7', description: 'Start the full spelling and grammar check, read aloud by NVDA.'),
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
    ],
    quiz: [
      QuizQuestion(
        question: 'Which NVDA command reads continuously from the cursor position ("Say All")?',
        options: ['NVDA + Down Arrow', 'NVDA + F7', 'Ctrl + Home', 'Insert + T'],
        correctIndex: 0,
        explanation: 'NVDA + Down Arrow starts Say All, reading continuously until stopped.',
      ),
      QuizQuestion(
        question: 'In JAWS, which single letter key jumps to the next heading while the Virtual Cursor is active?',
        options: ['P', 'H', 'T', 'L'],
        correctIndex: 1,
        explanation: '"H" moves to the next heading, similar to web browsing navigation in JAWS.',
      ),
      QuizQuestion(
        question: 'What must you toggle in Narrator to browse a Word document by headings and structure?',
        options: ['Focus Mode', 'Scan Mode', 'Say All Mode', 'Ribbon Mode'],
        correctIndex: 1,
        explanation: 'Scan Mode (Caps Lock + Space) lets Narrator navigate by structural elements.',
      ),
      QuizQuestion(
        question: 'Which shortcut moves the cursor to the very end of a Word document, in all three screen readers?',
        options: ['Ctrl + End', 'Ctrl + Shift + End', 'End', 'Alt + End'],
        correctIndex: 0,
        explanation: 'Ctrl + End is a standard Word shortcut that all three screen readers respect.',
      ),
      QuizQuestion(
        question: 'Which key starts the spelling and grammar check in Word for all three screen readers?',
        options: ['F5', 'F7', 'F2', 'Ctrl + F7'],
        correctIndex: 1,
        explanation: 'F7 opens the spelling and grammar check, which is then read aloud by whichever screen reader is running.',
      ),
      QuizQuestion(
        question: 'NVDA + F7 opens which feature?',
        options: ['Spell check', 'Elements List', 'Font dialog', 'Print dialog'],
        correctIndex: 1,
        explanation: 'NVDA + F7 opens the Elements List, letting you jump to headings, links, or tables.',
      ),
      QuizQuestion(
        question: 'Which shortcut opens Find and Replace in Word (same across screen readers)?',
        options: ['Ctrl + F', 'Ctrl + H', 'Ctrl + R', 'Ctrl + G'],
        correctIndex: 1,
        explanation: 'Ctrl + H opens Find and Replace directly.',
      ),
      QuizQuestion(
        question: 'What does Insert + F (JAWS) or NVDA + F (NVDA) do?',
        options: [
          'Opens the Font dialog box',
          'Reports current character/font formatting at the cursor',
          'Finds text in the document',
          'Saves the file',
        ],
        correctIndex: 1,
        explanation: 'Both report formatting details such as font name, size, bold/italic at the current cursor position.',
      ),
    ],
  );

  // ---------------------------------------------------------------------
  // MICROSOFT EXCEL
  // ---------------------------------------------------------------------
  static final Course _excelCourse = Course(
    id: 'excel',
    title: 'Microsoft Excel',
    description:
        'Learn to navigate cells, read rows/columns, and work with formulas non-visually using NVDA, JAWS, and Narrator.',
    iconLabel: 'Microsoft Excel course',
    lessons: [
      Lesson(
        id: 'excel_navigation',
        title: 'Cell Navigation & Reading Data',
        summary:
            'Understand how screen readers announce cell references, content, and how to move efficiently through large spreadsheets.',
        sections: [
          ScreenReaderSection(
            screenReaderName: 'NVDA',
            introText:
                'NVDA announces the cell reference (like A1) followed by its contents as you move around with the arrow keys. '
                'Use Ctrl + Arrow keys to jump to the edge of a data region quickly instead of arrowing cell by cell.',
            shortcuts: [
              ShortcutItem(keys: 'Arrow Keys', description: 'Move one cell at a time; NVDA announces cell reference and content.'),
              ShortcutItem(keys: 'Ctrl + Arrow Key', description: 'Jump to the last used cell in a row/column of data.'),
              ShortcutItem(keys: 'Ctrl + Home', description: 'Move to cell A1.'),
              ShortcutItem(keys: 'NVDA + Alt + Arrow', description: 'Read the entire current row or column (context varies by add-on).'),
              ShortcutItem(keys: 'Ctrl + Page Up/Down', description: 'Move between worksheet tabs.'),
              ShortcutItem(keys: 'NVDA + F', description: 'Report formatting of the current cell, including borders.'),
              ShortcutItem(keys: 'Shift + F11', description: 'Insert a new worksheet.'),
            ],
          ),
          ScreenReaderSection(
            screenReaderName: 'JAWS',
            introText:
                'JAWS has dedicated commands for reading entire rows or columns, and can announce headers automatically once you set them with "Set Column/Row Headers", which is extremely useful for large tables.',
            shortcuts: [
              ShortcutItem(keys: 'Arrow Keys', description: 'Move one cell at a time, with cell reference and content spoken.'),
              ShortcutItem(keys: 'Ctrl + Arrow Key', description: 'Jump to the edge of the current data region.'),
              ShortcutItem(keys: 'Insert + Ctrl + Arrow', description: 'Read the entire row or column from the current cell.'),
              ShortcutItem(keys: 'Ctrl + Shift + Right Arrow (in dialog)', description: 'Mark selection when setting row/column headers.'),
              ShortcutItem(keys: 'Ctrl + Home', description: 'Move to cell A1.'),
              ShortcutItem(keys: 'Ctrl + Page Up/Down', description: 'Switch between worksheet tabs.'),
              ShortcutItem(keys: 'Insert + F', description: 'Report font/formatting of the current cell.'),
            ],
          ),
          ScreenReaderSection(
            screenReaderName: 'Narrator',
            introText:
                'Narrator reads the active cell reference and value as you move, and supports basic table navigation commands within Excel using Scan Mode-like table reading commands.',
            shortcuts: [
              ShortcutItem(keys: 'Arrow Keys', description: 'Move one cell at a time; Narrator announces reference and content.'),
              ShortcutItem(keys: 'Ctrl + Arrow Key', description: 'Jump to the edge of a data region.'),
              ShortcutItem(keys: 'Ctrl + Home', description: 'Move to cell A1.'),
              ShortcutItem(keys: 'Ctrl + Page Up/Down', description: 'Move between worksheet tabs.'),
              ShortcutItem(keys: 'Caps Lock + Space', description: 'Toggle Scan Mode for structural browsing.'),
            ],
          ),
        ],
      ),
      Lesson(
        id: 'excel_formulas',
        title: 'Formulas, Sums & Reading Results',
        summary:
            'Learn how to enter formulas confidently and hear calculated results announced correctly.',
        sections: [
          ScreenReaderSection(
            screenReaderName: 'NVDA',
            introText:
                'When you type a formula and press Enter, NVDA reads the resulting calculated value of the cell, not the formula text — press F2 to hear or edit the formula itself.',
            shortcuts: [
              ShortcutItem(keys: 'Alt + =', description: 'Insert AutoSum for the selected range.'),
              ShortcutItem(keys: 'F2', description: 'Edit the current cell; NVDA reads the formula text.'),
              ShortcutItem(keys: 'Esc', description: 'Cancel editing without saving changes.'),
              ShortcutItem(keys: 'Ctrl + `', description: 'Toggle showing formulas instead of results in all cells.'),
            ],
          ),
          ScreenReaderSection(
            screenReaderName: 'JAWS',
            introText:
                'JAWS reads formula results by default and can be configured to speak the formula itself when navigating with a specific keystroke, which is handy for auditing spreadsheets.',
            shortcuts: [
              ShortcutItem(keys: 'Alt + =', description: 'Insert AutoSum for the selected range.'),
              ShortcutItem(keys: 'F2', description: 'Edit the current cell and hear the formula.'),
              ShortcutItem(keys: 'Ctrl + `', description: 'Toggle formula view for the whole sheet.'),
            ],
          ),
          ScreenReaderSection(
            screenReaderName: 'Narrator',
            introText:
                'Narrator announces the calculated result of a formula cell; use F2 to enter edit mode and hear the raw formula text.',
            shortcuts: [
              ShortcutItem(keys: 'Alt + =', description: 'Insert AutoSum for the selected range.'),
              ShortcutItem(keys: 'F2', description: 'Edit the cell and hear the formula text.'),
              ShortcutItem(keys: 'Ctrl + `', description: 'Toggle formula view.'),
            ],
          ),
        ],
      ),
    ],
    quiz: [
      QuizQuestion(
        question: 'What does Ctrl + Arrow Key do in Excel?',
        options: [
          'Selects the entire worksheet',
          'Jumps to the edge of the current data region',
          'Opens a new worksheet',
          'Inserts a formula',
        ],
        correctIndex: 1,
        explanation: 'Ctrl + Arrow jumps to the last non-empty cell in that direction, much faster than arrowing cell by cell.',
      ),
      QuizQuestion(
        question: 'Which JAWS feature lets it automatically announce column names when reading data further down a table?',
        options: ['AutoSum', 'Set Column/Row Headers', 'Say All', 'Virtual Ribbon'],
        correctIndex: 1,
        explanation: 'Setting row/column headers lets JAWS announce header context automatically as you navigate.',
      ),
      QuizQuestion(
        question: 'Pressing F2 on a formula cell does what?',
        options: [
          'Deletes the formula',
          'Enters edit mode so you hear/see the formula text itself',
          'Saves the workbook',
          'Applies bold formatting',
        ],
        correctIndex: 1,
        explanation: 'Normally you hear only the calculated result; F2 lets you review or edit the actual formula.',
      ),
      QuizQuestion(
        question: 'Which shortcut quickly inserts AutoSum for a selected range?',
        options: ['Ctrl + =', 'Alt + =', 'Shift + =', 'Ctrl + Shift + S'],
        correctIndex: 1,
        explanation: 'Alt + = inserts the SUM formula automatically for the detected range.',
      ),
      QuizQuestion(
        question: 'What does Ctrl + ` (backtick) toggle in Excel?',
        options: [
          'Bold text',
          'Showing formulas instead of calculated results',
          'Worksheet protection',
          'AutoSave',
        ],
        correctIndex: 1,
        explanation: 'It switches the whole sheet between showing formulas and showing calculated values.',
      ),
      QuizQuestion(
        question: 'Ctrl + Home moves you to which cell?',
        options: ['The last used cell', 'Cell A1', 'The currently selected column top', 'Nowhere, it is unused in Excel'],
        correctIndex: 1,
        explanation: 'Ctrl + Home always returns the cursor to cell A1.',
      ),
    ],
  );

  // ---------------------------------------------------------------------
  // MICROSOFT POWERPOINT
  // ---------------------------------------------------------------------
  static final Course _powerPointCourse = Course(
    id: 'powerpoint',
    title: 'Microsoft PowerPoint',
    description:
        'Build and review slide decks non-visually — navigating slides, objects, and reading speaker notes with each screen reader.',
    iconLabel: 'Microsoft PowerPoint course',
    lessons: [
      Lesson(
        id: 'ppt_navigation',
        title: 'Navigating Slides & Objects',
        summary:
            'Learn how to move between slides, tab through objects on a slide, and understand what is on screen without seeing it.',
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
            introText:
                'Narrator announces the slide title and object type as focus changes, similar to the other readers, though with slightly less detail on complex object types like SmartArt.',
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
            introText:
                'Switch to Notes view (or use the Notes pane) to read or dictate speaker notes; NVDA reads this pane like a normal text box.',
            shortcuts: [
              ShortcutItem(keys: 'F5', description: 'Start the slideshow from the beginning.'),
              ShortcutItem(keys: 'Shift + F5', description: 'Start the slideshow from the current slide.'),
              ShortcutItem(keys: 'Esc', description: 'End the slideshow.'),
              ShortcutItem(keys: 'Alt + Shift + Tab (Notes pane focus)', description: 'Move focus into/out of the speaker notes pane.'),
            ],
          ),
          ScreenReaderSection(
            screenReaderName: 'JAWS',
            introText:
                'JAWS reads the speaker notes pane the same as any editable text region, and clearly announces when the slideshow starts and ends.',
            shortcuts: [
              ShortcutItem(keys: 'F5', description: 'Start the slideshow from the beginning.'),
              ShortcutItem(keys: 'Shift + F5', description: 'Start from the current slide.'),
              ShortcutItem(keys: 'Esc', description: 'End the slideshow.'),
            ],
          ),
          ScreenReaderSection(
            screenReaderName: 'Narrator',
            introText:
                'Narrator supports the same slideshow shortcuts and reads speaker notes text normally when the notes pane has focus.',
            shortcuts: [
              ShortcutItem(keys: 'F5', description: 'Start the slideshow from the beginning.'),
              ShortcutItem(keys: 'Shift + F5', description: 'Start from the current slide.'),
              ShortcutItem(keys: 'Esc', description: 'End the slideshow.'),
            ],
          ),
        ],
      ),
    ],
    quiz: [
      QuizQuestion(
        question: 'Which key moves you to the next object on the current slide?',
        options: ['Page Down', 'Tab', 'Ctrl + N', 'Enter'],
        correctIndex: 1,
        explanation: 'Tab moves focus to the next object on the slide; Shift + Tab goes back.',
      ),
      QuizQuestion(
        question: 'Which shortcut starts a slideshow from the very beginning?',
        options: ['Shift + F5', 'F5', 'Ctrl + F5', 'Alt + F5'],
        correctIndex: 1,
        explanation: 'F5 starts the presentation from slide one; Shift + F5 starts from the current slide.',
      ),
      QuizQuestion(
        question: 'What do Page Up and Page Down do while editing a PowerPoint deck?',
        options: [
          'Zoom in and out',
          'Move to the previous/next slide',
          'Move to the previous/next object',
          'Nothing, they are unused',
        ],
        correctIndex: 1,
        explanation: 'They move between slides in the slide list/editor.',
      ),
      QuizQuestion(
        question: 'Which key ends a running slideshow?',
        options: ['Esc', 'F5', 'Alt + F4', 'Backspace'],
        correctIndex: 0,
        explanation: 'Esc exits the presentation and returns to the editing view.',
      ),
      QuizQuestion(
        question: 'What does Enter do when focus is on an object (like a text box) on a slide?',
        options: ['Deletes the object', 'Enters edit mode for that object', 'Duplicates the object', 'Moves to the next slide'],
        correctIndex: 1,
        explanation: 'Enter lets you start editing the content of the selected object.',
      ),
    ],
  );

  // ---------------------------------------------------------------------
  // GOOGLE CHROME
  // ---------------------------------------------------------------------
  static final Course _chromeCourse = Course(
    id: 'chrome',
    title: 'Google Chrome',
    description:
        'Browse the web confidently — links, headings, forms, and tabs — using NVDA, JAWS, and Narrator inside Chrome.',
    iconLabel: 'Google Chrome course',
    lessons: [
      Lesson(
        id: 'chrome_page_navigation',
        title: 'Reading & Navigating a Web Page',
        summary:
            'Learn how to move through headings, links, and landmarks on a page, and how to use Say All to read a whole article.',
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
            introText:
                'Narrator announces field type and label as you Tab through forms, and requires Scan Mode to be off while actively typing into a field.',
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
    quiz: [
      QuizQuestion(
        question: 'In NVDA or JAWS Browse Mode, which single key moves you to the next heading on a page?',
        options: ['N', 'H', 'G', 'B'],
        correctIndex: 1,
        explanation: '"H" is the standard single-letter quick key for moving to the next heading in both NVDA and JAWS.',
      ),
      QuizQuestion(
        question: 'Pressing the number "2" while browsing a page in NVDA jumps to which element?',
        options: ['The 2nd link on the page', 'The next Heading level 2 (H2)', 'The 2nd open tab', 'The 2nd form field'],
        correctIndex: 1,
        explanation: 'Number keys 1–6 jump to the next heading of that specific heading level.',
      ),
      QuizQuestion(
        question: 'Which shortcut opens a new browser tab in Chrome?',
        options: ['Ctrl + N', 'Ctrl + T', 'Ctrl + Tab', 'Ctrl + W'],
        correctIndex: 1,
        explanation: 'Ctrl + T opens a new tab; Ctrl + Tab switches between already-open tabs.',
      ),
      QuizQuestion(
        question: 'What does pressing "F" do while browsing a page (Browse Mode) in NVDA or JAWS?',
        options: ['Finds text on the page', 'Moves to the next form field', 'Refreshes the page', 'Opens Favorites'],
        correctIndex: 1,
        explanation: '"F" is the quick navigation key for jumping between form fields.',
      ),
      QuizQuestion(
        question: 'Which key toggles Scan Mode on or off for Narrator in Chrome?',
        options: ['Caps Lock + Space', 'Ctrl + Space', 'Alt + Space', 'Tab'],
        correctIndex: 0,
        explanation: 'Caps Lock + Space toggles Narrator\'s Scan Mode for structural page browsing.',
      ),
      QuizQuestion(
        question: 'Which shortcut moves keyboard focus straight to the Chrome address bar?',
        options: ['Ctrl + L', 'Ctrl + A', 'Alt + D', 'Both Ctrl + L and Alt + D'],
        correctIndex: 3,
        explanation: 'Chrome supports both Ctrl + L and Alt + D to move focus to the address bar.',
      ),
      QuizQuestion(
        question: 'What does the "D" quick key do while browsing with NVDA or JAWS?',
        options: ['Deletes the current element', 'Moves to the next landmark region', 'Downloads the page', 'Opens dev tools'],
        correctIndex: 1,
        explanation: '"D" moves between landmark regions such as navigation, main content, and footer.',
      ),
    ],
  );
}
