
# get master addr from nic (eib or hib)
for nic in eth0 eib0 hib0 enp94s0f0; do
  master_addr=$(ifconfig $nic 2>/dev/null | grep netmask | awk '{print $2}'| cut -f2 -d:)
  if [ "$master_addr" ]; then
    break
  fi
done

# make sure to source the matched version.
source /home/ec2-user/anaconda3/envs/transformer/lib/python3.7/site-packages/torch_ccl-1.3.0+43f48a1-py3.7-linux-x86_64.egg/torch_ccl/env/setvars.sh

export LD_LIBRARY_PATH=/home/ec2-user/anaconda3/envs/transformer/lib/python3.7/site-packages/torch_ccl-1.3.0+43f48a1-py3.7-linux-x86_64.egg/:$LD_LIBRARY_PATH

export KMP_BLOCKTIME=1
export KMP_AFFINITY="granularity=fine,compact,1,0"
export LD_PRELOAD="${CONDA_PREFIX}/lib/libtcmalloc.so:${CONDA_PREFIX}/lib/libiomp5.so"
export CCL_WORKER_COUNT=4
export CCL_WORKER_AFFINITY="0,1,2,3,20,21,22,23"
#export CCL_BCAST_PART_COUNT=32
export CCL_ATL_TRANSPORT=ofi
#export CCL_ATL_SHM=0
#export FI_PROVIDER=psm2
export ATL_PROGRESS_MODE=0 # only 16 ranks need this option
export MASTER_ADDR=$master_addr

