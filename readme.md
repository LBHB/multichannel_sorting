
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
c.TemplateGUI.plugins = c.TemplateGUI.plugins = ['AmplitudeHistogram','ChannelExportUpdate','ISIView','PlotClusterLocations','SpikeSNR','TraceViewUpdate','ExportMeanWaveforms','MergeRuns','ExportSNRs','NextSpikePairUpdate','FeatureTemplateTimeView']
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

1. The interface with Kilosort is stored in baphy: baphy/Utilities/KiloSort/
	* run ```baphy_set_path``` to add these to your path

2. Create a job using ```UTkilosort_create_job``` or ```UTkilosort_create_job_tetrode```

	* Unless the section at the end of ```UTkilosort_create_job.m``` is turned off, jobs will be automatically   added to the hyrax job queue and ran one at a 	time, using the GPU on hyena.
	* Use ```UTkilosort_run_job``` to run a job locally on your machine, set job.GPU to 0 unless you have a GPU.
	* Currently results are saved both without modification (in job.results_path)
    and after Kilosort's automerge (which needs improvement) (in [job.results_path,'_after_automerge'] )

3. Use the Kilosort browser to review jobs in phy:
      * To start it, in MATLAB, run: 
        ```Kilosort_browser```
        
     * Browse jobs by typing the first few letters of the job name in the "Name" field and pressing \<Enter>. For example type "TAR" to find all Tartufo jobs or "TAR009" to find Tartufo jobs from sesion 9.
        
	* To view a job, select it and press "View in Phy." 
		* If "Use automerged" is checked, phy will load the automerged version. Information from phy will be displayed in the MATLAB command window. 
          
      * If you instead right-click on "View in Phy," no information will be displayed and control will be returned to MATLAB. Use this method if you want to compare two spike sorting jobs side-by-side.
        
    * Review and make any adjustments necessary.
       * A guide to phy is [here](http://phy-contrib.readthedocs.io/en/latest/template-gui)
       * Press ctrl+s at any time to save
    
     *  Write the results into baphy format by pressing "Save to database"
           * If "Save to temp" is checked, results will be saved to the temporary folder, otherwise, they will be saved to the server and put into the database.
            * If "Force compute quality" is checked, isolation metrics will always be computed. By default they are not computed when saving to temp.
            * If "Delete existing file" is checked, any existing spike sorting results will be overwritten. Otherwise, the new results will be appended.
        
  3a. To run phy from the terminal instead of using the Kilosort browser, cd to one of the results directories and run:
  ```bash
    source activate phy
    phy template-gui params.py
    ```
  
4. View results using baphy_remote.m or other tools.

    * Checking "temp" in baphy_remote allows you to look at the results saved in the temporary file.
    
## Good things to know:

1. Spike templates are created by KiloSort. Templates shown in phy (pressing 'w' alternates between showing template and selected waveforms and sowing tempates only) are scaled by the mean fit (by Kilosort) amplitude of the selected waveforms. If you split a cluster the templates shown for the two may be scaled differently, but are still just one underlying template.

2. You can merge two Kilosort jobs by using the [merging plugin](Merging_Runs.md)
