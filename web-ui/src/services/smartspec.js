import { client } from "../utils/axios"

/**
 * startLearningAPI calls the REST Api to start the Scenario-Learning.
 * @returns Null or an error.
 */
export const startLearningAPI = async () => {
    const response = await client.post("/learning/start")

    return response.data
}

/**
 * getStatusLearningAPI calls the REST Api to fetch the Scenario-Learning
 * status.
 * @returns The Scenario-Learning status.
 */
export const getStatusLearningAPI = async () => {
    const response = await client.get("/learning/status")

    return response.data
}

/**
 * startGenerationAPI calls the REST Api to start the Scenario-Generation.
 * @returns Null or an error.
 */
export const startGenerationAPI = async () => {
  const response = await client.post("/generation/start")

  return response.data
}

/**
 * getStatusGenerationAPI calls the REST Api to fetch the Scenario-Generation
 * status.
 * @returns The Scenario-Generation status.
 */
export const getStatusGenerationAPI = async () => {
  const response = await client.get("/generation/status")

  return response.data
}

/**
 * persistGenerationResultAPI calls the REST Api to persist the
 * Scenario-Learning result.
 * @returns Null or an error.
 */
export const persistGenerationResultAPI = async () => {
  const response = await client.post("/generation/persist")

  return response.data
}
