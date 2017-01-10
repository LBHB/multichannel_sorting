
## To Install:

cd to folder where you want to store the multichannel code.
The path to this folder is referred to as &lt;multichannel_sorting_path&gt; throughout these instructions

Get all the code:
```bash
git clone https://github.com/LBHB/multichannel_sorting.git
cd multichannel_sorting
git submodule init
git submodule update
pip install pyaml  # SVD: may be necessary
```
Set up the python environment for phy, make sure you're still in the multichannel_sorting folder, then run:
```bash
conda env create -n phy
source activate phy
pip install -e ./phy
pip install -e ./phy-contrib
```
To add the LBHB phy-config plugins to phy, add the following lines to ~/.phy/phy_config.py
```bash
c.Plugins.dirs = [r'/home/luke/.phy/plugins/','<multichannel_sorting_path>/phy-contrib/phycontrib/LBHB_plugins/']
c.TemplateGUI.plugins = c.TemplateGUI.plugins = ['AmplitudeHistogram','ChannelExportUpdate','ISIView','PlotClusterLocations','SpikeSNR','TraceViewUpdate','ExportMeanWaveforms','MergeRuns','ExportSNRs','FeatureTemplateTimeView']
```
Add or remove plgins by modifying c.TemplateGUI.plugins

Add the path to the multichannel code to BaphyConfigPath.m
In MATLAB:
```bash
baphy_set_path
edit BaphyConfigPath
```
Add the line:
```bash
MULTICHANNEL_SORTING_PATH=<multichannel_sorting_path>;
```
replacing <multichannel_sorting_path> with the location you stored the mulitchannel code, including a trailing slash.

## To update:

```bash
cd multichannel_sorting
git pull
git submodule update    #maybe necessary? unless we have appropriate hooks added to the pull command
```

## To Use:

1. The interface with kilosort is stored in baphy: baphy/Utilities/KiloSort/
    run baphy_set_path to add these to your path

2. Create a job using UTkilosort_create_job.m 

3. Run all jobs using UTkilosort_run_jobs.m or run one job using UTkilosort_run_job.m

4. One job has finished, view results using phy.

    Currently results are save both without modification (in job.results_path)
    and after Kilosort's automerge (which needs improvement) (in [job.results_path,'_after_automerge'] )
    
    To run phy, cd to one of the results directories and run:
    ```bash
    source activate phy
    phy template-gui params.py
    ```
    A guide to phy is [here](http://phy-contrib.readthedocs.io/en/latest/template-gui)
    Press ctrl+s at any time to save

5. Write results into baphy format using UTkilosort_load_completed_job.m

    Jobs can either be loaded into a temporary file, or onto the server (and celldB)
    
6. View results using baphy_remote.m or other tools.

    Checking temp in baphy_remote allows you to look at the results saved in the temporary file.
    
## Good things to know:

1. Spike templates are created by KiloSort. Templates shown in phy (pressing 'w' alternates between showing template and selected waveforms and sowing tempates only) are scaled by the mean fit (by Kilosort) amplitude of the selected waveforms. If you split a cluster the templates shown for the two may be scaled differently, but are still just one underlying template.

2. You can merge two Kilosort runs by using the [merging plugin](Merging_Runs.md)
