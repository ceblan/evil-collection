<h1 id="title-evil-collection">+TITLE: Evil Collection</h1>
<p>[[https://github.com/emacs-evil/evil-collection/actions][file:https://github.com/emacs-evil/evil-collection/workflows/build/badge.svg?branch=master]][[https://melpa.org/#/evil-collection][file:https://melpa.org/packages/evil-collection-badge.svg]] [[https://stable.melpa.org/#/evil-collection][file:https://stable.melpa.org/packages/evil-collection-badge.svg]]</p>
<p>This is a collection of [[https://github.com/emacs-evil/evil][Evil]] bindings for /the parts of Emacs/ that Evil does not cover properly by default, such as <sub>help-mode</sub>, ~M-x calendar~, Eshell and more.</p>
<p><em>Warning:</em> Expect some default bindings to change in the future.</p>
<p>** Goals</p>
<ol>
<li><p>Reduce context switching: As soon as "moving around" gets hardwired to <sub><hjkl></sub>, it becomes frustratingly inefficient not to have it everywhere.</p></li>
<li><p>Community work: setting up bindings is tremendous work and joining force can only save hours for all of Evil users out there. While not everyone may agree on the chosen bindings, it helps to have something to start with rather than nothing at all. In the end, users are free to override a subset of the proposed bindings to best fit their needs.</p></li>
<li><p>Consistency: Having all bindings defined in one place allows for enforcing consistency across special modes and coordinating the community work to define a reference implementation.</p></li>
</ol>
<p>** Installation</p>
<ul>
<li>Get the package, either from MELPA:</li>
</ul>
<p>: M-x package-install RET evil-collection RET</p>
<p>Or clone / download this repository and modify your <sub>load-path</sub>:</p>
<p>: (add-to-list 'load-path (expand-file-name "/path/to/evil-collection/" user-emacs-directory))</p>
<ul>
<li>Register the bindings, either all at once with</li>
</ul>
<p>: (evil-collection-init)</p>
<p>or mode-by-mode, for instance:</p>
<p>: (with-eval-after-load 'calendar (evil-collection-calendar-setup))</p>
<p>or by providing an argument to <sub>evil-collection-init</sub>:</p>
<p>: (evil-collection-init 'calendar)</p>
<p>The list of supported modes is configured by <sub>evil-collection-mode-list</sub>.</p>
<p><sub>evil-collection</sub> assumes <sub>evil-want-keybinding</sub> is set to nil and <sub>evil-want-integration</sub> is set to t before loading <sub>evil</sub> and <sub>evil-collection.</sub> Note some other packages may load evil (e.g. evil-leader) so bear that in mind when determining when to set the variables.</p>
<p>See https://github.com/emacs-evil/evil-collection/issues/60 and https://github.com/emacs-evil/evil/pull/1087 for more details.</p>
<p>For example:</p>
<p>#+begin_src emacs-lisp :tangle yes (setq evil-want-integration t) ;; This is optional since it's already set to t by default. (setq evil-want-keybinding nil) (require 'evil) (when (require 'evil-collection nil t) (evil-collection-init)) #+end_src</p>
<p>Here's another full TLDR <sub>use-package</sub> example.</p>
<p>#+begin_src emacs-lisp :tangle yes (use-package evil :ensure t :init (setq evil-want-integration t) ;; This is optional since it's already set to t by default. (setq evil-want-keybinding nil) :config (evil-mode 1))</p>
<p>(use-package evil-collection :after evil :ensure t :config (evil-collection-init)) #+end_src</p>
<p>NOTE: If you don't like surprises but still want to use <sub>evil-collection-init</sub>, setting <sub>evil-collection-mode-list</sub> to nil and adding each mode manually might be a better option.</p>
<p>** Configuration</p>
<p>Modify <sub>evil-collection-mode-list</sub> to disable or add any modes that should be evilified by <sub>evil-collection</sub>.</p>
<table>
<colgroup>
<col style="width: 36%" />
<col style="width: 7%" />
<col style="width: 55%" />
</colgroup>
<thead>
<tr class="header">
<th>Variable</th>
<th>Default</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>evil-collection-company-use-tng</td>
<td>t</td>
<td>Set up autocompletion to be similar to Vim's YouCompleteMe.</td>
</tr>
<tr class="even">
<td>evil-collection-calendar-want-org-bindings</td>
<td>nil</td>
<td>Set up Org functions in calendar keymap.</td>
</tr>
<tr class="odd">
<td>evil-collection-outline-bind-tab-p</td>
<td>nil</td>
<td>Enable <tab>-based bindings in Outline mode.</td>
</tr>
<tr class="even">
<td>evil-collection-term-sync-state-and-mode-p</td>
<td>t</td>
<td>Synchronize insert/normal state with char/line-mode in term-mode.</td>
</tr>
<tr class="odd">
<td>evil-collection-setup-minibuffer</td>
<td>nil</td>
<td>Set up Vim style bindings in the minibuffer.</td>
</tr>
<tr class="even">
<td>evil-collection-setup-debugger-keys</td>
<td>t</td>
<td>Set up debugger keys for certain modes.</td>
</tr>
</tbody>
</table>
<p>For example, if you want to enable Evil in the minibuffer, you'll have to turn it on explicitly by customizing <sub>evil-collection-setup-minibuffer</sub> to <sub>t</sub>. Some minibuffer-related packages such as Helm rely on this option.</p>
<p><sub>use-package</sub> example:</p>
<p>#+begin_src emacs-lisp :tangle yes (use-package evil-collection :custom (evil-collection-setup-minibuffer t) :init (evil-collection-init)) #+end_src</p>
<p>** Guidelines</p>
<p>The following rules serve as guiding principles to define the set of standard Evil bindings for various modes. Since special modes are by definition structurally incomparable, those rules cannot be expected to be applied universally.</p>
<p>The rules are more-or-less sorted by priority.</p>
<ol>
<li><p>Don't bind anything to <sub>:</sub> nor <sub><escape></sub>.</p></li>
<li><p>Keep the movement keys when possible and sensible.</p>
<ul>
<li><sub>h</sub>, <sub>j</sub>, <sub>k</sub>, <sub>l</sub></li>
<li><sub>w</sub>, <sub>W</sub>, <sub>b</sub>, <sub>B</sub>, <sub>e</sub>, <sub>E</sub>, <sub>ge</sub>, <sub>gE</sub></li>
<li><sub>f</sub>, <sub>F</sub>, <sub>t</sub>, <sub>T</sub>, <sub>;</sub>, =,=</li>
<li><sub>gg</sub>, <sub>G</sub></li>
<li><sub>|</sub></li>
<li><sub>(</sub>, <sub>)</sub></li>
<li><sub>{</sub>, <sub>}</sub></li>
<li><sub>%</sub></li>
<li><sub>+</sub>, <sub>-</sub>, <sub>0</sub>, <sub>^</sub>, <sub>$</sub></li>
<li><sub>C-i</sub>, <sub>C-o</sub></li>
</ul></li>
<li><p>Keep the yanking and register keys when possible and sensible.</p>
<ul>
<li><sub>y</sub>, <sub>Y</sub></li>
<li>="=</li>
</ul></li>
<li><p>Keep the search keys when possible and sensible.</p>
<ul>
<li><sub>/</sub>, <sub>?</sub></li>
<li><sub>#</sub>, ~*~</li>
</ul></li>
<li><p>Keep the mark keys when possible and sensible.</p>
<ul>
<li><sub>m</sub></li>
<li>='=, =~=</li>
</ul></li>
<li><p>Keep the windowing keys when possible and sensible.</p>
<ul>
<li><sub>H</sub>, <sub>L</sub>, <sub>M</sub></li>
<li><sub>C-e</sub>, <sub>C-y</sub></li>
<li><sub>C-f</sub>, <sub>C-b</sub></li>
<li><sub>C-d</sub>, <sub>C-u</sub></li>
<li><sub>C-w</sub>-prefixed bindings.</li>
<li>Some <sub>z</sub>-prefixed bindings (see below).</li>
</ul></li>
<li><p>The following keys are free when insert state does not make sense in the current mode:</p>
<ul>
<li><p><sub>a</sub>, <sub>A</sub>, <sub>i</sub>, <sub>I</sub></p></li>
<li><p><sub>c</sub>, <sub>C</sub>, <sub>r</sub>, <sub>R</sub>, <sub>s</sub>, <sub>S</sub></p></li>
<li><p><sub>d</sub>, <sub>D</sub>, <sub>x</sub>, <sub>X</sub></p></li>
<li><p><sub>o</sub>, <sub>O</sub></p></li>
<li><p><sub>p</sub>, <sub>P</sub></p></li>
<li><p><sub>=</sub>, <sub>&lt;</sub>, <sub>&gt;</sub></p></li>
<li><p><sub>J</sub></p></li>
<li><p>=~=</p>
<p>Any of those keys can be set to be a prefix key.</p></li>
</ul></li>
<li><p>Prefix keys: <sub>g</sub> and <sub>z</sub> are the ubiquitous prefix keys.</p>
<ul>
<li><sub>g</sub> generally stands for "go" and is best used for movements.</li>
<li><sub>z</sub> is used for scrolling, folding, spell-checking and more.</li>
</ul></li>
<li><p>Macro and action keys</p>
<ul>
<li><sub>@</sub>, <sub>q</sub></li>
<li><sub>.</sub></li>
</ul></li>
<li><p>Ensure terminal compatibility without sacrificing GUI key bindings.</p>
<ul>
<li>Tab key
<ul>
<li>Tab key is recognized as <sub><tab></sub> in GUI and <sub>TAB</sub> in terminal. <sub>TAB</sub> equals <sub>C-i</sub>.</li>
<li><sub>C-i</sub> is bound to jumping forward for vim compatibility. If Shift+Tab is not relevant, just bind ~g TAB~ to the function that Tab is bound to. If Shift+Tab is relevant, bind <sub>g]</sub> and ~g TAB~ to the function that Tab is bound to, and bind <sub>g[</sub> to the function that Shift+Tab is bound to for terminal compatibility.</li>
</ul></li>
<li>Enter key
<ul>
<li>Enter key is recognized as <sub><return></sub> in GUI and <sub>RET</sub> in terminal. <sub>RET</sub> equals <sub>Ctrl+m</sub>.</li>
<li>Bind only <sub>RET</sub> and <sub>M-RET</sub>. Or, bind <sub>RET</sub> and <sub>M-RET</sub> to the same functions <sub><return></sub> and <sub><M-return></sub> are bound to.</li>
<li><sub>S-RET</sub> is impossible on terminal. Bind <sub><S-return></sub> and a vacant key to the same function for terminal compatibility.</li>
</ul></li>
</ul></li>
</ol>
<p>** Rationale</p>
<p>Many special modes share the same set of similar actions. Those actions should share the same bindings across all modes whenever feasible.</p>
<p>*** Motion (<sub>[~, ~]</sub>, <sub>{</sub>, <sub>}</sub>, <sub>(</sub>, <sub>)</sub>, <sub>gj</sub>, <sub>gk</sub>, <sub>C-j</sub>, <sub>C-k</sub>)</p>
<pre><code>- ~[~ and ~]~: Use ~[-~ and ~]-~ prefixed keys for navigation between sections.

  If the mode makes no difference between the end of a section and the beginning
  of the next, use ~[~ and ~]~.

- ~gj~ and ~gk~: synonym for ~[~ and ~]~.  That&#39;s what [[evilmagit][evil-magit]] does.

*Question:* Should ~gj~ / ~gk~ rather be synonyms for ~C-j~ / ~C-k~?  They cannot
emulate the behaviour of ~[]~ or ~][~.

- ~C-j~, ~C-k~: If there is granularity, i.e. subsections, use ~C-j~ and ~C-k~
  to browse them.  This reflects [[evilmagit][evil-magit]] and [[evilmu4e][evil-mu4e]] default
  bindings.

- ~{~, ~}~: If there is no paragraph structure, ~{~ and ~}~ can be used for sub-sectioning.

- ~(~, ~)~: If there is no sentence structure, ~(~ and ~)~ can be used for sub-sectioning.

- ~HJKL~: ~hjkl~ can be used for atomic movements, but ~HJKL~ can usually not be used
  because ~H~, ~K~ and ~L~ are all universal (~J~ is ~evil-join~ and usually
  does not make sense in special modes).

- ~C-h~ should not be remapped: Since we have ~C-j~ and ~C-k~ for vertical motion, it would
  make sense to use ~C-h~ and ~C-l~ for horizontal motion.  There are some
  shortcomings though:

  - In Vim, ~C-h~ works as backspace, but Evil does not follow that behaviour.

  - In Emacs, it is a prefix key for all help-related commands, and so is ~&lt;f1&gt;~.

  - Most importantly, ~C-h~ is too widespread and ubiquitous to be replaced.
    So we don&#39;t.

- ~C-l~: As a consequence of the former point, ~C-l~ is available.

- ~M-&lt;hjkl&gt;~: Those keys are usually free in Evil but still bound to their Emacs
  default (e.g. ~M-l~ is ~downcase-word~).  Besides, if ~C-j~ and ~C-k~ are
  already used, having ~M-j~ and ~M-k~ might add up to the confusion.</code></pre>
<p>*** Quitting (<sub>q</sub>, <sub>ZQ</sub>, <sub>ZZ</sub>)</p>
<pre><code>In Vim, ~q~ is for recording macros.  Vim quits with ~ZZ~ or ~ZQ~.  In most
Emacs special modes, it stands for quitting while macros are recorded/played
with ~&lt;f3&gt;~ and ~&lt;f4&gt;~.

A good rule of thumb would be:

- Always bind ~q~, ~ZZ~ and ~ZQ~ to the mode specific quitting functions. If there is none,

- Bind ~q~ and ~ZZ~ to ~quit-window~

- Bind ~ZQ~ to ~evil-quit~

- If macros don&#39;t make sense in current mode, then ~@~ is available.</code></pre>
<p>*** Refreshing / Reverting (<sub>gr</sub>)</p>
<pre><code>- ~gr~ is used for refreshing in [[evilmagit][evil-magit]], [[evilmu4e][evil-mu4e]], and some Spacemacs
  configurations (org-agenda and neotree among others).

~C-l~ is traditionally used to refresh the terminal screen.  Since there does
not seem to be any existing use of it, we leave the binding free for other uses.</code></pre>
<p>*** Marking</p>
<pre><code>~m~ defaults to ~evil-set-marker~ which might not be very useful in special
modes.
=&#39;= can still be used as it can jump to other buffers.

- ~m~: Mark or toggle mark, depending on what the mode offers.
  In visual mode, always mark.
  With a numeric argument, toggle mark on that many following lines.

- ~u~: Unmark current selection.

- ~U~: Unmark all.

- =~=: Toggle all marks.  This mirrors the &quot;invert-char&quot; Vim command bound to =~=
  by default.

- ~M~: Mark all, if available.  Otherwise use =U~=.

- ~*~: Mark-prefix or mark all if current mode has no prefix. ~*~ is traditionally a wildcard.

- ~%~: Mark regexp.

- ~x~: Execute action on marks.  This mirrors Dired&#39;s binding of ~x~.

If ~*~ is used for marking, then ~#~ is free.

Also note that Emacs inconsistently uses ~u~ and ~U~ to unmark.</code></pre>
<p>*** Selecting / Filtering / Narrowing / Searching</p>
<pre><code>- ~s~ and ~S~ seem to be used in some places like [[mu4e][mu4e]].

  - ~s~: [s]elect/[s]earch/filter candidates according to a pattern.

  - ~S~: Remove filter and select all.

- ~=~ is usually free and its significance is obvious.  It&#39;s taken for zooming though.

- ~|~ is not free but the pipe symbolic is very tantalizing.</code></pre>
<p>*** Sorting</p>
<pre><code>- ~o~: Change the sort [o]rder.
- ~O~: Sort in reverse order.

There is no real consensus around which key to bind to sorting.  What others do by default:

- ~package-menu~ uses ~S~.

- ~M-x proced~ and Dired use ~s~.

- ~profiler~ uses ~A~ and ~D~.

- [[mu4e][mu4e]] uses ~O~.

- [[http://www.nongnu.org/ranger/][ranger]] uses ~o~, inspired from [[http://mutt.org][Mutt]].</code></pre>
<p>*** Go to definition (<sub>gd</sub>, <sub>gD</sub>)</p>
<pre><code>- ~gd~: [g]o to [d]efinition.  This is mostly for programming modes.
  If there&#39;s a corresponding &#39;pop&#39; action, use ~C-t~.</code></pre>
<p>*** Go to current entity</p>
<pre><code>- ~.~: go to current entity (day for calendar, playing track for [[EMMS][EMMS]]).
  Bind only if more relevant than ~evil-repeat~.</code></pre>
<p>*** Open thing at point (<sub>RET</sub>, <sub>S-RET</sub>, <sub>M-RET</sub>, <sub>go</sub>, <sub>gO</sub>)</p>
<pre><code>- ~RET~, ~S-RET~, ~M-RET~: Open thing at point in current window, open in other
  window and display in other window respectively.  The latter is like the
  former with the focus remaining on the current window.

- ~go~, ~gO~: When available, same as ~S-RET~ and ~M-RET~ respectively.  This is
  useful in terminals where ~S-RET~ and ~M-RET~ might not work.</code></pre>
<p>*** Emacs-style jumping (<sub>J</sub>)</p>
<pre><code>- ~J~: [[mu4e][mu4e]] has ~j~ and [[evil-mu4e][evil-mu4e]] uses ~J~, so we use ~J~ too.

Some special modes like [[mu4e][mu4e]] and ibuffer offer to &quot;jump&quot; to a different
buffer.  This sometimes depends on the thing at point.

This is not related to Evil jumps like ~C-i~ and ~C-o~, nor to &quot;go to
definition&quot;.</code></pre>
<p>*** Browse URL (<sub>gx</sub>)</p>
<pre><code>~gx~: go to URL.  This is a default Vim binding.</code></pre>
<p>*** Help (<sub>?</sub>)</p>
<pre><code>- ~g?~ : is the standard key for help related commands.
- ~?~ in places where backward search is not very useful.</code></pre>
<p>*** History browsing (<sub>C-n</sub>, <sub>C-p</sub>)</p>
<pre><code>~C-n~ and ~C-p~ are standard bindings to browse the history elements.</code></pre>
<p>*** Bookmarking</p>
<pre><code>?</code></pre>
<p>*** REPL (<sub>gz</sub>) If the mode has a Go To REPL-type command, set it to <sub>gz</sub>. *** Zooming (<sub>+</sub>, <sub>-</sub>, <sub>=</sub>, <sub>0</sub>)</p>
<pre><code>- ~+~ and ~-~ have obvious meanings.

- ~0~ has a somewhat intuitive meaning, plus it is next to ~+~ and ~-~ on QWERTY.

- ~=~ is useful as a synonym for ~+~ because it is the unshifted key of ~+~ on QWERTY.</code></pre>
<p>*** Debugging When debugging is on, debugger keys takes the most precedence.</p>
<pre><code>These keys will be set when there&#39;s an available command for them.

- ~n~ : Step Over
- ~i~ : Step Into
- ~o~ : Step Out
- ~c~ : Continue/Resume Execution
- ~L~ : Locals
- ~t~ : Tracing
- ~q~ : Quit Debugging
- ~H~ : Continue until Point
- ~e~ : Evaluate Expression
- ~b~ : Set Breakpoint
- ~u~ : Unset Breakpoint
- ~&gt;~ : Navigate to Next Frame
- ~&lt;~ : Navigate to Previous Frame
- ~g?~ : Help
- ~J~ : Jump to debugger location
- ~R~ : Restart

For debugging outside of debugger being on (e.g. setting initial breakpoints),
we use similar keys to [[https://github.com/realgud/realgud][realgud]].

- ~f5~ Start/Continue/Resume Execution
- ~S-f5~ Continue Execution
- ~Mouse-1~ Toggle Breakpoint
- ~f9~ Toggle Breakpoint
- ~f10~ Step Over
- ~f11~ Step Into
- ~S-f11~ Step Out</code></pre>
<p>*** Editable Buffers For buffers where insert-state doesn't make sense but buffer can be edited, (e.g. wdired or wgrep), pressing <sub>i</sub> will change into editable state.</p>
<pre><code>When this editable state is turned on,

~ZQ~ will abort and clear any changes.
~ZZ~ will finish and save any changes.
~ESC~ will exit editable state.</code></pre>
<p>*** :q/:wq/etc Modes with commands that can be bound to :q/:wq/etc will have those keys remapped. ** Key Translation <sub>evil-collection-translate-key</sub> allows binding a key to the definition of another key in the same keymap (comparable to how Vim's keybindings work). Its arguments are the <sub>states</sub> and <sub>keymaps</sub> to bind/look up the key(s) in followed optionally by keyword arguments (currently only <sub>:destructive</sub>) and key/replacement pairs. <sub>states</sub> should be nil for non-evil keymaps, and both <sub>states</sub> and <sub>keymaps</sub> can be a single symbol or a list of symbols.</p>
<p>This function can be useful for making key swaps/cycles en masse. For example, someone who uses an alternate keyboard layout may want to retain the <sub>hjkl</sub> positions for directional movement in dired, the calendar, etc.</p>
<p>Here's an example for Colemak of making swaps in a single keymap: #+begin_src emacs-lisp (evil-collection-translate-key nil 'evil-motion-state-map ;; colemak hnei is qwerty hjkl "n" "j" "e" "k" "i" "l" ;; add back nei "j" "e" "k" "n" "l" "i") #+end_src</p>
<p>Here's an example of using <sub>evil-collection-setup-hook</sub> to cycle the keys for all modes in <sub>evil-collection-mode-list</sub>: #+begin_src emacs-lisp (defun my-hjkl-rotation (_mode mode-keymaps &amp;rest _rest) (evil-collection-translate-key 'normal mode-keymaps "n" "j" "e" "k" "i" "l" "j" "e" "k" "n" "l" "i"))</p>
<p>;; called after evil-collection makes its keybindings (add-hook 'evil-collection-setup-hook #'my-hjkl-rotation)</p>
<p>(evil-collection-init) #+end_src</p>
<p>A more common use case of <sub>evil-collection-translate-key</sub> would be for keeping the functionality of some keys that users may bind globally. For example, <sub>SPC</sub>, <sub>[~, and ~]</sub> are bound in some modes. If you use these keys as global prefix keys that you never want to be overridden, you'll want to give them higher priority than other evil keybindings (e.g. those made by ~(evil-define-key 'normal some-map ...)~). To do this, you can create an "intercept" map and bind your prefix keys in it instead of in <sub>evil-normal-state-map</sub>: #+begin_src emacs-lisp (defvar my-intercept-mode-map (make-sparse-keymap) "High precedence keymap.")</p>
<p>(define-minor-mode my-intercept-mode "Global minor mode for higher precedence evil keybindings." :global t)</p>
<p>(my-intercept-mode)</p>
<p>(dolist (state '(normal visual insert)) (evil-make-intercept-map ;; NOTE: This requires an evil version from 2018-03-20 or later (evil-get-auxiliary-keymap my-intercept-mode-map state t t) state))</p>
<p>(evil-define-key 'normal my-intercept-mode-map (kbd "SPC f") 'find-file) ;; ... #+end_src</p>
<p>You can then define replacement keys: #+begin_src emacs-lisp (defun my-prefix-translations (_mode mode-keymaps &amp;rest _rest) (evil-collection-translate-key 'normal mode-keymaps "C-SPC" "SPC" ;; these need to be unbound first; this needs to be in same statement "[" nil "]" nil "[[" "[" "]]" "]"))</p>
<p>(add-hook 'evil-collection-setup-hook #'my-prefix-translations)</p>
<p>(evil-collection-init) #+end_src</p>
<p>By default, the first invocation of <sub>evil-collection-translate-key</sub> will make a backup of the keymap. Each subsequent invocation will look up keys in the backup instead of the original. This means that a call to <sub>evil-collection-translate-key</sub> will always have the same behavior even if evaluated multiple times. When ~:destructive t~ is specified, keys are looked up in the keymap as it is currently. This means that a call to <sub>evil-collection-translate-key</sub> that swapped two keys would continue to swap/unswap them with each call. Therefore when ~:destructive t~ is used, all cycles/swaps must be done within a single call to <sub>evil-collection-translate-key</sub>. To make a comparison to Vim keybindings, ~:destructive t~ is comparable to Vim's <sub>map</sub>, and ~:destructive nil~ is comparable to Vim's <sub>noremap</sub> (where the "original" keybindings are those that existed in the keymap when <sub>evil-collection-translate-key</sub> was first called). You'll almost always want to use the default behavior (especially in your init file). The limitation of ~:destructive nil~ is that you can't translate a key to another key that was defined after the first <sub>evil-collection-translate-key</sub>, so ~:destructive t~ may be useful for interactive experimentation.</p>
<p><sub>evil-collection-swap-key</sub> is also provided as a wrapper around <sub>evil-collection-translate-key</sub> that allows swapping keys: #+begin_src emacs-lisp (evil-collection-swap-key nil 'evil-motion-state-map ";" ":") ;; is equivalent to (evil-collection-translate-key nil 'evil-motion-state-map ";" ":" ":" ";") #+end_src</p>
<p>** Modes left behind</p>
<p>Some modes might still remain unsupported by this package. Should you be missing your <sub><hjkl></sub>, feel free to file an issue or even a pull request.</p>
<p>** Third-party packages</p>
<p>Third-party packages are provided by several parties:</p>
<table>
<colgroup>
<col style="width: 31%" />
<col style="width: 68%" />
</colgroup>
<thead>
<tr class="header">
<th>Major mode</th>
<th>Evil bindings</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>lispy</td>
<td>[[https://github.com/noctuid/lispyville][lispyville]] or [[https://github.com/sp3ctum/evil-lispy][evil-lispy]]</td>
</tr>
<tr class="even">
<td>org</td>
<td>[[https://github.com/GuiltyDolphin/org-evil][org-evil]] or [[https://github.com/Somelauw/evil-org-mode][evil-org]]</td>
</tr>
<tr class="odd">
<td>markdown</td>
<td>[[https://github.com/Somelauw/evil-markdown][evil-markdown]]</td>
</tr>
<tr class="even">
<td>ledger</td>
<td>[[https://github.com/atheriel/evil-ledger][evil-ledger]]</td>
</tr>
</tbody>
</table>
<p>Should you know any suitable package not mentioned in this list, let us know and file an issue.</p>
<p>[[https://github.com/emacs-evil/evil-magit][evil-magit]] is included with evil-collection as of: [[https://github.com/emacs-evil/evil-collection/commit/e24469514a30dd55e65d2c6d90264f496cf4d27f][this commit]].</p>
<p>Other references:</p>
<ul>
<li>[[https://github.com/syl20bnr/spacemacs/blob/master/doc/CONVENTIONS.org#key-bindings-conventions][Spacemacs]]</li>
<li>[[https://github.com/hlissner/doom-emacs/tree/develop/modules/editor/evil][Doom Emacs]]</li>
</ul>
<p>** FAQ - Making SPC work similarly to [[https://github.com/syl20bnr/spacemacs][spacemacs]].</p>
<pre><code> ~evil-collection~ binds over SPC in many packages. To use SPC as a leader
 key with the [[https://github.com/noctuid/general.el][general]] library:

 #+begin_src emacs-lisp :tangle yes
    (use-package general
      :ensure t
      :init
      (setq general-override-states &#39;(insert
                                      emacs
                                      hybrid
                                      normal
                                      visual
                                      motion
                                      operator
                                      replace))
      :config
      (general-define-key
       :states &#39;(normal visual motion)
       :keymaps &#39;override
       &quot;SPC&quot; &#39;hydra-space/body))
       ;; Replace &#39;hydra-space/body with your leader function.
 #+end_src

 See [[https://github.com/noctuid/evil-guide][noctuid&#39;s evil guide]] for other approaches.

 This should also be accomplishable using key translation from [[https://github.com/noctuid/general.el][general]].</code></pre>
<p>** Contributing Please do!</p>
<p>We welcome any additional modes that are not already supported.</p>
<p>All bindings in <sub>evil-collection</sub> are still open to change so if there's a better or more consistent binding, please [[https://github.com/emacs-evil/evil-collection/issues][open an issue]] or [[https://github.com/emacs-evil/evil-collection/pulls][submit a pull request]].</p>
<p>Follow [[https://github.com/bbatsov/emacs-lisp-style-guide/][The Emacs Lisp Style Guide]] for coding conventions.</p>
<p>[[https://github.com/erlang/otp/wiki/writing-good-commit-messages][Erlang/OTP]] has a good read for helpful commit messages.</p>
<p>#+LINK: EMMS https://www.gnu.org/software/emms/ #+LINK: evilmagit https://github.com/emacs-evil/evil-magit #+LINK: evilmu4e https://github.com/JorisE/evil-mu4e #+LINK: mu4e https://www.djcbsoftware.nl/code/mu/mu4e.html</p>
