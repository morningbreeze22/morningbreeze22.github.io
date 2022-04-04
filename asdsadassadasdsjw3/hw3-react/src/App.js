import './App.css';
import React from 'react';
import ReactDOM from 'react-dom';
import {Map} from '@esri/react-arcgis';
import {Scene} from '@esri/react-arcgis';
import {WebMap,WebScene} from '@esri/react-arcgis';
import Campus from "./Campus"


function App() {
  ReactDOM.render(
    <Map /> ,
    document.getElementById('container')
  );

}

export default (props) => (
  <Scene style={{ width: '70vw', height: '90vh' }}
      //mapProperties={{ basemap: 'satellite' }}
      viewProperties={{
          center: [-118.28538,34.0220],
          zoom: 15
      }}>
      <Campus />
  </Scene>
)

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
  
  