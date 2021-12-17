import './App.css';
import './css/card.css';
import './css/structure.css';
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
import {TopBar, Space, createPreviewStructure} from './components/structure.js';
import {SectionTitle} from './components/labels.js';
import React from 'react';

class App extends React.Component {

  choise = 0;

  constructor(props) {
    super(props);
    this.state = {choise: 0};
  }

  render() {
    return (
      <div className="App">
        <Space/>
        <TopBar onClicks={
          [this.onHomePressed, this.onFilmPressed_Animazione, this.onFilmPressed_Azione,
            this.onFilmPressed_Avventura, this.onFilmPressed_Drammatici, this.onFilmPressed_Commedie,
            this.onFilmPressed_Fantascienza, this.onFilmPressed_Horror, this.onSeriePressed_TV,
            this.onSeriePressed_Animazione]
        }/>
        {
          this.choise === 0 ? <this._displayHome/> : null
        }
        
      </div>
    );
  }

  _displayHome = () => {
    var randomValue = Math.floor(Math.random() * 7) + 1;
    return (
      <div>
        <SectionTitle text="Goditi qualcosa di nuovo"/>
        {createPreviewStructure("Film consigliati")}
        {createPreviewStructure("Serie TV consigliate")}
        <SectionTitle text="Una categoria interessante"/>
        {
          randomValue === 1 ?
            createPreviewStructure("Film di animazione") :
          randomValue === 2 ?
            createPreviewStructure("Film di azione / thriller") :
          randomValue === 3 ?
            createPreviewStructure("Film di avventura") :
          randomValue === 4 ?
            createPreviewStructure("Film drammatici / romantici") :
          randomValue === 5 ?
            createPreviewStructure("Film divertenti / comici") :
          randomValue === 6 ?
            createPreviewStructure("Film di fantascienza") :
          randomValue === 7 ?
            createPreviewStructure("Film horror") :
          null
        }
      </div>
    );
  }

  onHomePressed = () => {
    this.setState({
      choise: 0
    });
  }

  onFilmPressed_Animazione = () => {
    this.setState({
      choise: 1
    })
  }
  
  onFilmPressed_Azione = () => {
    this.setState({
      choise: 2
    })
  }

  onFilmPressed_Avventura = () => {
    this.setState({
      choise: 3
    })
  }

  onFilmPressed_Drammatici = () => {
    this.setState({
      choise: 4
    })
  }

  onFilmPressed_Commedie = () => {
    this.setState({
      choise: 5
    })
  }

  onFilmPressed_Fantascienza = () => {
    this.setState({
      choise: 6
    })
  }

  onFilmPressed_Horror = () => {
    this.setState({
      choise: 7
    })
  }
  
  onSeriePressed_Animazione = () => {
    this.setState({
      choise: 8
    })
  }

  onSeriePressed_TV = () => {
    this.setState({
      choise: 9
    })
  }

}

export default App;
