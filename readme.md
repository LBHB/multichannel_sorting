
## To Install:

cd to folder where you want to store the multichannel code

Get all the code:
```bash
git clone https://github.com/LBHB/multichannel_sorting.git
cd multichannel_sorting
git submodule init
git submodule update
(svd maybe necessary?) pip install pyaml
```
Set up the python environment for phy:
```bash
conda env create -n phy
source activate phy
pip install -e ./phy
pip install -e ./phy-contrib
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