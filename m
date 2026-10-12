Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D3DCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE05310F1DB;
	Mon, 12 Oct 2026 15:12:16 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F114C10F1E2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 15:12:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id BAF6E4E411FB;
 Mon, 12 Oct 2026 15:12:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8CDD3601A6;
 Mon, 12 Oct 2026 15:12:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 52BBF11D70CC0; 
 Mon, 12 Oct 2026 17:12:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791817926; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=hsr4q6N64Fcf6mYkwtlmKaY913OD6ROMQBz3nI6nZSA=;
 b=I7a1ficVVdXqQhn4g9Q+0hbsycz4p4gNccwb07fbYPLvJVjsl4tPdCQFTQhWfUqUdYgfgH
 8pmfYdPFIA9HDbXnRaIqxUIjBYSLzUKbycpsFXgHNEQGCOOwnR1KK3ulVffmrFsz00cH85
 RamtkeujxQJSN/PbhNpQvzeYPIaLNwVxudVf93sRRfACKmeY27pzc3qZFu6l7NmYagkefv
 vkvirJ/KB6JrumGCIPAEx5+3JMLY+VgcH8bj8aceXyMrLFHkaSK4GiYqQtBIKtthcOYszI
 hiW5rXs5YiSA2IyyZDL7CHDcDTAR2VmtYGYUT2R60VBQkJoNUfZ971AKINtT0A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 12 Oct 2026 17:11:01 +0200
Subject: [PATCH RFC v3 6/8] drm/bridge: Expose link training state via new
 DRM_BRIDGE_OP_DP flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-feat_link_cap-v3-6-7517f4aba0f3@bootlin.com>
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
In-Reply-To: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Daniel Stone <daniels@collabora.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 Manasi Navare <navaremanasi@google.com>, 
 Drew Davenport <ddavenport@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3
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

Introduce DRM_BRIDGE_OP_DP, a new bridge operation flag for bridges
that provide DisplayPort connector operations with link training support.
Bridges advertising this flag must fill the dp_link_caps field in
struct drm_bridge with their link capabilities.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v3:
- Mone on from drmm_connector_dp_init() to drm_dp_source_set_caps().

Change in v2:
- New patch
---
 drivers/gpu/drm/display/Kconfig                |  1 +
 drivers/gpu/drm/display/drm_bridge_connector.c | 29 ++++++++++++++++++++++++++
 include/drm/drm_bridge.h                       | 13 ++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
index df09cf9a8ca19..ce2f6d62c76d0 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -19,6 +19,7 @@ config DRM_BRIDGE_CONNECTOR
 	select DRM_DISPLAY_HDMI_AUDIO_HELPER
 	select DRM_DISPLAY_HDMI_CEC_HELPER
 	select DRM_DISPLAY_HDMI_STATE_HELPER
+	select DRM_DISPLAY_DP_HELPER
 	help
 	  DRM connector implementation terminating DRM bridge chains.
 
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 81f3e26f6fdf5..5b58e86da6259 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -26,6 +26,7 @@
 #include <drm/display/drm_hdmi_cec_helper.h>
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
+#include <drm/display/drm_dp_helper.h>
 
 /**
  * DOC: overview
@@ -109,6 +110,13 @@ struct drm_bridge_connector {
 	 * HDMI Audio infrastructure, if any (see &DRM_BRIDGE_OP_HDMI_AUDIO).
 	 */
 	struct drm_bridge *bridge_hdmi_audio;
+	/**
+	 * @bridge_dp:
+	 *
+	 * The bridge in the chain that implements necessary support for the
+	 * DisplayPort connector infrastructure, if any (see &DRM_BRIDGE_OP_DP).
+	 */
+	struct drm_bridge *bridge_dp;
 	/**
 	 * @bridge_dp_audio:
 	 *
@@ -835,6 +843,7 @@ static void drm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
 	drm_bridge_put(bridge_connector->bridge_hdmi_audio);
 	drm_bridge_put(bridge_connector->bridge_dp_audio);
 	drm_bridge_put(bridge_connector->bridge_hdmi_cec);
+	drm_bridge_put(bridge_connector->bridge_dp);
 }
 
 /**
@@ -968,6 +977,15 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			bridge_connector->bridge_hdmi_audio = drm_bridge_get(bridge);
 		}
 
+		if (bridge->ops & DRM_BRIDGE_OP_DP) {
+			if (bridge_connector->bridge_dp)
+				return ERR_PTR(-EBUSY);
+			if (!bridge->dp_link_caps)
+				return ERR_PTR(-EINVAL);
+
+			bridge_connector->bridge_dp = drm_bridge_get(bridge);
+		}
+
 		if (bridge->ops & DRM_BRIDGE_OP_DP_AUDIO) {
 			if (bridge_connector->bridge_dp_audio)
 				return ERR_PTR(-EBUSY);
@@ -1079,6 +1097,17 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 					       connector_type, ddc);
 		if (ret)
 			return ERR_PTR(ret);
+	} else if (bridge_connector->bridge_dp) {
+		ret = drmm_connector_init(drm, connector,
+					  &drm_bridge_connector_funcs,
+					  connector_type, ddc);
+		if (ret)
+			return ERR_PTR(ret);
+
+		ret = drm_dp_source_set_caps(connector,
+					     bridge_connector->bridge_dp->dp_link_caps);
+		if (ret)
+			return ERR_PTR(ret);
 	} else {
 		ret = drmm_connector_init(drm, connector,
 					  &drm_bridge_connector_funcs,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 1981d24a700d2..d1430b2b72518 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1021,6 +1021,14 @@ enum drm_bridge_ops {
 	 * &drm_bridge_funcs->hdmi_clear_spd_infoframe callbacks.
 	 */
 	DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME = BIT(10),
+	/**
+	 * @DRM_BRIDGE_OP_DP: The bridge provides DisplayPort connector
+	 * operations, including link training support. Bridges that set
+	 * this flag must provide DisplayPort-related information and
+	 * fill the &drm_bridge->dp_link_caps link training
+	 * capabilities.
+	 */
+	DRM_BRIDGE_OP_DP = BIT(11),
 };
 
 /**
@@ -1214,6 +1222,11 @@ struct drm_bridge {
 	 */
 	void *hpd_data;
 
+	/**
+	 * @dp_link_caps: DisplayPort link capabilities
+	 */
+	const struct drm_connector_dp_link_caps *dp_link_caps;
+
 	/**
 	 * @next_bridge: Pointer to the following bridge, automatically put
 	 * when this bridge is freed (i.e. at destroy time). This is for

-- 
2.43.0

