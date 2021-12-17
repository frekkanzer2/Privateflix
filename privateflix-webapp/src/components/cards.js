import React from 'react';
import {getFilmData} from '../utils/filmdata';

export function FilmCard (props) {
    var bgimage = props.image;
    var click = () => {
        window.open(props.link);
    }
    return (
        <div className="filmcard">
            <img className="illustration" src={bgimage} onClick={click}/>
        </div>
    );
}

export function ItemFilmCard (props) {
    var bgimage = props.image;
    var click = () => {
        window.open(props.link);
    }
    return (
        <div className="itemfilmcard">
            <img className="illustration" src={bgimage} onClick={click}/>
        </div>
    );
}

export function generateFilmCards(content, id) {
    var contents = getFilmData(content, id, 20).data;
    var _generateCards = (cont) => {
        var _contents = [];
        var index = 0;
        cont.forEach(
            item => {
                _contents.push(
                    <FilmCard title={item.title} link={item.link} image={item.imgurl} key={index}/>
                );
                index++;
            }
        );
        return _contents;
    }
    return _generateCards(contents);
}

export function generateItemFilmCards(content, id) {
    var contents = getFilmData(content, id).data;
    var _generateCards = (cont) => {
        var _contents = [];
        var index = 0;
        cont.forEach(
            item => {
                _contents.push(
                    <ItemFilmCard title={item.title} link={item.link} image={item.imgurl} key={index}/>
                );
                index++;
            }
        );
        return _contents;
    }
    return _generateCards(contents);
}