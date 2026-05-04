Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D41FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 20:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B03B10E013;
	Mon,  4 May 2026 20:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hdIVqGlD";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 472F710E3AD
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1777925483; bh=wPMBVFwRIRSbcXggzPj66q6ILg3rZ1uUdNpLeXq9w7g=;
 b=hdIVqGlDfdCkj4u5t1u6cD6c+rnSzC3rogP36PNdJeR7c8FFyaGtlBsi2tljlrZYzaqm2+1Yb
 v4KtmDHyFvWBjAnD85FZoevVG0kaW6oXdgY4sYvoUjf+hq8JZJdULGAXT18UZFIUHmttfXwhEwK
 qHSmjwjWUWH49OfLJFMyf46sxrWOsFGg1vINVuslnX5wF5JLwNkz9RWF7D09Ea91JJLM+YP12ib
 WxXH/gwhSsgNpZDGjCH0iLRr5d641UoDZDUvpn/yvqYRn58d5b6DcVMI2es+SurM0NX87hfY/B3
 k36CWClQhwQOOPbUyfpEWHMXi0rOEaEO2mkMBQcW24Ag==
X-Forward-Email-ID: 69f8ef7b04bb1dff846bb964
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.7.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Liu Ying <victor.liu@nxp.com>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@kernel.org>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/17] drm: bridge: dw_hdmi: Use generic CEC notifier
 helpers
Date: Mon,  4 May 2026 19:10:49 +0000
Message-ID: <20260504191059.275928-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504191059.275928-1-jonas@kwiboo.se>
References: <20260504191059.275928-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The commit 8b1a8f8b2002 ("drm/display: add CEC helpers code") added
generic CEC helpers to be used by HDMI drivers.

Replace the open-coded CEC notifier handling with use of the generic CEC
notifier helpers. Ensure DRM_DISPLAY_HDMI_CEC_NOTIFIER_HELPER is also
selected when DRM_DW_HDMI_CEC is enabled so that the CEC helpers is
available.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v4: New patch
---
 drivers/gpu/drm/bridge/synopsys/Kconfig   |  1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 32 ++++-------------------
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
index a46df7583bcf..e6723af03b43 100644
--- a/drivers/gpu/drm/bridge/synopsys/Kconfig
+++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
@@ -49,6 +49,7 @@ config DRM_DW_HDMI_CEC
 	depends on DRM_DW_HDMI
 	select CEC_CORE
 	select CEC_NOTIFIER
+	select DRM_DISPLAY_HDMI_CEC_NOTIFIER_HELPER
 	help
 	  Support the CE interface which is part of the Synopsys
 	  Designware HDMI block.
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 4c712aa07a89..0aa29b92327e 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -23,12 +23,11 @@
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
 
-#include <media/cec-notifier.h>
-
 #include <linux/media-bus-format.h>
 #include <linux/videodev2.h>
 
 #include <drm/bridge/dw_hdmi.h>
+#include <drm/display/drm_hdmi_cec_helper.h>
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_scdc_helper.h>
 #include <drm/drm_atomic.h>
@@ -183,8 +182,6 @@ struct dw_hdmi {
 	void (*enable_audio)(struct dw_hdmi *hdmi);
 	void (*disable_audio)(struct dw_hdmi *hdmi);
 
-	struct cec_notifier *cec_notifier;
-
 	hdmi_codec_plugged_cb plugged_cb;
 	struct device *codec_dev;
 	enum drm_connector_status last_connector_result;
@@ -2453,7 +2450,7 @@ dw_hdmi_connector_status_update(struct drm_connector *connector,
 
 	if (status == connector_status_disconnected) {
 		drm_edid_connector_update(connector, NULL);
-		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
+		drm_connector_cec_phys_addr_invalidate(connector);
 		return;
 	}
 
@@ -2462,8 +2459,7 @@ dw_hdmi_connector_status_update(struct drm_connector *connector,
 	drm_edid_free(drm_edid);
 
 	if (status == connector_status_connected)
-		cec_notifier_set_phys_addr(hdmi->cec_notifier,
-				connector->display_info.source_physical_address);
+		drm_connector_cec_phys_addr_set(connector);
 }
 
 static enum drm_connector_status
@@ -2539,8 +2535,6 @@ static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs =
 static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
 {
 	struct drm_connector *connector = &hdmi->connector;
-	struct cec_connector_info conn_info;
-	struct cec_notifier *notifier;
 
 	if (hdmi->version >= 0x200a)
 		connector->ycbcr_420_allowed =
@@ -2571,15 +2565,8 @@ static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
 
 	drm_connector_attach_encoder(connector, hdmi->bridge.encoder);
 
-	cec_fill_conn_info_from_drm(&conn_info, connector);
-
-	notifier = cec_notifier_conn_register(hdmi->dev, NULL, &conn_info);
-	if (!notifier)
-		return -ENOMEM;
-
-	hdmi->cec_notifier = notifier;
-
-	return 0;
+	return drmm_connector_hdmi_cec_notifier_register(connector, NULL,
+							 hdmi->dev);
 }
 
 /* -----------------------------------------------------------------------------
@@ -2887,14 +2874,6 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge,
 	return dw_hdmi_connector_create(hdmi);
 }
 
-static void dw_hdmi_bridge_detach(struct drm_bridge *bridge)
-{
-	struct dw_hdmi *hdmi = bridge->driver_private;
-
-	cec_notifier_conn_unregister(hdmi->cec_notifier);
-	hdmi->cec_notifier = NULL;
-}
-
 static enum drm_mode_status
 dw_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
 			  const struct drm_display_info *info,
@@ -2972,7 +2951,6 @@ static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.attach = dw_hdmi_bridge_attach,
-	.detach = dw_hdmi_bridge_detach,
 	.atomic_check = dw_hdmi_bridge_atomic_check,
 	.atomic_get_output_bus_fmts = dw_hdmi_bridge_atomic_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = dw_hdmi_bridge_atomic_get_input_bus_fmts,
-- 
2.54.0

