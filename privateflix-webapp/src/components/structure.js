import {generateFilmCards, generateItemFilmCards, generateSearchFilmCards} from './cards';
import {PreviewSectionLabel} from './labels';
import { Navbar, Container, Nav, NavDropdown, Form, FormControl, Button } from 'react-bootstrap';
import React, { Component, useState } from 'react';

export function createPreviewStructure(name, content, id) {
    return (
        <div className="preview-struct">
            <PreviewSectionLabel text={name}/>
            <div className="scrollable-container">
                {generateFilmCards(content, id)}
            </div>
        </div>
    );
}

export function createContainerStructure(content, id) {
    return (
        <div className="container-struct">
            <div className="grid-container">
                {generateItemFilmCards(content, id)}
            </div>
        </div>
    );
}

export function createSearchStructure(content, id, criteria) {
    return (
        <div className="container-struct">
            <div className="grid-container">
                {generateSearchFilmCards(content, id, criteria)}
            </div>
        </div>
    );
}

export function Space() {
    return (
        <div className='space'></div>
    );
}

// props contains an array of functions
export function TopBar(props) {
    var functions = props.onClicks;
    var formCallback = props.callback;
    return(
        <Navbar bg="dark" variant="dark" expand="lg" fixed="top">
            <Container fluid>
                <Navbar.Brand onClick={functions[0]} style={{color:"#289eed", fontSize: 32, marginRight: 24}}><b>PRIVATEFLIX</b></Navbar.Brand>
                <Navbar.Toggle aria-controls="navbarScroll" />
                <Navbar.Collapse id="navbarScroll">
                <Nav
                    className="me-auto my-2 my-lg-0"
                    style={{ maxHeight: '500px' }}
                    navbarScroll
                >
                    <Nav.Link onClick={functions[0]}>Home</Nav.Link>
                    <NavDropdown title="Film" id="navbarScrollingDropdown">
                        <NavDropdown.Item onClick={functions[1]}>Animazione</NavDropdown.Item>
                        <NavDropdown.Item onClick={functions[2]}>Azione / Thriller</NavDropdown.Item>
                        <NavDropdown.Item onClick={functions[3]}>Avventura</NavDropdown.Item>
                        <NavDropdown.Item onClick={functions[4]}>Drammatici / Romantici</NavDropdown.Item>
                        <NavDropdown.Item onClick={functions[5]}>Commedie</NavDropdown.Item>
                        <NavDropdown.Item onClick={functions[6]}>Fantascienza</NavDropdown.Item>
                        <NavDropdown.Item onClick={functions[7]}>Horror</NavDropdown.Item>
                    </NavDropdown>
                    <NavDropdown title="Serie TV" id="navbarScrollingDropdown">
                        <NavDropdown.Item onClick={functions[8]}>Serie TV</NavDropdown.Item>
                        <NavDropdown.Item onClick={functions[9]}>Serie TV Animate</NavDropdown.Item>
                    </NavDropdown>
                </Nav>
                <SearchForm callback={formCallback}/>
                </Navbar.Collapse>
            </Container>
        </Navbar>
    );
}

// needs a callback in props
export class SearchForm extends Component {

    constructor(props) {
        super(props);
        this.state = {
            title: ""
        }
        this.formPreventDefault = this.formPreventDefault.bind(this);
    }
    
    // handler recieves the `e` event object
    formPreventDefault(e) {
        e.preventDefault();
        var input = this.state.title;
        if (input.length >= 3) {
            this.setState({title: ""});
            console.log("RECEIVED " + input);
            this.props.callback(input);
        }
    }

    render() {
        return (
            <Form className="d-flex" onSubmit={this.formPreventDefault}>
                <FormControl
                    type="search"
                    placeholder="Inserisci"
                    className="me-2"
                    aria-label="Search"
                    onChange={
                        (e) => this.setState({title: e.target.value})
                    }
                    value = {this.state.title}
                />
                <Button variant="info" type="submit">Cerca</Button>
            </Form>
        );
    }

}