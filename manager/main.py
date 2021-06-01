import json

filepath = input("Insert file path: ")

with open(filepath, "r+") as f:
    f.seek(0)
    data = json.load(f)
    while(True):
        print("Set category as empty to exit")
        print("Set title as empty to choise another category")
        category = input("Select category: ")
        if category == "":
            break
        if category == "azione" or category == "thriller":
            category = "azione_thriller"
        elif category == "serie tv":
            category = "serietv"
        elif category == "serie tv animata" or category == "serve tv animate":
            category = "serietv_animate"
        while(True):
            print("")
            title = input("Title: ")
            if title == "":
                break
            videolink = input("Youtube link: ")
            coverlink = input("Cover link: ")
            headerlink = input("Header link: ")
            if title == "annulla" or videolink == "annulla" or coverlink == "annulla" or headerlink == "annulla":
                continue
            data['root']['category_film'][category].insert(0, {"title": title, "link": videolink, "imgurl": coverlink, "head": headerlink})
            f.seek(0)
            json.dump(data, f, indent=4, ensure_ascii=False)
            f.truncate()
            # special chars to edit manually:
            # Ã¨ -> è
            # Ã -> à
            # Ã¹ -> ù
            # Ã² -> ò

