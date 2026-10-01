Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98452CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A53A710F529;
	Thu,  1 Oct 2026 01:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Zs4utTKB";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C43410E303
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 01:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790817300;
 bh=DB5PODYXy2kTpjxX6UTzF7oxk3JRTsiShBO+9zBy3Sk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Zs4utTKBVDuyiChnNSINLLgvURyuHzEy7D9SmPF4SXs1EXITeY3M+lb4TBQBkqZUJ
 Wtl4yCc6/FGlJmmYEOsPOb5n8ii3MRnUHFlUzjXI3Jkyeg3lJf0CK4Jqss+md9YIu5
 omy6QcJnIMxQkZHgXfQ/KNHJNF2GzLfLaAYinQNI88NkvUsJ4jnjDp5IwuDafCuvrm
 /SdXYDgSC5BlUx0C/4UU8NEuzItAw9fWUJvMUL34Ln+e8UyQQVXuhEcAmpmaxF7oYY
 R1qbXO9mntYLhs6+aq9W+Q7hGSdfZgUt3CwNzCNGTIs8nZzACNvotR+/r5p7t5gdYh
 GgSDJbA4NwPGg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EB38217E0A27;
 Thu, 01 Oct 2026 03:14:59 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 01 Oct 2026 04:14:34 +0300
Subject: [PATCH 3/8] drm/bridge: ite-it6263: Drop redundant .mode_valid
 hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-bridge-advert-hdmi-caps-v1-3-f8806570e243@collabora.com>
References: <20261001-bridge-advert-hdmi-caps-v1-0-f8806570e243@collabora.com>
In-Reply-To: <20261001-bridge-advert-hdmi-caps-v1-0-f8806570e243@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andy Yan <andy.yan@rock-chips.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
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

Bridges using DRM_BRIDGE_OP_HDMI expect connectors to be created through
drm_bridge_connector_init(), thereby relying on the bridge connector's
.mode_valid hook to invoke drm_hdmi_connector_mode_valid().

The generic helper computes the mode's TMDS character rate and forwards
it to the bridge's .hdmi_tmds_char_rate_valid callback through the
connector HDMI funcs.  This covers exactly what
it6263_bridge_mode_valid() does for 8 bpc RGB444, but due to being
output-format aware, it also handles the validation more thoroughly.

Both the connector and bridge .mode_valid hooks are invoked during
mode validation through drm_mode_validate_pipeline(), so the custom
bridge hook is redundant.  Drop it.

While at it, remove the now-unused drm_hdmi_helper.h include.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/ite-it6263.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index 21ac8e58b9d2..550999491086 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -15,7 +15,6 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
-#include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -669,20 +668,6 @@ static void it6263_bridge_atomic_enable(struct drm_bridge *bridge,
 	regmap_write(regmap, HDMI_REG_PKT_GENERAL_CTRL, ENABLE_PKT | REPEAT_PKT);
 }
 
-static enum drm_mode_status
-it6263_bridge_mode_valid(struct drm_bridge *bridge,
-			 const struct drm_display_info *info,
-			 const struct drm_display_mode *mode)
-{
-	unsigned long long rate;
-
-	rate = drm_hdmi_compute_mode_clock(mode, 8, DRM_OUTPUT_COLOR_FORMAT_RGB444);
-	if (rate == 0)
-		return MODE_NOCLOCK;
-
-	return bridge->funcs->hdmi_tmds_char_rate_valid(bridge, mode, rate);
-}
-
 static int it6263_bridge_attach(struct drm_bridge *bridge,
 				struct drm_encoder *encoder,
 				enum drm_bridge_attach_flags flags)
@@ -831,7 +816,6 @@ static const struct drm_bridge_funcs it6263_bridge_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = it6263_bridge_attach,
-	.mode_valid = it6263_bridge_mode_valid,
 	.atomic_disable = it6263_bridge_atomic_disable,
 	.atomic_enable = it6263_bridge_atomic_enable,
 	.detect = it6263_bridge_detect,

-- 
2.55.0

