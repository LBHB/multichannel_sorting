## Merging two kilosort jobs using the Merge Runs plugin

##To Start:

Type:
```bash
:mr
```
to start the merging program. Select the results (or results_after_automerge) folder for the job to be merged. This will open up a "slave" phy and merging gui. The "master" phy is the first phy instance. The merging gui has a column for each master cluster and a row for each slave cluster. The master clusters are sorted by channel and unit number, with single-unit clusters shown first. Values in the table are the eculidian distance between the mean waveforms of the two clusters, normalized by the maximum distance over all possible combinations. Numbers in red text indicate the match that will be made between master and slave job. Matches are initialized by the closest master cluster for each slave cluster.

## General Procedure:
1. Review all the single-unit matches by clicking on them one at a time. Multile clusters can be selected at once for comparison.
2. If a master cluster has no slave cluster match, look to see what the closest slave cluster is, it's possbile one of the slave clusters should be split. But it's also possible that this neuron didn't fire enough during the slave job to be assigned its own cluster, or was lost.
3. Change any matches that should be changed.
4. Move all low SNR clusters to the noise channel by clicking on Merge-> Move low-snr clusters to noise. This will create a new label "noise" and assign it to all slave clusters with snr < 0.5.
5. Save by going to Merge->save cluster associations
    5a. If there are master clusters that are matched with multiple slaves, the program will ask you if you'd like to merge them. In most circumstances you should say yes. If this slave job is to be used as a master in another merge, this will make it so there is only once cluster for each channel/unit number combination. Review the merges it made and then press save again.



## To split a slave or master cluster or to merge master clusters:
IMPORTANT: Currently the merging gui does not detect changes in either phy window. So if you need to split a cluster, do the split and save, and then close the merging window and slave phy window, and re-start the merging process.

## To merge slave clusters:
Select slave clusters to be merged as well as master cluster theey should be assigned to. Press Merge-> Merge selected slaves.

## To change a match
Select the desired match and press Merge->Set master for selected slave.

## To add a new label:
Press Merge -> Add new unit label. Dialog boxed will come up allowing you to input the desired channel, unit number, and type of the new label. By default the unit number is the next available unit number for the given channel. This will create a new column, you can then assign a match to the column as usual.

