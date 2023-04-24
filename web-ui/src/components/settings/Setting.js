import Form from 'react-bootstrap/Form'
import OverlayTrigger from 'react-bootstrap/OverlayTrigger'
import Popover from 'react-bootstrap/Popover'
import Button from 'react-bootstrap/Button'
import { QuestionCircleFill } from 'react-bootstrap-icons'

/**
 * Setting is the component for a single setting contained in a form field.
 * @param {} props The passed properties.
 * @returns A form group JSX element.
 */
const Setting = (props) => {
  const popover = (
    <Popover id="setting-popover">
      <Popover.Header as="h3">{props.name}</Popover.Header>
      <Popover.Body>{props.description}</Popover.Body>
    </Popover>
  )

  return (
    <Form.Group className="mb-3">
      <Form.Label>
        {props.name}&nbsp;
        <OverlayTrigger trigger="click" placement="right" overlay={popover}>
          <QuestionCircleFill id="setting-question" size={20} />
        </OverlayTrigger>
      </Form.Label>
      <Form.Control id="setting-input" as="textarea" rows={20} ref={props.fieldRef} defaultValue={props.value} />
    </Form.Group>
  )
}

export default Setting
