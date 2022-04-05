import './App.css';
import React from 'react';
import ReactDOM from 'react-dom';
import {Map} from '@esri/react-arcgis';
import Scenemap from './Scenemap';
import Webmap from './Webmap';
import MapController from "./MapController"

let ismap = 0;

function App() {
  ReactDOM.render(
    <MapController /> ,
    document.getElementById('container')
  );


}

export default App;

/*function App(){
  ReactDOM.render(
    <div style={{ width: '100vw', height: '100vh' }}  
        viewProperties={{
          center: [-118.28538,34.0220],
          zoom: 15
    }}>
  
    <WebMap id='d8160e88e9604a14a2624f37f4f33d30'>
    <Campus/>
    </WebMap>
  
    </div>,
    document.getElementById('container')
  );  
}

export default App;*/
  
  