with open("/home/runner/work/RPMTW-website/RPMTW-website/build/web/index.html","r") as f:
  text=f.read().replace('<base href="/">','<base href="/docs">')
with open("/home/runner/work/RPMTW-website/RPMTW-website/build/web/index.html","w") as ff:
  ff.write(text)
