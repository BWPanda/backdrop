#!/usr/bin/env php
<?php
/**
 * Post a comment on the PR with login details.
 */

$comment = "Tugboat has finished building a preview for this pull request!

Website: " . getenv('TUGBOAT_DEFAULT_SERVICE_URL') . "
Username: admin
Password: password";

// Initialise session.
$ch = curl_init('https://api.github.com/repos/' . getenv('TUGBOAT_GITHUB_OWNER') . '/' . getenv('TUGBOAT_GITHUB_REPO') . '/issues/' . getenv('TUGBOAT_GITHUB_PR') . '/comments');

// Set options.
print 'Token: ' . getenv('BACKDROP_GITHUB_TOKEN') . "\n";
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
  'Authorization: token ' . getenv('BACKDROP_GITHUB_TOKEN'),
  'Content-Type: application/json',
  'Accept: application/vnd.github.v3+json',
  'User-Agent: Backdrop CMS',
));
curl_setopt($ch, CURLOPT_HEADER, TRUE);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($ch, CURLOPT_POST, TRUE);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode(array('body' => $comment)));

// Execute and parse response.
$response = curl_exec($ch);
print_r($response);
// $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
// dpm($code = curl_getinfo($ch, CURLINFO_HTTP_CODE));
// $header = trim(substr($response, 0, $header_size));
// dpm($body = json_decode(substr($response, $header_size)));

// Close session.
curl_close($ch);
