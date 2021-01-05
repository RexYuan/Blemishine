
# .zshenv wrapper
#

# Obtain this script's path. Modified from ohmyzsh/oh-my-zsh.sh
# https://github.com/ohmyzsh/ohmyzsh/commit/28ee5846bbac56926241fc5ef9f116161ceb6f23
export BLEM="${${(%):-%x}:A:h:h}"
# How it works:
#   The whole expression ${${(%):-%x}:A:h:h} is nested. Let's look at
#   the inner expression first, lest we suffer brain damage for which
#   the Zsh Development Group officially takes no responsibility.
#
#   The inner expansion ${(%):-%x} uses the operator :-
#   14.3 Parameter Expansion
#     ${name:-word}
#       If name is defined and non-empty, then substitute its value;
#       otherwise substitute with word. If name is omitted,
#       then word is always substituted.
#   The expansion ${(%):-%x} has a flag (%).
#   14.3.1 Parameter Expansion Flags
#     %
#       Expand all % escapes in the resulting words in the same way
#       as in prompts.
#   The substituting word of the expansion is %x.
#   13.2.3 Shell state
#     %x
#       The name of the file containing the source code currently
#       being executed.
#   So, ${(%):-%x} gives the running script's file name.
#   Depending on how it's run, it expands to different results.
#   For file /path/to/script.zsh which contains "${(%):-%x}",
#     running "/path/to/script.zsh" gives "/path/to/script.zsh";
#     running "./script.zsh" gives "./script.zsh";
#     running "zsh script.zsh" gives "script.zsh".
#   In particular, for startup files, it expands to the absolute path.
#
#   The outer expansion ${inner:A:h:h} applies two modifiers :A and :h
#   14.1.4 Modifiers
#     A
#       Turn a file name into an absolute path as the ‘a’ modifier does,
#       and then pass the result through the realpath(3) library
#       function to resolve symbolic links.
#     a
#       Turn a file name into an absolute path: prepends the current
#       directory, if the word isn't an absolute path already;
#       remove ‘.’ path segments; and remove ‘..’ path segments and
#       the segments that immediately precede them.
#       For example, at directory /path/to/current/,
#         if name="/x/", "${name:a}" gives "/x";
#         if name="./x/", "${name:a}" gives "/path/to/current/x";
#         if name="../x/", "${name:a}" gives "/path/to/x".
#       In particular, for startup files, it tries to prepend $HOME.
#     h
#       Remove a trailing pathname component, shortening the path by
#       one directory level: this is the ‘head’ of the pathname.
#   So, ${inner:A:h:h} resolves all the symlinks of inner and then
#   takes the head of its path twice.
#   For symlink /path1/to1/link -> /path2/to2/the2/linked,
#   and inner="/path1/to1/link", "${inner:A:h:h}" gives "/path2/to2".
#
#   Finally, according to the doc, the outer expansion operates on
#   what inner expansion gives as if it's a word (instead of a name).
#   14.3.2 Rules
#   1. Nested substitution
#     If multiple nested ${...} forms are present, substitution is
#     performed from the inside outwards. [...]
#     At each nested level of substitution, the substituted words
#     undergo all forms of single-word substitution [...]
#   So, when the inner expression ${(%):-%x} gives this file's
#   absolute path, which is $HOME/.zshenv, the outer expression
#   ${inner:A:h:h} operates directly on the result expansion of inner
#   and resolves all the symlinks and then takes its path head twice.
#   For HOME="/Users/Rex" and symlink /Users/Rex/.zshenv ->
#   /Users/Rex/Projects/Blemishine/zsh/prime.zsh, the whole expression
#   "${${(%):-%x}:A:h:h}" gives "/Users/Rex/Projects/Blemishine".

# Wrapper trick from comment by u/beautiful_tango in r/zsh.
# https://www.reddit.com/r/zsh/comments/3ubrdr/proper_way_to_set_zdotdir/
export ZDOTDIR="$BLEM/zsh/zdotdir"
source $ZDOTDIR/.zshenv
