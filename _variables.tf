variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to which the Virtual Private Gateway will be attached"
}

variable "vpn_gateway_amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the VPN gateway. If you don't specify an ASN, the Virtual Private Gateway is created with the default ASN"
  default     = 64512
}

variable "customer_gateway_bgp_asn" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)"
  default     = 65000
}

variable "customer_gateway_ip_address" {
  type        = string
  description = "The IP address of the gateway's Internet-routable external interface"
}

variable "route_table_ids" {
  type        = list(string)
  description = "The IDs of the route tables for which routes from the Virtual Private Gateway will be propagated"
  default     = []
}

variable "vpn_connection_static_routes_only" {
  type        = bool
  description = "If set to `true`, the VPN connection will use static routes exclusively. Static routes must be used for devices that don't support BGP"
  default     = true
}

variable "vpn_connection_static_routes_destinations" {
  type        = list(string)
  description = "List of CIDR blocks to be used as destination for static routes. Routes to destinations will be propagated to the route tables defined in `route_table_ids`"
  default     = []
}

variable "vpn_connection_local_ipv4_network_cidr" {
  type        = string
  description = "The IPv4 CIDR on the customer gateway (on-premises) side of the VPN connection."
  default     = "0.0.0.0/0"
}

variable "vpn_connection_remote_ipv4_network_cidr" {
  type        = string
  description = "The IPv4 CIDR on the AWS side of the VPN connection."
  default     = "0.0.0.0/0"
}

variable "vpn_connection_tunnel1_dpd_timeout_action" {
  type        = string
  description = "The action to take after DPD timeout occurs for the first VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear | none | restart."
  default     = "clear"
}

variable "vpn_connection_tunnel1_ike_versions" {
  type        = list(string)
  description = "The IKE versions that are permitted for the first VPN tunnel. Valid values are ikev1 | ikev2."
  default     = []
}

variable "vpn_connection_tunnel1_inside_cidr" {
  type        = string
  description = "The CIDR block of the inside IP addresses for the first VPN tunnel"
  default     = null
}

variable "vpn_connection_tunnel1_phase1_encryption_algorithms" {
  type        = list(string)
  description = "List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16."
  default     = []
}

variable "vpn_connection_tunnel1_phase2_encryption_algorithms" {
  type        = list(string)
  description = "List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16."
  default     = []
}

variable "vpn_connection_tunnel1_phase1_integrity_algorithms" {
  type        = list(string)
  description = "One or more integrity algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 | SHA2-256 | SHA2-384 | SHA2-512."
  default     = []
}

variable "vpn_connection_tunnel1_phase2_integrity_algorithms" {
  type        = list(string)
  description = "One or more integrity algorithms that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are SHA1 | SHA2-256 | SHA2-384 | SHA2-512."
  default     = []
}

variable "vpn_connection_tunnel1_phase1_dh_group_numbers" {
  type        = list(string)
  description = "List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are 2 | 5 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24."
  default     = []
}

variable "vpn_connection_tunnel1_phase2_dh_group_numbers" {
  type        = list(string)
  description = "List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are 2 | 5 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24."
  default     = []
}

variable "vpn_connection_tunnel1_phase1_lifetime_seconds" {
  type        = number
  description = "The lifetime in seconds for phase 1 of the IKE negotiations for the first VPN tunnel. You can specify a number between 900 and 28800."
  default     = 28800
}

variable "vpn_connection_tunnel1_phase2_lifetime_seconds" {
  type        = number
  description = "The lifetime in seconds for phase 2 of the IKE negotiations for the first VPN tunnel. You can specify a number between 900 and 3600. The number that you specify must be less than the number of seconds for the phase 1 lifetime."
  default     = 3600
}

variable "vpn_connection_tunnel1_preshared_key" {
  type        = string
  description = "The preshared key of the first VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero. Allowed characters are alphanumeric characters, periods(.) and underscores(_)"
  default     = null
}

variable "vpn_connection_tunnel1_startup_action" {
  type        = string
  description = "The action to take when the establishing the tunnel for the first VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are add | start."
  default     = "add"
}

variable "vpn_connection_tunnel1_log_enabled" {
  type        = bool
  description = "Enable or disable VPN tunnel logging feature. The default is false."
  default     = false
}

variable "vpn_connection_tunnel1_log_output_format" {
  type        = string
  description = "Set log format. Possible values are: json and text. The default is json."
  default     = "json"
}

variable "vpn_connection_tunnel2_dpd_timeout_action" {
  type        = string
  description = "The action to take after DPD timeout occurs for the second VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear | none | restart."
  default     = "clear"
}

variable "vpn_connection_tunnel2_ike_versions" {
  type        = list(string)
  description = "The IKE versions that are permitted for the second VPN tunnel. Valid values are ikev1 | ikev2."
  default     = []
}

variable "vpn_connection_tunnel2_inside_cidr" {
  type        = string
  description = "The CIDR block of the inside IP addresses for the second VPN tunnel"
  default     = null
}

variable "vpn_connection_tunnel2_phase1_encryption_algorithms" {
  type        = list(string)
  description = "List of one or more encryption algorithms that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16."
  default     = []
}

variable "vpn_connection_tunnel2_phase2_encryption_algorithms" {
  type        = list(string)
  description = "List of one or more encryption algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16."
  default     = []
}

variable "vpn_connection_tunnel2_phase1_integrity_algorithms" {
  type        = list(string)
  description = "One or more integrity algorithms that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 | SHA2-256 | SHA2-384 | SHA2-512."
  default     = []
}

variable "vpn_connection_tunnel2_phase2_integrity_algorithms" {
  type        = list(string)
  description = "One or more integrity algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are SHA1 | SHA2-256 | SHA2-384 | SHA2-512."
  default     = []
}

variable "vpn_connection_tunnel2_phase1_dh_group_numbers" {
  type        = list(string)
  description = "List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are 2 | 5 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24."
  default     = []
}

variable "vpn_connection_tunnel2_phase2_dh_group_numbers" {
  type        = list(string)
  description = "List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are 2 | 5 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24."
  default     = []
}

variable "vpn_connection_tunnel2_phase1_lifetime_seconds" {
  type        = number
  description = "The lifetime in seconds for phase 1 of the IKE negotiations for the second VPN tunnel. You can specify a number between 900 and 28800."
  default     = 28800
}

variable "vpn_connection_tunnel2_phase2_lifetime_seconds" {
  type        = number
  description = "The lifetime in seconds for phase 2 of the IKE negotiations for the second VPN tunnel. You can specify a number between 900 and 3600. The number that you specify must be less than the number of seconds for the phase 1 lifetime."
  default     = 3600
}

variable "vpn_connection_tunnel2_preshared_key" {
  type        = string
  description = "The preshared key of the second VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero. Allowed characters are alphanumeric characters, periods(.) and underscores(_)"
  default     = null
}

variable "vpn_connection_tunnel2_startup_action" {
  type        = string
  description = "The action to take when the establishing the tunnel for the second VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are add | start."
  default     = "add"
}

variable "vpn_connection_tunnel2_log_enabled" {
  type        = bool
  description = "Enable or disable VPN tunnel logging feature. The default is false."
  default     = false
}

variable "vpn_connection_tunnel2_log_output_format" {
  type        = string
  description = "Set log format. Possible values are: json and text. The default is json."
  default     = "json"
}

variable "vpn_tunnel_log_group_name" {
  type        = string
  description = "The name of the CloudWatch log group to send VPN tunnel logs to. The default is \"/aws/vpc/site-to-site-vpn\"."
  default     = "/aws/vpc/site-to-site-vpn"
}

variable "vpn_tunnel_logs_retention" {
  type        = number
  default     = 365
  description = "Retention in days for VPN tunnel logs CloudWatch Log Group. The default is 365."
}

variable "vpn_tunnel_logs_kms_key_arn" {
  type        = string
  default     = null
  description = "The ARN of the KMS Key to use when encrypting VPN tunnel log data."
}

variable "ipsec_type" {
  type        = string
  description = "Define Ipsec Type"
  default     = "ipsec.1"
}


variable "transit_gateway_id" {
  type        = string
  description = "Define Transit gateway id in case private gateway is not defined. To use when sharing the VPN connection with multiple accounts via Transit Gateway"
  default     = null
}

variable "transit_gateway_default_route_table_id" {
  type        = string
  description = "Define Transit gateway default route table id. Required when vpn_connection_static_routes_destinations is used"
  default     = null
}

variable "name" {
  type        = string
  description = <<-EOT
    ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.
    This is the only ID element not also included as a `tag`.
    The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input.
    EOT
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Extra tags to attach to resources"
}

variable "create_vpn_gateway" {
  type        = bool
  description = "Create VPN Gateway"
  default     = true
}
