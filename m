Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE6AC55175
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899F110F33F;
	Fri, 31 Jul 2026 16:23:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="npjc/afz";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019D510F30D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514791;
 bh=9ULxXAJ8Lgf9TVfLmpWCFcvW40GpvaJh+iJkfEerDYw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=npjc/afzI1OKbdV8DaRoeSuQGdPdtk/hQu4jEuEIPOBbhn+x86LnZwE528j0ygFU8
 Bx90AUdWUC4HobXzn3dHl+GGMsH4/lUljY4VPMgdqL/rIADssmyl10AIugYIzjODUZ
 8CLYEHw06brO/ZaVKnH4EnPfNVrwd3GC3JLiKHEWCmrmOlJ6ZtOfcC7ED5bE3okYRr
 4kjWBQqi00ieV71cwrV5zPGqu8xFHNLOTxrFZ3WNn3w3fHo0yt8Fv5W2jFmENMoEWM
 mkxJcbTOsd1gWwwdJHeFPzfnOAiLRQjh+ohWR+8g4M6qtTiqPvkVzOwKcDL8YSw5gL
 PeCDoP7Os5L9w==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 258D717E0998;
 Fri, 31 Jul 2026 18:19:51 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:19:58 +0300
Subject: [PATCH v10 51/69] drm/bridge: ite-it6263: Advertise HDMI 1.3
 capabilities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-51-294364b2cf15@collabora.com>
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

Advertise HDMI 1.3 support for IT6263, covering the 225 MHz TMDS
character rate currently documented by the driver, which is within the
HDMI 1.3 limit of 340 MHz.  Additionally, keep the stricter 150 MHz
effective mode limit by setting max_tmds_char_rate from
MAX_PIXEL_CLOCK_KHZ.

The existing .hdmi_tmds_char_rate_valid() hook checks both the pixel
clock and TMDS character rate.  Since the bridge only supports 8 bpc
RGB444, these are equivalent for supported modes, making the 225 MHz
TMDS rate check unreachable once the 150 MHz pixel-clock limit is
applied.

drm_bridge_connector_atomic_check() invokes
drm_atomic_helper_connector_hdmi_check(), which rejects modes whose
computed TMDS character rate exceeds the connector's max_tmds_char_rate
before invoking the driver's .tmds_char_rate_valid hook.  Since
max_tmds_char_rate now carries the existing effective limit,
it6263_hdmi_tmds_char_rate_valid() is redundant.  Drop it.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/ite-it6263.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index 550999491086..e8e0197171e1 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -738,20 +738,6 @@ it6263_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
-static enum drm_mode_status
-it6263_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
-				 const struct drm_display_mode *mode,
-				 unsigned long long tmds_rate)
-{
-	if (mode->clock > MAX_PIXEL_CLOCK_KHZ)
-		return MODE_CLOCK_HIGH;
-
-	if (tmds_rate > MAX_HDMI_TMDS_CHAR_RATE_HZ)
-		return MODE_CLOCK_HIGH;
-
-	return MODE_OK;
-}
-
 static int it6263_hdmi_clear_avi_infoframe(struct drm_bridge *bridge)
 {
 	struct it6263 *it = bridge_to_it6263(bridge);
@@ -821,7 +807,6 @@ static const struct drm_bridge_funcs it6263_bridge_funcs = {
 	.detect = it6263_bridge_detect,
 	.edid_read = it6263_bridge_edid_read,
 	.atomic_get_input_bus_fmts = it6263_bridge_atomic_get_input_bus_fmts,
-	.hdmi_tmds_char_rate_valid = it6263_hdmi_tmds_char_rate_valid,
 	.hdmi_clear_avi_infoframe = it6263_hdmi_clear_avi_infoframe,
 	.hdmi_write_avi_infoframe = it6263_hdmi_write_avi_infoframe,
 	.hdmi_clear_hdmi_infoframe = it6263_hdmi_clear_hdmi_infoframe,
@@ -883,6 +868,8 @@ static int it6263_probe(struct i2c_client *client)
 	it->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	it->bridge.vendor = "ITE";
 	it->bridge.product = "IT6263";
+	it->bridge.supported_hdmi_ver = HDMI_VERSION_1_3;
+	it->bridge.max_tmds_char_rate = 1000ULL * MAX_PIXEL_CLOCK_KHZ;
 
 	return devm_drm_bridge_add(dev, &it->bridge);
 }

-- 
2.55.0

