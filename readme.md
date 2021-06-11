## To set-up using the copy in /auto/users/lbhb/:

<b>If you don't have a copy of baphy already:</b>
1. Checkout a copy of [baphy](https://bitbucket.org/lbhb/baphy/)
2. Start MATLAB, make sure baphy is in your path, and run:
```bash
baphy_set_path
```
3. Choose lbhb as the lab

<b>If you already have a copy of baphy:</b>
1. Pull the latest version  

<b>Whether or not you already have baphy:</b>
1. Add the path to the multichannel code to BaphyConfigPath.m:  
In MATLAB:  
	```bash
	baphy_set_path
	edit BaphyConfigPath
	```
	Add or modify the line the line:  
	```bash
	MULTICHANNEL_SORTING_PATH='/auto/users/lbhb/Code/multichannel_sorting/';
	```
2. Make/update your copy of phy_config.py to use lbhb plugins:  
This will overwrite your phy_config.py file. Maybe make a backup.  
In bash:
	```bash
	mkdir ~/.phy
	sudo cp /auto/users/lbhb/Code/multichannel_sorting/phy_config.py ~/.phy/phy_config.py
	```

3. Create a smylink to the lbhb phy enironment:  
In bash:
	```bash
	sudo ln -s /auto/users/lbhb/Code/miniconda3/envs/phy2/bin/phy /usr/local/bin/phy_lbhb
	```

## To use the copy in /auto/users/lbhb/:
1. Start a new job by filling in options and running UTkilosort2_create_job_wrapper (replace with what you need):  
	In MATLAB:  
	`options.animal='Tabor';`  
	`opions.site='TBR009a';`  
	`options.run_nums=1:2;` or `options.run_nums='all';`  
	`options.channel_map='64D_slot2_bottom';`  
	By default KiloSort 2 is used. To use 2.5 or 3, add  
	`options.KSversion=2.5` or `options.KSversion=3`  
	To start the job, run:  
	`UTkilosort2_create_job_wrapper(options)`  

2. Use the Kilosort browser to review jobs in phy:
      * To start it, in MATLAB, run: 
        ```Kilosort_browser```
        
     * Browse jobs by typing the first few letters of the job name in the "Name" field and pressing \<Enter>. For example type "TAR" to find all Tartufo jobs or "TAR009" to find Tartufo jobs from sesion 9.
        
	* To view a job, select it and press "View in Phy." 
        * If you instead right-click on "View in Phy," no information will be displayed and control will be returned to MATLAB. Use this method if you want to compare two spike sorting jobs side-by-side.
        * Sometimes it's easier to run phy directoy from bash. The code to run it will show on the MATLAB command window when you click on a job.
     * Review and make any adjustments necessary.
        * A guide to phy is [here](https://phy.readthedocs.io/en/latest/). In particular, the [typical approach to manual clustering](http://phy-contrib.readthedocs.io/en/latest/template-gui/#a-typical-approach-to-manual-clustering) is useful. I would add a step 2a: use the amplitude histogram to check that there aren't too many missing spikes (typically less than 2%).
        * LBHB additions to phy:
           * Channel Zoom update:
              * Type ` :cz ` to zoom in on the best channel of the current cluster
              * To zoom in other ways, `:cz <channel_number> <span>` zooms to <span} channels around <channel_number>
           * Spike SNR: the standard deviation of the mean spike waveform divided by the standard deviation of waveforms over times when spikes are not occuring. Use this to quicky find good and bad clusters.
           * NextSpikePairUpdate: skips the TraceView to window around pairs of spikes ordered by interspike interval. Shortcut is Alt-Cntrl-PgDown and Alt-Cntrl-PgUp. If only one cluster is selected this will skip to the closest pair of spikes within that cluster. If two clusters are selected this will skip to the closest pair of spikes across the clusters.
           * FeatureTemplatetime: The phy version can show template projections over time. Show in colors are the currently selected spikes. Grey are spikes from clusters that have high similarity to the first selected cluster. The console tells you which are being shown. Orange lines indicate divisions in time between different runs. Hold down Shift and left-click at a time to skip the TraceView to be centered on that time. Press A to cycle through the different projections:
           		*  template_feature: Projections onto the first selected cluster's template.
           		*  template: Projections of each cluster onto it's own template (not super useful)
           		*  feature: Projections onto the 1st PC of the best channel (change which channel by holding Cntrl and lick-clinging on differnt channels in the WaveformView
           * ExportMeanWaveforms: Saves mean_waveforms.npy when you save in phy. There are stored in the spk.mat file by UT_load_completed_job, and can be used to cluster based on spike type
           * ExportBestChannels: Saves best_channels.npw when you save in phy. Used to tell baphy what channel each unit is on.
           * custom_columns: changes which columns are shown in the ClusterView panel of phy
           * n_spikes_per_view: Changes how many spikes are shown for various views. 
        * Phy features that are good to know:
           * Hold down the right mouse button and move around to zoom and change the aspect ratio.
        * Press ctrl+s at any time to save
    
     *  Write the results into baphy format by pressing "Save to database"
	     *  If "Save to temp" is checked, results will be saved to the temporary folder, otherwise, they will be saved to the server and put into the database.
	     *  If "Force compute quality" is checked, isolation metrics will always be computed. By default they are not computed when saving to temp.
	     *  If "Delete existing file" is checked, any existing spike sorting results will be overwritten. Otherwise, the new results will be appended.
        
  
4. View results using `baphy_remote` or other tools.

    * Checking "temp" in `baphy_remote` allows you to look at the results saved in the temporary file.



## OLD Install Instructions:

In a terminal, navigate to a folder where you want to store the multichannel code.
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
If you want the CellTypes plugin (FS/RS classification) to work, you must make sure that sklearn is installed inside of your phy environment. To do this, while still in the phy environment, run:
```bash
pip install sklearn
```

To add the LBHB phy-config plugins to phy, add the following lines to ~/.phy/phy_config.py
Replace \<username> with your user name. 
Replace <multichannel_sorting_path> with the path where you stored the multichannel code.

```bash
c.Plugins.dirs = [r'/home/<username>/.phy/plugins/','<multichannel_sorting_path>/phy-contrib/phycontrib/LBHB_plugins/']
c.TemplateGUI.plugins = ['AmplitudeHistogram','ChannelExportUpdate','ISIView','PlotClusterLocations','SpikeSNR','ExportMeanWaveforms','MergeRuns','ExportSNRs','NextSpikePairUpdate','FeatureTemplateTime', 'CellTypes','CopyTraceView']
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

If you haven't done this already for some other reason, set up you computer to be able to run jobs on the cluster. Brief instructions [here](http://hyrax.ohsu.edu/treeki/tree.php?pid=118) under **Configuring linux for batching**. More detailed instruction should be added here...

## To update:

```bash
cd multichannel_sorting
git pull
git submodule update --init   #maybe necessary? unless we have appropriate hooks added to the pull command
#(--init *may* take care of pulling any submodule added since the last pull)
```

## To Use:

1. The interface with Kilosort is stored in baphy: baphy/Utilities/KiloSort/
	* run ```baphy_set_path``` to add it to your path

2. Create a job using ```UTkilosort_create_job``` or ```UTkilosort_create_job_tetrode```. Right now there is no   GUI, so you will have to ```edit UTkilosort_create_job``` and change the animal name, the site, and the run_nums variables to the desired ones. 

	* Unless the section at the end of ```UTkilosort_create_job.m``` is turned off, jobs will be automatically   added to the hyrax job queue and ran one at a 	time, using the GPU on hyena.
	* Check [CelldB Jobs](http://hyrax.ohsu.edu/celldb/queuemonitor.php?user=%25&complete=-1&machinename=%25&notemask=kilo) to make sure the kilosort job started correctly. 
	* If you don't see the job, check to see what's running on [Hyena](http://hyrax.ohsu.edu/celldb/queuemonitor.php?user=%25&complete=-1&machinename=hyena&notemask=) and kill a job that has been running for a short about of time.
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
       * A guide to phy is [here](http://phy-contrib.readthedocs.io/en/latest/template-gui). In particular, the [typical approach to manual clustering](http://phy-contrib.readthedocs.io/en/latest/template-gui/#a-typical-approach-to-manual-clustering) is useful. I would add a step 2a: use the amplitude histogram to check that there aren't too many missing spikes (typically less than 2%).
       * LBHB additions to phy:
           * ISI histogram as an alternative to the correlation histograms.
           * Spike SNR: the standard deviation of the mean spike waveform divided by the standard deviation of waveforms over times when spikes are not occuring. Use this to quicky find good and bad clusters.
           * NextSpikePairUpdate: skips the TraceView to window around pairs of spikes ordered by interspike interval. Shortcut is Alt-Shift-PgDown and Alt-Shift-PgUp. If only one cluster is selected this will skip to the closest pair of spikes within that cluster. If two clusters are selected this will skip to the closest pair of spikes across the clusters.
           * FeatureTemplatetime: shows a projection of the spikes onto first template dimension of the first selected cluster (blue) vs time. Lines indicate divisions in time between different runs. Hold down Cntrl and left-click at a time to skip the TraceView to be centered on that time.
           * [Merge runs plugin](Merging_Runs.md)
       * Undocumented phy features that are good to know:
           * Hold down the right mouse button and move around to zoom and change the aspect ratio.
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
  
4. View results using `baphy_remote` or other tools.

    * Checking "temp" in `baphy_remote` allows you to look at the results saved in the temporary file.
    
## Good things to know:

1. Spike templates are created by KiloSort. Templates shown in phy (pressing 'w' alternates between showing template and selected waveforms and sowing tempates only) are scaled by the mean fit (by Kilosort) amplitude of the selected waveforms. If you split a cluster the templates shown for the two may be scaled differently, but are still just one underlying template.

2. You can merge two Kilosort jobs by using the [merging plugin](Merging_Runs.md)

3. cluster_group.tsv is the name of the file that gets saved to identify which clusters are good. This file used to be called cluster_groups.tsv and cluster_group.csv. When loading old files rename to cluster_group.tsv to make them work.

4. cluster_names.ts is the name of the file that gets generated by the merge tool. Old data might have cluster_names.tsv or cluster_names.csv. Rename.

