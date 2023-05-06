class ImagesAPIs {
  static const baseUrl = 'https://api.unsplash.com/';
  static const clientId =
      'client_id=6L7XvN6EjomWftmOCEOlHlvb6hTsvsGYdn9p77Vr-rI';
  static const pages = 'page=1';
  static const search = 'query=nature';
  static const noOfImages = 'per_page=1';

  static const endPoint =
      '${baseUrl}search/photos?$clientId&$pages&$noOfImages&$search';
}
