with open("example.txt", "rt", encoding="utf-8") as file:
    f = file.read()
    words_count = len(f.split())
    comma_count = f.count(",")
    d_count = f.count("d")
    repl_to = f.replace('to', 'TO')

    print("Words:", words_count,
          "\nComma:", comma_count,
          "\nLitera d:", d_count,
          "\nReplacing \"to\" on \"TO\":\n", repl_to)

    file.close()