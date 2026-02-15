-- matte_mono.lua
-- Sophisticated monochrome theme with subtle color accents
-- Optimized for macOS - looks sexy and professional

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "matte_mono"

-- ============================================================================
-- COLOR PALETTE
-- ============================================================================

-- Base monochrome
local bg_dark = "#181B1D" -- darker panels
local bg_light = "#282C2F" -- lighter panels, popups
local bg_lighter = "#323639" -- hover states
local bg_highlight = "#3A3F44" -- popups, menus

-- Grayscale spectrum
local fg = "#D0D0D0" -- main text
local fg_bright = "#E8E8E8" -- bright text (headings, emphasis)
local fg_dim = "#A0A0A0" -- dimmed text
local gray = "#7C7C7C" -- comments, disabled
local gray_dark = "#5A5A5A" -- very subtle elements

-- Selection and search
local visual_bg = "#4A5560" -- visual selection background

-- Diff backgrounds
local diff_add_bg = "#2A3A2E" -- git add background
local diff_change_bg = "#2E3540" -- git change background
local diff_delete_bg = "#3A2A2E" -- git delete background
local diff_text_bg = "#3A4555" -- diff text highlight

-- Accent colors
local blue = "#8BB4CF" -- functions, methods, types
local green = "#A8C98A" -- strings
local orange = "#D9B88A" -- numbers, constants, search
local purple = "#C49BC4" -- keywords, control flow
local yellow = "#D9C88A" -- yellowings
local red = "#D98E8E" -- errors

-- ============================================================================
-- EDITOR UI
-- ============================================================================

-- Basic UI
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", fg = fg })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", fg = fg })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = gray })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", fg = fg_dim })

-- Cursor
vim.api.nvim_set_hl(0, "Cursor", { bg = blue, fg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = bg_light })
vim.api.nvim_set_hl(0, "CursorColumn", { bg = bg_light })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = fg_bright, bold = true })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = bg_dark })

-- Line numbers & signs
vim.api.nvim_set_hl(0, "LineNr", { fg = gray_dark, bold = true, bg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", fg = gray })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE", fg = gray_dark })

-- Folds
vim.api.nvim_set_hl(0, "Folded", { bg = bg_dark, fg = gray, italic = true })

-- Search & Selection
vim.api.nvim_set_hl(0, "Visual", { bg = visual_bg })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = visual_bg })
vim.api.nvim_set_hl(0, "Search", { bg = orange, fg = bg_dark, bold = true })
vim.api.nvim_set_hl(0, "IncSearch", { bg = orange, fg = bg_dark, bold = true })
vim.api.nvim_set_hl(0, "CurSearch", { bg = orange, fg = bg_dark, bold = true })

-- Statusline
vim.api.nvim_set_hl(0, "StatusLine", { bg = bg_light, fg = fg })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = bg_dark, fg = gray })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = bg_lighter })

-- Tabline
vim.api.nvim_set_hl(0, "TabLine", { bg = bg_dark, fg = gray })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = bg_light, fg = fg_bright, bold = true })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = bg_dark })

-- Popups & Menus
vim.api.nvim_set_hl(0, "Pmenu", { bg = bg_light, fg = fg })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = bg_highlight, fg = fg_bright, bold = true })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = bg_dark })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = gray })

-- Messages & Command line
vim.api.nvim_set_hl(0, "ModeMsg", { fg = fg_bright, bold = true })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = green, bold = true })
vim.api.nvim_set_hl(0, "Question", { fg = blue, bold = true })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = red, bold = true })
vim.api.nvim_set_hl(0, "WarningMsg", { fg = yellow, bold = true })

-- Spelling
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = red })
vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = yellow })
vim.api.nvim_set_hl(0, "SpellRare", { undercurl = true, sp = purple })
vim.api.nvim_set_hl(0, "SpellLocal", { undercurl = true, sp = blue })

-- Diff
vim.api.nvim_set_hl(0, "DiffAdd", { bg = diff_add_bg, fg = green })
vim.api.nvim_set_hl(0, "DiffChange", { bg = diff_change_bg, fg = blue })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = diff_delete_bg, fg = red })
vim.api.nvim_set_hl(0, "DiffText", { bg = diff_text_bg, fg = fg_bright, bold = true })

-- Misc
vim.api.nvim_set_hl(0, "Directory", { fg = blue })
vim.api.nvim_set_hl(0, "Title", { fg = fg_bright, bold = true })
vim.api.nvim_set_hl(0, "MatchParen", { bg = bg_highlight, fg = orange, bold = true })
vim.api.nvim_set_hl(0, "NonText", { fg = gray_dark })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = gray_dark })
vim.api.nvim_set_hl(0, "Whitespace", { fg = gray_dark })

-- ============================================================================
-- SYNTAX HIGHLIGHTING
-- ============================================================================

-- Comments
vim.api.nvim_set_hl(0, "Comment", { fg = gray, italic = true })
vim.api.nvim_set_hl(0, "SpecialComment", { fg = gray, italic = true, bold = true })
vim.api.nvim_set_hl(0, "Todo", { fg = yellow, bold = true, italic = true })

-- Constants
vim.api.nvim_set_hl(0, "Constant", { fg = orange })
vim.api.nvim_set_hl(0, "String", { fg = green })
vim.api.nvim_set_hl(0, "Character", { fg = green })
vim.api.nvim_set_hl(0, "Number", { fg = orange })
vim.api.nvim_set_hl(0, "Boolean", { fg = orange, bold = true })
vim.api.nvim_set_hl(0, "Float", { fg = orange })

-- Identifiers
vim.api.nvim_set_hl(0, "Identifier", { fg = fg })
vim.api.nvim_set_hl(0, "Function", { fg = blue })

-- Statements
vim.api.nvim_set_hl(0, "Statement", { fg = purple, bold = true })
vim.api.nvim_set_hl(0, "Conditional", { fg = purple, bold = true })
vim.api.nvim_set_hl(0, "Repeat", { fg = purple, bold = true })
vim.api.nvim_set_hl(0, "Label", { fg = purple })
vim.api.nvim_set_hl(0, "Operator", { fg = fg_dim })
vim.api.nvim_set_hl(0, "Keyword", { fg = purple, bold = true })
vim.api.nvim_set_hl(0, "Exception", { fg = red, bold = true })

-- PreProc
vim.api.nvim_set_hl(0, "PreProc", { fg = purple })
vim.api.nvim_set_hl(0, "Include", { fg = purple })
vim.api.nvim_set_hl(0, "Define", { fg = purple })
vim.api.nvim_set_hl(0, "Macro", { fg = purple })
vim.api.nvim_set_hl(0, "PreCondit", { fg = purple })

-- Types
vim.api.nvim_set_hl(0, "Type", { fg = blue })
vim.api.nvim_set_hl(0, "StorageClass", { fg = purple })
vim.api.nvim_set_hl(0, "Structure", { fg = blue })
vim.api.nvim_set_hl(0, "Typedef", { fg = blue })

-- Special
vim.api.nvim_set_hl(0, "Special", { fg = fg_bright })
vim.api.nvim_set_hl(0, "SpecialChar", { fg = orange })
vim.api.nvim_set_hl(0, "Tag", { fg = blue })
vim.api.nvim_set_hl(0, "Delimiter", { fg = fg_dim })
vim.api.nvim_set_hl(0, "Debug", { fg = red })

-- Underlined & Error
vim.api.nvim_set_hl(0, "Underlined", { underline = true })
vim.api.nvim_set_hl(0, "Ignore", { fg = gray_dark })
vim.api.nvim_set_hl(0, "Error", { fg = red, bold = true })

-- ============================================================================
-- TREESITTER (Modern syntax highlighting)
-- ============================================================================

-- Variables
vim.api.nvim_set_hl(0, "@variable", { fg = fg })
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = orange, italic = true })
vim.api.nvim_set_hl(0, "@variable.parameter", { fg = fg_dim, italic = true })
vim.api.nvim_set_hl(0, "@variable.member", { fg = fg })

-- Constants
vim.api.nvim_set_hl(0, "@constant", { fg = orange })
vim.api.nvim_set_hl(0, "@constant.builtin", { fg = orange, bold = true })
vim.api.nvim_set_hl(0, "@constant.macro", { fg = purple })

-- Modules & Namespaces
vim.api.nvim_set_hl(0, "@module", { fg = blue })
vim.api.nvim_set_hl(0, "@namespace", { fg = blue })

-- Strings & Text
vim.api.nvim_set_hl(0, "@string", { fg = green })
vim.api.nvim_set_hl(0, "@string.documentation", { fg = gray, italic = true })
vim.api.nvim_set_hl(0, "@string.regex", { fg = purple })
vim.api.nvim_set_hl(0, "@string.escape", { fg = orange })
vim.api.nvim_set_hl(0, "@character", { fg = green })
vim.api.nvim_set_hl(0, "@number", { fg = orange })
vim.api.nvim_set_hl(0, "@boolean", { fg = orange, bold = true })
vim.api.nvim_set_hl(0, "@float", { fg = orange })

-- Functions
vim.api.nvim_set_hl(0, "@function", { fg = blue })
vim.api.nvim_set_hl(0, "@function.builtin", { fg = blue, bold = true })
vim.api.nvim_set_hl(0, "@function.call", { fg = blue })
vim.api.nvim_set_hl(0, "@function.macro", { fg = purple })
vim.api.nvim_set_hl(0, "@method", { fg = blue })
vim.api.nvim_set_hl(0, "@method.call", { fg = blue })
vim.api.nvim_set_hl(0, "@constructor", { fg = blue, bold = true })

-- Keywords
vim.api.nvim_set_hl(0, "@keyword", { fg = purple, bold = true })
vim.api.nvim_set_hl(0, "@keyword.function", { fg = purple, bold = true })
vim.api.nvim_set_hl(0, "@keyword.operator", { fg = purple })
vim.api.nvim_set_hl(0, "@keyword.return", { fg = purple, bold = true })
vim.api.nvim_set_hl(0, "@keyword.import", { fg = purple })
vim.api.nvim_set_hl(0, "@conditional", { fg = purple, bold = true })
vim.api.nvim_set_hl(0, "@repeat", { fg = purple, bold = true })
vim.api.nvim_set_hl(0, "@exception", { fg = red, bold = true })

-- Operators
vim.api.nvim_set_hl(0, "@operator", { fg = fg_dim })

-- Punctuation
vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = fg_dim })
vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = fg_dim })
vim.api.nvim_set_hl(0, "@punctuation.special", { fg = fg_bright })

-- Types
vim.api.nvim_set_hl(0, "@type", { fg = blue })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = blue, bold = true })
vim.api.nvim_set_hl(0, "@type.definition", { fg = blue })
vim.api.nvim_set_hl(0, "@attribute", { fg = purple })
vim.api.nvim_set_hl(0, "@property", { fg = fg })

-- Tags (HTML, XML, JSX)
vim.api.nvim_set_hl(0, "@tag", { fg = blue })
vim.api.nvim_set_hl(0, "@tag.attribute", { fg = blue })
vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = fg_dim })

-- Comments
vim.api.nvim_set_hl(0, "@comment", { fg = gray, italic = true })
vim.api.nvim_set_hl(0, "@comment.documentation", { fg = gray, italic = true })
vim.api.nvim_set_hl(0, "@comment.error", { fg = red, bold = true })
vim.api.nvim_set_hl(0, "@comment.yellowing", { fg = yellow, bold = true })
vim.api.nvim_set_hl(0, "@comment.todo", { fg = yellow, bold = true, italic = true })
vim.api.nvim_set_hl(0, "@comment.note", { fg = blue, bold = true, italic = true })

-- Markup (Markdown, etc.)
vim.api.nvim_set_hl(0, "@markup.strong", { bold = true })
vim.api.nvim_set_hl(0, "@markup.italic", { italic = true })
vim.api.nvim_set_hl(0, "@markup.strikethrough", { strikethrough = true })
vim.api.nvim_set_hl(0, "@markup.underline", { underline = true })
vim.api.nvim_set_hl(0, "@markup.heading", { fg = fg_bright, bold = true })
vim.api.nvim_set_hl(0, "@markup.link", { fg = blue, underline = true })
vim.api.nvim_set_hl(0, "@markup.link.url", { fg = blue, italic = true })
vim.api.nvim_set_hl(0, "@markup.raw", { fg = green })
vim.api.nvim_set_hl(0, "@markup.list", { fg = purple })
vim.api.nvim_set_hl(0, "@markup.quote", { fg = gray, italic = true })

-- ============================================================================
-- LSP (Language Server Protocol)
-- ============================================================================

-- Diagnostics
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = red })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = yellow })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = blue })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = blue })
vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = green })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = red })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = yellow })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = blue })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = blue })

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = red, bg = bg_dark })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = yellow, bg = bg_dark })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = blue, bg = bg_dark })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = blue, bg = bg_dark })

-- LSP Semantic Tokens
vim.api.nvim_set_hl(0, "@lsp.type.class", { fg = blue })
vim.api.nvim_set_hl(0, "@lsp.type.decorator", { fg = purple })
vim.api.nvim_set_hl(0, "@lsp.type.enum", { fg = blue })
vim.api.nvim_set_hl(0, "@lsp.type.enumMember", { fg = orange })
vim.api.nvim_set_hl(0, "@lsp.type.function", { fg = blue })
vim.api.nvim_set_hl(0, "@lsp.type.interface", { fg = blue })
vim.api.nvim_set_hl(0, "@lsp.type.macro", { fg = purple })
vim.api.nvim_set_hl(0, "@lsp.type.method", { fg = blue })
vim.api.nvim_set_hl(0, "@lsp.type.namespace", { fg = blue })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = fg_dim, italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = fg })
vim.api.nvim_set_hl(0, "@lsp.type.struct", { fg = blue })
vim.api.nvim_set_hl(0, "@lsp.type.type", { fg = blue })
vim.api.nvim_set_hl(0, "@lsp.type.typeParameter", { fg = blue, italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.variable", { fg = fg })

-- ============================================================================
-- GIT SIGNS (gitsigns.nvim)
-- ============================================================================

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = green })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = blue })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = red })
vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = green })
vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = blue })
vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = red })
vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = diff_add_bg })
vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = diff_change_bg })
vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = diff_delete_bg })

-- ============================================================================
-- MINI.PICK (fuzzy finder)
-- ============================================================================

vim.api.nvim_set_hl(0, "MiniPickBorder", { fg = gray, bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniPickBorderBusy", { fg = orange, bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniPickBorderText", { fg = fg_bright, bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniPickIconDirectory", { fg = blue })
vim.api.nvim_set_hl(0, "MiniPickIconFile", { fg = fg })
vim.api.nvim_set_hl(0, "MiniPickHeader", { fg = blue, bold = true })
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { bg = bg_highlight })
vim.api.nvim_set_hl(0, "MiniPickMatchMarked", { fg = green, bold = true })
vim.api.nvim_set_hl(0, "MiniPickMatchRanges", { fg = orange, bold = true })
vim.api.nvim_set_hl(0, "MiniPickNormal", { fg = fg, bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniPickPreviewLine", { bg = bg_highlight })
vim.api.nvim_set_hl(0, "MiniPickPreviewRegion", { bg = bg_lighter })
vim.api.nvim_set_hl(0, "MiniPickPrompt", { fg = blue, bg = "NONE", bold = true })

-- ============================================================================
-- OIL.NVIM (file explorer)
-- ============================================================================

vim.api.nvim_set_hl(0, "OilDir", { fg = blue })
vim.api.nvim_set_hl(0, "OilDirIcon", { fg = blue })
vim.api.nvim_set_hl(0, "OilLink", { fg = purple })
vim.api.nvim_set_hl(0, "OilLinkTarget", { fg = blue })
vim.api.nvim_set_hl(0, "OilCopy", { fg = green, bold = true })
vim.api.nvim_set_hl(0, "OilMove", { fg = orange, bold = true })
vim.api.nvim_set_hl(0, "OilChange", { fg = yellow, bold = true })
vim.api.nvim_set_hl(0, "OilCreate", { fg = green, bold = true })
vim.api.nvim_set_hl(0, "OilDelete", { fg = red, bold = true })
vim.api.nvim_set_hl(0, "OilPermissionNone", { fg = gray_dark })
vim.api.nvim_set_hl(0, "OilPermissionRead", { fg = green })
vim.api.nvim_set_hl(0, "OilPermissionWrite", { fg = yellow })
vim.api.nvim_set_hl(0, "OilPermissionExecute", { fg = blue })
vim.api.nvim_set_hl(0, "OilTypeDir", { fg = blue, bold = true })
vim.api.nvim_set_hl(0, "OilTypeFifo", { fg = orange })
vim.api.nvim_set_hl(0, "OilTypeFile", { fg = fg })
vim.api.nvim_set_hl(0, "OilTypeLink", { fg = purple })
vim.api.nvim_set_hl(0, "OilTypeSocket", { fg = purple })

-- ============================================================================
-- MASON (package manager)
-- ============================================================================

vim.api.nvim_set_hl(0, "MasonNormal", { fg = fg, bg = "NONE" })
vim.api.nvim_set_hl(0, "MasonHeader", { fg = blue, bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "MasonHeaderSecondary", { fg = green, bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "MasonHighlight", { fg = blue })
vim.api.nvim_set_hl(0, "MasonHighlightBlock", { fg = bg_dark, bg = blue })
vim.api.nvim_set_hl(0, "MasonHighlightBlockBold", { fg = bg_dark, bg = blue, bold = true })
vim.api.nvim_set_hl(0, "MasonMuted", { fg = gray })
vim.api.nvim_set_hl(0, "MasonMutedBlock", { fg = fg, bg = "NONE" })
