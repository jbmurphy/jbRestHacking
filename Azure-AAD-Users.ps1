# LogIn if you haven't : $AzureConnection=Connect-AzureRmAccount
$SubscriptionId = "$($env:SubscriptionId)"
$TenantId       = "$($env:ClientID)"
$TenantDomain   = "$($env:TenantDomain)"
$ClientID       = "$($env:ClientID)"      
$ClientSecret   = "$($env:ClientSecret)"  

$resource       = "https://graph.windows.net"             # Azure AD Graph API resource URI
$body           = @{grant_type="client_credentials";resource=$resource;client_id=$ClientID;client_secret=$ClientSecret}
$oauth          = Invoke-RestMethod -Method Post -Uri $loginURL/$tenantdomain/oauth2/token?api-version=1.0 -Body $body

$headerParams = @{'Authorization'="$($oauth.token_type) $($oauth.access_token)"}
$url = 'https://graph.windows.net/' + $tenantdomain + "/users?api-version=2013-11-08"
$results=Invoke-RestMethod -UseBasicParsing -Headers $headerParams -Uri $url
$results.value