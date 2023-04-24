import Toast from 'react-bootstrap/Toast'
import ToastContainer from 'react-bootstrap/ToastContainer'

import './MyToast.css'

/**
 * MyToast is a component to display toast messages.
 * @param {*} props The props of the component.
 * @returns A JSX element containing a a ToastContainer with a Toast in it.
 */
const MyToast = (props) => {
  return (
    <ToastContainer id="toast-container" className="p-3" position="top-end">
      <Toast onClose={() => props.stateFunc(false)} show={props.show} delay={10000} bg={props.variant} autohide>
        <Toast.Header>
          <strong className="me-auto">{props.title}</strong>
        </Toast.Header>
        <Toast.Body>{props.text}</Toast.Body>
      </Toast>
    </ToastContainer>
  )
}

export default MyToast
