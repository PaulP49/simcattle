INSERT INTO simcattle.smartspec_conf (`sensors`, `spaces`, `metasensors`, `learn_conf`, `gen_conf`)
VALUES (
'[
    {
        "id": 1,
        "metasensor-id": 1,
        "coverage": [1],
        "coordinates": [3,3,1],
        "geoCoordinates": [49.68168614140271,12.199246531983448,1]
    },
    {
        "id": 2,
        "metasensor-id": 1,
        "coverage": [2],
        "coordinates": [3,2,1],
        "geoCoordinates": [49.68163864109388,12.199289060635687,1]
    },
    {
        "id": 3,
        "metasensor-id": 1,
        "coverage": [3],
        "coordinates": [3,1,1],
        "geoCoordinates": [49.68158996138931,12.19933106498558,1]
    },
    {
        "id": 4,
        "metasensor-id": 1,
        "coverage": [4],
        "coordinates": [3,0,1],
        "geoCoordinates": [49.6815416168796,12.199374698510486,1]
    },
    {
        "id": 5,
        "metasensor-id": 1,
        "coverage": [5],
        "coordinates": [2,0,1],
        "geoCoordinates": [49.681507303985796,12.19927908068362,1]
    },
    {
        "id": 6,
        "metasensor-id": 1,
        "coverage": [6],
        "coordinates": [2,1,1],
        "geoCoordinates": [49.68155539409804,12.199236814182555,1]
    },
    {
        "id": 7,
        "metasensor-id": 1,
        "coverage": [7],
        "coordinates": [2,2,1],
        "geoCoordinates": [49.681604348471495,12.199194191858536,1]
    },
    {
        "id": 8,
        "metasensor-id": 1,
        "coverage": [8],
        "coordinates": [2,4,1],
        "geoCoordinates": [49.681660897440366,12.199142826903778,1]
    },
    {
        "id": 9,
        "metasensor-id": 1,
        "coverage": [9],
        "coordinates": [1,3,1],
        "geoCoordinates": [49.681617047119886,12.199057964795283,1]
    },
    {
        "id": 10,
        "metasensor-id": 1,
        "coverage": [10],
        "coordinates": [1,2,1],
        "geoCoordinates": [49.68156855583595,12.19910049056047,1]
    },
    {
        "id": 11,
        "metasensor-id": 1,
        "coverage": [11],
        "coordinates": [1,1,1],
        "geoCoordinates": [49.681521095937654,12.19914174430126,1]
    },
    {
        "id": 12,
        "metasensor-id": 1,
        "coverage": [12],
        "coordinates": [1,0,1],
        "geoCoordinates": [49.681472604558024,12.199184270066445,1]
    },
    {
        "id": 13,
        "metasensor-id": 1,
        "coverage": [13],
        "coordinates": [0,0,1],
        "geoCoordinates": [49.681454888552196,12.199139437638001,1]
    },
    {
        "id": 14,
        "metasensor-id": 1,
        "coverage": [14],
        "coordinates": [0,1,1],
        "geoCoordinates": [49.68150332868538,12.199099995195867,1]
    },
    {
        "id": 15,
        "metasensor-id": 1,
        "coverage": [15],
        "coordinates": [0,2,1],
        "geoCoordinates": [49.68155265441732,12.199056744575499,1]
    },
    {
        "id": 16,
        "metasensor-id": 1,
        "coverage": [16],
        "coordinates": [0,3,1],
        "geoCoordinates": [49.681599431109674,12.199011649936438,1]
    },
    {
        "id": 17,
        "metasensor-id": 1,
        "coverage": [17],
        "coordinates": [0,4,1],
        "geoCoordinates": [49.68164737378305,12.198968064039947,1]
    },
    {
        "id": 18,
        "metasensor-id": 1,
        "coverage": [18],
        "coordinates": [1,4,1],
        "geoCoordinates": [49.68166940624579,12.199029922485352,1]
    },
    {
        "id": 19,
        "metasensor-id": 1,
        "coverage": [19],
        "coordinates": [2,3,1],
        "geoCoordinates": [49.681637855756065,12.199179120361807,1]
    }
]',
'[
    {
        "id": 0,
        "description": "outside",
        "capacity": -1,
        "neighbors": [
            8
        ],
        "coordinates": [6,1,1],
        "geoCoordinates": [49.68181426283488,12.198898781537865,1]
    },
    {
        "id": 1,
        "capacity": 10,
        "neighbors": [
            2, 19
        ],
        "coordinates": [3,3,1],
        "geoCoordinates": [49.68168614140271,12.199246531983448,1]
    },
    {
        "id": 2,
        "capacity": 10,
        "neighbors": [
            7, 3, 1
        ],
        "coordinates": [3,2,1],
        "geoCoordinates": [49.68163864109388,12.199289060635687,1]
    },
    {
        "id": 3,
        "capacity": 10,
        "neighbors": [
            4, 6, 2
        ],
        "coordinates": [3,1,1],
        "geoCoordinates": [49.68158996138931,12.19933106498558,1]
    },
    {
        "id": 4,
        "capacity": 10,
        "neighbors": [
            5, 3
        ],
        "coordinates": [3,0,1],
        "geoCoordinates": [49.6815416168796,12.199374698510486,1]
    },
    {
        "id": 5,
        "capacity": 10,
        "neighbors": [
            6, 12, 4
        ],
        "coordinates": [2,0,1],
        "geoCoordinates": [49.681507303985796,12.19927908068362,1]
    },
    {
        "id": 6,
        "capacity": 10,
        "neighbors": [
            11, 5, 7, 3
        ],
        "coordinates": [2,1,1],
        "geoCoordinates": [49.68155539409804,12.199236814182555,1]
    },
    {
        "id": 7,
        "capacity": 10,
        "neighbors": [
            10, 6, 2, 19
        ],
        "coordinates": [2,2,1],
        "geoCoordinates": [49.681604348471495,12.199194191858536,1]
    },
    {
        "id": 8,
        "capacity": 10,
        "neighbors": [
            18, 19
        ],
        "coordinates": [2,4,1],
        "geoCoordinates": [49.681660897440366,12.199142826903778,1]
    },
    {
        "id": 9,
        "capacity": 10,
        "neighbors": [
            16, 10, 18, 19
        ],
        "coordinates": [1,3,1],
        "geoCoordinates": [49.681617047119886,12.199057964795283,1]
    },
    {
        "id": 10,
        "capacity": 10,
        "neighbors": [
            15, 11, 9, 7
        ],
        "coordinates": [1,2,1],
        "geoCoordinates": [49.68156855583595,12.19910049056047,1]
    },
    {
        "id": 11,
        "capacity": 10,
        "neighbors": [
            14, 12, 10, 6
        ],
        "coordinates": [1,1,1],
        "geoCoordinates": [49.681521095937654,12.19914174430126,1]
    },
    {
        "id": 12,
        "capacity": 10,
        "neighbors": [
            13, 11, 5
        ],
        "coordinates": [1,0,1],
        "geoCoordinates": [49.681472604558024,12.199184270066445,1]
    },
    {
        "id": 13,
        "capacity": 10,
        "neighbors": [
            12, 14
        ],
        "coordinates": [0,0,1],
        "geoCoordinates": [49.681454888552196,12.199139437638001,1]
    },
    {
        "id": 14,
        "capacity": 10,
        "neighbors": [
            13, 11, 15
        ],
        "coordinates": [0,1,1],
        "geoCoordinates": [49.68150332868538,12.199099995195867,1]
    },
    {
        "id": 15,
        "capacity": 10,
        "neighbors": [
            14, 10, 16
        ],
        "coordinates": [0,2,1],
        "geoCoordinates": [49.68155265441732,12.199056744575499,1]
    },
    {
        "id": 16,
        "capacity": 10,
        "neighbors": [
            9, 17, 15
        ],
        "coordinates": [0,3,1],
        "geoCoordinates": [49.681599431109674,12.199011649936438,1]
    },
    {
        "id": 17,
        "capacity": 10,
        "neighbors": [
            16, 18
        ],
        "coordinates": [0,4,1],
        "geoCoordinates": [49.68164737378305,12.198968064039947,1]
    },
    {
        "id": 18,
        "capacity": 10,
        "neighbors": [
            17, 9, 8
        ],
        "coordinates": [1,4,1],
        "geoCoordinates": [49.68166940624579,12.199029922485352,1]
    },
    {
        "id": 19,
        "capacity": 10,
        "neighbors": [
            9, 7, 8, 2
        ],
        "coordinates": [2,3,1],
        "geoCoordinates": [49.681637855756065,12.199179120361807,1]
    }
]',
'[
    {
        "id" : 1,
        "description" : "Bluetooth Beacon"
    }
]',
'[learners]
start       = 2022-04-26
end         = 2022-04-28
unit        = 1
validity    = 1
smooth      = EMA
window      = 10
time-thresh = 5
occ-thresh  = 1

',
'[people]
number = 10
generation = all

[events]
number = 3000
generation = all

[synthetic-data-generator]
start = 2022-04-26
end   = 2022-04-26

'
);
