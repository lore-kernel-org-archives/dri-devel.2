Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896AB608363A
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=DeROcM54
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79D110E3F2;
	Thu,  5 Nov 2026 01:01:20 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 329E910E539
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 01:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793840472;
 bh=9ArlfghBrJdwW0nP4zg0k3Av6BQeQyflO3wXjVsY0As=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=DeROcM54jjDIyHjvbYu4F7UIzTzJTZFRckMugNbacLFlEjKtWgRfQdnjv9YINRl5Q
 q82qV2vGy57/LleuqjBLrMCZ6V3FUgZuw56hVyj9d5drP9lGL8mlTvGoYRhtGpBoun
 NckatM3ZmD8wKnGiTGBp1bT/44t3ut3yRL5Vq9nrzwciVjfRVWvxubz2wK4uGUu1Rr
 jULTePNFjgashxm77dFh/Kf+FaHFNzQBtj2SSIssvzRQhRFzV1GCa1F5ezs2yqtK3q
 g/jyZX9NIoK8BiGjpYJks7ED23KisvWlsM7sLB3nKVP19A6IV1+1TrTpdCyMOkGpzs
 nCIT1uAMLAynA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EA80917E0D5D;
 Thu, 05 Nov 2026 02:01:11 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 05 Nov 2026 03:00:42 +0200
Subject: [PATCH v6 08/15] drm/rockchip: vop2: Consolidate HDMI PHY PLL
 clock parent switch
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-dw-hdmi-qp-yuv-v6-8-1bb63ef5766e@collabora.com>
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
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Paunovic <royalnet026@gmail.com>
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

The DCLK parent switch logic for HDMI0 and HDMI1 PHY PLLs was
duplicated, with each endpoint repeating the same clk_get_parent(),
clk_set_parent() and error handling calls.

Refactor this by first selecting the appropriate PHY PLL clock handle
based on the active HDMI endpoint, then performing the parent switch in
a single shared code path.

While at it, retrieve the original DCLK parent at init time, along with
the rest of the clocks, instead of lazily on the first switch to a PHY
PLL.

Tested-by: Igor Paunovic <royalnet026@gmail.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 35 +++++++++++-----------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 98430587a7ab..ab6ced49ae40 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1956,42 +1956,31 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 	if (vop2->pll_hdmiphy0 || vop2->pll_hdmiphy1) {
 		unsigned int bpc = vcstate->output_bpc ?: 8;
 		unsigned long max_dclk = DIV_ROUND_CLOSEST_ULL(VOP2_MAX_DCLK_RATE * 8, bpc);
+		struct clk *pll_hdmiphy = NULL;
 
 		if (clock <= max_dclk) {
 			drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mask) {
 				struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
 
 				if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI0) {
-					if (!vop2->pll_hdmiphy0)
-						break;
-
-					if (!vp->dclk_src)
-						vp->dclk_src = clk_get_parent(vp->dclk);
-
-					ret = clk_set_parent(vp->dclk, vop2->pll_hdmiphy0);
-					if (ret < 0)
-						drm_warn(vop2->drm,
-							 "Could not switch to HDMI0 PHY PLL: %d\n",
-							 ret);
+					pll_hdmiphy = vop2->pll_hdmiphy0;
 					break;
 				}
 
 				if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI1) {
-					if (!vop2->pll_hdmiphy1)
-						break;
-
-					if (!vp->dclk_src)
-						vp->dclk_src = clk_get_parent(vp->dclk);
-
-					ret = clk_set_parent(vp->dclk, vop2->pll_hdmiphy1);
-					if (ret < 0)
-						drm_warn(vop2->drm,
-							 "Could not switch to HDMI1 PHY PLL: %d\n",
-							 ret);
+					pll_hdmiphy = vop2->pll_hdmiphy1;
 					break;
 				}
 			}
 		}
+
+		if (pll_hdmiphy) {
+			ret = clk_set_parent(vp->dclk, pll_hdmiphy);
+			if (ret < 0)
+				drm_warn(vop2->drm,
+					 "Failed to switch DCLK to HDMI PHY PLL: %d\n",
+					 ret);
+		}
 	}
 
 	clk_set_rate(vp->dclk, clock);
@@ -2610,6 +2599,8 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 			return dev_err_probe(drm->dev, PTR_ERR(vp->dclk),
 					     "failed to get %s\n", dclk_name);
 
+		vp->dclk_src = clk_get_parent(vp->dclk);
+
 		vp->dclk_rst = devm_reset_control_get_optional_exclusive(vop2->dev,
 									 dclk_name);
 		if (IS_ERR(vp->dclk_rst))

-- 
2.55.0

