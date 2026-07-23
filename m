Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CE1C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDEBB10E604;
	Thu, 23 Jul 2026 22:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="E/LCjJAW";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6E110E604
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784845042;
 bh=zvctOOszEPdaW2wvBhmfi5ScnGryQvXn/NEr+72L2Zg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=E/LCjJAWLki7TN7x/69XqHRQiXJ5IBmLBR4+Z37I36E9+sigy0MYZl/nUhzEarjEg
 Vmm4gzbxUXcs4o1LHgNq7Oir6IszqHNGgeFxWiW6VE8wF1PGiLZmjY3FxevZD5ruf+
 N8v6w7zySk4bdRtKp00Ez/4Sp196VffwScJhrChhPgGGdl4cKH4Me6HR3w/EagXnsa
 FWAwm6Fo4XsrYJgo67ACMn7V+R5NyHAOIPPSsE3huOhCxIxUE36RXnInO7lIfCGZ58
 Cl1ZdsNiBtHr0FkrU/IPdStkxPZQvg6G4usDjm//ssCR52IW4u846ACJuNXhcjlOS5
 VhBH6RymdYo2g==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 59FD517E37C2;
 Fri, 24 Jul 2026 00:17:22 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 10E28480030; Fri, 24 Jul 2026 00:17:22 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 24 Jul 2026 00:17:12 +0200
Subject: [PATCH v5 04/15] drm/bridge: synopsys: dw-dp: Move
 dw_dp_bridge_atomic_get_output_bus_fmts()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-synopsys-dw-dp-improvements-v5-4-9445c2e87441@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com>
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4011;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=zvctOOszEPdaW2wvBhmfi5ScnGryQvXn/NEr+72L2Zg=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpikvFUdRiHnaxTGb6g5hJ8ajujy9gTkVhqd
 TmGvJtoPWh1eYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqYpLxAAoJENju1/PI
 O/qaEs0QAIpCDo22gUhHqoyfV8KHh4vutW/9P4VfkDb2QWf/vxLf+zzKEnVTaKIdl0HKWVgTT1D
 VLLNUUXTs5Yf9ZyFiHkDbQOReoVHrfpcto4MUIx7wUEn8fw+/zrBrBGUYmmmc4ev8Ppv2AFEKTK
 Trnxb3OK/RnxLNACWZTgrYU1ENkmjLbgVvdXab1VwJWaeBY07TAUpIKjPH8rZJFQAyxHIUd3kL0
 zQFXBZdE00hfb7YdHEXpe+DT4vb/AXMyUI7C2Tmlj0QfS5pCdf3V9fjCVdgQ8BDhYj7fJHaTtvx
 OdI/YnQYRlMxVYyCXl8uSWIzEBCTj/7No2eSysJZc2GJbCWXs1L9Vmmu2p4D54wMgav9DL+olta
 rwv/7eNLupswfpoTXmttgCHtpISrc5V4d3KScTcJU7M18Rxwe9IBg8Nv6gUyNM1REdsQof8V8JQ
 mLcz11LG/8sufJbc3CVS0DI/uhfr8giTKF1KH9vGD4jr9nF0nn1lmGQjKXrZJRSjUyVt9MReiDn
 ugXzkH1O236rsK6uCdEkqesksZvswckzoayhk2kCAJlXDPsJtPvSBa8Zz7ChK9XdcJ5YTvlqVHw
 H9XUnOJQLY8pRV4HSQaens7/5Wv2f4QsPn4qfB3HZ0hJJm/zVICyxJI3HAIRE34mttFuoi83uIs
 lAioyM9d9S84yHT6juYcljA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

Move dw_dp_bridge_atomic_get_output_bus_fmts() before
dw_dp_bridge_atomic_check() in preparation for reusing it.

No functional change intended.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 96 ++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index b28040d69fab..3dec7777fb28 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1522,6 +1522,54 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
  * 2. the minimum hsync should be 9 pixel;
  * 3. the minimum hbp should be 16 pixel;
  */
+static u32 *dw_dp_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
+						    struct drm_bridge_state *bridge_state,
+						    struct drm_crtc_state *crtc_state,
+						    struct drm_connector_state *conn_state,
+						    unsigned int *num_output_fmts)
+{
+	struct dw_dp *dp = bridge_to_dp(bridge);
+	struct dw_dp_link *link = &dp->link;
+	struct drm_display_info *di = &conn_state->connector->display_info;
+	struct drm_display_mode mode = crtc_state->mode;
+	const struct dw_dp_output_format *fmt;
+	u32 i, j = 0;
+	u32 *output_fmts;
+
+	*num_output_fmts = 0;
+
+	output_fmts = kcalloc(ARRAY_SIZE(dw_dp_output_formats), sizeof(*output_fmts), GFP_KERNEL);
+	if (!output_fmts)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(dw_dp_output_formats); i++) {
+		fmt = &dw_dp_output_formats[i];
+
+		if (fmt->bpc > conn_state->max_bpc)
+			continue;
+
+		if (!(BIT(fmt->color_format) & di->color_formats))
+			continue;
+
+		if (fmt->color_format == DRM_OUTPUT_COLOR_FORMAT_YCBCR420 &&
+		    !link->vsc_sdp_supported)
+			continue;
+
+		if (fmt->color_format != DRM_OUTPUT_COLOR_FORMAT_YCBCR420 &&
+		    drm_mode_is_420_only(di, &mode))
+			continue;
+
+		if (!dw_dp_bandwidth_ok(dp, &mode, fmt->bpp, link->lanes, link->rate))
+			continue;
+
+		output_fmts[j++] = fmt->bus_format;
+	}
+
+	*num_output_fmts = j;
+
+	return output_fmts;
+}
+
 static int dw_dp_bridge_atomic_check(struct drm_bridge *bridge,
 				     struct drm_bridge_state *bridge_state,
 				     struct drm_crtc_state *crtc_state,
@@ -1752,54 +1800,6 @@ static const struct drm_edid *dw_dp_bridge_edid_read(struct drm_bridge *bridge,
 	return edid;
 }
 
-static u32 *dw_dp_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
-						    struct drm_bridge_state *bridge_state,
-						    struct drm_crtc_state *crtc_state,
-						    struct drm_connector_state *conn_state,
-						    unsigned int *num_output_fmts)
-{
-	struct dw_dp *dp = bridge_to_dp(bridge);
-	struct dw_dp_link *link = &dp->link;
-	struct drm_display_info *di = &conn_state->connector->display_info;
-	struct drm_display_mode mode = crtc_state->mode;
-	const struct dw_dp_output_format *fmt;
-	u32 i, j = 0;
-	u32 *output_fmts;
-
-	*num_output_fmts = 0;
-
-	output_fmts = kcalloc(ARRAY_SIZE(dw_dp_output_formats), sizeof(*output_fmts), GFP_KERNEL);
-	if (!output_fmts)
-		return NULL;
-
-	for (i = 0; i < ARRAY_SIZE(dw_dp_output_formats); i++) {
-		fmt = &dw_dp_output_formats[i];
-
-		if (fmt->bpc > conn_state->max_bpc)
-			continue;
-
-		if (!(BIT(fmt->color_format) & di->color_formats))
-			continue;
-
-		if (fmt->color_format == DRM_OUTPUT_COLOR_FORMAT_YCBCR420 &&
-		    !link->vsc_sdp_supported)
-			continue;
-
-		if (fmt->color_format != DRM_OUTPUT_COLOR_FORMAT_YCBCR420 &&
-		    drm_mode_is_420_only(di, &mode))
-			continue;
-
-		if (!dw_dp_bandwidth_ok(dp, &mode, fmt->bpp, link->lanes, link->rate))
-			continue;
-
-		output_fmts[j++] = fmt->bus_format;
-	}
-
-	*num_output_fmts = j;
-
-	return output_fmts;
-}
-
 static struct drm_bridge_state *dw_dp_bridge_atomic_duplicate_state(struct drm_bridge *bridge)
 {
 	struct dw_dp_bridge_state *state;

-- 
2.53.0

