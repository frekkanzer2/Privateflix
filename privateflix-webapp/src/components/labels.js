export function AppTitle (props) {
    return (
        <h1 style={{textAlign: "center", color:"#289eed"}}>
            PRIVATEFLIX
        </h1>
    );
}

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

export function SectionTitleDedicated (props) {
    return (
        <h4 style={{textAlign: "center", marginLeft: 14, paddingTop: 12, marginBottom: 24, color:"#289eed"}}>
            {props.text.toUpperCase()}
        </h4>
    );
}

export function LoadingText() {
    return (
        <div className="center-container">
            <h1 style={{textAlign: "center", paddingTop: 12, color:"white"}}>
                LOADING
            </h1>
            <h4 style={{textAlign: "center", color:"white"}}>
                Getting films for you
            </h4>
            <h2 style={{textAlign: "center", paddingTop: 12, color:"white"}}>
                🤍
            </h2>
        </div>
    )
}