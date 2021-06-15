if [ $# -eq 0 ]; then
      
    cluster_result="$(kubectl get nodes)"

    if echo "$cluster_result" | grep -q "dev-pool"; then
        LD="dev"
        echo "dev";
    else
      if echo "$cluster_result" | grep -q "live-pool"; then
        LD="live"
        echo "live";
      fi
    fi

else
    echo $1
fi
