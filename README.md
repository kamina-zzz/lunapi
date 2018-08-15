# Lunapi

Lunapi is 高可用性を備えたとりあえず k8s 上で動く Rails アプリケーションです。<br>
名前は衛星っぽくしたくて、あと api だったので。

## 仕様

- `kubernetes` で動き、rails サーバーをスケールさせることができるやつ
- `rails new --api` した
- `scaffold` で `HostController` だけ作った
  - `/host` で実行中のホスト名 = pod の名前を json で返すので、バランシングされている様を感じ取れる

## how to use

```sh
$ docker build -t lunapi:latest -f Dockerfile.dev .
# プライベートレジストリを立てておく ( 今回は localhost:5000 に立てた )
$ docker tag lunapi:latest localhost:5000/lunapi-vx
$ docker push localhost:5000/lunapi-vx
$ kubectl create -f kubernetes/deployment.yml
$ kubectl create -f kubernetes/service.yml
# kubectl describe service/lunapi-lb して NordPort を確認しておく
$ curl -s localhost:3XXXX/host
{"host":"lunapi-app-xxxxxxxxxx-xxxxx\n"}
```

## いろいろ

- めんどくさかったので sqlite で db ごと pod 内に押し込んだ
- ふつーは外部に db 立ててそいつにアクセスできるようにうまいことやるんだと思う
- バランシングは NodePort まかせなので、これも妥当かどうかわからない
  - ingress つかって nginx-ingress-controller とかにやらせるんだろうが、 NodePort でも今回は十分だったので
