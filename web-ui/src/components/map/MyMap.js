import React, { useState, useEffect, useRef } from 'react'
import './MyMap.css'

import Map from 'ol/Map'
import View from 'ol/View'
import TileLayer from 'ol/layer/Tile'
import VectorLayer from 'ol/layer/Vector'
import VectorSource from 'ol/source/Vector'
import GeoJSON from 'ol/format/GeoJSON'
import {fromLonLat, toLonLat} from 'ol/proj'
import OSM from 'ol/source/OSM'
import DragAndDrop from 'ol/interaction/DragAndDrop'
import Modify from 'ol/interaction/Modify'
import Draw from 'ol/interaction/Draw'
import Select from 'ol/interaction/Select.js';
import Feature from 'ol/Feature'
import Point from 'ol/geom/Point'
import Style from 'ol/style/Style'
import Text from 'ol/style/Text'
import Fill from 'ol/style/Fill'
import Stroke from 'ol/style/Stroke'
import Icon from 'ol/style/Icon'
import { pointerMove } from 'ol/events/condition.js';

import Button from 'react-bootstrap/Button'
import Card from 'react-bootstrap/Card'
import { Play, Pause } from 'react-bootstrap-icons'

/**
 * MyMap is a functional component which contains the map.
 * @returns The map as a JSX element.
 */
const MyMap = (props) => {
  // Props.
  const points = props.points
  const sensors = props.sensors

  // Stateful variables.
  const [map, setMap] = useState()
  const [vectorSource, setVectorSource] = useState()
  const [entitySource, setEntitySource] = useState()
  const [sensorSource, setSensorSource] = useState()
  const [currTime, setCurrTime] = useState()
  const [playing, setPlaying] = useState(true)
  const [editing, setEditing] = useState(false)
  const [dadInteraction, setDadInteraction] = useState()
  const [modInteraction, setModInteraction] = useState()
  const [drawInteraction, setDrawInteraction] = useState()
    
  // Refs.
  const mapElement = useRef()
  const downloadElement = useRef()
  const playingRef = useRef(true)

  mapElement.current = map
  
  /**
   * clock runs a loop to update the current time in a defined interval.
   */
  const clock = async () => {
    if (points === undefined || points.length === 0) {
      return
    }

    const minTime = Date.parse(points[0].startTime)
    const maxTime = Date.parse(points[points.length-1].endTime)
    const rate = 1 // Jump 1 second.
    const speed = 1 // One update per second.

    let time = minTime
    if (currTime !== undefined) { // Resume clock.
      time = currTime
    } else { // Start clock.
      setCurrTime(minTime)
    }

    while(time < maxTime) {
      await new Promise(r => setTimeout(r, 1000 * speed))

      // Using a ref as "playing" state is not changing in loop.
      if (!playingRef.current) {
        return
      }

      time = time + (1000 * rate)
      setCurrTime(time)
    }

    // Reset clock.
    setCurrTime(minTime)
  }

  /**
   * startStopAnimation starts/stops animation based on the "playing" state.
   */
  const startStopAnimation = () => {
    if (playing) {
      playingRef.current = true
      clock()
    } else {
      playingRef.current = false
    }
  }

  /**
   * enableDisableEditing enables/disables the interactions for editing the map
   * layout.
   */
  const enableDisableEditing = () => {
    if (map === undefined) {
      return
    }

    if (editing) {
      map.addInteraction(dadInteraction)
      map.addInteraction(modInteraction)
      map.addInteraction(drawInteraction)
      
      setDownloadLink(vectorSource)
    } else {
      map.removeInteraction(dadInteraction)
      map.removeInteraction(modInteraction)
      map.removeInteraction(drawInteraction)
    }
  }

  /**
   * addMissingPoints converts the points, which are not already on the map to
   * features and displays them on the map.
   */
  const addMissingPoints = (features) => {
    pointsloop:
    for (const i in points) {
      const startTime = Date.parse(points[i].startTime)
      const endTime = Date.parse(points[i].endTime)
      if (startTime <= currTime && currTime <= endTime) {
        const name = points[i].cattleID
        const uid = name + startTime + endTime
        const geometry = new Point(fromLonLat([points[i].longitude, points[i].latitude]))

        for (const feature of features) {
          if (feature.get("uid") === uid) {
            continue pointsloop
          }
        }

        entitySource.addFeature(
          new Feature({
            uid: uid,
            name: "Entity " + name,
            geometry: geometry,
            startTime: startTime,
            endTime: endTime
          })
        )
      } else if (endTime <= currTime) {
        points.splice(i, 1)
      }
    }
  }

  /**
   * removeOutdatedPoints removes all outdated points from the map.
   * @param {*} features 
   */
  const removeOutdatedPoints = (features) => {
    for (const feature of features) {
      if (feature.get("endTime") <= currTime) {
        entitySource.removeFeature(feature)
      }
    }
  }

  /**
   * updatePoints updates the points on the map to the one's which are valid for
   * the current clock time.
   */
  const updatePoints = () => {
    if (entitySource === undefined) {
      return
    }
    
    const features = entitySource.getFeatures()
    
    removeOutdatedPoints(features)
    addMissingPoints(features)
  }

  /**
   * Returns the style for the points on the map including icon and label.
   * @returns Style[]
   */
  const getPointStyle = () => {
    const iconStyle = new Style({
      image: new Icon({
        anchor: [0.5, 46],
        anchorXUnits: 'fraction',
        anchorYUnits: 'pixels',
        src: 'https://www.geocodezip.net/mapIcons/geolocation_marker.png',
        scale: 1
      })
    })

    const labelStyle = new Style({
      text: new Text({
        font: '12px Calibri,sans-serif',
        overflow: true,
        fill: new Fill({
          color: '#000'
        }),
        stroke: new Stroke({
          color: '#fff',
          width: 3
        }),
        offsetY: -12
      })
    })
    
    return [iconStyle, labelStyle]
  }

  /**
   * Returns the style for the sensors on the map including icon and label.
   * @returns Style[]
   */
  const getSensorStyle = () => {
    const iconStyle = new Style({
      image: new Icon({
        anchor: [0.5, 46],
        anchorXUnits: 'fraction',
        anchorYUnits: 'pixels',
        src: 'https://cdn-icons-png.flaticon.com/512/747/747404.png',
        scale: 0.03
      })
    })

    const labelStyle = new Style({
      text: new Text({
        font: '12px Calibri,sans-serif',
        overflow: true,
        fill: new Fill({
          color: '#000'
        }),
        stroke: new Stroke({
          color: '#fff',
          width: 3
        }),
        offsetY: -12
      })
    })
    
    return [iconStyle, labelStyle]
  }

  /**
   * addSensors adds the sensors to the map.
   */
  const addSensors = () => {
    if (sensorSource === undefined) {
      return
    }

    sensors.forEach(sensor => {
      const geometry = new Point(fromLonLat([sensor.geoCoordinates[1], sensor.geoCoordinates[0]]))

      sensorSource.addFeature(
        new Feature({
          name: "Sensor " + sensor.id,
          geometry: geometry
        })
      )
    })
  }

  /**
   * clearMap removes all vector drawings from the map.
   */
  const clearMap = () => {
    vectorSource.clear()
  }

  /**
   * setDownloadLink set the download link for the current vector drawings on
   * the map as a GeoJSON file.
   * @param {*} source The vector drawings.
   */
  const setDownloadLink = (source) => {
    const format = new GeoJSON({featureProjection: 'EPSG:3857'})
    const features = source.getFeatures()
    const json = format.writeFeatures(features)

    downloadElement.current.href = 'data:application/json;charset=utf-8,' + encodeURIComponent(json)
  }

  /**
   * Toggles the display of the text for any feature after it is
   * selected/unselected.
   * @param {*} event The select event.
   */
  const toggleFeatureText = (event) => {
    if (event.deselected.length) {
      const feature = event.deselected[0]
      feature.set('displayName', '')

    } else if (event.selected.length) {
      const feature = event.selected[0]
      feature.set('displayName', feature.get('name'))
    }
  }

  /**
   * logCoords logs the clicked coordinates in the browser console.
   * @param {*} event The click event
   */
  const logCoords = (event) => {
    const clickedCoord = mapElement.current.getCoordinateFromPixel(event.pixel);
    const coords = toLonLat(clickedCoord)

    console.log("Lat:", coords[1], "\nLon:", coords[0])
  }

  /**
   * clockPretty converts a unix timestamp to a human readable format.
   * @returns A date string in de-DE format.
   */
  const clockPretty = () => {
    const date = new Date(currTime)
    return date.toLocaleString("de-DE")
  }

  /**
   * createMap creates the map. 
   */
  const createMap = () => {
    const vectorSource = new VectorSource()
    const entitySource = new VectorSource({
      useSpatialIndex: false
    })
    const sensorSource = new VectorSource({
      useSpatialIndex: false
    })
    const select = new Select({
      condition: pointerMove,
      style: null,
    });

    const pointsStyle = getPointStyle()
    const sensorStyle = getSensorStyle()

    let center = [0, 0]
    if (points !== undefined && points.length !== 0) {
      center = fromLonLat([points[0].longitude, points[0].latitude])
    }

    const initialMap = new Map({
      target: mapElement.current,
      layers: [
        new TileLayer({
          source: new OSM()
        }),
        new VectorLayer({
          source: vectorSource
        }),
        new VectorLayer({
          source: sensorSource,
          style: (feature) => {
            sensorStyle[1].getText().setText(feature.get('displayName'))
            return sensorStyle
          }
        }),
        new VectorLayer({
          source: entitySource,
          style: (feature) => {
            pointsStyle[1].getText().setText(feature.get('displayName'))
            return pointsStyle
          }
        })
      ],
      view: new View({
        center: center,
        zoom: 20
      }),
      controls: []
    })

    setDadInteraction(
      new DragAndDrop({
        source: vectorSource,
        formatConstructors: [GeoJSON],
      })
    )
    
    setModInteraction(
      new Modify({
        source: vectorSource,
      }) 
    )
    
    setDrawInteraction(
      new Draw({
        type: 'Polygon',
        source: vectorSource,
      })
    )
    
    vectorSource.on('change', () => setDownloadLink(vectorSource))
    initialMap.on('click', logCoords)

    initialMap.addInteraction(select)
    select.on('select', toggleFeatureText)

    setVectorSource(vectorSource)
    setEntitySource(entitySource)
    setSensorSource(sensorSource)
    setMap(initialMap)

    return () => initialMap.setTarget(null)
  }

  // Create map after the render.
  useEffect(createMap, [])

  // Add sensors to map after render.
  useEffect(addSensors, [map])

  // Update the points on the map at every clock tick.
  useEffect(updatePoints, [currTime])

  // Start/stop animation after play/pause button click.
  useEffect(startStopAnimation, [playing])

  // Enable/disable editing.
  useEffect(enableDisableEditing, [editing])

  return (
    <>
      <div ref={mapElement} className="map-container">
        <Button id="play-btn" variant="dark" onClick={() => { setPlaying(!playing) }}>
          { playing
            ? <Pause size={30}/>
            : <Play size={30}/>
          }
        </Button>

        <Card id="clock" className="text-center">
          <Card.Body>{clockPretty()}</Card.Body>
        </Card>
        
        <div id="tools">
          { editing ? 
            <>
              <Button id="clear-btn" variant="danger" onClick={clearMap}>Clear</Button>
              <Button id="download-btn" variant="secondary">
                <a id="download" ref={downloadElement} download="features.json">Download</a>
              </Button>
              <Button id="save-btn" variant="primary" onClick={() => setEditing(false)}>Save</Button>
            </>
            : <Button id="edit-btn" variant="light" onClick={() => setEditing(true)}>Edit Layout</Button>
          }
        </div>
      </div>
    </>
  ) 
}

export default MyMap
