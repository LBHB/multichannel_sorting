## How to correct for drift:
1. Use UTkilosort_create_job to create and run a job as normal. 
2. Find a file that needs correction
3. Run UTkilosort_create_filtered_binary
    * -OR- if you knew it needed drift correction in the first place, set job.save_filtered_binary=true; when creating the job
4. Run UTkilosort_drift_wrapper to create drift correction files
5. Use UTkilosort_crease_job to create a job that uses drift correction. 
    * set job.driftCorrectionFile to point to the drift correction file you want to use.
 