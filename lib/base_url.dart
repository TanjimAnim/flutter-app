const baseUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://localhost:5000',
);

final mediaUrl = '$baseUrl/api/media/serve';
