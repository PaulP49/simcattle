import Container from 'react-bootstrap/Container'
import Nav from 'react-bootstrap/Nav'
import Navbar from 'react-bootstrap/Navbar'

/**
 * MyNavbar is the component which contains the top nav bar with links to all
 * pages.
 * @returns A JSX element containing the navbar.
 */
const MyNavbar = () => {
    return (
    <Navbar bg="light" expand="lg">
      <Container>
        <Navbar.Brand href="/">SimCattle</Navbar.Brand>
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="me-auto">
            <Nav.Link href="/">Execution</Nav.Link>
            <Nav.Link href="/map">Map View</Nav.Link>
            <Nav.Link href="/settings">Settings</Nav.Link>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
    )
}

export default MyNavbar
