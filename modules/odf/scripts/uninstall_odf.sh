#!/bin/sh

ibmcloud config --check-version=false
ibmcloud login -apikey ${IC_API_KEY}
ibmcloud ks cluster config -c ${CLUSTER} --admin

# Delete OCS/ODF operator

# 1.Check the current version of the subscribed Operator
CURRENT_CSV=`kubectl get subscription ocs-subscription -n openshift-storage -o jsonpath='{.status.currentCSV}{"\n"}'`
# 2.Delete the Operator’s Subscription
kubectl delete subscription ocs-subscription -n openshift-storage
# 3.Delete the CSV for the Operator in the target namespace using the currentCSV value from the previous step
kubectl delete clusterserviceversion ${CURRENT_CSV} -n openshift-storage
# Disable OCS/ODF addon
ibmcloud ks cluster addon disable openshift-data-foundation -c ${CLUSTER} -f

#!/bin/bash
ocscluster_name=`oc get ocscluster | awk 'NR==2 {print $1}'`
oc delete ocscluster --all --wait=false
kubectl patch ocscluster/$ocscluster_name -p '{"metadata":{"finalizers":[]}}' --type=merge
oc delete ns openshift-storage --wait=false
sleep 20
kubectl -n openshift-storage patch persistentvolumeclaim/db-noobaa-db-0 -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl -n openshift-storage patch cephblockpool.ceph.rook.io/ocs-storagecluster-cephblockpool -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl -n openshift-storage patch cephcluster.ceph.rook.io/ocs-storagecluster-cephcluster -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl -n openshift-storage patch cephfilesystem.ceph.rook.io/ocs-storagecluster-cephfilesystem -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl -n openshift-storage patch cephobjectstore.ceph.rook.io/ocs-storagecluster-cephobjectstore -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl -n openshift-storage patch cephobjectstoreuser.ceph.rook.io/noobaa-ceph-objectstore-user -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl -n openshift-storage patch cephobjectstoreuser.ceph.rook.io/ocs-storagecluster-cephobjectstoreuser -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl -n openshift-storage patch noobaa/noobaa -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl -n openshift-storage patch backingstores.noobaa.io/noobaa-default-backing-store -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl -n openshift-storage patch bucketclasses.noobaa.io/noobaa-default-bucket-class -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl -n openshift-storage patch storagecluster.ocs.openshift.io/ocs-storagecluster -p '{"metadata":{"finalizers":[]}}' --type=merge
sleep 20
oc delete pods -n openshift-storage --all --force --grace-period=0
sleep 20