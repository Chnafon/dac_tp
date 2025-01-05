#!/bin/bash

echo "Creating root directory for the TP : /tmp/dac_tp"
mkdir /tmp/dac_tp

echo ""
echo "Initializing root tree"
for dir in home etc opt share; do 
	echo "  - Creating directory /tmp/dac_tp/${dir}"
	mkdir "/tmp/dac_tp/${dir}"
done

echo ""
echo "Initializing etc tree"
for etc_file in bash.bashrc fstab group gshadow host.conf hostname hosts login.defs passwd profile shadow; do 
	echo "  - Creating file /tmp/dac_tp/etc/${etc_file} with 666 mode"
	touch "/tmp/dac_tp/etc/${etc_file}"
	chmod 666 "/tmp/dac_tp/etc/${etc_file}"
done

echo ""
echo "Initializing opt tree"
echo "  - Creating directory /tmp/dac_tp/opt/web_service"
mkdir "/tmp/dac_tp/opt/web_service"
for dir in config bin data log; do
	echo "  - Creating directory /tmp/dac_tp/opt/web_service/${dir} with 777 mode"
	mkdir -p "/tmp/dac_tp/opt/web_service/${dir}"
	chmod 777 "/tmp/dac_tp/opt/web_service/${dir}"
done
echo ""
for file in "config/gunicorn.conf" "config/web_service.yml" "bin/app.py" "data/database.db" "log/web_service.log" "log/web_service_1.gz" "log/web_service_2.gz"; do
	echo "  - Creating file /tmp/dac_tp/opt/web_service/${file} with 666 mode"
        touch "/tmp/dac_tp/opt/web_service/${file}"
        chmod 666 "/tmp/dac_tp/opt/web_service/${file}"
done

echo ""
echo "Creating users for the purpose of the TP"
for username in web_service admin1 admin2 dev1 dev2 dev3 dev4 dev5 dev6 supp1 supp2; do
	if [ "${username}" == "web_service" ]; then
		echo "  - Creating system user ${username} with shell /usr/sbin/nologin"
        	sudo useradd --system --shell /usr/sbin/nologin "${username}"
	else
		echo "  - Creating user ${username} with home directory in /tmp/dac_tp/home/${username}, shell /bin/bash and password ${username}_pass"
		sudo useradd --create-home --home "/tmp/dac_tp/home/${username}" --password "${username}_pass" --shell /bin/bash "${username}"
	fi
done

echo ""
echo "Creating groups for the purpose of the TP and add members"
for groupname in admins devs support_team; do
	echo "  - Creating the group ${groupname}"
	sudo groupadd "${groupname}"
done
echo ""
for admin_username in admin1 admin2; do
	echo "  - Adding user ${admin_username} to group admins"
	sudo usermod -G admins "${admin_username}"
done
echo ""
for dev_username in dev1 dev2 dev3 dev4 dev5 dev6; do
        echo "  - Adding user ${dev_username} to group devs"
        sudo usermod -G devs "${dev_username}"
done
echo ""
for support_username in supp1 supp2; do
        echo "  - Adding user ${support_username} to group support_team"
        sudo usermod -G support_team "${support_username}"
done
