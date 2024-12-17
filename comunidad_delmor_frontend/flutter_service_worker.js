'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "8803854b4d19d5467d6f0363e71341e5",
"assets/AssetManifest.bin.json": "404bd8e065a4a9393096d6618a607969",
"assets/AssetManifest.json": "24b00c54404c2de59340b7f48aa78b10",
"assets/FontManifest.json": "866b9b20ab0e8c30ffe220d2a2d66abe",
"assets/fonts/MaterialIcons-Regular.otf": "c67bc7564d18155733122f33672a83c7",
"assets/lib/assets/animations/people.json": "ccd614f2fd57e279b62ef6be393acb33",
"assets/lib/assets/animations/people.riv": "83aaa478760c98c90a40c0fda28a0674",
"assets/lib/assets/animations/people2.json": "96bd76c88816c45a031dc8650dd3c351",
"assets/lib/assets/animations/people3.json": "941a5ec8149b10f34eb9ab35fa072418",
"assets/lib/assets/animations/people4.json": "3a2f25852ac2b9564760a4dd3628b696",
"assets/lib/assets/icons/area-de-trabajo.png": "0c4fe4f31e53feb68eaa2f96b7c21535",
"assets/lib/assets/icons/area.png": "7706fdfacaf256d829ee667a7e36e041",
"assets/lib/assets/icons/boletin-informativo.png": "fec8f96846f57e5bcc2d24f5188f0ef4",
"assets/lib/assets/icons/cake.png": "c97cd0a1c91b3a578d6e430e73ec269a",
"assets/lib/assets/icons/cakeColor.png": "3a5a2d62d16ebcda62301669093f7b9f",
"assets/lib/assets/icons/calendario.png": "476173c5f6552edbc4a623c30f39df29",
"assets/lib/assets/icons/candado.png": "447fac3d7ff51cc32f4f9b76ee8689a0",
"assets/lib/assets/icons/catalogo.png": "e93fb9c9418674a702e9084501c6e69c",
"assets/lib/assets/icons/cedula.png": "c64aba58df8f7fcc48533eb5fd2cbed0",
"assets/lib/assets/icons/cerrar-sesion-de-usuario.png": "a53ee0446fb1577a4481386d68ca0ad4",
"assets/lib/assets/icons/comentarios.png": "b125756216022cd4cf0f21e7fff44675",
"assets/lib/assets/icons/comisariato.png": "0903ecb72a2a701cf47573c8d7baf3a3",
"assets/lib/assets/icons/configuraciones.png": "b9a6bc39856b4c28cf6336b860988015",
"assets/lib/assets/icons/cumpleanios.png": "28af4cd65f8efc1ca55fc148ed175834",
"assets/lib/assets/icons/edad.png": "7d6e69a9b64ba2706197ddfc12c251b2",
"assets/lib/assets/icons/fecha-fin.png": "ffd90a087f5a73137ae5499759f96a10",
"assets/lib/assets/icons/fecha-inicio.png": "476173c5f6552edbc4a623c30f39df29",
"assets/lib/assets/icons/maletin.png": "148020793c9b8ba2552bc5e620754569",
"assets/lib/assets/icons/maletinColor.png": "bb9606322993b7e499d9a7da7c712923",
"assets/lib/assets/icons/memorandos.png": "b30f3112cee098cddc63fb6bab4124df",
"assets/lib/assets/icons/pdf.png": "dedce39251ef755a9d9a2db9fc890baa",
"assets/lib/assets/icons/recorrido.png": "b031010cd86f445e6051515cfdf4a27c",
"assets/lib/assets/icons/salario.png": "b88420e659e03bbc7ded3fa1b242195a",
"assets/lib/assets/icons/seguro-social.png": "01241617380d827b375ffc3f107635b4",
"assets/lib/assets/icons/sin-conexion.png": "04531cee26275f401096bda07fb8b94b",
"assets/lib/assets/icons/team.png": "c6a2afd7994c016d1fedab7d8c1adac5",
"assets/lib/assets/icons/user.png": "d6d3d378a2bca5f8b7162aeb21c1fb91",
"assets/lib/assets/icons/userColor.png": "42eb3c9c2cbc1c958efa24047b606b79",
"assets/lib/assets/icons/vacaciones.png": "4d9c7e7273bd0c6b679f0d0a48cd5f15",
"assets/lib/assets/images/comunidad.jpg": "fcbd896598cc39559869fc76923ed4bc",
"assets/lib/assets/images/comunidad.png": "75114cc03745cedda655013d32ded21f",
"assets/NOTICES": "4ed3bd2a38118a41a581d15b24ab8b59",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/syncfusion_flutter_pdfviewer/assets/fonts/RobotoMono-Regular.ttf": "5b04fdfec4c8c36e8ca574e40b7148bb",
"assets/packages/syncfusion_flutter_pdfviewer/assets/highlight.png": "7384946432b51b56b0990dca1a735169",
"assets/packages/syncfusion_flutter_pdfviewer/assets/squiggly.png": "c9602bfd4aa99590ca66ce212099885f",
"assets/packages/syncfusion_flutter_pdfviewer/assets/strikethrough.png": "cb39da11cd936bd01d1c5a911e429799",
"assets/packages/syncfusion_flutter_pdfviewer/assets/underline.png": "c94a4441e753e4744e2857f0c4359bf0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"firebase-messaging-sw.js": "92e88f1549a6c99335bee960b2ef2228",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "37288d0dfa7270375226e27b5ebda38f",
"icons/android-icon-144x144.png": "9345de7143533fe4080a96b8ba8f3da4",
"icons/android-icon-192x192.png": "ad9a426fc8643a123af869b262945dd5",
"icons/android-icon-36x36.png": "fab186feff6fb41deccc79815c432888",
"icons/android-icon-48x48.png": "26564140993b501aae523a9505841586",
"icons/android-icon-72x72.png": "fca7c17614222b00dbd05af2ce66b022",
"icons/android-icon-96x96.png": "0b7abe03a1c381bda7252b9a0bd8f89e",
"icons/apple-icon-114x114.png": "594cfa6fd08a0018f36e9cb4ca5163f7",
"icons/apple-icon-120x120.png": "736ef7c0bd526af6e7e7550ed40013e1",
"icons/apple-icon-144x144.png": "9345de7143533fe4080a96b8ba8f3da4",
"icons/apple-icon-152x152.png": "c434eecce3997a6400c08432056d630f",
"icons/apple-icon-180x180.png": "741dc2f4eb9de03d6888d004260991f0",
"icons/apple-icon-57x57.png": "e366ae4f34ecbb36a66bfdf31595d780",
"icons/apple-icon-60x60.png": "72c8bff5bfcc18faa4a5d62184041533",
"icons/apple-icon-72x72.png": "fca7c17614222b00dbd05af2ce66b022",
"icons/apple-icon-76x76.png": "ca8cd08de45f39e353fdf8700356651f",
"icons/apple-icon-precomposed.png": "0c744c23486dbbbb6fc2ad70b1c079ff",
"icons/apple-icon.png": "745da7bb7e0ef029ac510ca6897d29cf",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/favicon-16x16.png": "05eed44b3e067779e6c0c65dded4e557",
"icons/favicon-32x32.png": "60791c88c95c60d357bc78ccb85d3f58",
"icons/favicon-96x96.png": "a7cf34d8756482f17e9408726bcc0a57",
"icons/favicon.ico": "3bc73afe6a62e06ce42f71ebcbdcc2c3",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"icons/ms-icon-144x144.png": "1e7e2325d0ef81e7e74e8ee0c6521e10",
"icons/ms-icon-150x150.png": "cef3be76955c9bb58232905af1fbe9c8",
"icons/ms-icon-310x310.png": "763f9540309d45792377fb478c2c913d",
"icons/ms-icon-70x70.png": "925e42b3deedcb5cb493298096f34d28",
"index.html": "f9afdd2ef2227a1a8fa5db8660b56630",
"/": "f9afdd2ef2227a1a8fa5db8660b56630",
"main.dart.js": "ad4528c5498ef324505964765f1460e2",
"manifest.json": "b33023e849f673bc95e01b0ed697c2b0",
"version.json": "ab4c7b265303f07f2c21e712a85aabd7"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
