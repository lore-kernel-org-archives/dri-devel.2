Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A95FCA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9497210E404;
	Thu,  1 Oct 2026 12:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="r80KNzmN";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E6D910E404
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:43:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 638581A24E0;
 Thu,  1 Oct 2026 12:43:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 343EF60341;
 Thu,  1 Oct 2026 12:43:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 484B6103280C2; 
 Thu,  1 Oct 2026 14:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790858626; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=uKuUcofX5/ZyNl98LW21rjHuBTltvMLL1DsGp6AUZAQ=;
 b=r80KNzmNp8jEbtHPvg2txOMWdKfq0sSrS9ipdXjF2s6Npb0+CucV6Ux582/U9iTxQCb4aA
 23WX3vQyGKFjh9CEjQD9imBecUY67gcfo17lyy1Mw7UdyrYRsOH3gGP/v3FDR5wFtMu+EQ
 klZvXK7Uyxw7wOgtdmNTj3F8tYUSELGTdfTURa74zAlXosA+WoGuhbe8ux0U2AZpUXAej6
 wYNGsqYKFtwMyVPB9jfr1YjPHs8LcMults+oY49FOS9sVphdaKfz7Zn/lk3ouTLD5BFEDt
 lzSVlPgTmHeirtKFsSkoOmLNc2wSIU0B2ONjlQi2O2gb58SujQMi4Fo7xBY6Jg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 01 Oct 2026 14:42:33 +0200
Subject: [PATCH RFC v2 11/24] drm/atomic: move
 drm_atomic_helper_disable_all() and drm_atomic_helper_shutdown() from
 drm_atomic_helper to drm_atomic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-drm-bridge-hotplug-v2-11-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
In-Reply-To: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.16.0
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

drm_atomic_helper_shutdown() is needed to support the upcoming DRM bridge
hot-unplug, and will have to be called by the encoder code when a bridge
device is removed in order to detach it from the encoder chain. However
this would create a module dependency loop between the drm module (where
drm_encoder is) and the drm_kms_helper module where
drm_atomic_helper_shutdown() function currently is.

Solve by moving it, along with its callee drm_atomic_helper_disable_all(),
to drm_atomic which is in the drm module. Use identical names except for
dropping the "_atomic" infix, and make the original functions a deprecated
wrapper to the new ones.

No changes to the functions body.

No functional changes except for moving the code to a different module.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_atomic.c        | 115 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_atomic_helper.c |  76 ++----------------------
 include/drm/drm_atomic.h            |   3 +
 3 files changed, 124 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 61fd7f12a474..d39aaa8c9b8d 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -2087,6 +2087,121 @@ int __drm_atomic_helper_set_config(struct drm_mode_set *set,
 }
 EXPORT_SYMBOL(__drm_atomic_helper_set_config);
 
+/**
+ * drm_atomic_disable_all - disable all currently active outputs
+ * @dev: DRM device
+ * @ctx: lock acquisition context
+ *
+ * Loops through all connectors, finding those that aren't turned off and then
+ * turns them off by setting their DPMS mode to OFF and deactivating the CRTC
+ * that they are connected to.
+ *
+ * This is used for example in suspend/resume to disable all currently active
+ * functions when suspending. If you just want to shut down everything at e.g.
+ * driver unload, look at drm_atomic_helper_shutdown().
+ *
+ * Note that if callers haven't already acquired all modeset locks this might
+ * return -EDEADLK, which must be handled by calling drm_modeset_backoff().
+ *
+ * Returns:
+ * 0 on success or a negative error code on failure.
+ *
+ * See also:
+ * drm_atomic_helper_suspend(), drm_atomic_helper_resume() and
+ * drm_atomic_helper_shutdown().
+ */
+int drm_atomic_disable_all(struct drm_device *dev,
+			   struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_atomic_commit *state;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *conn;
+	struct drm_plane_state *plane_state;
+	struct drm_plane *plane;
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+	int ret, i;
+
+	state = drm_atomic_commit_alloc(dev);
+	if (!state)
+		return -ENOMEM;
+
+	state->acquire_ctx = ctx;
+
+	drm_for_each_crtc(crtc, dev) {
+		crtc_state = drm_atomic_get_crtc_state(state, crtc);
+		if (IS_ERR(crtc_state)) {
+			ret = PTR_ERR(crtc_state);
+			goto free;
+		}
+
+		crtc_state->active = false;
+
+		ret = drm_atomic_set_mode_prop_for_crtc(crtc_state, NULL);
+		if (ret < 0)
+			goto free;
+
+		ret = drm_atomic_add_affected_planes(state, crtc);
+		if (ret < 0)
+			goto free;
+
+		ret = drm_atomic_add_affected_connectors(state, crtc);
+		if (ret < 0)
+			goto free;
+	}
+
+	for_each_new_connector_in_state(state, conn, conn_state, i) {
+		ret = drm_atomic_set_crtc_for_connector(conn_state, NULL);
+		if (ret < 0)
+			goto free;
+	}
+
+	for_each_new_plane_in_state(state, plane, plane_state, i) {
+		ret = drm_atomic_set_crtc_for_plane(plane_state, NULL);
+		if (ret < 0)
+			goto free;
+
+		drm_atomic_set_fb_for_plane(plane_state, NULL);
+	}
+
+	ret = drm_atomic_commit(state);
+free:
+	drm_atomic_commit_put(state);
+	return ret;
+}
+EXPORT_SYMBOL(drm_atomic_disable_all);
+
+/**
+ * drm_atomic_shutdown - shutdown all CRTC
+ * @dev: DRM device
+ *
+ * This shuts down all CRTC, which is useful for driver unloading. Shutdown on
+ * suspend should instead be handled with drm_atomic_helper_suspend(), since
+ * that also takes a snapshot of the modeset state to be restored on resume.
+ *
+ * This is just a convenience wrapper around drm_atomic_helper_disable_all(),
+ * and it is the atomic version of drm_helper_force_disable_all().
+ */
+void drm_atomic_shutdown(struct drm_device *dev)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	int ret;
+
+	if (dev == NULL)
+		return;
+
+	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
+
+	ret = drm_atomic_disable_all(dev, &ctx);
+	if (ret)
+		drm_err(dev,
+			"Disabling all crtc's during unload failed with %i\n",
+			ret);
+
+	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
+}
+EXPORT_SYMBOL(drm_atomic_shutdown);
+
 static void drm_atomic_private_obj_print_state(struct drm_printer *p,
 					       const struct drm_private_state *state)
 {
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 9d006f98413a..3b8301a385b5 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3539,6 +3539,8 @@ EXPORT_SYMBOL(drm_atomic_helper_set_config);
  * @dev: DRM device
  * @ctx: lock acquisition context
  *
+ * Deprecated wrapper to drm_atomic_disable_all().
+ *
  * Loops through all connectors, finding those that aren't turned off and then
  * turns them off by setting their DPMS mode to OFF and deactivating the CRTC
  * that they are connected to.
@@ -3560,61 +3562,7 @@ EXPORT_SYMBOL(drm_atomic_helper_set_config);
 int drm_atomic_helper_disable_all(struct drm_device *dev,
 				  struct drm_modeset_acquire_ctx *ctx)
 {
-	struct drm_atomic_commit *state;
-	struct drm_connector_state *conn_state;
-	struct drm_connector *conn;
-	struct drm_plane_state *plane_state;
-	struct drm_plane *plane;
-	struct drm_crtc_state *crtc_state;
-	struct drm_crtc *crtc;
-	int ret, i;
-
-	state = drm_atomic_commit_alloc(dev);
-	if (!state)
-		return -ENOMEM;
-
-	state->acquire_ctx = ctx;
-
-	drm_for_each_crtc(crtc, dev) {
-		crtc_state = drm_atomic_get_crtc_state(state, crtc);
-		if (IS_ERR(crtc_state)) {
-			ret = PTR_ERR(crtc_state);
-			goto free;
-		}
-
-		crtc_state->active = false;
-
-		ret = drm_atomic_set_mode_prop_for_crtc(crtc_state, NULL);
-		if (ret < 0)
-			goto free;
-
-		ret = drm_atomic_add_affected_planes(state, crtc);
-		if (ret < 0)
-			goto free;
-
-		ret = drm_atomic_add_affected_connectors(state, crtc);
-		if (ret < 0)
-			goto free;
-	}
-
-	for_each_new_connector_in_state(state, conn, conn_state, i) {
-		ret = drm_atomic_set_crtc_for_connector(conn_state, NULL);
-		if (ret < 0)
-			goto free;
-	}
-
-	for_each_new_plane_in_state(state, plane, plane_state, i) {
-		ret = drm_atomic_set_crtc_for_plane(plane_state, NULL);
-		if (ret < 0)
-			goto free;
-
-		drm_atomic_set_fb_for_plane(plane_state, NULL);
-	}
-
-	ret = drm_atomic_commit(state);
-free:
-	drm_atomic_commit_put(state);
-	return ret;
+	return drm_atomic_disable_all(dev, ctx);
 }
 EXPORT_SYMBOL(drm_atomic_helper_disable_all);
 
@@ -3670,6 +3618,8 @@ EXPORT_SYMBOL(drm_atomic_helper_reset_crtc);
  * drm_atomic_helper_shutdown - shutdown all CRTC
  * @dev: DRM device
  *
+ * Deprecated wrapper to drm_atomic_shutdown().
+ *
  * This shuts down all CRTC, which is useful for driver unloading. Shutdown on
  * suspend should instead be handled with drm_atomic_helper_suspend(), since
  * that also takes a snapshot of the modeset state to be restored on resume.
@@ -3679,21 +3629,7 @@ EXPORT_SYMBOL(drm_atomic_helper_reset_crtc);
  */
 void drm_atomic_helper_shutdown(struct drm_device *dev)
 {
-	struct drm_modeset_acquire_ctx ctx;
-	int ret;
-
-	if (dev == NULL)
-		return;
-
-	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
-
-	ret = drm_atomic_helper_disable_all(dev, &ctx);
-	if (ret)
-		drm_err(dev,
-			"Disabling all crtc's during unload failed with %i\n",
-			ret);
-
-	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
+	return drm_atomic_shutdown(dev);
 }
 EXPORT_SYMBOL(drm_atomic_helper_shutdown);
 
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 3ae35b09c0cf..aa6de7d959b2 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1409,5 +1409,8 @@ drm_atomic_get_old_bridge_state(const struct drm_atomic_commit *state,
 struct drm_bridge_state *
 drm_atomic_get_new_bridge_state(const struct drm_atomic_commit *state,
 				struct drm_bridge *bridge);
+int drm_atomic_disable_all(struct drm_device *dev,
+			   struct drm_modeset_acquire_ctx *ctx);
+void drm_atomic_shutdown(struct drm_device *dev);
 
 #endif /* DRM_ATOMIC_H_ */

-- 
2.55.0

