import { client } from "../utils/axios"

/**
 * getConfigurationAPI calls the REST Api to fetch the configuration for the
 * simulator.
 * @returns The currently stored configuration.
 */
export const getConfigurationAPI = async () => {
  const response = await client.get("/configuration")

  return response.data
}

/**
 * saveConfigurationAPI calls the REST Api to update the configuration for the
 * simulator.
 * @returns Null or an error.
 */
export const saveConfigurationAPI = async (configuration) => {
  const response = await client.put("/configuration", configuration)

  return response.data
}
