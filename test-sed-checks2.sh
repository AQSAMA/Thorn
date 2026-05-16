#!/bin/bash
cp app/build.gradle.kts app/build.gradle.kts.bak
cp app/src/main/res/values/non-translatable.xml app/src/main/res/values/non-translatable.xml.bak

sed -i 's/applicationId = "com.valhalla.thor"/applicationId = "com.valhalla.thorn"/g' app/build.gradle.kts
sed -i 's/<string name="app_name" translatable="false">Thor<\/string>/<string name="app_name" translatable="false">Thorn<\/string>/g' app/src/main/res/values/non-translatable.xml

FAILS=0

if grep -q 'applicationId = "com.valhalla.thor"' app/build.gradle.kts; then
  echo "Error: Old applicationId still exists."
  FAILS=1
fi
if ! grep -q 'applicationId = "com.valhalla.thorn"' app/build.gradle.kts; then
  echo "Error: New applicationId not found."
  FAILS=1
fi
if grep -q '<string name="app_name" translatable="false">Thor</string>' app/src/main/res/values/non-translatable.xml; then
  echo "Error: Old app_name still exists."
  FAILS=1
fi
if ! grep -q '<string name="app_name" translatable="false">Thorn</string>' app/src/main/res/values/non-translatable.xml; then
  echo "Error: New app_name not found."
  FAILS=1
fi

if [ $FAILS -eq 0 ]; then
  echo "All checks passed!"
fi

mv app/build.gradle.kts.bak app/build.gradle.kts
mv app/src/main/res/values/non-translatable.xml.bak app/src/main/res/values/non-translatable.xml
