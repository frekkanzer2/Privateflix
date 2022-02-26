import React from 'react';
import {getFilmData, getFilmDataByCriteria} from '../utils/filmdata';
import Button from '@mui/material/Button';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogTitle from '@mui/material/DialogTitle';
import Slide from '@mui/material/Slide';
import Card from '@mui/material/Card';
import CardMedia from '@mui/material/CardMedia';

const Transition = React.forwardRef(function Transition(props, ref) {
    return <Slide direction="up" ref={ref} {...props} />;
});

export function generateFilmCards(content, id) {
    var contents = getFilmData(content, id, 20).data;
    var _generateCards = (cont) => {
        var _contents = [];
        var index = 0;
        cont.forEach(
            item => {
                _contents.push(
                    <FilmCard title={item.title} link={item.link} image={item.imgurl} altImage={item.head} key={index}/>
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
                    <ItemFilmCard title={item.title} link={item.link} image={item.imgurl} altImage={item.head} key={index}/>
                );
                index++;
            }
        );
        return _contents;
    }
    return _generateCards(contents);
}

export function generateSearchFilmCards(content, id, criteria) {
    var contents = getFilmDataByCriteria(content, id, criteria).data;
    var _generateCards = (cont) => {
        var _contents = [];
        var index = 0;
        cont.forEach(
            item => {
                _contents.push(
                    <ItemFilmCard title={item.title} link={item.link} image={item.imgurl} key={index} superkey={index}/>
                );
                index++;
            }
        );
        return _contents;
    }
    return _generateCards(contents);
}

export function FilmCard (props) {
    var click = () => {
        window.open(props.link);
    }
    return (
        <FilmCardWrapper mode={1} clickEvent={click} previewTitle={props.title} previewImage={props.image} altImage={props.altImage} key={props.superkey}/>
    );
}

export function ItemFilmCard (props) {
    var click = () => {
        window.open(props.link);
    }
    var bigCard = (
    <FilmCardWrapper mode={2} clickEvent={click} previewTitle={props.title} previewImage={props.image} altImage={props.altImage} key={props.superkey}/>
    );
    var smallCard = (
    <FilmCardWrapper mode={3} clickEvent={click} previewTitle={props.title} previewImage={props.image} altImage={props.altImage} key={props.superkey}/>
    );
    if (window.innerWidth >= 920)
        return bigCard;
    else return smallCard;
}

export function FilmCardWrapper(props) {

    var mode = props.mode;
    
    const [open, setOpen] = React.useState(false);
  
    const handleClickOpen = () => {
      setOpen(true);
    };
  
    const handleClose = () => {
      setOpen(false);
    };

    const startFilm = () => {
        handleClose();
        props.clickEvent();
    }
  
    if (mode == 1)
        return (
            <div className="filmcard">
                <img className="illustration" src={props.previewImage} onClick={handleClickOpen}/>
                <Dialog
                    open={open}
                    TransitionComponent={Transition}
                    keepMounted
                    onClose={handleClose}
                    aria-describedby="alert-dialog-slide-description"
                    maxWidth="xs"
                >
                    <DialogContent>
                        <div>
                            <div className="preview-image-container">
                                <img className="preview-image" src={props.altImage}/>
                            </div>
                            <div className="preview-title">
                                {props.previewTitle}
                            </div>
                        </div>
                    </DialogContent>
                    <DialogActions>
                        <div style={{flex: '2 0 0'}} />
                        <Button onClick={handleClose}>Chiudi</Button>
                        <div style={{flex: '5 0 0'}} />
                        <Button onClick={startFilm}>Play</Button>
                        <div style={{flex: '2 0 0'}} />
                    </DialogActions>
                </Dialog>
            </div>
        );
    else if (mode == 2)
        return (
            <div className="itemfilmcard">
                <img className="illustration" src={props.previewImage} onClick={handleClickOpen}/>
                <Dialog
                    open={open}
                    TransitionComponent={Transition}
                    keepMounted
                    onClose={handleClose}
                    aria-describedby="alert-dialog-slide-description"
                    maxWidth="xs"
                >
                    <DialogContent>
                        <div>
                            <div className="preview-image-container">
                                <img className="preview-image" src={props.altImage}/>
                            </div>
                            <div className="preview-title">
                                {props.previewTitle}
                            </div>
                        </div>
                    </DialogContent>
                    <DialogActions>
                        <div style={{flex: '2 0 0'}} />
                        <Button onClick={handleClose}>Chiudi</Button>
                        <div style={{flex: '5 0 0'}} />
                        <Button onClick={startFilm}>Play</Button>
                        <div style={{flex: '2 0 0'}} />
                    </DialogActions>
                </Dialog>
            </div>
        );
    else if (mode == 3)
        return (
            <div className="itemfilmcard-small">
                <img className="illustration" src={props.previewImage} onClick={handleClickOpen}/>
                <Dialog
                    open={open}
                    TransitionComponent={Transition}
                    keepMounted
                    onClose={handleClose}
                    aria-describedby="alert-dialog-slide-description"
                    maxWidth="xs"
                >
                    <DialogContent>
                        <div>
                            <div className="preview-image-container">
                                <img className="preview-image" src={props.altImage}/>
                            </div>
                            <div className="preview-title">
                                {props.previewTitle}
                            </div>
                        </div>
                    </DialogContent>
                    <DialogActions>
                        <div style={{flex: '2 0 0'}} />
                        <Button onClick={handleClose}>Chiudi</Button>
                        <div style={{flex: '5 0 0'}} />
                        <Button onClick={startFilm}>Play</Button>
                        <div style={{flex: '2 0 0'}} />
                    </DialogActions>
                </Dialog>
            </div>
        );
}