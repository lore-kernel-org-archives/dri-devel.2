Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA25FF885C
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 00:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDE110E4D7;
	Sun, 26 Apr 2026 00:20:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="aIwmUvhZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD54610E4D2
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777162828;
 bh=PhCBUZ9LP1QlSA5Vw3scKGIP9YUqVnd7mb1z6jP2Cgg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=aIwmUvhZYNxAN75eBf2UNQliuzeBxHsJEEbVb1RCVGgUbMO9qeL5XU9gid7Qrzye8
 vZkHT8VBBeas2OJ0FZF5CXqEHikha37LCjau4Uc8gcgM/lzXbak/Dj5RcMYSyGhxrw
 /FRaR/J1Tz1PWz7ey2u+rR1LErU2N7UXhaDzJsAMQDAuVnx0eH2lnggmtMYAWrxoEs
 F2vN8moPy3BQJCfofzBJyJ0kPN4vb5gkQUDB8RXZC1gCoRLUTbjbF/6uS/TyPbTvJ3
 gGv9a+cs3ensFHMv7bt5+2UDsBHPF2dbZzL+X9i6tIlbMZINdi0aoxaRSvEWvTHti/
 JG2M/y0yUJqiQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B7BAB17E107E;
 Sun, 26 Apr 2026 02:20:28 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 26 Apr 2026 03:20:14 +0300
Subject: [PATCH v5 02/10] drm/bridge: Add detect_ctx hook and
 drm_bridge_detect_ctx() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-dw-hdmi-qp-scramb-v5-2-d778e70c317b@collabora.com>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
In-Reply-To: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 Maud Spierings <maud_spierings@hotmail.com>
X-Mailer: b4 0.15.1
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

Add an atomic-aware .detect_ctx() callback to drm_bridge_funcs and a
drm_bridge_detect_ctx() helper that accepts an optional
drm_modeset_acquire_ctx.

This enables bridge drivers to perform operations requiring modeset
locking during connector detection, such as SCDC management for HDMI
2.0.  When both ->detect_ctx and ->detect are defined, the former takes
precedence.  When ctx is NULL, locking is managed internally with EDEADLK
retry.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>
Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_bridge.c | 66 ++++++++++++++++++++++++++++++++++++++++----
 include/drm/drm_bridge.h     | 43 +++++++++++++++++++++++++----
 2 files changed, 98 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 986e4c79a4e0..a5c6c2ea4ba6 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1361,9 +1361,9 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_check);
  * @connector: attached connector
  *
  * If the bridge supports output detection, as reported by the
- * DRM_BRIDGE_OP_DETECT bridge ops flag, call &drm_bridge_funcs.detect for the
- * bridge and return the connection status. Otherwise return
- * connector_status_unknown.
+ * DRM_BRIDGE_OP_DETECT bridge ops flag, call &drm_bridge_funcs.detect_ctx
+ * or &drm_bridge_funcs.detect for the bridge and return the connection status.
+ * Otherwise return connector_status_unknown.
  *
  * RETURNS:
  * The detection status on success, or connector_status_unknown if the bridge
@@ -1372,12 +1372,68 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_check);
 enum drm_connector_status
 drm_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
 {
+	return drm_bridge_detect_ctx(bridge, connector, NULL);
+}
+EXPORT_SYMBOL_GPL(drm_bridge_detect);
+
+/**
+ * drm_bridge_detect_ctx - check if anything is attached to the bridge output
+ * @bridge: bridge control structure
+ * @connector: attached connector
+ * @ctx: acquire_ctx, or NULL to let this function handle locking
+ *
+ * If the bridge supports output detection, as reported by the
+ * DRM_BRIDGE_OP_DETECT bridge ops flag, call &drm_bridge_funcs.detect_ctx
+ * or &drm_bridge_funcs.detect for the bridge and return the connection status.
+ * Otherwise return connector_status_unknown.
+ *
+ * RETURNS:
+ * The detection status on success, or connector_status_unknown if the bridge
+ * doesn't support output detection.
+ * If @ctx is set, it might also return -EDEADLK.
+ */
+int drm_bridge_detect_ctx(struct drm_bridge *bridge,
+			  struct drm_connector *connector,
+			  struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_modeset_acquire_ctx br_ctx;
+	int ret;
+
 	if (!(bridge->ops & DRM_BRIDGE_OP_DETECT))
 		return connector_status_unknown;
 
-	return bridge->funcs->detect(bridge, connector);
+	if (!bridge->funcs->detect_ctx)
+		return bridge->funcs->detect(bridge, connector);
+
+	if (ctx) {
+		ret = bridge->funcs->detect_ctx(bridge, connector, ctx);
+		if (ret == -EDEADLK)
+			return ret;
+
+		goto out;
+	}
+
+	drm_modeset_acquire_init(&br_ctx, 0);
+retry:
+	ret = drm_modeset_lock(&connector->dev->mode_config.connection_mutex,
+			       &br_ctx);
+	if (!ret)
+		ret = bridge->funcs->detect_ctx(bridge, connector, &br_ctx);
+
+	if (ret == -EDEADLK) {
+		drm_modeset_backoff(&br_ctx);
+		goto retry;
+	}
+
+	drm_modeset_drop_locks(&br_ctx);
+	drm_modeset_acquire_fini(&br_ctx);
+out:
+	if (WARN_ON(ret < 0))
+		ret = connector_status_unknown;
+
+	return ret;
 }
-EXPORT_SYMBOL_GPL(drm_bridge_detect);
+EXPORT_SYMBOL_GPL(drm_bridge_detect_ctx);
 
 /**
  * drm_bridge_get_modes - fill all modes currently valid for the sink into the
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index d6cd0f5af045..6c751b96c3c9 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -535,10 +535,12 @@ struct drm_bridge_funcs {
 	 *
 	 * Check if anything is attached to the bridge output.
 	 *
-	 * This callback is optional, if not implemented the bridge will be
-	 * considered as always having a component attached to its output.
-	 * Bridges that implement this callback shall set the
-	 * DRM_BRIDGE_OP_DETECT flag in their &drm_bridge->ops.
+	 * This is the non-atomic version of detect_ctx() callback, and is
+	 * optional. If both are implemented, it is ignored. If none is
+	 * implemented, the bridge will be considered as always having a
+	 * component attached to its output. Bridges that implement this
+	 * callback shall set the DRM_BRIDGE_OP_DETECT flag in their
+	 * &drm_bridge->ops.
 	 *
 	 * RETURNS:
 	 *
@@ -547,6 +549,32 @@ struct drm_bridge_funcs {
 	enum drm_connector_status (*detect)(struct drm_bridge *bridge,
 					    struct drm_connector *connector);
 
+	/**
+	 * @detect_ctx:
+	 *
+	 * Check if anything is attached to the bridge output.
+	 *
+	 * This is the atomic version of detect() callback, and is optional.
+	 * If both are implemented, it takes precedence. If none is implemented,
+	 * the bridge will be considered as always having a component attached
+	 * to its output. Bridges that implement this callback shall set the
+	 * DRM_BRIDGE_OP_DETECT flag in their &drm_bridge->ops.
+	 *
+	 * To avoid races against concurrent connector state updates, the
+	 * helper libraries always call this with ctx set to a valid context,
+	 * and &drm_mode_config.connection_mutex will always be locked with
+	 * the ctx parameter set to this ctx. This allows taking additional
+	 * locks as required.
+	 *
+	 * RETURNS:
+	 *
+	 * &drm_connector_status indicating the bridge output status,
+	 * or the error code returned by drm_modeset_lock(), -EDEADLK.
+	 */
+	int (*detect_ctx)(struct drm_bridge *bridge,
+			  struct drm_connector *connector,
+			  struct drm_modeset_acquire_ctx *ctx);
+
 	/**
 	 * @get_modes:
 	 *
@@ -1002,8 +1030,8 @@ struct drm_bridge_timings {
 enum drm_bridge_ops {
 	/**
 	 * @DRM_BRIDGE_OP_DETECT: The bridge can detect displays connected to
-	 * its output. Bridges that set this flag shall implement the
-	 * &drm_bridge_funcs->detect callback.
+	 * its output. Bridges that set this flag shall implement either the
+	 * &drm_bridge_funcs->detect or &drm_bridge_funcs->detect_ctx callbacks.
 	 */
 	DRM_BRIDGE_OP_DETECT = BIT(0),
 	/**
@@ -1565,6 +1593,9 @@ drm_atomic_helper_bridge_propagate_bus_fmt(struct drm_bridge *bridge,
 
 enum drm_connector_status
 drm_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector);
+int drm_bridge_detect_ctx(struct drm_bridge *bridge,
+			  struct drm_connector *connector,
+			  struct drm_modeset_acquire_ctx *ctx);
 int drm_bridge_get_modes(struct drm_bridge *bridge,
 			 struct drm_connector *connector);
 const struct drm_edid *drm_bridge_edid_read(struct drm_bridge *bridge,

-- 
2.53.0

