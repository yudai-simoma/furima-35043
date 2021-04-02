# webpackerを用いることで、Railsで設定した環境変数をJavaScriptで呼び出せる
Webpacker::Compiler.env["PAYJP_PUBLIC_KEY"] = ENV["PAYJP_PUBLIC_KEY"]