import './App.css';
import './css/card.css';
import './css/structure.css';
import {createPreviewStructure} from './components/structure.js';

function App() {

  return (
    <div className="App">
      {createPreviewStructure("PREVIEW 1")}
      {createPreviewStructure("PREVIEW 2")}
      {createPreviewStructure("PREVIEW 3")}
    </div>
  );
}

export default App;
