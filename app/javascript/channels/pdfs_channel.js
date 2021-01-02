import consumer from "./consumer"

consumer.subscriptions.create("PdfsChannel", {
    connected() {
        // Called when the subscription is ready for use on the server
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        const links = document.querySelectorAll('.pdf-download')
        console.log(data)
        console.log(links);
        for (const link of links) {
            if (parseInt(link.dataset.pdfId) === data.pdf_id) {
                link.classList.remove("available", "pending", "none")
                link.classList.add(data.status)
            }
        }
    }
});