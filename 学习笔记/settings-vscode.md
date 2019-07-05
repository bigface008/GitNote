# Visual Studio Code 使用笔记
## Setting File
```json
{
    "workbench.startupEditor": "newUntitledFile",
    "workbench.colorCustomizations": {
        "editor.selectionHighlightBorder": "#666",
    },
    "editor.renderWhitespace": "boundary",
    // "editor.fontFamily": "Fira Code",
    "editor.fontFamily": "CamingoCode",
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
        "<C-S-x>": false
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
            "before":["<C-w>"],
            "commands": [
                ":wq",
            ]
        },
        {
            "before":["<C-n>"],
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
    // "vim.autoSwitchInputMethod.enable": true,
    // "vim.autoSwitchInputMethod.defaultIM": "1033",
    // "vim.autoSwitchInputMethod.obtainIMCmd": "D:\\program\\im-select\\im-select.exe",
    // "vim.autoSwitchInputMethod.switchIMCmd": "D:\\program\\im-select\\im-select.exe {im}",

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
    "explorer.confirmDelete": false,
    // "[javascript]": {
    //     "editor.defaultFormatter": "HookyQR.beautify"
    // },
    // "workbench.activityBar.visible": false
}
```
## Others
1. VScodeVim的链接请到[此处](https://github.com/VSCodeVim/Vim)查看。im-select的链接请到[此处](https://github.com/daipeihust/im-select)查看。
2. 目前使用[CamingoCode](https://github.com/chrissimpkins/codeface/tree/master/fonts/camingo-code)字体。