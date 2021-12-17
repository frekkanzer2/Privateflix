export function PreviewSectionLabel (props) {
    return (
        <h3 style={{textAlign: "left", marginBottom: 4, marginLeft: 8}}>
            {props.text.toUpperCase()}
        </h3>
    );
}