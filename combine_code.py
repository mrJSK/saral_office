import os
from pathlib import Path

ROOT = Path(r"D:\saral_office\lib")   # change if needed
OUTPUT_DIR = ROOT / "_combined"     # where combined files will be written

def main():
    OUTPUT_DIR.mkdir(exist_ok=True)

    folder_to_files = {}

    # Walk all dart files under ROOT
    for dirpath, dirnames, filenames in os.walk(ROOT):
        dirpath = Path(dirpath)
        # Skip our own output directory if re-run
        if OUTPUT_DIR in dirpath.parents or dirpath == OUTPUT_DIR:
            continue

        for fname in filenames:
            if not fname.endswith(".dart"):
                continue

            file_path = dirpath / fname
            # folder_name = relative directory (using path with /)
            rel_dir = file_path.parent.relative_to(ROOT)
            folder_name = str(rel_dir) if str(rel_dir) != "." else ""  # root-level

            folder_to_files.setdefault(folder_name, []).append(file_path)

    # For each folder, write one combined file
    for folder_name, files in folder_to_files.items():
        # Make a safe file name for folder
        if folder_name == "":
            combined_name = "root.dart"
        else:
            # replace path separators with underscore
            safe = folder_name.replace(os.sep, "_").replace("/", "_")
            combined_name = f"{safe}.dart"

        output_path = OUTPUT_DIR / combined_name
        print(f"Writing {output_path} ({len(files)} files)")

        with output_path.open("w", encoding="utf-8") as out:
            for f in sorted(files):
                rel_path = f.relative_to(ROOT).as_posix()
                out.write(f"// {rel_path}\n")
                with f.open("r", encoding="utf-8") as src:
                    out.write(src.read())
                out.write("\n\n")

if __name__ == "__main__":
    main()
