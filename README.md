# DAC TP

This TP is to practice Discretional Access Control.

You will have to set the owners and groups on a filesystem tree and apply the desired permissions.

## Initialization

1. Clone the repository

```shell
git clone https://github.com/Chnafon/dac_tp.git
cd dac_tp
```

2. Run the setup script

```shell
bash dac_tp_setup.sh
```

It will create the full filesystem tree and a bunch of users and groups.

### Filesystem tree

The generated filesystem tree is located under /tmp/dac_tp.

Five main directories are created :
* **bin** : Common binaries found on any Linux machine
* **etc** : Common files found on any Linux machine
* **home** : Home directories for the created users
* **opt** : Services directory
    * **web_service** : Web service tree
* **share** : Shared directories

Every files and directories, except for the `home/*` dirs are owned by your user and have the maximum permissions :
* **666** for files
* **777** for directories

Here is the full tree :

```shell
/tmp/dac_tp/
├── bin
│   ├── cat
│   ├── chage
│   ├── crontab
│   ├── find
│   ├── ls
│   ├── mount
│   ├── passwd
│   ├── python3
│   ├── su
│   ├── sudo
│   ├── systemctl
│   ├── tail
│   ├── top
│   └── umount
├── etc
│   ├── bash.bashrc
│   ├── fstab
│   ├── group
│   ├── gshadow
│   ├── host.conf
│   ├── hostname
│   ├── hosts
│   ├── login.defs
│   ├── passwd
│   ├── profile
│   └── shadow
├── home
│   ├── admin1
│   ├── admin2
│   ├── dev1
│   ├── dev2
│   ├── dev3
│   ├── dev4
│   ├── dev5
│   ├── dev6
│   ├── supp1
│   └── supp2
├── opt
│   └── web_service
│       ├── bin
│       │   └── app.py
│       ├── config
│       │   ├── gunicorn.conf
│       │   └── web_service.yml
│       ├── data
│       │   └── database.db
│       └── log
│           ├── web_service_1.gz
│           ├── web_service_2.gz
│           └── web_service.log
└── share
```

### Users and groups

4 kinds of users are created :
* Administrators (members of the **admins** group)
* Developers (members of the **devs** group)
* Support users (members of the **support_team** group)
* A **web_service** user dedicated to the web service

## Work to do

### 1. Main directories

Update the main directories owner, group and permission based on these requirements :
* Owned by root:root
* Full access for the root user
* Read and access for the root group
* Read and access for any user

### 2. Share directories

Create share directories under `/tmp/dac_tp/share` for all groups :
* **admins**
* **devs**
* **support_team**

They will be used to share ressources between members of each team.

You must respect these requirements :
* A share directory must be accessible only by its members
* No specific user must own the share
* The members of each group must be able to (in their share only):
    * Create a file
    * Read any file
    * Access to any subdirectory
* Within a share, the members can only modify their own files and directories

### 3. Common files

Set the owner, group and permissions of every files within `/tmp/dac_tp/etc` as it should be.

### 4. Common binaries

Set the owner, group and permissions of every files within `/tmp/dac_tp/bin` as it should be to work as expected.

### 5. web_service

The web_service is a Python web server run using Gunicorn.

You will find 4 directories :
* **bin** : Contains the web server Python code
* **config** : Configuration files
* **data** : Data stored by the web service into a database
* **log** : Log files

Here is the filesystem tree :

```shell
/tmp/dac_tp/opt/web_service/
├── bin
│   └── app.py
├── config
│   ├── gunicorn.conf
│   └── web_service.yml
├── data
│   └── database.db
└── log
    ├── web_service_1.gz
    ├── web_service_2.gz
    └── web_service.log
```

Set the owner, group and permissions of every files and directories within `/tmp/dac_tp/opt` based on these requirements :
* The whole `web_service` tree must be own by the **web_service** user
* The application must be run by the **web_service** user only
* The **web_service** user must have every access required for the web server to work as expected
* The administrators must be able to :
    * Read the web server Python code
    * Read and write the configuration files
    * Read and write the database
    * Read and compress the log files
* The developers must be able to :
    * Read the web server Python code
    * Read the configuration files
    * Read the log files
* The support users must be able to :
    * Read the log files

REMEMBER TO APPLY THE LEAST PRIVILEGE PRINCIPLE !

You may need to create new groups, feel free to do so but you have to explain your decision.

#### Report

Write a report about :
* The groups you created and explain :
    * The name you have chosen
    * The members you have put in
* The property you have set on files and directory

You can make a Word document or a simple text file.

## Delivery

Run the following command :
```shell
ls -lR /tmp/dac_tp/ >> $HOME/dac_tp_delivery.txt
```

It will create a `dac_tp_delivery.txt` in your home directory.

Copy/paste this file and the report you made for Part 5 on an USB stick and deliver it. 

## Clean up

Run the cleanup script

```shell
bash dac_tp_cleanup.sh
```

The whole filesystem tree and all created users and group will be deleted.
