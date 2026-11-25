Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD65606A33B
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=TZalUQ3S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B82110FB81;
	Wed, 25 Nov 2026 11:22:47 +0000 (UTC)
Received: from mail-m12848.netease.com (mail-m12848.netease.com
 [103.209.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8134510FB75
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:22:21 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55f81607b;
 Wed, 25 Nov 2026 19:22:18 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jingoo Han <jingoohan1@gmail.com>,
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v7 18/20] drm/bridge: analogix_dp: Declare DRM_BRIDGE_OP_HPD
 for hotplug reporting
Date: Wed, 25 Nov 2026 19:21:39 +0800
Message-Id: <20261125112141.1434903-19-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125112141.1434903-1-damon.ding@rock-chips.com>
References: <20261125112141.1434903-1-damon.ding@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa2127132cf03a8kunm17c230507758ef
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGU8aVk0eGklOHxpCTU0fGlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=TZalUQ3SLylho/NRn0MA8P5SySXILCW1Rq8vLSN4l/B1Wykh6kCehnea6h4yOYgJK4mnalmyK1PS1DyKLzsdADTszfoAJ8ALDQ26jaRzdeY6QpGNuaY9HojmTYP+Nj4EvF0cVPLw3qohQv4Q0Z52Tu7Fd34rhvfBfY7wM33i8bo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=1tGFif0lEsOnMlHS24tGcaJgl/1gi5O3vYFmGxpevgI=;
 h=date:mime-version:subject:message-id:from;
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

This commit declares DRM_BRIDGE_OP_HPD for the analogix_dp bridge,
adds the hpd_enable/hpd_disable bridge callbacks and reports the
hotplug events through drm_bridge_hpd_notify() with the status read
from the HPD GPIO pin or the controller registers.

The DRM_BRIDGE_OP_HPD capability is declared only for the platforms
which support hotplug detection (the GPIO HPD mode, or the native HPD
mode on RK3576 and RK3588), since the drm core stops polling the
connector once DRM_BRIDGE_OP_HPD is declared.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v6:
- Declare DRM_BRIDGE_OP_HPD only for the platforms which support
  hotplug detection, since the drm core stops polling the connector
  once DRM_BRIDGE_OP_HPD is declared. (Sashiko)
- Add Tested-by tag.

Changes in v7:
- Set the bridge ops after the chain is attached, as the
  DRM_BRIDGE_OP_HPD declaration previously preceded the
  force_connected_mode initialization, leaving the hotplug detection
  broken on fixed panels with a wired HPD GPIO. (Sashiko)
- Drop the Tested-by tags, as the design of this patch changed
  significantly in this version.
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index cda6e4c5cbc8..7ab183f72eb6 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -31,7 +31,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
-#include <drm/drm_probe_helper.h>
 
 #include <video/of_display_timing.h>
 
@@ -757,9 +756,13 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 		hpd_detected = (irq_type & DP_IRQ_TYPE_HP_CABLE_IN) ||
 			       (irq_type & DP_IRQ_TYPE_HP_CABLE_OUT);
 	if (hpd_detected) {
+		enum drm_connector_status status;
+
 		dev_dbg(dp->dev, "Detected cable status changed!\n");
-		if (dp->drm_dev)
-			drm_helper_hpd_irq_event(dp->drm_dev);
+
+		status = analogix_dp_get_plug_in_status(dp) == 0 ? connector_status_connected :
+								   connector_status_disconnected;
+		drm_bridge_hpd_notify(&dp->bridge, status);
 	}
 
 	if (!dp->hpd_gpiod)
@@ -1293,6 +1296,14 @@ static void analogix_dp_bridge_atomic_post_disable(struct drm_bridge *bridge,
 		DRM_ERROR("Failed to enable psr (%d)\n", ret);
 }
 
+static void analogix_dp_bridge_hpd_enable(struct drm_bridge *bridge)
+{
+}
+
+static void analogix_dp_bridge_hpd_disable(struct drm_bridge *bridge)
+{
+}
+
 static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
@@ -1305,6 +1316,8 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.attach = analogix_dp_bridge_attach,
 	.edid_read = analogix_dp_bridge_edid_read,
 	.detect = analogix_dp_bridge_detect,
+	.hpd_enable = analogix_dp_bridge_hpd_enable,
+	.hpd_disable = analogix_dp_bridge_hpd_disable,
 };
 
 static int analogix_dp_dt_parse_lanes_map(struct analogix_dp_device *dp)
@@ -1633,7 +1646,6 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 		return ret;
 	}
 
-	bridge->ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
 	bridge->of_node = dp->dev->of_node;
 	bridge->type = DRM_MODE_CONNECTOR_eDP;
 	ret = devm_drm_bridge_add(dp->dev, &dp->bridge);
@@ -1646,6 +1658,10 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 		goto err_unregister_aux;
 	}
 
+	bridge->ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
+	if (analogix_dp_supports_hpd(dp))
+		bridge->ops |= DRM_BRIDGE_OP_HPD;
+
 	if (analogix_dp_require_pm_for_hpd_irq(dp)) {
 		ret = pm_runtime_resume_and_get(dp->dev);
 		if (ret)
-- 
2.34.1

