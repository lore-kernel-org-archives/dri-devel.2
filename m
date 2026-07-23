Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB59FC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E6410EF17;
	Thu, 23 Jul 2026 01:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LAkZC9d2";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8291A10E503
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784770511;
 bh=qurORQ6igqDJlK3F/3fKY6xyx3u4PU6ljmbOomijTtA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=LAkZC9d2hEPRI9CEf8cALWSsMXzEoux3qpHktQdDZbXzXKRs+kufX1A4deGEgERAV
 KQVMqFmLm/LFCJx4+6CbFKNaKcgHpXzYnDqskZFsLszMrYBtra4MUIRQ4DH/v2WLg+
 hoGK24JTBZ8fIXacgbHT8EeYEJm1DYgjLo16CmNo8J5ElWYZqzkjCaGUw20f/98RCM
 Vc8Sz1/26tdkq1+PEsZxMR5y+CHM9jFG20phNua5A3kniJ9LLaJ4Q/zmbMDx+siGiy
 P+WK/DHUnAPK+mMwzVvF9N1pkwIG1c6NYSaXE6WBk7ULBLzprM28t377ItUkAptmvj
 LDtQyw4QQvFIw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 25F2817E062C;
 Thu, 23 Jul 2026 03:35:11 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 23 Jul 2026 04:35:02 +0300
Subject: [PATCH v9 13/61] drm/display: bridge_connector: Switch to
 .detect_ctx() connector helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-dw-hdmi-qp-scramb-v9-13-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
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
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 Maud Spierings <maud_spierings@hotmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

Replace the .detect() connector_funcs callback with the atomic-aware
.detect_ctx() connector_helper_funcs hook.

This is preparatory work to allow propagating the modeset acquire
context through drm_atomic_helper_connector_hdmi_hotplug() to the HDMI
connector framework, enabling SCDC state recovery via CRTC reset when
the sink reconnects during an active display pipeline.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>
Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 69 +++++++++++++-------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 8a833c813101..0d44a270b636 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -208,39 +208,6 @@ static void drm_bridge_connector_disable_hpd(struct drm_connector *connector)
  * Bridge Connector Functions
  */
 
-static enum drm_connector_status
-drm_bridge_connector_detect(struct drm_connector *connector, bool force)
-{
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
-	struct drm_bridge *detect = bridge_connector->bridge_detect;
-	struct drm_bridge *hdmi = bridge_connector->bridge_hdmi;
-	enum drm_connector_status status;
-
-	if (detect) {
-		status = detect->funcs->detect(detect, connector);
-
-		if (hdmi)
-			drm_atomic_helper_connector_hdmi_hotplug(connector, status);
-
-		drm_bridge_connector_hpd_notify(connector, status);
-	} else {
-		switch (connector->connector_type) {
-		case DRM_MODE_CONNECTOR_DPI:
-		case DRM_MODE_CONNECTOR_LVDS:
-		case DRM_MODE_CONNECTOR_DSI:
-		case DRM_MODE_CONNECTOR_eDP:
-			status = connector_status_connected;
-			break;
-		default:
-			status = connector_status_unknown;
-			break;
-		}
-	}
-
-	return status;
-}
-
 static void drm_bridge_connector_force(struct drm_connector *connector)
 {
 	struct drm_bridge_connector *bridge_connector =
@@ -307,7 +274,6 @@ drm_bridge_connector_color_format(const struct drm_connector_state *conn_state)
 }
 
 static const struct drm_connector_funcs drm_bridge_connector_funcs = {
-	.detect = drm_bridge_connector_detect,
 	.force = drm_bridge_connector_force,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_create_state = drm_bridge_connector_create_state,
@@ -322,6 +288,40 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
  * Bridge Connector Helper Functions
  */
 
+static int drm_bridge_connector_detect_ctx(struct drm_connector *connector,
+					   struct drm_modeset_acquire_ctx *ctx,
+					   bool force)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *detect = bridge_connector->bridge_detect;
+	struct drm_bridge *hdmi = bridge_connector->bridge_hdmi;
+	enum drm_connector_status status;
+
+	if (detect) {
+		status = detect->funcs->detect(detect, connector);
+
+		if (hdmi)
+			drm_atomic_helper_connector_hdmi_hotplug(connector, status);
+
+		drm_bridge_connector_hpd_notify(connector, status);
+	} else {
+		switch (connector->connector_type) {
+		case DRM_MODE_CONNECTOR_DPI:
+		case DRM_MODE_CONNECTOR_LVDS:
+		case DRM_MODE_CONNECTOR_DSI:
+		case DRM_MODE_CONNECTOR_eDP:
+			status = connector_status_connected;
+			break;
+		default:
+			status = connector_status_unknown;
+			break;
+		}
+	}
+
+	return status;
+}
+
 static int drm_bridge_connector_get_modes_edid(struct drm_connector *connector,
 					       struct drm_bridge *bridge)
 {
@@ -413,6 +413,7 @@ static int drm_bridge_connector_atomic_check(struct drm_connector *connector,
 
 static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs = {
 	.get_modes = drm_bridge_connector_get_modes,
+	.detect_ctx = drm_bridge_connector_detect_ctx,
 	.mode_valid = drm_bridge_connector_mode_valid,
 	.enable_hpd = drm_bridge_connector_enable_hpd,
 	.disable_hpd = drm_bridge_connector_disable_hpd,

-- 
2.55.0

