# Install Docker Toolbox in Windows Home Edition, step by step

![](images/win1.png)

![](images/win2.png)

![](images/win3.png)

![](images/win4.png)

![](images/win5.png)

![](images/win6.png)

![](images/win7.png)

![](images/win8.png)

![](images/win9.png)

![](images/win10.png)

![](images/win11.png)

![](images/win12.png)

![](images/win13.png)

![](images/win14.png)

![](images/win15.png)

![](images/win16.png)

![](images/win17.png)

![](images/win18.png)

![](images/win19.png)

![](images/win20.png)

## Window helpers
Set the default organization to use the address http://192.168.99.100:3000

```
docker-compose exec app bin/rails db:seed:hostname-windows-toolbox
```

Somthing wrong? you can revert to the original address http://localhost:3000 with this command:

```
docker-compose exec app bin/rails db:seed:hostname-localhost
```

