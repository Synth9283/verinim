import md5, options

proc checksum*(filename: string): Option[string] =
    try:
        let contents: string = readFile(filename)
        return some($toMD5(contents))
    except:
        return none(string)
