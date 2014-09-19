# ELB Commands

Usage=$Usage$(cat <<EOF


  Elastic Load Balancer (ELB) Commands:

      amowrap elb list all

    List Members
      amowrap elb list <elb_name> members

    Remove ELB Members
      amowrap elb <elb_name> remove <instance_id>

    Add ELB Members
      amowrap elb <elb_name> add <instance_id>
EOF
)

# List ALL ELB's in current AZ
[[ "$1" == +(elb|lb) && "$2" == +(list|show) && "$3" == +(all|any) ]] \
    && aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].{Name :LoadBalancerName}" --output table \
    && exit 0

# Show ELB members
[[ "$1" == +(elb|lb) && "$2" == +(list|show) && "$4" == +(members) ]] \
  && aws elb describe-load-balancers --load-balancer-names $3 --query 'LoadBalancerDescriptions[*]'.Instances[*] --output table \
  && exit 0

# Remove ELB Member
# $MyNameIs elb <elb_name> remove <instance_id>
[[ "$1" == +(elb|load_balancer) && "$2" == +(remove|rm) ]] \
  && aws elb deregister-instances-from-load-balancer --load-balancer-name "$3" \
                                    --instances "$4" \
  && exit 0.

# Add Instace to ELB Pool
[[ "$1" == +(elb|lb|load_balancer) && "$2" == +(add) ]] \
  && aws elb register-instances-with-load-balancer --load-balancer-name "$3" \
                                    --instances "$4" \
  && exit 0
