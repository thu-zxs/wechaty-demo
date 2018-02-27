{ Contact, Wechaty, MediaMessage} = require 'wechaty'
bot = Wechaty.instance()
bot.on('scan', (url, code) =>
  if !/201|200/.test(String(code))
    loginUrl = url.replace(/\/qrcode\//, '/l/')
    require('qrcode-terminal').generate(loginUrl)
  console.log("Scan QR Code to login: #{code}\n#{url}")
).on('login', (user) =>
  console.log("User #{user} logged in")
  onLogin()
).on('message', (m) =>
  if /^你好$/.test m.content()
    await m.say('Hi, there')
)

bot.init()
.catch( (e) =>
  console.log ("[Error]#{e}")
  bot.quit()
  process.exit(-1)
)

onLogin = () =>
  contactList = await Contact.findAll()
  toFH = await Contact.find({name: '文件传输助手'})
  # Say Hello to FileHelper every 3 secs for 10 times
  for i in [1..10]
    await sleep(3000)
    await toFH.say("hello from yourself #{i} times!")

sleep = (time) =>
  new Promise (resolve, reject) ->
    setTimeout( () ->
      resolve('ok')
    , time)
