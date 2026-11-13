
# make filenames portable across modern Windows, macOS, and Linux/NAS
# guarantees:
#  - preserve Chinese, Japanese, Unicode, and valid punctuation
#  - normalize Unicode to NFC (canonical composition)
#  - replace unsafe characters, including ~ . ' " and \ with _
#  - preserve final file extensions (.png, .jpg, .webp, etc.)
#  - preserve spaces, brackets, parentheses, and Unicode symbols
#  - leave already-compliant names untouched
#  - never truncate filenames or automatically resolve collisions
#  - abort before changes if preflight detects problems
#  - never modify file contents or follow symlinks
# strategy:
#  - pathvalidate "universal" rules + custom character restrictions
#  - validate 255 UTF-8 bytes and 255 UTF-16 code units
#  - detect case-insensitive and Unicode-equivalent collisions
#  - scan one directory level by default; -r enables full recursion
#  - process deepest directories first when recursive
#  - use temporary names for APFS-safe renaming
#  - preview by default; only modify with --apply
# usage: clean-names <directory> [-r|--recursive] [--apply]
function clean-names
{
    # ---------- arguments ----------
    local input=""
    local mode="preview"
    local recursive=0

    for arg in "$@"; do
        case "$arg" in
            -h|--help)
                cat <<'EOF'
usage: clean-names <directory> [options]

Normalize and sanitize filenames for Windows, macOS, and Linux/NAS.

options:
  -h, --help       Show this help message
  -r, --recursive  Process all nested files and directories
  --apply          Apply changes (default: preview only)

behavior:
  - Default depth: 1 (immediate children only)
  - Normalize Unicode to NFC
  - Preserve Chinese, Japanese, and other Unicode characters
  - Replace unsafe characters with underscores
  - Replace ~ . ' " (preserving file extensions)
  - Detect collisions and overlong filenames
  - Never automatically truncate or overwrite files
  - Abort preflight if errors are detected

examples:
  clean-names .
  clean-names . --apply
  clean-names . -r
  clean-names . -r --apply
EOF
                return 0
                ;;
            -r|--recursive)
                recursive=1
                ;;
            --apply)
                mode="apply"
                ;;
            -*)
                echo "clean-names: unknown option '$arg'"
                return 1
                ;;
            *)
                if [[ -n "$input" ]]; then
                    echo "clean-names: multiple directories specified"
                    return 1
                fi
                input="$arg"
                ;;
        esac
    done

    if [[ -z "$input" ]]; then
        echo "usage: clean-names <directory> [-r|--recursive] [--apply]"
        return 1
    fi

    if [[ ! -d "$input" ]]; then
        echo "clean-names: '$input' is not a directory"
        return 1
    fi

    # ---------- dependencies ----------
    if ! command -v pipx >/dev/null 2>&1; then
        echo "clean-names: pipx not found in PATH"
        return 1
    fi

    local pipx_venvs python

    pipx_venvs=$(pipx environment --value PIPX_LOCAL_VENVS) || {
        echo "clean-names: could not locate pipx environments"
        return 1
    }

    python="${pipx_venvs}/pathvalidate-cli/bin/python"

    if [[ ! -x "$python" ]] ||
       ! "$python" -c 'import pathvalidate' >/dev/null 2>&1; then
        echo "clean-names: pathvalidate-cli not installed"
        echo "Install with: pipx install pathvalidate-cli"
        return 1
    fi

    # ---------- execution ----------
    "$python" - "$input" "$mode" "$recursive" <<'PY'
import os
import re
import sys
import uuid
import unicodedata
from pathlib import Path
from pathvalidate import sanitize_filename, validate_filename

root = Path(sys.argv[1]).expanduser().resolve()
apply = sys.argv[2] == "apply"
recursive = sys.argv[3] == "1"

plans = []
errors = []
files = 0
directories = 0

# ---------- normalization ----------
def clean(name, is_dir):
    name = unicodedata.normalize("NFC", name)
    name = name.replace("\u00a0", " ")

    # Apply standard cross-platform restrictions.
    name = sanitize_filename(
        name,
        platform="universal",
        replacement_text="_",
        max_len=None,
        fs_encoding="utf-8",
    )

    # Preserve final file extensions.
    if is_dir:
        stem, ext = name, ""
    else:
        stem, ext = os.path.splitext(name)

        if ext[1:].isdigit():
            stem, ext = name, ""

    # Apply custom restrictions.
    stem = re.sub(r"""[.~'"]""", "_", stem)
    ext = re.sub(r"""[~'"]""", "_", ext)

    # Preserve leading dots for hidden files.
    if name.startswith(".") and not name.startswith(".."):
        stem = "." + stem.lstrip("_")

    result = stem + ext

    if not result or result in (".", ".."):
        raise ValueError("empty or reserved filename")

    if len(result.encode("utf-8")) > 255:
        raise ValueError("exceeds 255 UTF-8 bytes")

    if len(result.encode("utf-16-le")) // 2 > 255:
        raise ValueError("exceeds 255 UTF-16 code units")

    validate_filename(
        result,
        platform="universal",
        max_len=255,
        fs_encoding="utf-8",
    )

    return result

# ---------- collision detection ----------
def collision_key(name):
    return unicodedata.normalize(
        "NFD",
        unicodedata.normalize("NFD", name).casefold(),
    )

def walk_error(error):
    errors.append(str(error))

# ---------- directory selection ----------
if recursive:
    parents = []

    for parent, _, _ in os.walk(
        root, topdown=False, followlinks=False, onerror=walk_error
    ):
        parents.append(Path(parent))
else:
    parents = [root]

# ---------- preflight ----------
for parent in parents:
    try:
        with os.scandir(parent) as scan:
            entries = sorted(list(scan), key=lambda e: e.name)

        original_names = {e.name for e in entries}
        targets = {}
        changes = []

        for entry in entries:
            source = parent / entry.name

            if entry.is_symlink():
                errors.append(f"Symlink requires review: {source}")
                continue

            is_dir = entry.is_dir(follow_symlinks=False)
            is_file = entry.is_file(follow_symlinks=False)

            if not (is_dir or is_file):
                errors.append(f"Special file requires review: {source}")
                continue

            try:
                target = clean(entry.name, is_dir)
                key = collision_key(target)

                if key in targets:
                    errors.append(
                        f"Collision: {source} conflicts with "
                        f"{parent / targets[key]}"
                    )
                    continue

                targets[key] = entry.name

                if target != entry.name:
                    changes.append((entry.name, target))

                    if is_dir:
                        directories += 1
                    else:
                        files += 1

            except (ValueError, UnicodeError) as error:
                errors.append(f"{source}: {error}")

        if changes:
            plans.append((parent, original_names, changes))

    except OSError as error:
        errors.append(str(error))

if errors:
    print("== clean-names ==")
    print("Mode  : PREFLIGHT FAILED")
    print()

    for error in errors:
        print(f"ERROR: {error}")

    print("\nNo changes made.")
    sys.exit(1)

# ---------- report ----------
print("== clean-names ==")
print(f"Path  : {root}")
print(f"Mode  : {'APPLY' if apply else 'PREVIEW'}")
print(f"Depth : {'Recursive' if recursive else '1'}")
print(f"Files : {files}")
print(f"Dirs  : {directories}")
print()

for parent, _, changes in plans:
    if recursive and parent != root:
        print(f"[{parent.relative_to(root)}]")

    for old, new in changes:
        print(f"{old!r}")
        print(f"  -> {new!r}")

    if changes:
        print()

if not apply:
    print(f"Would rename: {files + directories}")

    if files + directories:
        print("Run with --apply to execute.")

    sys.exit(0)

# ---------- execution ----------
completed = 0

for parent, original_names, changes in plans:
    staged = []
    committed = []

    try:
        if set(os.listdir(parent)) != original_names:
            raise RuntimeError("directory changed since preflight")

        # Stage all affected entries under temporary names.
        for old, new in changes:
            temp = parent / f".clean_names_{uuid.uuid4().hex}"

            while os.path.lexists(temp):
                temp = parent / f".clean_names_{uuid.uuid4().hex}"

            os.rename(parent / old, temp)
            staged.append((old, new, temp))

        # Commit sanitized names.
        for old, new, temp in staged:
            destination = parent / new

            if os.path.lexists(destination):
                raise FileExistsError(destination)

            os.rename(temp, destination)
            committed.append((old, new, temp))

        completed += len(changes)

    except (OSError, RuntimeError) as error:
        print(f"\nERROR: {parent}: {error}")

        # ---------- rollback ----------
        try:
            for old, new, temp in reversed(committed):
                os.rename(parent / new, temp)

            for old, new, temp in reversed(staged):
                if os.path.lexists(temp):
                    os.rename(temp, parent / old)

        except OSError as rollback_error:
            print(f"ROLLBACK ERROR: {rollback_error}")
            print("Manual recovery may be required.")

        print(f"Stopped after {completed} successful rename(s).")
        sys.exit(1)

print(f"\nRenamed: {completed}")
print("Done.")
PY
}
