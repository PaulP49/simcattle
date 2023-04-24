import { client } from "../utils/axios"

/**
 * getLocationsAPI calls the REST Api to fetch the simulated locations between
 * two points in time.
 * @param {*} start UNIX timestamp
 * @param {*} end UNIX timestamp
 * @returns The locations.
 */
export const getLocationsAPI = async (start = 0, end = Number.MAX_SAFE_INTEGER) => {
  const response = await client.get(`/locations?start=${start}&end=${end}`)

  return response.data
}
