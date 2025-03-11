import React from 'react'
import { AuroraBackground } from '../components/aurora-background'

function Event() {
    const coverimage = "https://eventornado-files.ams3.cdn.digitaloceanspaces.com/events/343/Jj8aReQ7ctQ0xOwjwtDMswiBJcynGaiTtPjFrUBx_large.jpeg";


    return (
        <AuroraBackground>
            {/* coverimage */}
            <div className="relative w-full h-[80vh] overflow-hidden">

                <div className="absolute inset-0 bg-black/50"></div>
                <img className="w-full h-full object-cover" src={coverimage} alt="cover" />
            </div>

            {/* mainsection*/}
            <div className="h-[100vh] bottom-[-68vh] absolute left-1/2 transform -translate-x-1/2 bg-white/35 rounded-lg w-[90%] md:w-[85%]">
                {/* sub navbar with different features */}
            </div>

        </AuroraBackground>
    )
}

export default Event

