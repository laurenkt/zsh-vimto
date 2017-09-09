`zsh-vimto`
===========

A [pure](//github.com/sindresorhus/pure)-compatible extension to `bindkey -v` for zsh.

Pitch: zsh has support for a vim mode and it's improving all the time, however it has a few usability problems out of the box (like not being obvious what mode you're in, or some things not working like you'd expect). This plugin fixes some of those issues and makes it clear which mode you're in whilst retaining a minimal aesthetic.

![screencast demonstrating appearance](https://github.com/laurenkt/zsh-vimto/raw/master/screencast.gif)

Features
--------

+ Changes from block cursor to line cursor depending on whether in cmd or insert mode mode
+ Displays NORMAL on the right side of the prompt when in cmd mode
+ Fixes issue where backspace no longer works when returning from cmd mode
+ Re-enables <kbd>^R</kbd> for incremental search from emacs mode (it's useful...)
+ Reduce the wait timer for switching between modes – default is 0.4s which is very noticable, this plugin reduces it to 1ms
+ tmux support

Todo
----

+ Add a visual indicator for v-line and visual modes. This is currently quite complicated to do (see [this thread](https://www.zsh.org/mla/users/2016/msg00188.html)) but perhaps it will get easier in a future release, or another solution can be found.
