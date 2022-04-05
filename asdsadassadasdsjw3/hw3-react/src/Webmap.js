import Campus from "./Campus"
import {WebMap} from '@esri/react-arcgis';

const Webmap = (props)=>{
    return (    
        <WebMap id='d8160e88e9604a14a2624f37f4f33d30' 
        style={{  width: '70vw', height: '90vh' }}  
        viewProperties={{
        center: [-118.28538,34.0220],
        zoom: 15
        }}>
        <Campus/>
        </WebMap>
    );
};

export default Webmap;