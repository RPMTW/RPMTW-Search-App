with open("/home/runner/work/RPMTW-website/RPMTW-website/build/web/index.html","w+") as f:
  f.write(f.read().replace('<base href="/">','<base href="/docs">'))
