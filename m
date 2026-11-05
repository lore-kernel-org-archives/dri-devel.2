Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93788606D82B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=oBN2vH/O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAAC410E8E2;
	Thu,  5 Nov 2026 01:01:26 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F70810E311
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 01:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793840472;
 bh=Nombu86J0Q84Br7Nx4D8vE6Z266SQx5BEp7YtcUBtmI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oBN2vH/O6d0cX2n7QNWUq5ti5YHXWRD+p3QBcWR9H5K3g3TwEcIZzIZv8Xu9kqpc4
 sp6SkWN4xW8FbPtFy46xIG1K25Q961O1nilb9b/9aAevksEHZUi5a9lcA4CDqieP8x
 +p98cWsFGEq+qvMtaWFidhK1uu9/cIgwRX45z7RM2GdQS7Ffqx2tESbMtMdTGINtCj
 T6Wf9c6OgmndAHh5q5YmZ+i1el5bf9HtOyCWVp1Z5DdKxw2g/fFalqgZN6ZbTTIkzK
 AvqK8ghbQZMzROH5vK4m7D3+GnDU93e4JE91iJRDjPccjQ/b2qxAGd+QIrchyIy+7j
 Knx/UM8LcCGNQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B642817E0D69;
 Thu, 05 Nov 2026 02:01:12 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 05 Nov 2026 03:00:43 +0200
Subject: [PATCH v6 09/15] drm/rockchip: vop2: Use TMDS character rate to
 select DCLK source
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-dw-hdmi-qp-yuv-v6-9-1bb63ef5766e@collabora.com>
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The HDMI PHY PLL can only be used as DCLK source while the HDMI link
operates in TMDS mode, i.e. for TMDS character rates up to 600 MHz.
Beyond that, HDMI 2.1 FRL is required, in which case the PLL would run
at the link rate and VOP2 must keep using the system CRU.

Currently, this is decided by reconstructing the TMDS character rate
from the DCLK rate and the color depth, i.e. DCLK * bpc / 8, which does
not hold for all possible output configurations:

- YUV422 always transmits two 12-bit components per clock cycle,
  regardless of the color depth, which from a clock-rate perspective is
  equivalent to three 8-bit RGB components.  For example, 4K@60Hz 10-bit
  YUV422 requires the same bandwidth as 4K@60Hz 8-bit RGB, typically 594
  MHz.  However, VOP2 wrongly assumes it needs 742.5 MHz (594 * 10 / 8)
  and ends up switching the DCLK source.  As a consequence, modes
  requiring uncommon pixel clocks, such as those corresponding to
  fractional refresh rates, will fail.  An example is 3840x2160@59.94Hz,
  which would likely rely on a 593.407 MHz clock rate, unsupported by
  the system CRU.

- When VOP2 processes multiple pixels per clock cycle, DCLK is only a
  fraction of the pixel clock, e.g. RK3576 halves it for pixel clocks
  above 600 MHz.  Hence, an FRL mode such as 4K@120Hz 8-bit RGB, with a
  pixel clock of 1188 MHz, ends up with a 594 MHz DCLK, which slips
  under the limit and wrongly selects the HDMI PHY PLL as DCLK source.

In preparation for supporting the use cases above, rework the DCLK
source switch logic to check the TMDS character rate computed by the
HDMI connector state helpers, which already accounts for the output
color format and depth.  Keep using the system CRU when the rate is not
available.

While at it, drop the VOP2_MAX_DCLK_RATE define in favor of the generic
HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ, since the 600 MHz limit applies to the
TMDS character rate rather than to DCLK.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 50 ++++++++++++++++++----------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index ab6ced49ae40..7c35d73c82cb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -7,6 +7,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/delay.h>
+#include <linux/hdmi.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/media-bus-format.h>
@@ -103,8 +104,6 @@ enum vop2_afbc_format {
 	VOP2_AFBC_FMT_INVALID = -1,
 };
 
-#define VOP2_MAX_DCLK_RATE		600000000ULL
-
 /*
  * bus-format types.
  */
@@ -1800,6 +1799,23 @@ static int us_to_vertical_line(struct drm_display_mode *mode, int us)
 	return us * mode->clock / mode->htotal / 1000;
 }
 
+static bool vop2_hdmi_phy_pll_usable(struct drm_atomic_commit *state,
+				     struct drm_encoder *encoder)
+{
+	struct drm_connector_state *conn_state;
+	struct drm_connector *connector;
+	unsigned long long rate;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state, encoder);
+	if (!connector)
+		return false;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	rate = conn_state->hdmi.tmds_char_rate;
+
+	return rate && rate <= HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
+}
+
 static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 				    struct drm_atomic_commit *state)
 {
@@ -1950,28 +1966,26 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 	vop2_vp_write(vp, RK3568_VP_MIPI_CTRL, 0);
 
 	/*
-	 * Switch to HDMI PHY PLL as DCLK source for display modes up
-	 * to 4K@60Hz, if available, otherwise keep using the system CRU.
+	 * Switch to HDMI PHY PLL as DCLK source while the HDMI link operates
+	 * in TMDS mode, if available, otherwise keep using the system CRU.
 	 */
 	if (vop2->pll_hdmiphy0 || vop2->pll_hdmiphy1) {
-		unsigned int bpc = vcstate->output_bpc ?: 8;
-		unsigned long max_dclk = DIV_ROUND_CLOSEST_ULL(VOP2_MAX_DCLK_RATE * 8, bpc);
 		struct clk *pll_hdmiphy = NULL;
 
-		if (clock <= max_dclk) {
-			drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mask) {
-				struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
+		drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mask) {
+			struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
 
-				if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI0) {
-					pll_hdmiphy = vop2->pll_hdmiphy0;
-					break;
-				}
+			if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI0)
+				pll_hdmiphy = vop2->pll_hdmiphy0;
+			else if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI1)
+				pll_hdmiphy = vop2->pll_hdmiphy1;
+			else
+				continue;
 
-				if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI1) {
-					pll_hdmiphy = vop2->pll_hdmiphy1;
-					break;
-				}
-			}
+			if (pll_hdmiphy && !vop2_hdmi_phy_pll_usable(state, encoder))
+				pll_hdmiphy = NULL;
+
+			break;
 		}
 
 		if (pll_hdmiphy) {

-- 
2.55.0

