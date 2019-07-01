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
    "vim.easymotion": true,
    "vim.hlsearch": true,
    "vim.leader": "<space>",
    "vim.useSystemClipboard": true,
    "editor.rulers": [
        80
    ],
    "emmet.includeLanguages": {
        "javascript": "javascriptreact"
    },
    "emmet.triggerExpansionOnTab": true,
    "editor.wordSeparators": "`~!@#$%^&*()-=+[{]}\\|;:'\",.<>/?，。（）；、“”《》",
    // "workbench.editor.enablePreview": false,
    "terminal.integrated.shell.windows": "C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
    "vim.normalModeKeyBindingsNonRecursive": [
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
    "window.zoomLevel": 0,
    "extensions.autoUpdate": false,
    "extensions.ignoreRecommendations": false,
    "editor.suggestSelection": "first",
    "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
    "latex-workshop.view.pdf.viewer": "tab",
    "files.autoSave": "afterDelay",
    "explorer.confirmDragAndDrop": false,
    // "workbench.activityBar.visible": false
}
```
## Others
1. 目前使用[CamingoCode](https://github.com/chrissimpkins/codeface/tree/master/fonts/camingo-code)字体。