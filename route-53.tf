resource "aws_route53_record" "site_domain" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "www.terrencencube.com"  
  type    = "A" 

  alias {
    name                   = "d1234567890abcdef.cloudfront.net." 
    zone_id                = "Z2FDTNDATAQYW2"  
    evaluate_target_health = true  
  }
}
