import consumer from "./consumer"

export default consumer.subscriptions.create("PdfsChannel", {
    addReceiver(documentId, f) {
      if(this.receivers === undefined) {
        this.receivers = {}
      }
      this.receivers[documentId] = f
    },

    received(data) {
      const {document_id, status} = data.body
      console.log(`PdfsChannel received ${status} for ${document_id}`)
      if(this.receivers[document_id] && status !== null) {
        this.receivers[document_id](status)
      }
    }
});
