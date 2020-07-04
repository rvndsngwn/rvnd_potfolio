'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "61e550d633b1f82897a654426c8c082b",
"assets/assets/avatar.png": "32c0ddcf431d38d5eec5cce8e4c61a93",
"assets/assets/medium_light.png": "bd516690c99267a778885736015befe8",
"assets/assets/works/savaari_partner.png": "05e90af963f924eeac54490a5a2dcd38",
"assets/assets/works/gurukirpa.png": "140d457c3314a59d1bdc8ae496157f5e",
"assets/assets/works/truelancer.png": "1126f584894fa84c5c052ec625ebf54e",
"assets/assets/works/mydealer.png": "14f62eb3413897290d2b2a248dcd8931",
"assets/assets/works/mohesu.png": "6cbd5fd15402eee6581c680a126ab05c",
"assets/assets/works/flights.png": "e4e4eaa1e691ae17ee842dc8f837492a",
"assets/assets/works/trivz.png": "4fc7b4922689e1508fdbd35a9b1785ee",
"assets/assets/works/stattion.png": "3e39fc6c1f96b3201cb661452edc6d7f",
"assets/assets/works/vdrone.png": "f9817772bfa75c8d65c62810d83be284",
"assets/assets/works/btdoor.png": "b1d9f7e5ecf6c29b4d2716341641df52",
"assets/assets/works/kharedi_now.png": "d0c478d3e7e33419a8f48b34bf1207e3",
"assets/assets/works/rajasthan_tourism.png": "d7e838f9f73511fc7038a05b60859356",
"assets/assets/works/wheelie_repairs.png": "cd0c2be230c6e7b9cb6224da0726d7ca",
"assets/assets/works/mohesuEnter.png": "c1d392954e15fd2d4ead2543a942455d",
"assets/assets/works/savaari_consumer.png": "480950a09ee167d32cdabea4b45b676f",
"assets/assets/works/LoanKarao.png": "0fdc469fa7fa8a00762b73ba1ba6e90d",
"assets/assets/works/railenq.png": "7982d54f1972d96a8f10a389ad354db2",
"assets/assets/works/survey.png": "9d5f25775d55acaf05c7e3e857e9baa6",
"assets/assets/works/facelyt.png": "9c21f203fc4d3a9ca53455c525b63f94",
"assets/assets/works/cocoapay.png": "1a116679a577ef4af05f6e3c7f6f23be",
"assets/assets/works/vlive.png": "100cbbf4ad6d5b4530a55176e9e21097",
"assets/assets/works/messio.png": "827f062f04c16a164d9d7e9d13f24916",
"assets/assets/works/mynewcar.png": "a856c91717e8817762660e95e591a10f",
"assets/assets/works/trecker.png": "dbd36b91c34bae4c52e01170e8ce69a3",
"assets/assets/GoogleSansRegular.ttf": "b5c77a6aed75cdad9489effd0d5ea411",
"assets/assets/about.html": "cca535e84bb3f1ad20cd1423638d0253",
"assets/assets/moon.png": "a270b8a10d1a9a52441bf5a322dd1b86",
"assets/assets/FontManifest.json": "59c37979205b4b43589051e92e27cbcd",
"assets/assets/github.png": "d22ee3727a7216019c3848df6eafa024",
"assets/assets/instagram.png": "26631a4043b14dff84180bdf51c3cacb",
"assets/assets/facebook.png": "021ada146ffb7c1753557ff29618d04c",
"assets/assets/twitter.png": "8f35a40403a84631c4125c4f1859c7a6",
"assets/assets/linkedin.png": "926e2dcf5ab4220a359867614556df68",
"assets/assets/medium.png": "fb86f4060325caef8ea1f0fad0d25f40",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/FontManifest.json": "592290621294619b16740a9d89232ba6",
"assets/NOTICES": "e30f83a3e1a0b357556ca8206c7ddcd3",
"index.html": "edef834a9be4485a0a7e980be3cb2a7f",
"/": "edef834a9be4485a0a7e980be3cb2a7f",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "29f4961a12d769a4fed9d6935d0e0f79",
"main.dart.js": "a6c71adfbdcac6d7b4a594ecb6314258"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/LICENSE",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a no-cache param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'no-cache'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');

      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }

      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'no-cache'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.message == 'skipWaiting') {
    return self.skipWaiting();
  }

  if (event.message = 'downloadOffline') {
    downloadOffline();
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.add(resourceKey);
    }
  }
  return Cache.addAll(resources);
}
