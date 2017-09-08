FROM golang:1.7-alpine
ENV sourcesdir /go/src/github.com/JonathanMace/user/
ENV MONGO_HOST user-db
ENV HATEAOS user
ENV USER_DATABASE mongodb

COPY . ${sourcesdir}
RUN apk update
RUN apk add git gcc libc-dev
RUN go get github.com/JonathanMace/tracing-framework-go/cmd/modify-runtime
RUN go run /go/src/github.com/JonathanMace/tracing-framework-go/cmd/modify-runtime/modify.go
RUN go install -a std
RUN go get -v github.com/Masterminds/glide && cd ${sourcesdir} && glide install && go install

ENTRYPOINT ["user", "-port=80"]
EXPOSE 80