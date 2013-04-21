import os
instance_dir = '/usr/local/ckan.lo'
config_file = '/usr/local/ckan.lo/pyenv/src/ckan/development.ini'
pyenv_bin_dir = os.path.join(instance_dir, 'pyenv', 'bin')
activate_this = os.path.join(pyenv_bin_dir, 'activate_this.py')
execfile(activate_this, dict(__file__=activate_this))
from paste.deploy import loadapp
config_filepath = os.path.join(instance_dir, config_file)
from paste.script.util.logging_config import fileConfig
fileConfig(config_filepath)
application = loadapp('config:%s' % config_filepath)