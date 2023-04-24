import { useState, useEffect } from 'react'

import { 
  getStatusLearningAPI, 
  getStatusGenerationAPI, 
  startLearningAPI, 
  startGenerationAPI, 
  persistGenerationResultAPI } from "../../services/smartspec"
import './Execution.css'
import Step from "./Step"
import MyToast from '../toasts/MyToast'

import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'

/**
 * Execution is the component which contains the execution page.
 * @returns JSX element of the execution page.
 */
const Execution = () => {
  // Stateful variables.
  const [statusLearning, setStatusLearning] = useState()
  const [statusGeneration, setStatusGeneration] = useState()
  const [showToast, setShowToast] = useState(false)
  const [toastVariant, setToastVariant] = useState()
  const [toastTitle, setToastTitle] = useState()
  const [toastText, setToastText] = useState()

  /**
   * getStatusLearning fetches the learning status from the REST Api and sets it
   * on the page.
   */
  const getStatusLearning = async () => {
    const status = await getStatusLearningAPI()
    
    setStatusLearning(status)
  }

  /**
   * getStatusGeneration fetches the generation status from the REST Api and
   * sets it on the page.
   */
  const getStatusGeneration = async () => {
    const status = await getStatusGenerationAPI()
    
    setStatusGeneration(status)
  }

  /**
   * startLearning starts the learning by a call to the REST Api.
   */
  const startLearning = async () => {
    try {
      await startLearningAPI()

      setStatusLearning("IN_PROGRESS")

      setToastVariant("success")
      setToastTitle("Success")
      setToastText("Started Scenario-Learning.")
    } catch(e) {
      setToastVariant("danger")
      setToastTitle("Error starting Scenario-Learning.")
      setToastText(e.response.data)
    }

    setShowToast(true)
  }

  /**
   * startGeneration starts the generation by a call to the REST Api.
   */
  const startGeneration = async () => {
    try {
      await startGenerationAPI()

      setStatusGeneration("IN_PROGRESS")

      setToastVariant("success")
      setToastTitle("Success")
      setToastText("Started Scenario-Generation.")
    } catch(e) {
      setToastVariant("danger")
      setToastTitle("Error starting Scenario-Generation.")
      setToastText(e.response.data)
    }

    setShowToast(true)
  }

  /**
   * persistResult persists the generation result by a call to the REST Api.
   */
  const persistResult = async () => {
    try {
      await persistGenerationResultAPI()

      setToastVariant("success")
      setToastTitle("Persisted Scenario-Generation Result")
      setToastText("Switch to tab \"Map View\" to view the results on the map.")
    } catch(e) {
      setToastVariant("danger")
      setToastTitle("Error persisting Scenario-Generation result.")
      setToastText(e.response.data)
    }

    setShowToast(true)
  }

  /**
   * isButtonDisables returns if the button of a step is disabled.
   * @param {*} name The step name.
   * @returns If the button is disabled.
   */
  const isButtonDisabled = (name) => {
    switch(name) {
      case "Scenario-Learning":
        return statusLearning === "IN_PROGRESS" || statusGeneration === "IN_PROGRESS"
      case "Scenario-Generation":
        return statusLearning === "NOT_STARTED" || statusLearning === "IN_PROGRESS" || statusGeneration === "IN_PROGRESS"
      case "Persist Result":
        return statusGeneration !== "COMPLETED"
      default:
        return false
    }
  }

  // Periodically fetch learning status every 5 seconds after render.
  useEffect(() => {
    getStatusLearning()
    const id = setInterval(getStatusLearning, 5000)

    return () => clearInterval(id)
  }, [])

  // Periodically fetch generation status every 5 seconds after render.
  useEffect(() => {
    getStatusGeneration()
    const id = setInterval(getStatusGeneration, 5000)

    return () => clearInterval(id)
  }, [])

  return (
    <>
      <h1 className='title'>Execution</h1>
      <h2 className='subtitle'>Train your model and execute your simulation.</h2>
      <Container id="execution-container" fluid>
        <Row>
          <Col>
            <Step name="Scenario-Learning" status={statusLearning} clickFunc={startLearning} disabled={isButtonDisabled("Scenario-Learning")} />
          </Col>
          <Col>
            <Step name="Scenario-Generation" status={statusGeneration} clickFunc={startGeneration} disabled={isButtonDisabled("Scenario-Generation")} />
          </Col>
          <Col>
            <Step name="Persist Result" clickFunc={persistResult} disabled={isButtonDisabled("Persist Result")} />
          </Col>
        </Row>
      </Container>
      <MyToast variant={toastVariant} title={toastTitle} text={toastText} show={showToast} stateFunc={setShowToast}/>
    </>
  )
}

export default Execution
