import json

filepath = input("Insert file path: ")
if not filepath.endswith(".json"):
    filepath = filepath + "\\database.json"

with open(filepath, "r+", encoding='utf-8') as f:
    f.seek(0)
    data = json.load(f)
    while(True):
        print("Set category as empty to exit")
        print("Set title as empty to choise another category")
        print("Select one of the following categories:")
        print("1 - Animazione")
        print("2 - Avventura")
        print("3 - Azione / Thriller")
        print("4 - Commedia")
        print("5 - Drammatico / Romantico")
        print("6 - Fantascienza")
        print("7 - Horror")
        print("8 - Serie TV")
        print("9 - Serie TV di Animazione")
        category = input("Insert here: ")
        if category == "":
            break
        if category == "1":
            category = "animazione"
        elif category == "2":
            category = "avventura"
        elif category == "3":
            category = "azione_thriller"
        elif category == "4":
            category = "commedia"
        elif category == "5":
            category = "drammatico"
        elif category == "6":
            category = "fantascienza"
        elif category == "7":
            category = "horror"
        elif category == "8":
            category = "serietv"
        elif category == "9":
            category = "serietv_animate"
        else:
            print("Invalid category. Breaking")
            break
        while(True):
            print("")
            print("Type \"restart\" on any field to repeat the insert operation")
            print("")
            title = input("Title: ")
            if title == "":
                break
            videolink = input("Youtube link: ")
            coverlink = input("Cover link: ")
            headerlink = input("Header link: ")
            if title == "restart" or videolink == "restart" or coverlink == "restart" or headerlink == "restart":
                continue
            if category != "serietv" and category != "serietv_animate":
                data['root']['category_film'][category].insert(0, {"title": title, "link": videolink, "imgurl": coverlink, "head": headerlink})
            else:
                data['root']['category_serietv'][category].insert(0, {"title": title, "link": videolink, "imgurl": coverlink, "head": headerlink})
            f.seek(0)
            json.dump(data, f, indent=4, ensure_ascii=False)
            f.truncate()

