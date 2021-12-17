import React from 'react';
import {getFilmData} from '../utils/filmdata';

export function FilmCard (props) {
    console.log(props);
    return (
        <div className = "filmcard">
            <h3>{props.title}</h3>
            <p>{props.link}</p>
        </div>
    );
}

export function generateFilmCards() {
    var contents = getFilmData().data;
    var _generateCards = (cont) => {
        var _contents = [];
        var index = 0;
        cont.forEach(
            item => {
                _contents.push(
                    <FilmCard title={item.title} link={item.link} key={index}/>
                );
                index++;
            }
        );
        console.log(_contents);
        return _contents;
    }
    return _generateCards(contents);
}
