import "channels"
import React, {useState, useEffect} from "react"
import PdfsChannel from 'channels/pdfs_channel'

function PdfStatus ({pdf_id, document_id, pdf_status}) {
  const [pdfId] = useState(pdf_id)
  const [documentId] = useState(document_id)
  const [status, setStatus] = useState(pdf_status)

  useEffect(() => { 
    PdfsChannel.received = (data) => {
      console.log(`A pdf for document #${data.document_id} is now ${data.status}`)
      console.log('Local state:', "documentId =", documentId, "pdfId = ", pdfId)
      if(data.document_id === documentId) {
        setStatus(data.status)
      } 
    }}, [])

  return (
    <span className={`pdf-status ${status}`} key={`doc-${documentId}`}>{status} (doc #{documentId}, pdf #{pdfId})</span>
  )
}

export default PdfStatus
