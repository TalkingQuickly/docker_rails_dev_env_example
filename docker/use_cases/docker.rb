class Docker
  def ps
    'echo -e "GET /containers/json HTTP/1.1\r\n" | socat unix-connect:/var/run/docker.sock STDIO'
  end

  def j(json)
    JSON.parse(json)
  end
end