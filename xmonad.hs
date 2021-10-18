import XMonad
import System.Exit
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.EZConfig(removeKeys)
import XMonad.Hooks.SetWMName
import System.IO
import Control.Monad (liftM, sequence)
import XMonad.Util.NamedWindows (getName, unName)
import XMonad.Util.Loggers
import qualified XMonad.StackSet as W
import Data.List (intercalate)
import XMonad.Actions.WindowBringer
import XMonad.Actions.Navigation2D
import XMonad.Actions.CycleWS
import XMonad.Actions.CycleWindows
import XMonad.Layout.IndependentScreens
import Graphics.X11.ExtraTypes.XF86

logTitles :: (String -> String) -> Logger
logTitles ppFocus =
        let
            windowTitles windowset = sequence (map (fmap showName . getName) (W.index windowset))
                where
                    fw = W.peek windowset
                    showName nw =
                        let
                            window = unName nw
                            name = show nw
                        in
                            if maybe False (== window) fw
                                then
                                    ppFocus name
                                else
                                    name
        in
            withWindowSet $ liftM (Just . (intercalate " | ")) . windowTitles

myLogHook proc = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn proc
                        --, ppTitle = xmobarColor "green" "" . shorten 50
        		, ppExtras = [logTitles (xmobarColor "green" "")]
			, ppOrder = \(ws:l:t:e) -> [ws] ++ e
			}
 
main = do
    n <- countScreens
    xmproc0 <- spawnPipe "xmobar -x 0 -r /home/adeel/.xmobarrc-top"
    xmproc1 <- spawnPipe "xmobar -x 1 -r /home/adeel/.xmobarrc-top1"
    -- xmprocs <- mapM (\i -> spawnPipe $ "xmobar -x " ++ show i ++ " -r /home/adeel/.xmobarrc-top") [0..n-1]
    xmonad $ docks defaultConfig
        -- { startupHook = do
        -- rects <- xdisplays
        -- {- spawn xmobar -}
    	-- }
	{ terminal = "konsole"
	, startupHook = setWMName "LG3D"
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
--        , logHook = dynamicLogWithPP xmobarPP
--                        { ppOutput = hPutStrLn xmproc1 >> hPutStrLn xmproc0
--                        --, ppTitle = xmobarColor "green" "" . shorten 50
--        		, ppExtras = [logTitles (xmobarColor "green" "")]
--			, ppOrder = \(ws:l:t:e) -> [ws] ++ e
--			}
	, logHook = myLogHook xmproc0 >> myLogHook xmproc1
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `removeKeys`
	[ (mod4Mask .|. shiftMask, xK_q) -- Quit Xmonad
      	, (mod4Mask .|. shiftMask, xK_c)
     	, (mod4Mask .|. shiftMask, xK_Return) -- New terminal
     	, (mod4Mask .|. shiftMask, xK_w)
     	, (mod4Mask , xK_p)
    	] `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xlock") -- petri
	-- , (mod4Mask,               windowGo  )
	-- , (mod4Mask .|. shiftMask, windowSwap)
	, ((mod4Mask .|. shiftMask, xK_Down),  shiftToNext)
	, ((mod4Mask .|. shiftMask, xK_Up),    shiftToPrev)
	, ((mod4Mask .|. shiftMask, xK_Right), windowGo R False)
	, ((mod4Mask,               xK_Down),  nextWS)
	, ((mod4Mask,               xK_Up),    prevWS)
	, ((mod4Mask .|. shiftMask, xK_q), kill)
 	, ((mod4Mask, xK_Return), spawn "konsole")
 	, ((mod4Mask, xK_d), spawn "dmenu_run")
 	, ((mod4Mask, xK_c), spawn "gsimplecal")
 	, ((mod4Mask, xK_x), spawn "clipmenu")
 	, ((mod4Mask .|. shiftMask, xK_e), io (exitWith ExitSuccess))
	, ((mod4Mask .|. shiftMask, xK_g     ), gotoMenu)
	, ((mod4Mask .|. shiftMask, xK_b     ), bringMenu)
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
	, ((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
 	, ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+")
 	, ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5%-")
 	, ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 5")
 	, ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 5")
        ]

