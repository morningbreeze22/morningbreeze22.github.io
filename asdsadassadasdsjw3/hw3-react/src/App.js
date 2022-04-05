import './App.css';
import React from 'react';
import ReactDOM from 'react-dom';
import {Map} from '@esri/react-arcgis';
import Scenemap from './Scenemap';
import Webmap from './Webmap';
import MapController from "./MapController"

function App() {
  ReactDOM.render(
    <MapController /> ,
    document.getElementById('container')
  );


}

export default App;
