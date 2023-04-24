# Data
The used data is stored in the folder `daten/2022-04-26-Groundtruth_Almesbach/routes/trackbackend`.

It consists of data from 10 different cattle, which are measurements of their current location, including the nearest beacon to the cattle. In total there are 20 different beacons.

# Extraction from Excel sheets to MySQL
The data is stored in 10 excel sheets, split for every cattle.

The following steps have been done initally in the Excel sheets:
 - Removed column `Address` because its unnecessary information
 - Removed suffixes `Tränke`, `Bürste` and `AMS` from all entries in `Location Beacon` to have a unified format

After that, the data of each sheet was stored as `CSV` in the folder `code/data/` and renamed to the ID of the collar tracker it originates from, later stored as `device`.

## Insertion from CSV to MySQL
The script `scripts/init/load_data_from_csv.sql` is run during the initial setup to insert the cattle data into the table `measurement` in the local MySQL instance.

It stores the data from all 10 `CSV` files including the `device`.

# Preparing data for SmartSPEC

SmartSPEC's `scenario-learning` component expects the input data in the table `learning_measurement`.

The script `scripts/init/transform_measurements.sql` copies the data from the `measurement` table to the `learning_measurement` table in a format, which SmartSPEC can deal with. It stores the number suffix of the `beacon` field, `time` and `device` in the three available fields `wifi_ap`, `cnx_time` and `client_id`.
