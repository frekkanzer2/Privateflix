import {generateFilmCards} from './cards';
import {PreviewSectionLabel} from './labels';

export function createPreviewStructure(name) {
    return (
        <div className="preview-struct">
            <PreviewSectionLabel text={name}/>
            <div className="scrollable-container">
                {generateFilmCards()}
            </div>
        </div>
    );
}