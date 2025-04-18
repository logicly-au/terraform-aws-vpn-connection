data "aws_vpn_gateway" "default" {
  count           = var.create_vpn_gateway == "true" ? 1 : 0
  attached_vpc_id = var.vpc_id
}

# https://www.terraform.io/docs/providers/aws/r/vpn_gateway.html
resource "aws_vpn_gateway" "default" {
  count           = var.transit_gateway_id != null ? (var.create_vpn_gateway ? 1 : 0) : 0
  vpc_id          = var.vpc_id
  amazon_side_asn = var.vpn_gateway_amazon_side_asn
  tags = merge(
    var.tags,
    {
      "Name" = "vpg-${var.name}"
    },
  )
}

# https://www.terraform.io/docs/providers/aws/r/customer_gateway.html
resource "aws_customer_gateway" "default" {
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip_address
  type       = var.ipsec_type
  tags = merge(
    var.tags,
    {
      "Name" = "cgw-${var.name}"
    },
  )
}

# https://www.terraform.io/docs/providers/aws/r/vpn_connection.html
resource "aws_vpn_connection" "default" {
  vpn_gateway_id           = try(lenght(aws_vpn_gateway.default.*.id) > 0 ? aws_vpn_gateway.default.*.id : var.create_vpn_gateway ? data.aws_vpn_gateway.default[0].id : null, null)
  customer_gateway_id      = join("", aws_customer_gateway.default.*.id)
  transit_gateway_id       = try(var.transit_gateway_id, null)
  type                     = var.ipsec_type
  static_routes_only       = var.vpn_connection_static_routes_only
  local_ipv4_network_cidr  = var.vpn_connection_local_ipv4_network_cidr
  remote_ipv4_network_cidr = var.vpn_connection_remote_ipv4_network_cidr

  tunnel1_dpd_timeout_action = var.vpn_connection_tunnel1_dpd_timeout_action
  tunnel1_ike_versions       = var.vpn_connection_tunnel1_ike_versions
  tunnel1_inside_cidr        = var.vpn_connection_tunnel1_inside_cidr
  tunnel1_preshared_key      = var.vpn_connection_tunnel1_preshared_key
  tunnel1_startup_action     = var.vpn_connection_tunnel1_startup_action

  tunnel1_phase1_dh_group_numbers      = var.vpn_connection_tunnel1_phase1_dh_group_numbers
  tunnel1_phase2_dh_group_numbers      = var.vpn_connection_tunnel1_phase2_dh_group_numbers
  tunnel1_phase1_encryption_algorithms = var.vpn_connection_tunnel1_phase1_encryption_algorithms
  tunnel1_phase2_encryption_algorithms = var.vpn_connection_tunnel1_phase2_encryption_algorithms
  tunnel1_phase1_integrity_algorithms  = var.vpn_connection_tunnel1_phase1_integrity_algorithms
  tunnel1_phase2_integrity_algorithms  = var.vpn_connection_tunnel1_phase2_integrity_algorithms
  tunnel1_phase1_lifetime_seconds      = var.vpn_connection_tunnel1_phase1_lifetime_seconds
  tunnel1_phase2_lifetime_seconds      = var.vpn_connection_tunnel1_phase2_lifetime_seconds

  tunnel1_log_options {
    cloudwatch_log_options {
      log_enabled       = var.vpn_connection_tunnel1_log_enabled
      log_group_arn     = try(aws_cloudwatch_log_group.tunnel_logs[0].arn, "")
      log_output_format = var.vpn_connection_tunnel1_log_output_format
    }
  }

  tunnel2_dpd_timeout_action = var.vpn_connection_tunnel2_dpd_timeout_action
  tunnel2_ike_versions       = var.vpn_connection_tunnel2_ike_versions
  tunnel2_inside_cidr        = var.vpn_connection_tunnel2_inside_cidr
  tunnel2_preshared_key      = var.vpn_connection_tunnel2_preshared_key
  tunnel2_startup_action     = var.vpn_connection_tunnel2_startup_action

  tunnel2_phase1_dh_group_numbers      = var.vpn_connection_tunnel2_phase1_dh_group_numbers
  tunnel2_phase2_dh_group_numbers      = var.vpn_connection_tunnel2_phase2_dh_group_numbers
  tunnel2_phase1_encryption_algorithms = var.vpn_connection_tunnel2_phase1_encryption_algorithms
  tunnel2_phase2_encryption_algorithms = var.vpn_connection_tunnel2_phase2_encryption_algorithms
  tunnel2_phase1_integrity_algorithms  = var.vpn_connection_tunnel2_phase1_integrity_algorithms
  tunnel2_phase2_integrity_algorithms  = var.vpn_connection_tunnel2_phase2_integrity_algorithms
  tunnel2_phase1_lifetime_seconds      = var.vpn_connection_tunnel2_phase1_lifetime_seconds
  tunnel2_phase2_lifetime_seconds      = var.vpn_connection_tunnel2_phase2_lifetime_seconds

  tunnel2_log_options {
    cloudwatch_log_options {
      log_enabled       = var.vpn_connection_tunnel2_log_enabled
      log_group_arn     = try(aws_cloudwatch_log_group.tunnel_logs[0].arn, "")
      log_output_format = var.vpn_connection_tunnel2_log_output_format
    }
  }

  tags = merge(
    var.tags,
    {
      "Name" = "tg-${var.name}"
    },
  )
}

# https://www.terraform.io/docs/providers/aws/r/vpn_gateway_route_propagation.html
resource "aws_vpn_gateway_route_propagation" "default" {
  count          = var.transit_gateway_id != null && length(var.route_table_ids) > 0 ? 1 : 0
  vpn_gateway_id = join("", aws_vpn_gateway.default.*.id)
  route_table_id = element(var.route_table_ids, count.index)
}

# https://www.terraform.io/docs/providers/aws/r/vpn_connection_route.html
resource "aws_vpn_connection_route" "default" {
  count                  = var.vpn_connection_static_routes_only && var.transit_gateway_id == null ? length(var.vpn_connection_static_routes_destinations) : 0
  vpn_connection_id      = join("", aws_vpn_connection.default.*.id)
  destination_cidr_block = element(var.vpn_connection_static_routes_destinations, count.index)
}

resource "aws_ec2_transit_gateway_route" "default" {
  count                          = var.vpn_connection_static_routes_only && var.transit_gateway_id != null ? length(var.vpn_connection_static_routes_destinations) : 0
  destination_cidr_block         = var.vpn_connection_static_routes_destinations[count.index]
  transit_gateway_attachment_id  = aws_vpn_connection.default.transit_gateway_attachment_id
  transit_gateway_route_table_id = var.transit_gateway_default_route_table_id
}

resource "aws_cloudwatch_log_group" "tunnel_logs" {
  count             = var.vpn_connection_tunnel1_log_enabled || var.vpn_connection_tunnel2_log_enabled ? 1 : 0
  name              = var.vpn_tunnel_log_group_name
  retention_in_days = var.vpn_tunnel_logs_retention
  kms_key_id        = var.vpn_tunnel_logs_kms_key_arn
}
