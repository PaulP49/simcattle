import axios from "axios"

// Axios client for request to the REST Api.
const client = axios.create({
   baseURL: process.env.REACT_APP_SERVER_URL + "/api" 
})

export { client }
