import { useState, useEffect } from 'react'
import MyMap from "./MyMap"
import { getLocationsAPI } from "../../services/location"
import { getConfigurationAPI } from '../../services/configuration'

/**
 * MapView is the component for the Map View page.
 * @returns A JSX element containing the Map View page.
 */
const MapView = () => {
  // Stateful variables.
  const [locations, setLocations] = useState()
  const [sensors, setSensors] = useState()

  /**
   * getLocations fetches all locations from the REST Api.
   */
  const getLocations = async () => {
    const locations = await getLocationsAPI(0, 10413792000)
    setLocations(locations)
  }

  /**
   * getSensors fetches the defined sensors from the API.
   */
  const getSensors = async () => {
    const configuration = await getConfigurationAPI()
    const sensors = JSON.parse(configuration.sensors)

    setSensors(sensors)
  }

  // Fetch locations after render.
  useEffect(() => { getLocations() }, [])

  // Fetch configuration after render.
  useEffect(() => { getSensors() }, [])  

  // Show map after locations were loaded.
  return locations ? (
      <>
        <h1 className='title'>Map View</h1>
        <h2 className='subtitle'>Edit your layout and view your completed simulations.</h2>
        <MyMap points={locations} sensors={sensors}/>
      </>
  ) : <p>Loading...</p>
}

export default MapView
