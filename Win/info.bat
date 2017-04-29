:: Some wmic magic by suhass92
:: Useful to snapshot the initial state of the windows machines
:: So, if the attackers modify anything, it can be used as a reference to check for changes
:: Lists the users, current processes, services, startup items, groups
:: Software installed, hotfixes installed, shared resources
:: Results are stored in html, so a browser can be used to view the results.

for /f "delims=" %%A in ('dir /s /b %WINDIR%\system32\*htable.xsl') do set "var=%%A"

wmic process get CSName,Description,ExecutablePath,ProcessId /format:"%var%" >> results.html
wmic service get Caption,Name,PathName,ServiceType,Started,StartMode,StartName /format:"%var%" >> results.html
wmic USERACCOUNT list full /format:"%var%" >> results.html
wmic group list full /format:"%var%" >> results.html
wmic nicconfig where IPEnabled='true' get Caption,DefaultIPGateway,Description,DHCPEnabled,DHCPServer,IPAddress,IPSubnet,MACAddress /format:"%var%" >> results.html
wmic netuse list full /format:"%var%" >> results.html
wmic qfe get Caption,Description,HotFixID,InstalledOn /format:"%var%" >> results.html
wmic startup get Caption,Command,Location,User /format:"%var%" >> results.html
wmic PRODUCT get Description,InstallDate,InstallLocation,PackageCache,Vendor,Version /format:"%var%" >> results.html

