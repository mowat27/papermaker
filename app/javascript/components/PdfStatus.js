import React, {useState} from "react"

function PdfStatus (props) {
  const [state, setState] = useState( () => {
    return {
      status: props.pdf ? props.pdf.status : "missing"
    }
  })

  return (
    <React.Fragment>
      <span className={`pdf-status ${state.status}`}>{state.status}</span>
    </React.Fragment>
  )
}

export default PdfStatus
