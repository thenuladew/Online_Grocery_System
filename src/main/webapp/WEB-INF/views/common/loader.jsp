<!DOCTYPE html>
<html>
<head>
  <title>Lottie Loader</title>
  <script
  src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs"
  type="module"
></script>
</head>
<body style="min-height: 100vh; margin: 0;">
  <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); display: flex; flex-direction: column; justify-content: center; align-items: center;">
    <dotlottie-player
      src="https://lottie.host/8b4bf2b7-907b-4e4d-a443-b6d05e60cd6b/SHMpRf7cIx.json"
      background="transparent"
      speed="1"
      style="width: 150px; height: 150px"
      loop
      autoplay
    ></dotlottie-player>
    <div style="width: 120px; height: 4px; background: #fff3; border-radius: 2px; margin-top: 18px; overflow: hidden; position: relative;">
      <div id="loading-bar" style="height: 100%; width: 40px; background: linear-gradient(90deg, #fff 0%, #fff8 100%); border-radius: 2px; position: absolute; left: 0; top: 0;"></div>
    </div>
  </div>
  <script>
    // Loading bar: pill slides from left to right and resets
    const bar = document.getElementById('loading-bar');
    const barContainerWidth = 120;
    const pillWidth = 40;
    let pos = 0;
    function animateBar() {
      pos = 0;
      bar.style.left = '0px';
      const interval = setInterval(() => {
        pos += 3;
        if (pos > barContainerWidth) {
          pos = -pillWidth;
        }
        bar.style.left = pos + 'px';
      }, 16);
    }
    animateBar();
  </script>
</body>
</html> 