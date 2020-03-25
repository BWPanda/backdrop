#!/usr/bin/env php
<?php
/**
 * Delete any previous comments in the PR about this preview.
 */

$text = 'Tugboat has finished building a preview for this pull request!';
$url = getenv('TUGBOAT_DEFAULT_SERVICE_URL');

// Initialise session.
$ch = curl_init('https://api.github.com/repos/' . getenv('TUGBOAT_GITHUB_OWNER') . '/' . getenv('TUGBOAT_GITHUB_REPO') . '/issues/' . getenv('TUGBOAT_GITHUB_PR') . '/comments');

// Set options.
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
  'Authorization: token ' . getenv('BACKDROP_GITHUB_TOKEN'),
  'Content-Type: application/json',
  'Accept: application/vnd.github.v3+json',
  'User-Agent: Backdrop CMS',
));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);

// Execute and parse the response.
$response = curl_exec($ch);
$code = curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
if ($code == 200) {
  print_r($comments = json_decode($response));
}

// Close session.
curl_close($ch);
