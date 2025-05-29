#!/bin/bash
function git_sparse_clone() {
branch="$1" rurl="$2" localdir="$3" && shift 3
git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
cd $localdir
git sparse-checkout init --cone
git sparse-checkout set $@
mv -n $@ ../
cd ..
rm -rf $localdir
}

function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

git clone --depth 1 -b main https://github.com/xiaorouji/openwrt-passwall && mv -n openwrt-passwall/luci-app-passwall ./ && rm -rf openwrt-passwall
git clone --depth 1 -b main https://github.com/xiaorouji/openwrt-passwall2 && mv -n openwrt-passwall2/luci-app-passwall2 ./ && rm -rf openwrt-passwall2
git clone --depth 1 -b main https://github.com/xiaorouji/openwrt-passwall-packages && mv -n openwrt-passwall-packages/{chinadns-ng,dns2socks,geoview,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,sing-box,tcping,trojan-plus,tuic-client,v2ray-geodata,v2ray-plugin,xray-core,xray-plugin} ./ && rm -rf openwrt-passwall-packages
git clone --depth 1 -b master https://github.com/fw876/helloworld && mv -n helloworld/{luci-app-ssr-plus,gn,trojan,v2ray-core,dnsproxy,dns2tcp,dns2socks-rust,lua-neturl,shadow-tls,redsocks2} ./ && rm -rf helloworld
git clone --depth 1 -b main https://github.com/nikkinikki-org/OpenWrt-nikki && mv -n OpenWrt-nikki/{luci-app-nikki,nikki} ./ && rm -rf OpenWrt-nikki
git clone --depth 1 -b dev https://github.com/vernesong/OpenClash && mv -n OpenClash/luci-app-openclash ./ && rm -rf OpenClash
git clone --depth 1 -b master https://github.com/immortalwrt/homeproxy luci-app-homeproxy
git clone --depth 1 https://github.com/QiuSimons/luci-app-daed && mv -n luci-app-daed/{luci-app-daed,daed} ./ && rm -rf luci-app-daed
git clone --depth 1 https://github.com/oppen321/libcron
git clone --depth 1 https://github.com/oppen321/pdnsd

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
exit 0
