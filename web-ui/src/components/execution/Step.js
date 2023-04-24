import Button from 'react-bootstrap/Button'
import Card from 'react-bootstrap/Card'
import Badge from 'react-bootstrap/Badge'
import { CheckCircle, Circle, DashCircle, HourglassSplit, QuestionCircle } from 'react-bootstrap-icons'

/**
 * Step is the component containing a step in the execution pipeline.
 * @param {*} props The properties of this component.
 * @returns A JSX element containing the step.
 */
const Step = (props) => {
  /**
   * getStatus returns a Badge with an icon and text describing the current
   * status of the step.
   * @returns A JSX element containing a Badge.
   */
  const getStatus = () => {
    switch(props.status) {
      case "NOT_STARTED":
        return (
          <Badge className="status" bg="secondary">
            <Circle size={20} /> &nbsp;
            Not Started
          </Badge>
        )
      case "IN_PROGRESS":
        return (
          <Badge className="status" bg="warning">
            <HourglassSplit size={20} /> &nbsp;
            In Progress
          </Badge>
        )
      case "COMPLETED":
        return (
          <Badge className="status" bg="success">
            <CheckCircle size={20} /> &nbsp;
            Completed
          </Badge>
        )
      case "FAILED":
        return (
          <Badge className="status" bg="danger">
            <DashCircle size={20} /> &nbsp;
            Failed
          </Badge>
        )
      default:
        return
    }
  }

  /**
   * getText returns the description text of the step.
   * @returns Text.
   */
  const getText = () => {
    switch(props.name) {
      case "Scenario-Learning":
        return `This stage executes the Scenario-Learning component to generate
        a model out of the input data stored in the database. It analyses the 
        structure and diversity of the data to create a representation of the 
        entities\` behavior.`
      case "Scenario-Generation":
        return `This stage executes the Scenario-Generation component which uses
        the previously trained model to generate new data. The output are
        simulated locations of generated entities.`
      case "Persist Result":
        return `After the Scenario-Generation has finished the result can be 
        persisted in the database and afterwards viewed on the map in the tab 
        "Map View".`
      default:
        return ""
    }
  }

  /**
   * getButtonText returns the text on the button of the step.
   * @returns Text.
   */
  const getButtonText = () => {
    if (props.name.startsWith("Scenario")) {
      return "Start " + props.name
    } 
    
    return props.name
  }

  return (
    <Card>
      <Card.Header className="step-header" as="h5">
        {props.name}
        {getStatus()}
      </Card.Header>
      <Card.Body>
        <Card.Text className='step-text'>{getText()}</Card.Text>
        <Button variant="primary" onClick={props.clickFunc} disabled={props.disabled}>{getButtonText()}</Button>
      </Card.Body>
    </Card>
  )
}

export default Step
