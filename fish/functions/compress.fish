function compress
    if test (count $argv) -lt 1
        echo "Usage: compress <files...> [output_archive]"
        return 1
    end

    set failure false

    for file in $argv
        if not test -f $archive
            echo "File not found: $archive"
            set failure true
        end
    end

    if $failure
        return 1
    end

    if command -v gtar
        set tar gtar # MacOS GNU-Tar
    else
        set tar tar # Everybody else
    end

    # compress file -> file.tar
    if test (count $argv) -eq 1
        $tar cf "$argv[1].tar" "$argv[1]"
        return $status
    end

    set all_existing_files true

    for file in $argv
        if not test -f $file
            set all_existing_files false
        end
    end

    # compress foo bar baz -> archive.tar
    if $all_existing_files
        $tar cf "archive.tar" $argv
        return $status
    end

    set output $argv[1]
    set files $argv[2..-1]

    # compress foo.tar.gz foo -> foo.tar.gz
    switch $output
        case '*.tar.bz2' '*.tbz2' '*.tar.bz' '*.tbz'
            $tar -cjf $output $files

        case '*.tar.gz' '*.tgz'
            $tar -czf $output $files

        case '*.tar.xz' '*.txz'
            $tar -cJf $output $files

        case '*.tar.Z' '*.taz'
            $tar -cZf $output $files

        case '*.tar.zst' '*.tzst'
            $tar --zstd -cf $output $files

        case '*.tar.lzma' '*.tar.zma' '*.tlz'
            $tar --lzma -cf $output $files

        case '*.tar.lz'
            $tar --lzip -cf $output $files

        case '*.tar.lz4'
            $tar --use-compress-program=lz4 -cf $output $files

        case '*.tar.lzo'
            $tar --lzop -cf $output $files

        case '*.tar'
            $tar -cf $output $files

        case '*.7z'
            7zz a $output $files

        case '*.zip' '*.xpi' '*.jar'
            zip $output $files

        case '*.gz'
            if test (count $files) -ne 1
                echo "Cannot compress multiple files to .gz"
                return 1
            end
            gzip -c $files[1] >$output

        case '*.bz2' '*.bz'
            if test (count $files) -ne 1
                echo "Cannot compress multiple files to .bz2"
                return 1
            end
            bzip2 -c $files[1] >$output

        case '*.xz'
            if test (count $files) -ne 1
                echo "Cannot compress multiple files to .xz"
                return 1
            end
            xz -c $files[1] >$output

        case '*.lz4'
            if test (count $files) -ne 1
                echo "Cannot compress multiple files to .lz4"
                return 1
            end
            lz4 -c $files[1] >$output

        case '*.lzma'
            if test (count $files) -ne 1
                echo "Cannot compress multiple files to .lzma"
                return 1
            end
            lzma -c $files[1] >$output

        case '*.Z'
            if test (count $files) -ne 1
                echo "Cannot compress multiple files to .Z"
                return 1
            end
            compress -c $files[1] >$output

        case '*.zst'
            if test (count $files) -ne 1
                echo "Cannot compress multiple files to .zst"
                return 1
            end
            zstd -c $files[1] >$output

        case '*.zz'
            if test (count $files) -ne 1
                echo "Cannot compress multiple files to .zz"
                return 1
            end
            pigz -c $files[1] >$output

        case '*'
            echo "Unsupported archive format: $output"
            return 1
    end
end
