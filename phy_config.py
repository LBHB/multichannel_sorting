# This will load all the plugins in /auto/users/lbhb/Code/multichannel_sorting/phy-plugins/
# If you want to try out your own plugins, add them to ~/.phy/plugins/ and add them to user_plugins below (line 22)
# You can also add the code for plugins directly at the bottom

from phy import IPlugin
from phy import __version__
import os

isV2 = float(__version__[:3])>=2
if not isV2:
    try:
        import phycontrib
    except:
        pass

c = get_config()
if isV2:
    lbhb_plugin_dir = '/auto/users/lbhb/Code/multichannel_sorting/phy-plugins/'
    lbhb_plugins = files = os.listdir(lbhb_plugin_dir)
    lbhb_plugins = [file[:-3] for file in lbhb_plugins if file.count('.py')==1]
    c.Plugins.dirs = [r'~/.phy/plugins/', lbhb_plugin_dir]
    user_plugins = [] # Put the names to any new plugins you want to try out here
    c.TemplateGUI.plugins = lbhb_plugins + user_plugins
else:
    raise RuntimeError("Fix this if we want to go back to phy1")

# Plugin example:
#
# class MyPlugin(IPlugin):
#     def attach_to_cli(self, cli):
#         # you can create phy subcommands here with click
#         pass
