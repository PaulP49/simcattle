import './App.css'
import Execution from './components/execution/Execution'
import Settings from './components/settings/Settings'
import 'bootstrap/dist/css/bootstrap.min.css'
import MyNavbar from './components/navbar/MyNavbar'
import { Routes, Route } from 'react-router-dom'
import MapView from './components/map/MapView'

/**
 * App is the main component containing the application.
 * @returns A JSX element containing the app.
 */
const App = () => {
  return (
    <>
      <MyNavbar />
      <Routes>
        <Route path="" element={<Execution />} />
        <Route path="/map" element={<MapView />} />
        <Route path="/settings" element={<Settings />} />
      </Routes>
    </>
  )
}

export default App
