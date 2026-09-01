Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B84C624D7
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FEBD10EE71;
	Tue,  1 Sep 2026 18:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="B+Mw67EZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CBBA10EE70
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288681;
 bh=sA9hvcyp15eD/qblsyZ0XpFBugSaj6mhi+/AmnkxIDY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=B+Mw67EZlh2k4ird5z/Fvfoe+jsAcE7xo8k0CMIAPV1DG3G16zhoAUdpeu04kwd2Z
 7zc06iUwpJH3zN6wHRAz6+/nX/VQae1/qIP/Dv0LrIt8DKJODNM5sIgnD8Xy0m66LN
 izwLdoOs3z7v4acShiKNt2peklLdaSvfa36CAM+nrUd8EL14SxqR1QYJLl9s3lZolV
 4WAOwDhaheVmD3bHgS+kQSIlZXsGu7hoJ4wMbgQIZ0QNhJsOLnCQnwvaY90cWQ5dkR
 PA+xv//PskVss96Dq7XKVaZK+EA56p0AL6c8BVPwA0m79eYHVSopP1j8APQrJylRGC
 u92CNBhg4D5ig==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CFE6617E3C80;
 Tue, 01 Sep 2026 20:51:20 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:18 +0300
Subject: [PATCH v11 54/74] drm/bridge: ite-it66121: Advertise HDMI 1.2
 capabilities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-54-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org
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

Bridges using DRM_BRIDGE_OP_HDMI are now expected to also provide a
supported HDMI version.  This is not yet enforced, but will become
mandatory once the migration to the new caps-based HDMI connector
initialization API is completed.

Since none of the chip variants handled by the driver can drive a TMDS
character rate exceeding 148.5 MHz, advertise HDMI 1.2 as the supported
version.  HDMI 1.2 allows up to 165 MHz, so set the bridge's
max_tmds_char_rate to ensure the connector limit derived from
supported_hdmi_ver remains within the hardware capabilities.

drm_bridge_connector_atomic_check() runs
drm_atomic_helper_connector_hdmi_check(), which rejects modes whose
computed TMDS character rate exceeds the connector limit before invoking
the driver's .tmds_char_rate_valid() hook, making the max_rate check in
it66121_bridge_hdmi_tmds_char_rate_valid() redundant.  Drop it.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 51fc68ffdf8f..c8d0a26e8e90 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -10,6 +10,7 @@
 #include <linux/media-bus-format.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/hdmi.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/bitfield.h>
@@ -867,15 +868,6 @@ it66121_bridge_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
 					 const struct drm_display_mode *mode,
 					 unsigned long long tmds_rate)
 {
-	const struct it66121_ctx *ctx =
-		container_of(bridge, const struct it66121_ctx, bridge);
-	unsigned long long max_rate;
-
-	max_rate = (ctx->bus_width == 12) ? 74250000ULL : 148500000ULL;
-
-	if (tmds_rate > max_rate)
-		return MODE_CLOCK_HIGH;
-
 	if (tmds_rate < HDMI_TMDS_CHAR_RATE_MIN_HZ)
 		return MODE_CLOCK_LOW;
 
@@ -1670,6 +1662,9 @@ static int it66121_probe(struct i2c_client *client)
 			  DRM_BRIDGE_OP_HDMI;
 	ctx->bridge.vendor = "ITE";
 	ctx->bridge.product = "IT66121";
+	ctx->bridge.supported_hdmi_ver = HDMI_VERSION_1_2;
+	ctx->bridge.max_tmds_char_rate = ctx->bus_width == 12 ? 74250000ULL : 148500000ULL;
+
 	if (client->irq > 0) {
 		ctx->bridge.ops |= DRM_BRIDGE_OP_HPD;
 

-- 
2.55.0

