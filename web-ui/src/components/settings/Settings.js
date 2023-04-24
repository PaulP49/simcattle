import { useRef, useState, useEffect } from 'react'

import './Settings.css'
import { getConfigurationAPI, saveConfigurationAPI } from '../../services/configuration'
import MyToast from '../toasts/MyToast'

import Button from 'react-bootstrap/Button'
import Form from 'react-bootstrap/Form'
import Setting from './Setting'

/**
 * Settings is the component which contains the settings page.
 * @returns JSX element of the settings page.
 */
const Settings = () => {
  // Refs.
  const sensorsSetting = useRef()
  const spacesSetting = useRef()
  const metasensorsSetting = useRef()
  const learnConfSetting = useRef()
  const genConfSetting = useRef()

  // Stateful variables.
  const [sensorsVal, setSensorsVal] = useState()
  const [spacesVal, setSpacesVal] = useState()
  const [metasensorsVal, setMetasensorsVal] = useState()
  const [learnConfVal, setLearnConfVal] = useState()
  const [genConfVal, setGenConfVal] = useState()
  const [showToast, setShowToast] = useState(false)
  const [toastVariant, setToastVariant] = useState()
  const [toastTitle, setToastTitle] = useState()
  const [toastText, setToastText] = useState()

  // Stateless variables.
  const sensorsDesc = `Contains all simulated sensors in a JSON structure. They "measure" the location of the entities. 
  For simplicity this is initially set to the same coordinates as the spaces 
  with coverage of a single space each.
  `
  const spacesDesc = `Contains all simulated spaces in a JSON structure. The spaces are the points were an simulated entity can move to. 
  Align changes with the Sensors setting.
  `
  const metasensorsDesc = `Contains the types of sensors available in the simulated environment. Align changes with the Sensors setting.`
  const learnConfDesc = (
    <>
      <div>Contains the configuration for the SmartSPEC Scenario-Learning component in a YAML structure. Further documentation is available in the Github Repository of SmartSPEC:</div>
      <a href='https://github.com/andrewgchio/SmartSPEC/'>https://github.com/andrewgchio/SmartSPEC/</a>
    </>
  )
  const genConfDesc = (
    <>
      <div>Contains the configuration for the SmartSPEC Scenario-Generation component in a YAML structure. Further documentation is available in the Github Repository of SmartSPEC:</div>
      <a href='https://github.com/andrewgchio/SmartSPEC/'>https://github.com/andrewgchio/SmartSPEC/</a>
    </>
  )


  /**
   * getConfiguration fetches the configuration from the API and sets the
   * configuration variables.
   */
  const getConfiguration = async () => {
    const configuration = await getConfigurationAPI()

    setSensorsVal(configuration.sensors)
    setSpacesVal(configuration.spaces)
    setMetasensorsVal(configuration.metasensors)
    setLearnConfVal(configuration.learnConf)
    setGenConfVal(configuration.genConf)
  }

  /**
   * submit is the event handler for the form submission.
   * @param {*} event 
   */
  const submit = async (event) => {
    event.preventDefault()
    
    const configuration = {
      "sensors": sensorsSetting.current.value,
      "spaces": spacesSetting.current.value,
      "metasensors": metasensorsSetting.current.value,
      "learnConf": learnConfSetting.current.value,
      "genConf": genConfSetting.current.value
    }

    try {
      await saveConfigurationAPI(configuration)

      setToastVariant("success")
      setToastTitle("Success")
      setToastText("Saved configuration successfully.")
    } catch(e) {
      setToastVariant("danger")
      setToastTitle("Error Saving Configuration")
      setToastText(e.response.data)
    }

    setShowToast(true)
  }

  // Fetch configuration after render.
  useEffect(() => { getConfiguration() }, [])

  return (
    <>
      <h1 className='title'>Settings</h1>
      <h2 className='subtitle'>Configure the simulator.</h2>
      <Form id="settings-form" onSubmit={submit}>
        <Setting name="Sensors" fieldRef={sensorsSetting} value={sensorsVal} description={sensorsDesc}/>
        <Setting name="Spaces" fieldRef={spacesSetting} value={spacesVal} description={spacesDesc}/>
        <Setting name="Metasensors" fieldRef={metasensorsSetting} value={metasensorsVal} description={metasensorsDesc}/>
        <Setting name="Scenario-Learning Configuration" fieldRef={learnConfSetting} value={learnConfVal} description={learnConfDesc}/>
        <Setting name="Scenario-Generation Configuration" fieldRef={genConfSetting} value={genConfVal} description={genConfDesc}/>

        <Button variant="primary" type="submit">Save</Button>
      </Form>
      <MyToast variant={toastVariant} title={toastTitle} text={toastText} show={showToast} stateFunc={setShowToast}/>
    </>
  )
}

export default Settings
