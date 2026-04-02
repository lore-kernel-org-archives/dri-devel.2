Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CF8CC6B33
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F8010F0BA;
	Thu,  2 Apr 2026 09:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hwYGHIkS";
	dkim-atps=neutral
Received: from mail-m1973178.qiye.163.com (mail-m1973178.qiye.163.com
 [220.197.31.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 616BB10F0BA
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 09:14:58 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 394c8157d;
 Thu, 2 Apr 2026 17:14:53 +0800 (GMT+08:00)
Content-Type: multipart/mixed; boundary="------------pA08w6av2CYGH1v5Vjy6t1NO"
Message-ID: <d9b5c826-e0eb-4c0a-989b-48aa12fdbaef@rock-chips.com>
Date: Thu, 2 Apr 2026 17:14:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] drm/bridge: dw-hdmi: warn on unsupported attach
 combination
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>, Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com>
 <20260330-drm-lcdif-dbanc-v2-6-c7f2af536a24@bootlin.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260330-drm-lcdif-dbanc-v2-6-c7f2af536a24@bootlin.com>
X-HM-Tid: 0a9d4d795e9303a3kunme69324b095241
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pNT1YeT00dQxkaTUgaShhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
 pVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=hwYGHIkSikuofpTSHFwebC8Z6feWaoUJ3dbqqnt9MZuAJBUbRzjDoxXGvxcOn4j9NkNUUDiNbucKPIduKZrvAmo8ZgTvnE+WmB9N+e3tldsjk8dwC5SwWopcFHloVqwkfPXzAgbjILPvIGv1x74neMWR2lXN4dpR+i+rgG7KmPs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=2uJAsa6K7YXQMIGwXKQObtdIlbK0ldqP5sBHg2+Uhn0=;
 h=date:mime-version:subject:message-id:from;
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------pA08w6av2CYGH1v5Vjy6t1NO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luca,

On 3/31/2026 3:25 AM, Luca Ceresoli wrote:
> dw-hdmi can operate in two different modes, depending on the platform data
> as set by the driver:
> 
>   A. hdmi->plat_data->output_port = 0:
>      the HDMI output (port@1) in device tree is not used
> 
>   B. hdmi->plat_data->output_port = 1:
>      the HDMI output (port@1) is parsed to find the next bridge
> 
> Only case B is supported when the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is
> passed to the attach callback. Emit a warning when this is violated. Also
> return -EINVAL which would be returned by drm_bridge_attach() right after
> anyway.
> 
> Reviewed-by: Liu Ying <victor.liu@nxp.com>
> Tested-by: Martyn Welch <martyn.welch@collabora.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8MPxL/MBa8MPxL
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Note: Returning when the warning triggers does not change the functional
> behaviour of this function. It is not strictly necessary in this patch but
> it will have to be done anyway in the following patch.
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 0296e110ce65..ab1a6a8783cd 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2910,6 +2910,10 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge,
>   {
>   	struct dw_hdmi *hdmi = bridge->driver_private;
>   
> +	/* DRM_BRIDGE_ATTACH_NO_CONNECTOR requires a remote-endpoint to the next bridge */
> +	if (WARN_ON((flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) && !hdmi->plat_data->output_port))
> +		return -EINVAL;
> +
>   	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>   		return drm_bridge_attach(encoder, hdmi->bridge.next_bridge,
>   					 bridge, flags);
> 

Since many older Rockchip platforms (RK3288, RK3399, etc.) lack a 
hdmi-connector node linked to the HDMI DT node, which corresponds to 
case A. Could we relax this restriction and treat cases where 
DRM_BRIDGE_ATTACH_NO_CONNECTOR is set but hdmi->plat_data->output_port = 
0 as a new case C?

For Rockchip platforms, the HDMI driver invokes dw_hdmi_bind() to attach 
the Synopsys bridge. This sequence differs from that on the XNP 
platform, but is similar to the Allwinner implementation.

If we treat the case where DRM_BRIDGE_ATTACH_NO_CONNECTOR is set and 
hdmi->plat_data->output_port = 0 as -EINVAL, I will have to modify the 
HDMI DT configuration for all Rockchip platforms when adapting to the 
bridge-connector framework.

The patch that adapts to the bridge-connector framework and has been 
verified OK on RK3399 is attached.

Best regards,
Damon

--------------pA08w6av2CYGH1v5Vjy6t1NO
Content-Type: text/plain; charset=UTF-8;
 name="dw_hdmi-rockchip_test_env_20260402.patch"
Content-Disposition: attachment;
 filename="dw_hdmi-rockchip_test_env_20260402.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszMzk5LWV2Yi1p
bmQuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazMzOTktZXZiLWluZC5k
dHMKaW5kZXggNzBhZWUxYWI5MDRjLi41YTc4ZTc0MWYxMTMgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszMzk5LWV2Yi1pbmQuZHRzCisrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszMzk5LWV2Yi1pbmQuZHRzCkBAIC0xNyw2ICsx
Nyw3IEBAIGFsaWFzZXMgewogCiAJY2hvc2VuIHsKIAkJc3Rkb3V0LXBhdGggPSAic2VyaWFs
MjoxNTAwMDAwbjgiOworCQlib290YXJncyA9ICJyb290PVBBUlRVVUlEPTYxNGUwMDAwLTAw
MDAgcm9vdHdhaXQiOwogCX07CiAKIAl2Y2M1djBfc3lzOiByZWd1bGF0b3ItdmNjNXYwLXN5
cyB7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LWhk
bWkuYyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctaGRtaS5jCmluZGV4
IGFkYTQ1ZThiM2UyYy4uMGU5N2UxODNhOGIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYnJpZGdlL3N5bm9wc3lzL2R3LWhkbWkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYnJp
ZGdlL3N5bm9wc3lzL2R3LWhkbWkuYwpAQCAtMjkxNCw3ICsyOTE0LDcgQEAgc3RhdGljIGlu
dCBkd19oZG1pX2JyaWRnZV9hdHRhY2goc3RydWN0IGRybV9icmlkZ2UgKmJyaWRnZSwKIAog
CS8qIERSTV9CUklER0VfQVRUQUNIX05PX0NPTk5FQ1RPUiByZXF1aXJlcyBhIHJlbW90ZS1l
bmRwb2ludCB0byB0aGUgbmV4dCBicmlkZ2UgKi8KIAlpZiAoV0FSTl9PTigoZmxhZ3MgJiBE
Uk1fQlJJREdFX0FUVEFDSF9OT19DT05ORUNUT1IpICYmICFoZG1pLT5wbGF0X2RhdGEtPm91
dHB1dF9wb3J0KSkKLQkJcmV0dXJuIC1FSU5WQUw7CisJCXJldHVybiAwOwogCiAJaWYgKGZs
YWdzICYgRFJNX0JSSURHRV9BVFRBQ0hfTk9fQ09OTkVDVE9SKSB7CiAJCXN0cnVjdCBkZXZp
Y2Vfbm9kZSAqcmVtb3RlIF9fZnJlZShkZXZpY2Vfbm9kZSkgPQpAQCAtMzYyOCw3ICszNjI4
LDcgQEAgc3RydWN0IGR3X2hkbWkgKmR3X2hkbWlfYmluZChzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2LAogCWlmIChJU19FUlIoaGRtaSkpCiAJCXJldHVybiBoZG1pOwogCi0JcmV0
ID0gZHJtX2JyaWRnZV9hdHRhY2goZW5jb2RlciwgJmhkbWktPmJyaWRnZSwgTlVMTCwgMCk7
CisJcmV0ID0gZHJtX2JyaWRnZV9hdHRhY2goZW5jb2RlciwgJmhkbWktPmJyaWRnZSwgTlVM
TCwgRFJNX0JSSURHRV9BVFRBQ0hfTk9fQ09OTkVDVE9SKTsKIAlpZiAocmV0KSB7CiAJCWR3
X2hkbWlfcmVtb3ZlKGhkbWkpOwogCQlyZXR1cm4gRVJSX1BUUihyZXQpOwpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL0tjb25maWcgYi9kcml2ZXJzL2dwdS9kcm0v
cm9ja2NoaXAvS2NvbmZpZwppbmRleCBlN2Y0OWZlODQ1ZWEuLjY5YjgzMmQwYzhjNCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL0tjb25maWcKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3JvY2tjaGlwL0tjb25maWcKQEAgLTc2LDYgKzc2LDcgQEAgY29uZmlnIFJP
Q0tDSElQX0RXX0RQCiAKIGNvbmZpZyBST0NLQ0hJUF9EV19IRE1JCiAJYm9vbCAiUm9ja2No
aXAgc3BlY2lmaWMgZXh0ZW5zaW9ucyBmb3IgU3lub3BzeXMgRFcgSERNSSIKKwlzZWxlY3Qg
RFJNX0JSSURHRV9DT05ORUNUT1IKIAloZWxwCiAJICBUaGlzIHNlbGVjdHMgc3VwcG9ydCBm
b3IgUm9ja2NoaXAgU29DIHNwZWNpZmljIGV4dGVuc2lvbnMKIAkgIGZvciB0aGUgU3lub3Bz
eXMgRGVzaWduV2FyZSBIRE1JIGRyaXZlci4gSWYgeW91IHdhbnQgdG8KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9kd19oZG1pLXJvY2tjaGlwLmMgYi9kcml2ZXJz
L2dwdS9kcm0vcm9ja2NoaXAvZHdfaGRtaS1yb2NrY2hpcC5jCmluZGV4IDBkYzFlYjVkMmFl
My4uMTc0YTEwYzFkN2MyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAv
ZHdfaGRtaS1yb2NrY2hpcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9kd19o
ZG1pLXJvY2tjaGlwLmMKQEAgLTEzLDYgKzEzLDcgQEAKICNpbmNsdWRlIDxsaW51eC9yZWd1
bGF0b3IvY29uc3VtZXIuaD4KIAogI2luY2x1ZGUgPGRybS9icmlkZ2UvZHdfaGRtaS5oPgor
I2luY2x1ZGUgPGRybS9kcm1fYnJpZGdlX2Nvbm5lY3Rvci5oPgogI2luY2x1ZGUgPGRybS9k
cm1fZWRpZC5oPgogI2luY2x1ZGUgPGRybS9kcm1fb2YuaD4KICNpbmNsdWRlIDxkcm0vZHJt
X3Byb2JlX2hlbHBlci5oPgpAQCAtNTQyLDYgKzU0Myw3IEBAIHN0YXRpYyBpbnQgZHdfaGRt
aV9yb2NrY2hpcF9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZSAqbWFz
dGVyLAogCXN0cnVjdCBkcm1fZGV2aWNlICpkcm0gPSBkYXRhOwogCXN0cnVjdCBkcm1fZW5j
b2RlciAqZW5jb2RlcjsKIAlzdHJ1Y3Qgcm9ja2NoaXBfaGRtaSAqaGRtaTsKKwlzdHJ1Y3Qg
ZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yOwogCWludCByZXQ7CiAKIAlpZiAoIXBkZXYtPmRl
di5vZl9ub2RlKQpAQCAtNjE5LDcgKzYyMSwxNCBAQCBzdGF0aWMgaW50IGR3X2hkbWlfcm9j
a2NoaXBfYmluZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2UgKm1hc3RlciwK
IAkJZ290byBlcnJfYmluZDsKIAl9CiAKLQlyZXR1cm4gMDsKKwljb25uZWN0b3IgPSBkcm1f
YnJpZGdlX2Nvbm5lY3Rvcl9pbml0KGRybSwgZW5jb2Rlcik7CisJaWYgKElTX0VSUihjb25u
ZWN0b3IpKSB7CisJCXJldCA9IFBUUl9FUlIoY29ubmVjdG9yKTsKKwkJZGV2X2VycihoZG1p
LT5kZXYsICJGYWlsZWQgdG8gaW5pdGlhbGl6ZSBicmlkZ2VfY29ubmVjdG9yXG4iKTsKKwkJ
Z290byBlcnJfYmluZDsKKwl9CisKKwlyZXR1cm4gZHJtX2Nvbm5lY3Rvcl9hdHRhY2hfZW5j
b2Rlcihjb25uZWN0b3IsIGVuY29kZXIpOwogCiBlcnJfYmluZDoKIAlkcm1fZW5jb2Rlcl9j
bGVhbnVwKGVuY29kZXIpOwo=

--------------pA08w6av2CYGH1v5Vjy6t1NO--
