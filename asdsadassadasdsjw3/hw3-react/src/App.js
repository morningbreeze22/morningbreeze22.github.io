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