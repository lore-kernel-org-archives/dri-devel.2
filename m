Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44723C624DD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0D110ED63;
	Wed,  2 Sep 2026 22:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GN9ZAskp";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC5410F365
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 22:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788389657;
 bh=gSPXHyvotFuPHc3buR3f/TfayPaEzgZ99QXzk7ixLWU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=GN9ZAskphlBX6X7USq9G6xN868nL2mtcVSnsPADSZ4PPoR+PWYrGWRV6+QN3Q7xhg
 6NMe+8AHh3sjQI0dk9x/0qP3EsLwslBoinkYekhTX7df/v+Tg9Oojevj+1sYjcPPxT
 eOghLaKs+O0xsBcdTZ+YFUvxiB/8iREfd/xdjpCq4nngEZUrIKuArpNkWkNCqZmh5t
 SvU0/bi4JRpN6U2kM9LQWhOVWfph2SfsIG6kLmqzxTqW2hrfEEX04JeaiXNVcq9hjm
 7tZQfpxpH1yF9jMIrdVJAw0vo9YyOyX0A/R4z7CB0dEt7S7oSQJl8/xMUdSY6uq4dj
 o9SxiYmLJ1XlQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5839C17E131F;
 Thu, 03 Sep 2026 00:54:17 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 03 Sep 2026 01:54:15 +0300
Subject: [PATCH v4 08/14] drm/rockchip: vop2: Avoid DCLK source switch for
 10-bit YUV422 output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dw-hdmi-qp-yuv-v4-8-fb45bf4147eb@collabora.com>
References: <20260903-dw-hdmi-qp-yuv-v4-0-fb45bf4147eb@collabora.com>
In-Reply-To: <20260903-dw-hdmi-qp-yuv-v4-0-fb45bf4147eb@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.15.2
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

Currently the color depth is always factored into the DCLK source
decision for HDMI output, which can break certain modes when operating
with depths greater than 8 bpc.

When the required transmission rate exceeds the 600 MHz limit of the
HDMI PHY PLL, e.g. for 4K@60Hz 10-bit RGB output, VOP2 will normally
fall back to using the less accurate system CRU as a DCLK source,
assuming HDMI 2.1 FRL is supported by the pipeline, otherwise the mode
will be rejected.  For YUV420 output format this never happens, as it
uses half of the RGB bandwidth, hence the rate remains within the PHY
PLL limits.

On the other hand, YUV422 always transmits two 12-bit components per
clock cycle, regardless of the color depth, which from a clock-rate
perspective is equivalent to three 8-bit RGB components.  For example,
4K@60Hz 10-bit YUV422 requires the same bandwidth as 4K@60Hz 8-bit RGB,
typically 594 MHz.  However, VOP2 wrongly assumes it needs 742.5 MHz
(594 * 10 / 8) and ends up switching the DCLK source.

As a consequence, the modes requiring uncommon pixel clocks, such as
those corresponding to fractional refresh rates, will fail.  An example
is 3840x2160@59.94Hz, which would likely rely on the 593.407 MHz clock
rate unsupported by the system CRU.

Note this only affects YUV422 with color depths greater than 8 bpc; for
8-bit YUV422 the 8/bpc factor is unity and the bandwidth check is
already correct.

Prevent the incorrect switches of DCLK source to system CRU for YUV422
output format by forcing 8 bpc when checking the bandwidth.

Tested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 21b8a5960086..4b4346cf38cd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1954,7 +1954,15 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 	 * to 4K@60Hz, if available, otherwise keep using the system CRU.
 	 */
 	if (vop2->pll_hdmiphy0 || vop2->pll_hdmiphy1) {
-		unsigned int bpc = vcstate->output_bpc ?: 8;
+		/*
+		 * YUV422 always transmits two 12-bit components per clock
+		 * cycle, regardless of the color depth, which from a rate
+		 * perspective is equivalent to three 8-bit RGB components.
+		 * Force 8 bpc here so the bandwidth check reflects the actual
+		 * TMDS rate and avoids an unnecessary DCLK source switch.
+		 */
+		unsigned int bpc = vcstate->output_mode == ROCKCHIP_OUT_MODE_YUV422 ?
+					8 : (vcstate->output_bpc ?: 8);
 		unsigned long max_dclk = DIV_ROUND_CLOSEST_ULL(VOP2_MAX_DCLK_RATE * 8, bpc);
 
 		if (clock <= max_dclk) {

-- 
2.55.0

