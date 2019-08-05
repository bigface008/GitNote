# Visual Studio Code 使用笔记

目前使用Setting Sync来同步设置，所以设置文件就不用复制到这里了。

## Issues

1. 目前貌似还没有配置一段被选中的文本周围加上的字符的、语言相关的选项。请看这个[链接](https://github.com/microsoft/vscode/issues/38352)。相关的配置貌似是写死在vscode的editor core[里面](https://github.com/Microsoft/vscode/blob/c7c988c5af378cf4fb4de62066f3783fb5f2e57b/extensions/markdown/language-configuration.json#L15)的。

   如果要上issue找，你就输[surround selection](https://github.com/microsoft/vscode/issues?utf8=%E2%9C%93&q=surround+selection)。

2. 目前Symbol大纲的默认排序貌似还是有点问题。

## Others
1. VScodeVim的链接请到[此处](https://github.com/VSCodeVim/Vim)查看。im-select的链接请到[此处](https://github.com/daipeihust/im-select)查看。
2. 目前使用[CamingoCode](https://github.com/chrissimpkins/codeface/tree/master/fonts/camingo-code)字体。

## Setting File
```json
{
    "workbench.startupEditor": "newUntitledFile",
    "workbench.colorCustomizations": {
        "editor.selectionHighlightBorder": "#666",
    },
    "editor.renderWhitespace": "boundary",
    // "editor.fontFamily": "Fira Code, Microsoft YaHei",
    // "editor.fontFamily": "Consolas, Microsoft YaHei",
    // "editor.fontFamily": "Iosevka, Microsoft YaHei",
    // "editor.fontFamily": "Microsoft YaHei Mono",
    "editor.fontFamily": "CamingoCode, Microsoft YaHei",
    // "editor.fontLigatures": true,
    "editor.rulers": [
        80
    ],
    "emmet.includeLanguages": {
        "javascript": "javascriptreact",
        "vue-html": "html"
    },
    "emmet.triggerExpansionOnTab": true,
    "editor.wordSeparators": "`~!@#$%^&*()-=+[{]}\\|;:'\",.<>/?，。（）；、“”《》：",
    // "workbench.editor.enablePreview": false,
    "terminal.integrated.shell.windows": "C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
    // Vim
    "vim.easymotion": true,
    "vim.hlsearch": true,
    "vim.leader": "<space>",
    "vim.useSystemClipboard": true,
    "vim.handleKeys": {
        "<C-f>": false,
        "<C-c>": false,
        "<C-S-x>": false,
    },
    // Bind p in visual mode to paste without overriding the current register.
    "vim.visualModeKeyBindingsNonRecursive": [
        {
            "before": [
                "p",
            ],
            "after": [
                "p",
                "g",
                "v",
                "y"
            ]
        }
    ],
    "vim.normalModeKeyBindingsNonRecursive": [
        {
            "before": [
                "<C-w>"
            ],
            "commands": [
                ":wq",
            ]
        },
        {
            "before": [
                "<C-n>"
            ],
            "commands": [
                ":nohl",
            ]
        },
        {
            "before": [
                "j"
            ],
            "after": [
                "g",
                "j"
            ]
        },
        {
            "before": [
                "k"
            ],
            "after": [
                "g",
                "k"
            ]
        }
    ],
    "vim.autoSwitchInputMethod.enable": true,
    "vim.autoSwitchInputMethod.defaultIM": "1033",
    "vim.autoSwitchInputMethod.obtainIMCmd": "D:\\program\\im-select\\im-select.exe",
    "vim.autoSwitchInputMethod.switchIMCmd": "D:\\program\\im-select\\im-select.exe {im}",
    "window.zoomLevel": 0,
    "extensions.autoUpdate": false,
    "extensions.ignoreRecommendations": false,
    "editor.suggestSelection": "first",
    "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
    "latex-workshop.view.pdf.viewer": "tab",
    "files.autoSave": "afterDelay",
    "explorer.confirmDragAndDrop": false,
    "[javascript]": {
        "editor.defaultFormatter": "vscode.typescript-language-features"
    },
    "[markdown]": {
        "editor.wordWrap": "on",
        "editor.wordWrapColumn": 80,
        "editor.quickSuggestions": false,
        "editor.tabSize": 4,
        "breadcrumbs.symbolSortOrder": "position",
    },
    "explorer.confirmDelete": false,
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": true,
    "python.linting.lintOnSave": true,
    // "python.autoComplete.addBrackets": true,
    "markdown.extension.syntax.decorations": false,
    // "markdown.preview."
    "markdown.preview.fontFamily": "-apple-system, BlinkMacSystemFont, 'Segoe WPC', 'Segoe UI', 'Ubuntu', 'Droid Sans', 'Microsoft YaHei', sans-serif",
    // "workbench.activityBar.visible": false
    // "[javascript]": {
    //     "editor.defaultFormatter": "HookyQR.beautify"
    // },
    // "workbench.activityBar.visible": false
    "go.useLanguageServer": true,
    "[go]": {
        "editor.snippetSuggestions": "none",
        // "editor.formatOnSave": true,
        // "editor.codeActionsOnSave": {
        //     "source.organizeImports": true
        // }
    },
    "gopls": {
        "usePlaceholders": false // add parameter placeholders when completing a function
    },
    "[cpp]": {
        // "editor.wordBasedSuggestions": false
        "breadcrumbs.symbolSortOrder": "position"
    },
    // "go.useCodeSnippetsOnFunctionSuggest": false
    // "files.eol": "\n", // formatting only supports LF line endings
    "breadcrumbs.symbolSortOrder": "position",
    "markdown.extension.toc.githubCompatibility": true
}
```

## `task.json`

请看这个[链接](https://code.visualstudio.com/docs/editor/tasks)
