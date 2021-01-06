import "channels"
import React, { useState, useEffect } from "react"
import PdfsChannel from 'channels/pdfs_channel'

function PdfStatus({ pdf_id, document_id, pdf_status }) {
    const [pdfId] = useState(pdf_id)
    const [documentId] = useState(document_id)
    const [status, setStatus] = useState(pdf_status)

    useEffect(() => { PdfsChannel.addReceiver(documentId, setStatus) }, [])
    
    return ( <span className = { `pdf-status ${status}` }
        key = { `doc-${documentId}` } > { status }(doc# { documentId }, pdf# { pdfId }) </span>
    )
}

export default PdfStatus