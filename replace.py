with open("/home/runner/work/RPMTW-website/RPMTW-website/build/web","w+") as f:
  f.write(f.read().replace('<base href="/">','<base href="/docs">'))
