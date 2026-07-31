Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D07C55174
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8A210F315;
	Fri, 31 Jul 2026 16:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="O0OWg0qf";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D8910F30D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514792;
 bh=7rSZ9gXpFQ7En3lTm1pnNmIcuFb2s4vukUXLVZ8mwlQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=O0OWg0qfNv77GkzxlgnEtfyliP5gCib8NT0g4lJ0AcEpBQCKJHKUP6rrZE2H2/7av
 h7PN4nka0RVATZzhNPic9AuKoubn6+UFw2E/e3jztKrnIkQElRqKIzjmsHUzh2AG4b
 CMld+32ugq/lLVGGsJybBuD0bEJ9LccjuuB6ID9JSQaJ8zvtPmVL8+l5x4B8FDEQAw
 2T4BCTWb69XnL+cPW1EOtUa+9MwkFRTcVwBrkHJCdynEIu805CjlzA6K6oSFBsk3+q
 8CNwe9PO0Z14tUNfFitohpwd9hAih3FUMTt10PmEtQAuAoWdQosvWDSIQzufHipQKc
 kTEK7NDrgi4TA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C8D017E08EB;
 Fri, 31 Jul 2026 18:19:52 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:20:00 +0300
Subject: [PATCH v10 53/69] drm/bridge: lontium-lt9611: Advertise HDMI 1.4
 capabilities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-53-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org
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

Bridges using DRM_BRIDGE_OP_HDMI are expected to provide the supported
HDMI version.  This is not enforced yet, but will become mandatory once
the migration to the caps-based HDMI connector initialization API is
complete.

As LT9611 supposedly cannot drive a TMDS character rate exceeding 297
MHz, advertise HDMI 1.4 as the supported version.  HDMI 1.4 allows up to
340 MHz, so set the bridge's max_tmds_char_rate to ensure the connector
limit derived from supported_hdmi_ver remains within the hardware
capabilities.

drm_bridge_connector_atomic_check() calls
drm_atomic_helper_connector_hdmi_check(), which rejects modes whose
computed TMDS character rate exceeds the connector's max_tmds_char_rate
before invoking the driver's .tmds_char_rate_valid hook.  Since
max_tmds_char_rate now carries the existing effective limit,
lt9611_hdmi_tmds_char_rate_valid() is redundant.  Drop it.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index fb34f661ee0a..f66e3d1b1b57 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/gpio/consumer.h>
+#include <linux/hdmi.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/media-bus-format.h>
@@ -952,18 +953,6 @@ static int lt9611_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
 	return 0;
 }
 
-static enum drm_mode_status
-lt9611_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
-				 const struct drm_display_mode *mode,
-				 unsigned long long tmds_rate)
-{
-	/* 297 MHz for 4k@30 mode */
-	if (tmds_rate > 297000000)
-		return MODE_CLOCK_HIGH;
-
-	return MODE_OK;
-}
-
 static int lt9611_hdmi_audio_startup(struct drm_bridge *bridge,
 				     struct drm_connector *connector)
 {
@@ -1029,7 +1018,6 @@ static const struct drm_bridge_funcs lt9611_bridge_funcs = {
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts = lt9611_atomic_get_input_bus_fmts,
 
-	.hdmi_tmds_char_rate_valid = lt9611_hdmi_tmds_char_rate_valid,
 	.hdmi_write_audio_infoframe = lt9611_hdmi_write_audio_infoframe,
 	.hdmi_clear_audio_infoframe = lt9611_hdmi_clear_audio_infoframe,
 	.hdmi_write_avi_infoframe = lt9611_hdmi_write_avi_infoframe,
@@ -1177,6 +1165,8 @@ static int lt9611_probe(struct i2c_client *client)
 	lt9611->bridge.hdmi_audio_dev = dev;
 	lt9611->bridge.hdmi_audio_max_i2s_playback_channels = 8;
 	lt9611->bridge.hdmi_audio_dai_port = 2;
+	lt9611->bridge.supported_hdmi_ver = HDMI_VERSION_1_4;
+	lt9611->bridge.max_tmds_char_rate = 297000000; /* 297 MHz for 4k@30 mode */
 
 	drm_bridge_add(&lt9611->bridge);
 

-- 
2.55.0

