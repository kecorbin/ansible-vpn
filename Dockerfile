FROM ubuntu
# Place stuff that doesn't change much up here
RUN apt-get update && apt-get install -y git python python-virtualenv python-pip
ADD ./requirements.txt /ansible/

RUN pip install -r /ansible/requirements.txt

# Add our latest code..
ADD . /ansible

# the files in the main project will be available to you here
# can be overwritten at runtime..
WORKDIR /ansible

# Install any roles via ansible galaxy
RUN ansible-galaxy install -r roles/requirements.yml

# Run our playbook
CMD ansible-playbook -i inventory.yml site.yml
