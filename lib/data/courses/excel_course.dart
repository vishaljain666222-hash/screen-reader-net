import '../../models/models.dart';

final Course excelCourse = Course(
  id: 'excel',
  title: 'Microsoft Excel',
  description:
      'A deep, complete course on working with spreadsheets non-visually — cells, formulas, charts, and data tools — with NVDA, JAWS, and Narrator.',
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
            ShortcutItem(keys: 'Ctrl + End', description: 'Move to the last used cell in the worksheet.'),
            ShortcutItem(keys: 'Ctrl + Page Up/Down', description: 'Move between worksheet tabs.'),
            ShortcutItem(keys: 'NVDA + F', description: 'Report formatting of the current cell, including borders.'),
            ShortcutItem(keys: 'Shift + F11', description: 'Insert a new worksheet.'),
            ShortcutItem(keys: 'Ctrl + Shift + Arrow Key', description: 'Select from the current cell to the edge of the data region.'),
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
      summary: 'Learn to enter formulas confidently and hear calculated results announced correctly.',
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
            ShortcutItem(keys: 'Shift + F3', description: 'Open the Insert Function dialog.'),
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
            ShortcutItem(keys: 'Shift + F3', description: 'Open the Insert Function dialog.'),
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
    Lesson(
      id: 'excel_charts_data_tools',
      title: 'Charts and Data Tools',
      summary: 'Insert charts, understand what screen readers tell you about them, and use PivotTables for summaries.',
      sections: [
        ScreenReaderSection(
          screenReaderName: 'NVDA',
          introText:
              'Charts are graphical objects, so NVDA announces only the chart\'s title and type by default — for real data detail, use "Alt Text" on the chart or review the underlying data table directly, since NVDA cannot read chart visuals.',
          shortcuts: [
            ShortcutItem(keys: 'Alt + F1', description: 'Insert a default chart from the selected data.'),
            ShortcutItem(keys: 'F11', description: 'Create a chart on a new sheet from the selected data.'),
            ShortcutItem(keys: 'Alt + N, V', description: 'Open the PivotTable creation dialog (via Ribbon access keys).'),
            ShortcutItem(keys: 'NVDA + F', description: 'Check whether the selected chart object has useful Alt Text describing it.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'JAWS',
          introText:
              'JAWS can enter a chart object and announce data point values one series at a time using arrow keys once focus is placed on the chart, giving more detail than just the title.',
          shortcuts: [
            ShortcutItem(keys: 'Alt + F1', description: 'Insert a default chart from the selected data.'),
            ShortcutItem(keys: 'F11', description: 'Create a chart on a new sheet.'),
            ShortcutItem(keys: 'Arrow keys (chart focused)', description: 'Move between data series and points, reading values aloud.'),
            ShortcutItem(keys: 'Alt + N, V', description: 'Open the PivotTable creation dialog.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'Narrator',
          introText:
              'Narrator has the most limited chart support of the three — it typically announces only that a chart object exists, so reviewing the source data table is usually the more reliable approach.',
          shortcuts: [
            ShortcutItem(keys: 'Alt + F1', description: 'Insert a default chart from the selected data.'),
            ShortcutItem(keys: 'F11', description: 'Create a chart on a new sheet.'),
            ShortcutItem(keys: 'Ctrl + Home (chart focused)', description: 'Return focus to the worksheet grid from the chart.'),
          ],
        ),
      ],
    ),
    Lesson(
      id: 'excel_validation_filter_sort',
      title: 'Data Validation, Filtering & Sorting',
      summary: 'Set up dropdown data validation, and filter or sort large tables efficiently while staying oriented.',
      sections: [
        ScreenReaderSection(
          screenReaderName: 'NVDA',
          introText:
              'When a cell has data validation with a dropdown list, NVDA announces "has autocomplete" or similar, and Alt + Down Arrow opens the dropdown so you can pick a value with arrow keys.',
          shortcuts: [
            ShortcutItem(keys: 'Alt + Down Arrow', description: 'Open a data validation dropdown list on the current cell.'),
            ShortcutItem(keys: 'Ctrl + Shift + L', description: 'Turn AutoFilter on or off for the selected table.'),
            ShortcutItem(keys: 'Alt + Down Arrow (on filter header)', description: 'Open the filter menu for that column.'),
            ShortcutItem(keys: 'Alt + A, S, A', description: 'Sort ascending via the Data ribbon (access keys).'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'JAWS',
          introText:
              'JAWS announces "combo box" for validation dropdowns and reads the currently applied filter state on a column header, which helps confirm a filter is active without needing to check visually.',
          shortcuts: [
            ShortcutItem(keys: 'Alt + Down Arrow', description: 'Open a data validation dropdown list.'),
            ShortcutItem(keys: 'Ctrl + Shift + L', description: 'Turn AutoFilter on or off.'),
            ShortcutItem(keys: 'Alt + Down Arrow (on filter header)', description: 'Open the filter menu for that column.'),
          ],
        ),
        ScreenReaderSection(
          screenReaderName: 'Narrator',
          introText:
              'Narrator supports opening dropdowns and filters with the same keyboard shortcuts, though it gives less verbose feedback about whether a filter is currently active on a column.',
          shortcuts: [
            ShortcutItem(keys: 'Alt + Down Arrow', description: 'Open a data validation dropdown list.'),
            ShortcutItem(keys: 'Ctrl + Shift + L', description: 'Turn AutoFilter on or off.'),
          ],
        ),
      ],
    ),
  ],
  quizSets: _buildExcelQuizzes(),
);

List<QuizSet> _buildExcelQuizzes() {
  final basicByReader = {
    ScreenReaderKind.nvda: [
      const QuizQuestion(
        question: 'What does Ctrl + Arrow Key do in Excel?',
        options: ['Selects the entire worksheet', 'Jumps to the edge of the current data region', 'Opens a new worksheet', 'Inserts a formula'],
        correctIndex: 1,
        explanation: 'Ctrl + Arrow jumps to the last non-empty cell in that direction.',
      ),
      const QuizQuestion(
        question: 'Which cell does Ctrl + Home move you to?',
        options: ['The last used cell', 'Cell A1', 'The current column top', 'Nowhere, it is unused'],
        correctIndex: 1,
        explanation: 'Ctrl + Home always returns the cursor to cell A1.',
      ),
      const QuizQuestion(
        question: 'Which shortcut quickly inserts AutoSum for a selected range?',
        options: ['Ctrl + =', 'Alt + =', 'Shift + =', 'Ctrl + Shift + S'],
        correctIndex: 1,
        explanation: 'Alt + = inserts the SUM formula automatically for the detected range.',
      ),
    ],
    ScreenReaderKind.jaws: [
      const QuizQuestion(
        question: 'What does JAWS announce as you move between cells?',
        options: ['Only the cell color', 'Cell reference and content', 'Nothing at all', 'Only the sheet name'],
        correctIndex: 1,
        explanation: 'JAWS announces both the cell reference (like B4) and its content.',
      ),
      const QuizQuestion(
        question: 'Which shortcut moves between worksheet tabs in JAWS (and Excel generally)?',
        options: ['Ctrl + Page Up/Down', 'Alt + Page Up/Down', 'Ctrl + Tab', 'Shift + Tab'],
        correctIndex: 0,
        explanation: 'Ctrl + Page Up/Down switches between worksheet tabs.',
      ),
      const QuizQuestion(
        question: 'Which shortcut reports font/formatting of the current cell in JAWS?',
        options: ['Insert + F', 'Ctrl + F', 'Alt + F', 'Insert + T'],
        correctIndex: 0,
        explanation: 'Insert + F reports formatting details of the current cell.',
      ),
    ],
    ScreenReaderKind.narrator: [
      const QuizQuestion(
        question: 'What does Narrator announce as you arrow between cells?',
        options: ['Cell reference and content', 'Only the column letter', 'Nothing', 'Only the row number'],
        correctIndex: 0,
        explanation: 'Narrator announces both the reference and the value of the active cell.',
      ),
      const QuizQuestion(
        question: 'Which shortcut toggles Scan Mode in Narrator for structural browsing?',
        options: ['Caps Lock + Space', 'Ctrl + Space', 'Alt + Space', 'Tab'],
        correctIndex: 0,
        explanation: 'Caps Lock + Space toggles Scan Mode.',
      ),
      const QuizQuestion(
        question: 'Which shortcut moves to the edge of a data region with Narrator active?',
        options: ['Ctrl + Arrow Key', 'Shift + Arrow Key', 'Alt + Arrow Key', 'Tab'],
        correctIndex: 0,
        explanation: 'Ctrl + Arrow Key works the same way regardless of which screen reader is running.',
      ),
    ],
  };

  final intermediateByReader = {
    ScreenReaderKind.nvda: [
      const QuizQuestion(
        question: 'Pressing F2 on a formula cell does what?',
        options: ['Deletes the formula', 'Enters edit mode so you hear/see the formula text', 'Saves the workbook', 'Applies bold formatting'],
        correctIndex: 1,
        explanation: 'F2 lets you review or edit the actual formula rather than just hearing the result.',
      ),
      const QuizQuestion(
        question: 'What does Ctrl + ` (backtick) toggle in Excel?',
        options: ['Bold text', 'Showing formulas instead of results', 'Worksheet protection', 'AutoSave'],
        correctIndex: 1,
        explanation: 'It switches the whole sheet between showing formulas and showing calculated values.',
      ),
      const QuizQuestion(
        question: 'Which shortcut opens a data validation dropdown list on the current cell?',
        options: ['Alt + Down Arrow', 'Ctrl + Down Arrow', 'F4', 'Shift + Down Arrow'],
        correctIndex: 0,
        explanation: 'Alt + Down Arrow opens the dropdown list for a validated cell.',
      ),
    ],
    ScreenReaderKind.jaws: [
      const QuizQuestion(
        question: 'Which JAWS feature lets it automatically announce column names as you read down a table?',
        options: ['AutoSum', 'Set Column/Row Headers', 'Say All', 'Virtual Ribbon'],
        correctIndex: 1,
        explanation: 'Setting row/column headers lets JAWS announce header context automatically.',
      ),
      const QuizQuestion(
        question: 'What does JAWS announce for a data validation dropdown cell?',
        options: ['"Combo box"', '"Picture"', '"Hyperlink"', 'Nothing'],
        correctIndex: 0,
        explanation: 'JAWS announces "combo box" to indicate a dropdown selection is available.',
      ),
      const QuizQuestion(
        question: 'Which shortcut turns AutoFilter on or off for a selected table?',
        options: ['Ctrl + Shift + L', 'Ctrl + F', 'Alt + F', 'Ctrl + Shift + F'],
        correctIndex: 0,
        explanation: 'Ctrl + Shift + L toggles AutoFilter for the selected range.',
      ),
    ],
    ScreenReaderKind.narrator: [
      const QuizQuestion(
        question: 'How much detail can Narrator typically give about a chart object?',
        options: [
          'Full point-by-point data values',
          'Mostly just that a chart object exists',
          'Full color analysis',
          'Nothing about charts, it crashes',
        ],
        correctIndex: 1,
        explanation: 'Narrator has the most limited chart support of the three screen readers.',
      ),
      const QuizQuestion(
        question: 'Which shortcut inserts AutoSum for a selected range, usable with Narrator?',
        options: ['Alt + =', 'Ctrl + =', 'Shift + =', 'F9'],
        correctIndex: 0,
        explanation: 'Alt + = works the same across all screen readers since it is an Excel-level shortcut.',
      ),
      const QuizQuestion(
        question: 'Which shortcut opens a filter menu on a column header?',
        options: ['Alt + Down Arrow (on the header)', 'Ctrl + F', 'Shift + F3', 'Ctrl + Shift + F'],
        correctIndex: 0,
        explanation: 'Alt + Down Arrow on a filtered column header opens that column\'s filter menu.',
      ),
    ],
  };

  final advancedByReader = {
    ScreenReaderKind.nvda: [
      const QuizQuestion(
        question: 'Why can\'t NVDA describe the visual trend of a chart by default?',
        options: [
          'Charts are graphical objects; NVDA reads only title/type unless Alt Text is added',
          'NVDA cannot open Excel files with charts',
          'Charts always crash NVDA',
          'Excel blocks screen readers from charts entirely',
        ],
        correctIndex: 0,
        explanation: 'Without descriptive Alt Text on the chart, NVDA has no way to convey the visual data trend.',
      ),
      const QuizQuestion(
        question: 'What is the safest way to review chart data thoroughly with NVDA?',
        options: [
          'Review the underlying data table directly',
          'Guess based on the chart title only',
          'Enlarge the chart on screen',
          'Change the chart color',
        ],
        correctIndex: 0,
        explanation: 'Reviewing the source data table gives complete, reliable detail that the chart itself cannot convey via speech.',
      ),
      const QuizQuestion(
        question: 'Which Ribbon access-key sequence opens the PivotTable creation dialog?',
        options: ['Alt + N, V', 'Alt + H, V', 'Alt + P, T', 'Alt + F, V'],
        correctIndex: 0,
        explanation: 'Alt + N opens the Insert tab, and V is the PivotTable access key within it.',
      ),
    ],
    ScreenReaderKind.jaws: [
      const QuizQuestion(
        question: 'How does JAWS let you review chart data in more detail than just the title?',
        options: [
          'By entering the chart object and arrowing through data series/points',
          'It cannot; charts are always inaccessible',
          'By exporting to PDF automatically',
          'By reading the chart\'s color palette',
        ],
        correctIndex: 0,
        explanation: 'Once focus is on the chart, arrow keys move between series and points, with JAWS announcing each value.',
      ),
      const QuizQuestion(
        question: 'Which sequence begins setting row/column headers for a table in JAWS?',
        options: [
          'Insert + Ctrl + Space, then follow prompts',
          'Ctrl + Shift + H',
          'Alt + H',
          'Insert + H',
        ],
        correctIndex: 0,
        explanation: 'This starts the header-assignment prompt flow for the currently selected table.',
      ),
      const QuizQuestion(
        question: 'What is a practical benefit of JAWS reading filter state on a column header?',
        options: [
          'You can confirm a filter is active without checking visually',
          'It automatically removes the filter',
          'It hides the column entirely',
          'It disables sorting',
        ],
        correctIndex: 0,
        explanation: 'Hearing the filter state saves you from having to visually inspect the header for a filter icon.',
      ),
    ],
    ScreenReaderKind.narrator: [
      const QuizQuestion(
        question: 'Given Narrator\'s limited chart support, what is the recommended workflow for chart-heavy workbooks?',
        options: [
          'Rely primarily on the underlying data table rather than the chart object',
          'Avoid opening the workbook at all',
          'Only use charts, never tables',
          'Switch to a printed copy',
        ],
        correctIndex: 0,
        explanation: 'Since Narrator gives little chart detail, working from the data table is the more reliable approach.',
      ),
      const QuizQuestion(
        question: 'What is a known limitation of Narrator with filtered column headers compared to JAWS?',
        options: [
          'It gives less verbose feedback about whether a filter is active',
          'It cannot open filtered tables at all',
          'It deletes filtered rows automatically',
          'It disables AutoSum',
        ],
        correctIndex: 0,
        explanation: 'Narrator supports opening filters via the same shortcuts, but announces less detail about active filter state.',
      ),
      const QuizQuestion(
        question: 'Which shortcut returns focus from a focused chart back to the worksheet grid?',
        options: ['Ctrl + Home', 'Esc only', 'Alt + Home', 'Tab'],
        correctIndex: 0,
        explanation: 'Ctrl + Home moves focus back to cell A1 in the worksheet grid.',
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
