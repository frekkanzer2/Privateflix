import './App.css';
import './css/card.css';
import './css/structure.css';
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
import {TopBar, Space, createPreviewStructure, createContainerStructure} from './components/structure.js';
import {LoadingText, AppTitle, SectionTitle, SectionTitleDedicated} from './components/labels.js';
import React from 'react';

class App extends React.Component {

  constructor(props) {
    super(props);
    this.state = {choise: -1};
    fetch("https://test2-df6d1.firebaseio.com/root.json")
      .then((res) => res.json())
      .then((json) => {
        this.setState({
          content: json,
          choise: 0
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
            <TopBar onClicks={
              [this.onHomePressed, this.onFilmPressed_Animazione, this.onFilmPressed_Azione,
                this.onFilmPressed_Avventura, this.onFilmPressed_Drammatici, this.onFilmPressed_Commedie,
                this.onFilmPressed_Fantascienza, this.onFilmPressed_Horror, this.onSeriePressed_TV,
                this.onSeriePressed_Animazione]
            }/>
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

}

export default App;
