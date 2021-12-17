import './App.css';
import './css/card.css';
import './css/structure.css';
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
import {TopBar, Space, createPreviewStructure, createContainerStructure, createSearchStructure} from './components/structure.js';
import {LoadingText, AppTitle, SectionTitle, SectionTitleDedicated} from './components/labels.js';
import { Button } from 'react-bootstrap';
import React from 'react';

class App extends React.Component {

  constructor(props) {
    super(props);
    this.SERVER_ADDRESS_API = "https://test2-df6d1.firebaseio.com/root.json";
    this.state = {choise: -1};
    fetch(this.SERVER_ADDRESS_API)
      .then((res) => res.json())
      .then((json) => {
        this.setState({
          content: json,
          choise: 0,
          searchCriteria: ""
        });
        console.log(this.state.content);
      })
  }

  render() {
    return (
      <div className="App">
        {
          this.state.choise === -1 ? null : <Space/>
        }
        {
          this.state.choise === -1 ? <AppTitle/> :
            <TopBar
              onClicks={
                [this.onHomePressed, this.onFilmPressed_Animazione, this.onFilmPressed_Azione,
                  this.onFilmPressed_Avventura, this.onFilmPressed_Drammatici, this.onFilmPressed_Commedie,
                  this.onFilmPressed_Fantascienza, this.onFilmPressed_Horror, this.onSeriePressed_TV,
                  this.onSeriePressed_Animazione]
              }
              callback={this.onSearchPressed}
            />
        }
        {
          this.state.choise === -1 ? <this._displayLoading/> :
          this.state.choise === 0 ? <this._displayHome/> :
          this.state.choise === 1 ? <this._display text="Film di animazione" id={1} media={this.state.content}/> :
          this.state.choise === 2 ? <this._display text="Film di azione / thriller" id={2} media={this.state.content}/> :
          this.state.choise === 3 ? <this._display text="Film di avventura" id={3} media={this.state.content}/> :
          this.state.choise === 4 ? <this._display text="Film drammatici / romantici" id={4} media={this.state.content}/> :
          this.state.choise === 5 ? <this._display text="Film divertenti / comici" id={5} media={this.state.content}/> :
          this.state.choise === 6 ? <this._display text="Film di fantascienza" id={6} media={this.state.content}/> :
          this.state.choise === 7 ? <this._display text="Film horror" id={7} media={this.state.content}/> :
          this.state.choise === 8 ? <this._display text="Serie TV" id={8} media={this.state.content}/> :
          this.state.choise === 9 ? <this._display text="Serie TV Animate" id={9} media={this.state.content}/> :
          this.state.choise === 100 ? <this._displaySearch text="Ricerca nel catalogo" id={100} media={this.state.content} criteria={this.state.searchCriteria}/> :
          null
        }
        
      </div>
    );
  }

  _displayLoading = () => {
    return (
      <LoadingText/>
    );
  }

  _displayHome = () => {
    var randomValue = Math.floor(Math.random() * 7) + 1;
    return (
      <div>
        <SectionTitle text="Goditi qualcosa di nuovo"/>
        {createPreviewStructure("Film consigliati", this.state.content, 10)}
        {createPreviewStructure("Serie TV consigliate", this.state.content, 11)}
        <SectionTitle text="Una categoria interessante"/>
        {
          randomValue === 1 ?
            createPreviewStructure("Film di animazione", this.state.content, 1) :
          randomValue === 2 ?
            createPreviewStructure("Film di azione / thriller", this.state.content, 2) :
          randomValue === 3 ?
            createPreviewStructure("Film di avventura", this.state.content, 3) :
          randomValue === 4 ?
            createPreviewStructure("Film drammatici / romantici", this.state.content, 4) :
          randomValue === 5 ?
            createPreviewStructure("Film divertenti / comici", this.state.content, 5) :
          randomValue === 6 ?
            createPreviewStructure("Film di fantascienza", this.state.content, 6) :
          randomValue === 7 ?
            createPreviewStructure("Film horror", this.state.content, 7) :
          null
        }
      </div>
    );
  }

  _display = (props) => {
    return (
      <div>
        <SectionTitleDedicated text={props.text}/>
        {createContainerStructure(props.media, props.id)}
      </div>
    );
  }

  _displaySearch = (props) => {
    return (
      <div>
        <SectionTitleDedicated text={props.text}/>
        {createSearchStructure(props.media, props.id, props.criteria)}
        <Button variant="info" onClick={this.onHomePressed} style={{marginTop: 12}}>Torna indietro</Button>
      </div>
    );
  }

  onHomePressed = () => {
    if (this.state.choise != 0)
      this.setState({
        choise: 0
      });
  }

  onFilmPressed_Animazione = () => {
    if (this.state.choise != 1)
      this.setState({
        choise: 1
      })
  }
  
  onFilmPressed_Azione = () => {
    if (this.state.choise != 2)
      this.setState({
        choise: 2
      })
  }

  onFilmPressed_Avventura = () => {
    if (this.state.choise != 3)
      this.setState({
        choise: 3
      })
  }

  onFilmPressed_Drammatici = () => {
    if (this.state.choise != 4)
      this.setState({
        choise: 4
      })
  }

  onFilmPressed_Commedie = () => {
    if (this.state.choise != 5)
      this.setState({
        choise: 5
      })
  }

  onFilmPressed_Fantascienza = () => {
    if (this.state.choise != 6)
      this.setState({
        choise: 6
      })
  }

  onFilmPressed_Horror = () => {
    if (this.state.choise != 7)
      this.setState({
        choise: 7
      })
  }

  onSeriePressed_TV = () => {
    if (this.state.choise != 8)
      this.setState({
        choise: 8
      })
  }
  
  onSeriePressed_Animazione = () => {
    if (this.state.choise != 9)
      this.setState({
        choise: 9
      })
  }

  onSearchPressed = (input) => {
    console.log("onSearchPressed - received input " + input);
    this.setState({
      choise: 100, // choise ID for search function
      searchCriteria: input
    });
  }

}

export default App;
