export function PreviewSectionLabel (props) {
    return (
        <h5 style={{textAlign: "left", marginBottom: 6, marginLeft: 10, color:"white"}}>
            {props.text.toUpperCase()}
        </h5>
    );
}

export function SectionTitle (props) {
    return (
        <h4 style={{textAlign: "left", marginLeft: 14, paddingTop: 12, color:"#289eed"}}>
            {props.text.toUpperCase()}
        </h4>
    );
}