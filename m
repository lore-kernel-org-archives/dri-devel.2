Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B949CCD5BA3
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D62910EC3C;
	Tue, 19 May 2026 10:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="X7ylM8ZD";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4932310EC37
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:39:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 34A1D4E42CF2;
 Tue, 19 May 2026 10:39:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 07FFA606E9;
 Tue, 19 May 2026 10:39:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 35DB2107E8AE7; 
 Tue, 19 May 2026 12:39:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187189; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6aQOHdSM3KvIpT5KF1eIyzfFSNvOiiuZnItO9Aa//vI=;
 b=X7ylM8ZDKA3RRWZIcuK3ejr+oZ7hgl2kFaPk5eT3Vp3IWIkOem9G2KiCWdenRAlrdnZ5ea
 faH1dnSGiUpm5uE2Py5z0l8cCUw81PwaNg+8tzdiol5NRR7iUWHUsKpnXCpe7Qno9FWB/8
 23SK2tLNcNcrWg0wnxZvnbZB66VW0l3/pfMlorN9nLAV7U3p+FxBhmYL5X+p2o7ZosJxA9
 cJJQHNEf7u2lPFVfamlG0c77CkV9tPJk6evHdmXKUs+B73AFsoHQgHxdMpc5O+wf1ZxZtz
 gSwcojU/S6Upt/ipIs/I5RZz6gKs+8FYf0C3DEJt736hIPVqrGQvzYHwiS2JjQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:41 +0200
Subject: [PATCH 24/37] drm/atomic: move drm_atomic_helper_disable_all() and
 drm_atomic_helper_shutdown() from drm_atomic_helper to drm_atomic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-24-45e2bdb3dfb4@bootlin.com>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
In-Reply-To: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.2
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

To support the upcoming DRM bridge hotplug, the drm_bridge.c code will need
to call drm_atomic_helper_shutdown() to disable the pipeline when the tail
bridges of the pipeline are removed without tearing down the card.

However this would create a module dependency loop between the drm module
(where drm_encoder is) and the drm_kms_helper module where
drm_atomic_helper_shutdown() function currently is and which already
depends on the drm module.

Solve by moving drm_atomic_helper_shutdown(), along with its callee
drm_atomic_helper_disable_all(), to drm_atomic which is in the drm
module. Use identical names except for dropping the "_helper" infix, and
make the original functions a deprecated wrapper to the new ones.

No changes to the functions body.

No functional changes except for moving the code to a different module.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_atomic.c        | 115 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_atomic_helper.c |  76 ++----------------------
 include/drm/drm_atomic.h            |   3 +
 3 files changed, 124 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9b2009262c97..7d12c062c16d 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1993,6 +1993,121 @@ int __drm_atomic_helper_set_config(struct drm_mode_set *set,
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
index 51f39edc31ed..afedfab9b568 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3533,6 +3533,8 @@ EXPORT_SYMBOL(drm_atomic_helper_set_config);
  * @dev: DRM device
  * @ctx: lock acquisition context
  *
+ * Deprecated wrapper to drm_atomic_disable_all().
+ *
  * Loops through all connectors, finding those that aren't turned off and then
  * turns them off by setting their DPMS mode to OFF and deactivating the CRTC
  * that they are connected to.
@@ -3554,61 +3556,7 @@ EXPORT_SYMBOL(drm_atomic_helper_set_config);
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
 
@@ -3664,6 +3612,8 @@ EXPORT_SYMBOL(drm_atomic_helper_reset_crtc);
  * drm_atomic_helper_shutdown - shutdown all CRTC
  * @dev: DRM device
  *
+ * Deprecated wrapper to drm_atomic_shutdown().
+ *
  * This shuts down all CRTC, which is useful for driver unloading. Shutdown on
  * suspend should instead be handled with drm_atomic_helper_suspend(), since
  * that also takes a snapshot of the modeset state to be restored on resume.
@@ -3673,21 +3623,7 @@ EXPORT_SYMBOL(drm_atomic_helper_reset_crtc);
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
index 1a80a8cdf269..9eb3d1bfa084 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1373,5 +1373,8 @@ drm_atomic_get_old_bridge_state(const struct drm_atomic_commit *state,
 struct drm_bridge_state *
 drm_atomic_get_new_bridge_state(const struct drm_atomic_commit *state,
 				struct drm_bridge *bridge);
+int drm_atomic_disable_all(struct drm_device *dev,
+			   struct drm_modeset_acquire_ctx *ctx);
+void drm_atomic_shutdown(struct drm_device *dev);
 
 #endif /* DRM_ATOMIC_H_ */

-- 
2.54.0

