'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "65d09b565f1c28c12c3e825512885040",
"index.html": "826d24d8c6681ef856b5bbbd7a5e7984",
"/": "826d24d8c6681ef856b5bbbd7a5e7984",
"main.dart.js": "d2a617c1533d8c799751b58312385e79",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "d203020b136b1bf572ad3b94b9935815",
".git/config": "59ef2ca0fd1c62d12c840e22105246db",
".git/objects/0d/6ca540f43fa609584595f402d4493f0e554427": "b9ffb40f01978e23d943b9cb29d66524",
".git/objects/3e/432a152179956cfe12e2950b8ff174b71cc83e": "826b5cc9c80202498cefa215496978b0",
".git/objects/9b/05deb0169f48f97e33a50f4a2cf194cb00d898": "ec50ab2164a924d933dfba85958b2722",
".git/objects/32/46ad559eeae0370195978eaed83f1053ee13fd": "a043dbc0a0bda96ce2127799ccc27506",
".git/objects/34/994c8f70ca99843a39456475cb6145b28ac455": "e69ce55f1745b25446cc6710353f18ea",
".git/objects/5a/10cc052a7afed6f61af3085403fc5297f42322": "f215ed8dd47fab867c804860e32d351d",
".git/objects/a5/c4ef0b326165b06ab9ad051fe68ab3ccabc4f3": "56413896b7fdbcf6383cd0b1e43cd688",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/bc/2dc10e1db21f6b33ef000c0a9b0b982b3faadd": "c30a887a81cdf485f61c664fcdadfe24",
".git/objects/ae/1cccc7ca6ebf26b1e4104baba791f1ee278785": "d6c9a4268f64077e9f6637d2afce5d73",
".git/objects/ab/0e98497a51ead7821d1da35a24968ff314e50f": "557c35fe3928eb2af403d1b3926bb9ba",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/f3/d65f11729d7bfafaf9937e90c057bdd19ca60e": "ba3b64bac02f5109f489bc592d9db0c0",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/fc/4d44064cb4d80fac171ff039ba9d6b3ba2cd9c": "2a36c9457b9a3d5616538568f2ee8e79",
".git/objects/f2/89c52db54d5b9469942b98c6299f8f66641fd0": "ba42895e1c4d566a908310b2d237c47f",
".git/objects/e4/830768b94affaa25df3776b1fff904a32c9677": "d6a09eae1ce1e66a120ee011fcc67bd4",
".git/objects/fb/76a4df8a888afa7dde9662b24208851decf30e": "50733af0e18effc0317696e3f3737363",
".git/objects/27/5d5bdd31e9082ff77c4444eba8912e1a98ff48": "fa62012fdbed857fc4031f5fa79dbf40",
".git/objects/11/fbdff4912f74a6eb0aeb1d1cb4dd1e67817bbf": "cf33b7981d7c17b63f4a33a61c7d0d12",
".git/objects/87/f054e04ed114946a8053f1e1af75ae02515ad8": "5564957db507df4c078a0fee4df56451",
".git/objects/87/748811d9bdbffffa46bb959351dcefc851eef9": "f6ae000509c1c6189205c1dffee84fb3",
".git/objects/80/fd5316e3cdeabb4f237430c9a500c54bd77aad": "241709324262e6c2d0911865ca91f61f",
".git/objects/80/d4d6c24dc008fca6220852f0c311265c22562d": "c1da1f448ddaa37d72a46443cb4b7ba8",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/4c/ec15391a501ceb4fecd66a1add8e78bc095520": "61d3adb4ce264b3b968466e5ef8d827a",
".git/objects/26/daca806d9a2658d558b48eff90988b732877be": "1b42215b598af9464a02fcb886e444a0",
".git/objects/44/7bdedabe6bda65b3618ca27f4654113b419f81": "98a14f69af145b7421c1b269b2b3965f",
".git/objects/2a/bf3f37668f18a3466c4e929e4ca32bb2d16cd0": "2ba1638bb1a6946a95bd1e63af4e0133",
".git/objects/43/b222a60a5428585a01c5366a52346147484aa0": "a36b1729ce7c9dfced415d34dc18f309",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/07/9f9d89609e0a13ea42f2714436f37a73dca027": "eadc96cf07559464d5444059e289ce07",
".git/objects/38/db9bcf96775ac7937880fea5f5ab0e09cc4c38": "d38bf9ff0cec836afc9cce10f6ad9163",
".git/objects/00/5ae8a029012eac12a17ec8aa91eb920ec1d8a2": "f0df17d22ca1d61550e63c7da5096480",
".git/objects/65/647fb5bcca55e208cb176be85c26cdd9315dc2": "1d19117857b7683440941fd0eeede76f",
".git/objects/98/9a6853f60eb1d7222eb2a0f3ecc8562cb0874a": "2d06135dddd20a2ca615db52e463c555",
".git/objects/30/fd04eb1b2aa3c80be574b97e1d51066d5f3655": "cbab1027173b0a0ef1fa50288fec86d8",
".git/objects/01/616bea01c9299ce3c05f6a394e2475c7970edc": "f33ba22bd4bb39406f2af93621493eac",
".git/objects/a0/ba1b333313f3798265ff989e5890a4f27a3886": "9f1cae93168cfed366f493e0ad1a42ea",
".git/objects/a7/ce38aec1f4903baaa9e7ec26e6237d32518a31": "05a29fbfdac1f43d022b46c7d83e7312",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b7/557ab26809bd67b43dcc2e601dac4fdc3c3580": "71ba84a1bb2435986272574cf35c09fe",
".git/objects/db/e09ff61c1156ed9158efdb7d46b034c9bbad10": "666f4fc913edf5888795585dcdc2ed9e",
".git/objects/a8/beffd3ad4fe54d6cabccf83a05477d6a986cd0": "6677888e4a051c7838b5b240c09f0981",
".git/objects/de/390d5ed539ae37b22727c35b688fffaedd1adb": "af3e3a9b7f772163da733adc2382e5d6",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/e6/61d5e5d0e13e1b0a02dc9149dd390f4d0ec602": "086b27c5e3c41c51222c27370a1b2226",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/46/19a99c1c2e314dfbe06ff13b7a839e68bd0f21": "f6fef236e966fc783413674725b66e8e",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/77/e536559b85af523dd1c789ca8468feece67f87": "5d5bf09ef00ee8693c3418eb13c6dd92",
".git/objects/70/58e74da697066b1555ea5c6804e9e08cc29ab7": "4c07cc6ab78dec54c9e6aa8ef774c2bb",
".git/objects/8d/f0c93ccd4fa2edd3e41d50e791064b39e98ce7": "65154c3f0e736a6effc26c7308d99a33",
".git/objects/82/436f58bfa2b22228b53de533f38af7b6d9c4fa": "4886384236f07d4d70d656ac3825673c",
".git/objects/22/b8f6e9d953a6afe408a615a72985e6394b0d48": "b3fa5ec20e2f3a937b3b1e486937f937",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "0aebccfd5866bfc3e7c8f625230c22f7",
".git/logs/HEAD": "68c3a4187f0f614eda0dc7926474d614",
".git/logs/refs/heads/main": "cfb5baf885427fe47998bce5f9fb1e2b",
".git/logs/refs/remotes/origin_prod/main": "de6eaf500b9b3d28801a1775cbe84ab6",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "ea587b0fae70333bce92257152996e70",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/main": "99c43f967c4cc0ae92b21ec974332b30",
".git/refs/remotes/origin_prod/main": "99c43f967c4cc0ae92b21ec974332b30",
".git/index": "e469969d1d57821a693dbc7fc1217ebc",
".git/COMMIT_EDITMSG": "c64b0e030e15dd715b0c098be2b3def3",
"assets/AssetManifest.json": "2a38f186cc32845ef2f79da942696db4",
"assets/NOTICES": "bd50987c873d1bb413ce06707bd6d8c5",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/assets/ca/lets-encrypt-r3.pem": "be77e5992c00fcd753d1b9c11d3768f2",
"assets/assets/logos/2.0x/yuk_vaksin_logo_blue.png": "2a4311eddd4bca4cc789fe4c34b884aa",
"assets/assets/logos/2.0x/yuk_vaksin_logo.png": "1f4035869599278d9198b34ddf15a342",
"assets/assets/logos/yuk_vaksin_logo_blue.png": "fbb6bb32c77b1ded4093f343444a4b67",
"assets/assets/logos/3.0x/yuk_vaksin_logo_blue.png": "deab2babf76bb7cf38aa405e592aa1fd",
"assets/assets/logos/3.0x/yuk_vaksin_logo.png": "c34ed9680a1e239f909f4aec7f499f4d",
"assets/assets/logos/yuk_vaksin_logo.png": "c49a89b5a2c624d6988d1177875f0293",
"assets/assets/icons/2.0x/vaccines.png": "fdbf3ec5bb865ccb8ceed88b22264db9",
"assets/assets/icons/3.0x/vaccines.png": "030ffb35e6459cb308b000d7ca726509",
"assets/assets/icons/vaccines.png": "95d77b0198720b37e56ecc238e48b6f0",
"canvaskit/canvaskit.js": "62b9906717d7215a6ff4cc24efbd1b5c",
"canvaskit/profiling/canvaskit.js": "3783918f48ef691e230156c251169480",
"canvaskit/profiling/canvaskit.wasm": "6d1b0fc1ec88c3110db88caa3393c580",
"canvaskit/canvaskit.wasm": "b179ba02b7a9f61ebc108f82c5a1ecdb"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
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
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
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
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
