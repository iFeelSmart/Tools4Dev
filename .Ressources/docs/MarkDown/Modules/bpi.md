[<<< Back To Readme](../../../../README.md)
<p align="center">
    <img src="https://github.com/T4D-Suites/T4D-Ressources/blob/master/LogoBPI.png">
</p>


## Name
<p>bpi</p>


## Synopsis
<p>Interact with s3 contents and builds to simplify deployment of CI generated artifacts</p>


## Definition
<p>

Bpi (Build Puller & Injector) is a command line tools that allow user to interact with

    1. Devices
By loading their config files stored in a global inventory manager (smartphone, iphone etc. ).
It allow any user to save and share a configuration like his IP, his MacAddress, his Name or even his project's

- For more information:
```
bpi help device add
bpi help device select
```

    2. Binaries on AWS S3
All archives built might be stored in a global server called S3.
You can use bpi s3 to explore every single folders to find the right build that you need to test and import/pull it directly to your workspace

- For more information:
```
bpi help s3
```

    3. Install local bin to your devices
Using bpi install you will be able to connect to previous selected device ( by using bpi device {ID} ) to install any available AND compatible binaries downloaded ( using bpi s3 )

- For more information:
```
bpi help install
```


    4. Base Workflow
Using default workflow behavior you might want to first add you device to the current inventory, select it and load his configuration file.
Then you will be able to explore S3 Server to find any compatible archive, pull it (download + extract) then install it on your device.

- Device:
```
Add device                       = bpi device add -uuid uuid ...        
Select device                    = bpi device device-id
```
- Pull:
```
Search build on S3               = bpi s3 {S3FolderUrl}
Pull build from S3               = bpi s3 {FileS3Url} -pull -extract
```
- Install:
```
Select device                    = bpi device device-id
Install build on device          = bpi install folder
```
</p>


## Usage

* `bpi <option> **arguments**`

Will execute bpi command with all arguments


* `bpi help <option>`

Show specific option's documentation


## Options
- **device**
    - _Manage devices inventory_
        >        * add               = add device inventory content
        >        * update            = update device inventory content
        >        * remove            = remove device from inventory
        >        * <device-UUID>     = load device in console to use with bpi deploy commands
- **select**
    - _select a device, if none specified display available devices in inventory_
- **s3**
    - _Browse, download and extract content archived on S3 buckets_
        >        * -pull         = download file from given S3 path
        >        * -pull-latest  = list all files contained in given S3 path and only download latest's one
        >        * -extract      = if -pull is set, extract downloaded archive
        >        * -silent       = enable silent mode
- **install**
    - _Deploy a build to currently selected device_
- **info**
    - _Show info contained in inventory file (selected or not)_
- **help**
    - _Show Project Documentation_

## Example
<p>

* bpi s3                                

>  ls into s3://


* bpi s3 <{s3 path}> -pull -extract     

>  pull and extract given file


* bpi device                            

>  display existing devices in inventory


</p>

