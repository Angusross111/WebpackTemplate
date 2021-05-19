const { merge } = require("webpack-merge");
const common = require("./webpack.common.js");

module.exports = merge(common, {
  mode: "development",
  devtool: "inline-source-map",
  devServer: {
    host: "localhost",
    port: 4005,
    disableHostCheck: true,
    historyApiFallback: true,
    proxy: {
      "/api": "http://localhost:4001",
    },
  },
});
