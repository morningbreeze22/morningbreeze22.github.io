import {Scene} from '@esri/react-arcgis';
import Campus from "./Campus"

const Scenemap  = (props) => {
    return (
    <Scene style={{ width: '70vw', height: '90vh' }}
        //mapProperties={{ basemap: 'satellite' }}
        viewProperties={{
            center: [-118.28538,34.0220],
            zoom: 15
        }}>
        <Campus />
    </Scene>
    );
}

export default Scenemap;