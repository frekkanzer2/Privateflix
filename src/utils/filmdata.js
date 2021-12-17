export function getFilmData(content, id, limit) {
    console.log("Requesting items with ID = " + id);
    var dataToReturn = [];
    if (id === 1) dataToReturn = content["category_film"]["animazione"];
    else if (id === 2) dataToReturn = content["category_film"]["azione_thriller"];
    else if (id === 3) dataToReturn = content["category_film"]["avventura"];
    else if (id === 4) dataToReturn = content["category_film"]["drammatico"];
    else if (id === 5) dataToReturn = content["category_film"]["commedia"];
    else if (id === 6) dataToReturn = content["category_film"]["fantascienza"];
    else if (id === 7) dataToReturn = content["category_film"]["horror"];
    else if (id === 8) dataToReturn = content["category_serietv"]["serietv"];
    else if (id === 9) dataToReturn = content["category_serietv"]["serietv_animate"];
    else if (id === 10) {
        // case random films
        var allFilms = [].concat(content["category_film"]["animazione"]).concat(content["category_film"]["azione_thriller"])
            .concat(content["category_film"]["avventura"]).concat(content["category_film"]["drammatico"]).concat(content["category_film"]["commedia"])
            .concat(content["category_film"]["fantascienza"]).concat(content["category_film"]["horror"]);
        var picked = 0;
        while (picked < 20) {
            var index = Math.floor(Math.random() * allFilms.length);
            var found = false;
            dataToReturn.forEach(item => {
                if (item.title == allFilms[index].title)
                    found = true;
            })
            if (!found) {
                picked++;
                dataToReturn.push(allFilms[index]);
            }
        }
    } else if (id === 11) {
        // case random tv series
        var allFilms = [].concat(content["category_serietv"]["serietv"]).concat(content["category_serietv"]["serietv_animate"]);
        var picked = 0;
        while (picked < limit && picked < allFilms.length) {
            var index = Math.floor(Math.random() * allFilms.length);
            var found = false;
            dataToReturn.forEach(item => {
                if (item.title == allFilms[index].title)
                    found = true;
            })
            if (!found) {
                picked++;
                dataToReturn.push(allFilms[index]);
            }
        }
    }
    return {
        data: dataToReturn.slice(0, limit)
    }
}

export function getFilmDataByCriteria(content, id, criteria) {
    var dataToReturn = [];
    if (id === 100) {
        // case random tv series
        var allFilms = [].concat(content["category_film"]["animazione"]).concat(content["category_film"]["azione_thriller"])
        .concat(content["category_film"]["avventura"]).concat(content["category_film"]["drammatico"]).concat(content["category_film"]["commedia"])
        .concat(content["category_film"]["fantascienza"]).concat(content["category_film"]["horror"]).concat(content["category_serietv"]["serietv"])
        .concat(content["category_serietv"]["serietv_animate"]);
        allFilms.forEach(
            item => {
                if (item.title.toUpperCase().includes(criteria.toUpperCase()))
                    dataToReturn.push(item);
            }
        );
    }
    return {
        data: dataToReturn
    }
}