import Webmap from "./Webmap";
import Scenemap from "./Scenemap";
import React, { useState, useEffect } from 'react';


function MapController(){

    const [count,setCount] = useState(0);


    if(count==0){
        return(        
            <div className="flex-block">
                <div>
                    <Scenemap />
                </div>
                <div>
                    <button onClick={()=>setCount(1-count)}>change to webmap</button>
                </div>
            </div>
        );
    }
    else{
        return(        
            <div className="flex-block">
                <div>
                    <Webmap />
                </div>
                <div>
                    <button onClick={()=>setCount(1-count)}>change to scenemap</button>
                </div>
                
            </div>
        );
    }
}

export default MapController;