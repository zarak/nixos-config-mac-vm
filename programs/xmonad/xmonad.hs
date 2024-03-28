-- IMPORTS
{-# LANGUAGE QuasiQuotes #-}
-- IMPORTS
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-missed-extra-shared-lib #-}

-- Imports for Polybar --

import Codec.Binary.UTF8.String qualified as UTF8
import Control.Applicative (liftA2)
import DBus qualified as D
import DBus.Client qualified as D
import Data.Foldable (traverse_)
import Data.Map qualified as M
import Data.Monoid
-- Imports for strachpads

import Data.Semigroup
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import Text.RawString.QQ
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.WithAll (killAll)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive (fadeInactiveLogHook)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.OnPropertyChange
import XMonad.Hooks.UrgencyHook (UrgencyHook (..), withUrgencyHook)
import XMonad.Layout.Grid
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Layout.Spacing (Border (..), Spacing (..), spacingRaw)
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane
import XMonad.ManageHook
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.StackSet qualified as W
import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad
import XMonad.Util.NamedWindows qualified as W
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

data Folder
  = Books
  | Downloads
  | Videos
  deriving (Show)

-- original idea: https://pbrisbin.com/posts/using_notify_osd_for_xmonad_notifications/
data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
  urgencyHook LibNotifyUrgencyHook w = do
    name <- W.getName w
    maybeIdx <- W.findTag w <$> gets windowset
    traverse_ (\i -> safeSpawn "notify-send" [show name, "workspace " ++ i]) maybeIdx

mkRofiCommand :: Folder -> String
mkRofiCommand folder =
  "rofi -dpi 192 -modi filebrowser -show filebrowser -file-browser-dir '~/" <> show folder <> "' -file-browser-depth 3"

fuzzyWindowFinder = "wmctrl -a \"$(wmctrl -l | awk '{$1=$2=$3=\"\"; print substr($0,4)}' | fzf)\""

-- rofiBooksCommand = "rofi -modi file-browser -show file-browser -file-browser-dir '~/Books' -file-browser-depth 3 -theme ~/.config/polybar/material/scripts/rofi/launcher.rasi"

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
-- myTerminal = "alacritty"
myTerminal = "wezterm"

-- GridSelect config
-- myGSConfig = defaultGSConfig { gs_cellheight = 100, gs_cellwidth = 300, gs_font = "xft:Liberation Mono:size=9" }

-- | A colorizer for GridSelect
myColorizer =
  colorRangeFromClassName
    (0x26, 0x32, 0x38) -- lowest inactive bg
    (0x78, 0x90, 0x9c) -- highest inactive bg
    -- (0x60, 0x7d, 0x8b) -- active bg bluegrey
    (0xe9, 0x1e, 0x63) -- active bg old pink
    -- (0xF0, 0x62, 0x92) -- active bg layout pink
    (0x90, 0xa4, 0xae) -- inactive fg
    (0xec, 0xef, 0xf1) -- active fg

gsconfig2 colorizer =
  (buildDefaultGSConfig colorizer)
    { gs_cellheight = 40,
      gs_cellwidth = 350,
      gs_font = "xft:Liberation Mono:size=9"
    }

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
-- myWorkspaces    = ["code","office","graphics","mail","web","6","7","8","9"]
myWorkspaces = ["code", "web", "doc", "note", "vid", "6", "7", "8", "9"]

-- myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
-- icon-2 = graphics;♜
-- icon-3 = mail;♝
-- icon-4 = web;♞

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor = "#dddddd"

-- myFocusedBorderColor = "#ff0000"
-- myFocusedBorderColor = "#cc207e"
myFocusedBorderColor = "#F06292"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myAdditionalKeys :: [(String, X ())]
myAdditionalKeys =
  -- launch a terminal
  [ ("M-S-<Return>", spawn myTerminal),
    -- launcher
    -- ("M-p", spawn "rofi -no-lazy-grab -show drun -modi drun -theme ~/.config/polybar/material/scripts/rofi/launcher.rasi"),
    ("M-p", spawn "rofi -no-lazy-grab -show drun -modi drun -dpi 192"),
    -- close focused window
    ("M-S-c", kill),
    -- Rotate through the available layout algorithms
    ("M-<Space>", sendMessage NextLayout),
    -- Resize viewed windows to the correct size
    ("M-n", refresh),
    -- Browsers
    --
    -- Open vieb
    ("M-b v", spawn "vieb"),
    -- Open qutebrowser
    ("M-b u", spawn "qutebrowser"),
    -- Open Firefox
    ("M-b f", spawn "firefox"),
    -- Consider not using the b-leader because launching chrome is so common
    -- , ("M-b g", spawn "google-chrome-stable")
    --
    -- Open dev version of Google Chrome
    -- , ("M-c", spawn "google-chrome-unstable")
    -- Open beta version of Google Chrome
    -- , ("M-c", spawn "google-chrome-beta")
    --
    ("M-c", spawn "google-chrome-stable"),
    -- Open Brave
    ("M-b b", spawn "brave"),
    -- Open Tor
    ("M-b t", spawn "tor-browser"),
    -- Move focus to the next window
    ("M-<Tab>", windows W.focusDown),
    -- Move focus to the next window
    ("M-j", windows W.focusDown),
    -- Move focus to the previous window
    ("M-k", windows W.focusUp),
    -- Move focus to the master window
    ("M-m", windows W.focusMaster),
    -- Swap the focused window and the master window
    ("M-<Return>", windows W.swapMaster),
    -- Swap the focused window with the next window
    ("M-S-j", windows W.swapDown),
    -- Swap the focused window with the previous window
    ("M-S-k", windows W.swapUp),
    -- Shrink the master area
    ("M-h", sendMessage Shrink),
    -- Expand the master area
    ("M-l", sendMessage Expand),
    -- Push window back into tiling
    ("M-t", withFocused $ windows . W.sink),
    -- Increment the number of windows in the master area
    ("M-<Up>", sendMessage (IncMasterN 1)),
    -- Deincrement the number of windows in the master area
    ("M-<Down>", sendMessage (IncMasterN (-1))),
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    ("M-S-q", io (exitWith ExitSuccess)),
    -- Restart xmonad
    ("M-q", spawn "xmonad --recompile; xmonad --restart"),
    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    -- , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))

    -- Search for files using rofi
    ("M-/ b", spawn $ mkRofiCommand Books),
    -- , ("M-/ d", spawn $ mkRofiCommand Downloads)
    -- , ("M-/ v", spawn $ mkRofiCommand Videos)

    -- Lock screen
    ("M-S-z", spawn "xlock -mode blank +description"),
    -- Avoid this because of risk of confusing with M-S-a (killall)
    -- Anki
    -- , ("M-a", spawn "anki")

    -- GridSelet
    ("M-g", goToSelected $ gsconfig2 myColorizer),
    -- Fzf window select
    ("M-g", spawn fuzzyWindowFinder),
    -- Find a free workspace
    ("M-f", moveTo Next emptyWS),
    -- Run a shell command
    -- , ((modm .|. controlMask, xK_x), shellPrompt def)

    -- Cycle back to previous workspace
    ("M-w", toggleWS' ["NSP"]),
    -- Launch emacs client to current roam
    ("M-e o", spawn "emacsclient -nc -e '(org-roam-dailies-goto-today)'"),
    -- Anki Emacs Shelf
    ("M-e f", spawn "emacsclient -nc ~/Dropbox/org/anki/anki.org"),
    -- Org capture
    ("M-e c", spawn "emacsclient -e '(make-orgcapture-frame)'"),
    -- Launch scratchpad
    ("M-S-s", namedScratchpadAction myScratchpads "terminal"),
    -- , ((modm .|. shiftMask, xK_f), namedScratchpadAction myScratchpads "anki shelf")
    ("M-S-n", namedScratchpadAction myScratchpads "anki"),
    -- Kill all windows on current workspace
    ("M-S-a", killAll)
  ]

-- launch dmenu
-- , ((modm,               xK_p     ), spawn "dmenu_run")

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf),
      --  Reset the layouts on the current workspace to default
      ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
    ]
      ++
      --
      -- mod-[1..9], Switch to workspace N
      -- mod-shift-[1..9], Move client to workspace N
      --
      [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
      ]
      ++
      --
      -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
      -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
      --
      [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | --  | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
          --  | (key, sc) <- zip [xK_w, xK_r] [0..]
          (key, sc) <- zip [xK_comma, xK_period] [0 ..],
          (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
      ]
      ++
      --
      -- audio keys
      --
      [ ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
        ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-mute @DEFAULT_SINK@ false ; pactl set-sink-volume @DEFAULT_SINK@ -5%"),
        ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-mute @DEFAULT_SINK@ false ; pactl set-sink-volume @DEFAULT_SINK@ +5%")
      ]
      ++
      --
      -- brightness keys
      --
      [ ((0, xF86XK_MonBrightnessUp), spawn "lux -a 5%"),
        ((0, xF86XK_MonBrightnessDown), spawn "lux -s 5%")
      ]
      ++
      --
      -- screenshots
      --
      [ ((controlMask, xK_Print), spawn "maim -s ~/Pictures/$(date +%s).png"),
        ((0, xK_Print), spawn "maim ~/Pictures/$(date +%s).png"),
        ((shiftMask, xK_Print), spawn "flameshot gui")
      ]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) =
  M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ( (modm, button1),
        ( \w ->
            focus w
              >> mouseMoveWindow w
              >> windows W.shiftMaster
        )
      ),
      -- mod-button2, Raise the window to the top of the stack
      ((modm, button2), (\w -> focus w >> windows W.shiftMaster)),
      -- mod-button3, Set the window to floating mode and resize by dragging
      ( (modm, button3),
        ( \w ->
            focus w
              >> mouseResizeWindow w
              >> windows W.shiftMaster
        )
      )
      -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

myLayout = spaced1 ||| noBorders Full ||| tabbed ||| spaced2
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2

    -- Percent of screen to increment by when resizing panes
    delta = 5 / 100

    twopane = TwoPane delta ratio

    tabbed = avoidStruts (noBorders simpleTabbed)

    spaced1 = mySpacing 3 (avoidStruts (tiled ||| Mirror tiled))

    spaced2 = mySpacing 3 (avoidStruts (twopane ||| Grid))

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook =
  composeAll
    [ className =? "Qalculate-gtk" --> doFloat,
      className =? "MPlayer" --> doFloat,
      className =? "confirm" --> doFloat,
      className =? "VirtualBox Manager" --> doFloat,
      className =? "file_progress" --> doFloat,
      className =? "dialog" --> doFloat,
      className =? "download" --> doFloat,
      className =? "error" --> doFloat,
      className =? "notification" --> doFloat,
      className =? "pin-entry-gtk-2" --> doFloat,
      className =? "splash" --> doFloat,
      className =? "toolbar" --> doFloat,
      className =? "Anki" --> doFloat,
      className =? "Gimp" --> doFloat,
      className =? "zoom" --> doShift "vid",
      className =? "Anki" --> doShift "note",
      className =? "qutebrowser" --> viewShift "doc",
      className =? "mpv" --> viewShift "vid",
      resource =? "desktop_window" --> doIgnore,
      resource =? "kdesktop" --> doIgnore
    ]
    <+> namedScratchpadManageHook myScratchpads
  where
    viewShift = doF . liftA2 (.) W.greedyView W.shift

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook

--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- myEventHook = mempty
-- myEventHook = docksEventHook <+> ewmhDesktopsEventHook <+> fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- myLogHook = return ()
myLogHook = fadeInactiveLogHook 0.9

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook myConfig = do
  spawnOnce "dropbox &"

-- TODO: This doesn't appear to work?
-- pure () >> checkKeymap myConfig myAdditionalKeys

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.

main :: IO ()
main = mkDbusClient >>= main'

main' :: D.Client -> IO ()
main' dbus =
  xmonad $ ewmh $ ewmhFullscreen $ docks $ urgencyHook $ defaults dbus
  where
    urgencyHook = withUrgencyHook LibNotifyUrgencyHook

------------------------------------------------------------------------
-- Polybar settings (needs DBus client).
--
mkDbusClient :: IO D.Client
mkDbusClient = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.log") opts
  return dbus
  where
    opts = [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str =
  let opath = D.objectPath_ "/org/xmonad/Log"
      iname = D.interfaceName_ "org.xmonad.Log"
      mname = D.memberName_ "Update"
      signal = D.signal opath iname mname
      body = [D.toVariant $ UTF8.decodeString str]
   in D.emit dbus $ signal {D.signalBody = body}

polybarHook :: D.Client -> PP
polybarHook dbus =
  let fwrapper c s
        | s /= "NSP" = wrap ("%{F" <> c <> "} ") " %{F-}" s
        | otherwise = mempty
      bwrapper c s
        | s /= "NSP" = wrap ("%{B" <> c <> "} ") " %{B-}" s
        | otherwise = mempty
      ulwrapper c s
        | s /= "NSP" = wrap ("%{u" <> c <> "}%{+u} ") " %{u-}" s
        | otherwise = mempty
      shortenLayoutTitle = unwords . filter (/= "Spacing") . words
      green = "#76FF03"
      blue = "#607D8B"
      gray = "#7F7F7F"
      orange = "#ea4300"
      -- purple = "#9058c7"
      white = "#ECEFF1"
      red = "#722222"
      pink = "#F06292"
      pinklight = "#F8BBD0"
      cyan = "#84FFFF"
      bluegreylight = "#607D8B"
      bluegreydark = "#37474F"
   in def
        { ppOutput = dbusOutput dbus,
          ppCurrent = bwrapper bluegreylight,
          ppVisible = bwrapper bluegreydark,
          ppUrgent = bwrapper orange,
          ppHidden = fwrapper pink,
          ppHiddenNoWindows = fwrapper gray,
          ppTitle = fwrapper white . shorten 60,
          ppLayout = shortenLayoutTitle,
          -- , ppLayout          = ulwrapper pink . shortenLayoutTitle
          ppWsSep = "",
          ppSep = " : "
        }

myPolybarLogHook dbus = myLogHook <+> dynamicLogWithPP (polybarHook dbus)

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs

--
-- No need to modify this.
--
defaults dbus =
  def
    { -- simple stuff
      terminal = myTerminal,
      focusFollowsMouse = myFocusFollowsMouse,
      clickJustFocuses = myClickJustFocuses,
      borderWidth = myBorderWidth,
      modMask = myModMask,
      workspaces = myWorkspaces,
      normalBorderColor = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,
      -- key bindings
      keys = myKeys,
      mouseBindings = myMouseBindings,
      -- hooks, layouts
      layoutHook = myLayout,
      manageHook = myManageHook,
      -- handleEventHook    = myEventHook,
      logHook = myPolybarLogHook dbus,
      startupHook = myStartupHook (defaults dbus)
    }
    `additionalKeysP` myAdditionalKeys

-- Scratchpads
--
myScratchpads =
  [ NS "terminal" spawnTerm findTerm manageTerm,
    -- , NS "anki shelf" spawnShelf findShelf manageShelf
    NS "anki" spawnAnki findAnki manageAnki
  ]
  where
    spawnTerm = myTerminal ++ [r| start --always-new-process -- tmux new-session -A -s scratchpad 'journalctl -f' \; split-window -v \;|]
    findTerm = title =? "tmux"
    manageTerm = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 - h
        l = 0.95 - w
    -- spawnShelf = "emacsclient -nc ~/Dropbox/org/anki/anki.org"
    -- findShelf = className =? "Emacs"
    -- manageShelf = customFloating $ W.RationalRect l t w h
    -- where
    -- h = 0.9
    -- w = 0.9
    -- t = 0.95 -h
    -- l = 0.95 -w
    spawnAnki = "anki"
    findAnki = className =? "Anki"
    manageAnki = defaultFloating
