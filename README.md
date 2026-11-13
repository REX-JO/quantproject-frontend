# 加密貨幣走勢預測與穩定幣脫鉤風險預警系統：前端

銘傳大學人工智慧應用學系專題「基於機器學習與深度學習之加密貨幣走勢預測與穩定幣脫鉤風險預警系統」的網站前端，以 Flutter Web 製作，同時提供桌面與手機版面。

- 公開網站：https://quantproject-frontend.onrender.com
- 後端程式：https://github.com/REX-JO/quantproject-backend

後端部署在 Render 免費方案，閒置後會休眠。第一次開啟若沒有顯示資料，請稍候再按「重試」。

## 網站內容

| 頁面 | 顯示內容 |
| --- | --- |
| 穩定幣 | USDC、TUSD 最近 100 根一小時 K 線，Transformer 與 XGBoost 的脫鉤風險分數，以及未來最低價的迴歸估計 |
| 主流幣 | BTC、ETH、SOL、XRP 的一小時 K 線，四小時上漲分數與判定門檻，可複選幣種 |

每個模型都附有說明，列出預測目標、門檻、輸入的 K 線數量與特徵數。網站上的分數未經機率校準，因此標示為風險分數或方向分數，不代表機率，也不作為投資建議。

## 資料流程

1. 瀏覽器向 Binance 公開行情端點 `data-api.binance.vision` 取得六個交易對的一小時 K 線：USDCUSDT、TUSDUSDT、BTCUSDT、ETHUSDT、SOLUSDT、XRPUSDT。
2. 前端把 K 線送到後端 `POST /api/v1/dashboard/overview/from-klines`。
3. 後端計算特徵並執行模型推論，回傳一份 JSON，前端據此繪製 K 線圖與各模型的分數。

K 線改由瀏覽器取得，是因為後端部署到 Render 後，Binance 對主機的 IP 回傳 HTTP 418 並拒絕提供資料。改由使用者的瀏覽器取得 K 線、再交給後端計算後，網站才能公開運作。

## 本機執行

需要先安裝 Flutter（Dart SDK ^3.12.2）。

```bash
flutter pub get
flutter run -d chrome
```

後端網址預設為 `https://quantproject-backend.onrender.com`。若要連到本機後端，可在執行時加上 `--dart-define=API_BASE_URL=http://127.0.0.1:8000`。

## 專案結構

| 路徑 | 內容 |
| --- | --- |
| `lib/main.dart` | 全部畫面、資料存取與 K 線圖繪製 |
| `web/` | Flutter Web 的入口頁面與圖示 |
| `pubspec.yaml` | 套件設定 |

## 分工

本專題由五人團隊完成。前端早期版本由組員參與製作；前後端的整合與部署由專題組長負責。
