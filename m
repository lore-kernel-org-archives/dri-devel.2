Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4286FF8850
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 00:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F2710F714;
	Sat, 25 Apr 2026 00:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=packett.cool header.i=@packett.cool header.b="ULNgjlOC";
	dkim-atps=neutral
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [95.215.58.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C65410F716
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 00:18:33 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
 s=key1; t=1777075967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RlZ2+o4N3DW64rpTAcscHpZRsMpbmPMRUTMRbjJ/4OM=;
 b=ULNgjlOCZbMegD1R1RlfNPPJxglnua11FS6fr5KwQqHdLns6HHyD6HDLRiWpbyg/4Ria+f
 gVTTRONjdpxKfDgM2foLeXfT5yXnY43z+K6WUbpuUIKJEzmirEf9ELLuQ9qhMBH5ENCzPM
 +ZRQvFVUYC/5Mm+XrCB8eX3OJrcqumbIBNILJ25QWFsNtvq+2Hadm5XhFSKKxFYjQa4XuT
 WdTXcx8+tQkd0qhKbJUPYf504+1x/PEZxC1lzdAtLT913upju5EZvBWG9iIJkpfiyMFtd2
 JlcUxOT17XYVkwDVgmPy31F1csb8PBtQ9SKo340S727cgNP1SS9RIsZtKh+QIg==
From: Val Packett <val@packett.cool>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/panel: Add atomic versions of panel ops
Date: Fri, 24 Apr 2026 20:49:50 -0300
Message-ID: <20260425001130.233935-1-val@packett.cool>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Modern DSI panels support various modes (resolutions and refresh rates),
which usually requires sending mode-specific DCS commands to configure the
DDIC during operations like prepare(). However existing drm_panel_funcs
only take the panel itself as an argument, so there's no way to access
relevant state (such as the mode being set) inside of these functions.

To allow panel drivers access to the state, introduce new atomic_*
versions of the prepare/enable/disable/unprepare ops, and make the
corresponding drm_panel_* functions call them if available, falling back
to the original ops otherwise. To avoid the need to modify all consumers
at once, the original single-argument drm_panel_* functions are redefined
as aliases to the new ones, passing NULLs for the new extra arguments.

The atomic ops pass the CRTC as well as the atomic state because getting
the mode being set is part of per-CRTC state.

Signed-off-by: Val Packett <val@packett.cool>
---

As discussed in my recent RFC [1] and an older thread I was pointed to
there [2], the right way to expose the mode to panel drivers is to expose
the entire atomic state and let them find the mode there. (Turns out,
the drm_crtc must also be passed along with the state as it's necessary
for drm_atomic_get_new_crtc_state).

Hopefully this first "real" attempt is close enough! :)

I have tested this with the WIP nt37701 driver from the linked RFC,
only slightly updated to receive the new args and not directly the mode.

[1]: https://lore.kernel.org/all/20260412113851.355944-1-val@packett.cool/
[2]: https://lore.kernel.org/dri-devel/nfc6ih43gjpi5u67fpkkxgwwygv53grdldq7tfp5iiukrkiy2u@53fsrtezzkyt/

Thanks,
~val

---
 drivers/gpu/drm/drm_panel.c |  88 +++++++++++++++--------
 include/drm/drm_panel.h     | 137 ++++++++++++++++++++++++++++++++++--
 2 files changed, 193 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index d1e6598ea3bc..48fce5e89bca 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -102,16 +102,20 @@ void drm_panel_remove(struct drm_panel *panel)
 EXPORT_SYMBOL(drm_panel_remove);
 
 /**
- * drm_panel_prepare - power on a panel
+ * drm_panel_atomic_prepare - power on a panel
  * @panel: DRM panel
+ * @crtc: the CRTC used to drive the panel, may be NULL
+ * @state: current atomic commit state, may be NULL
  *
  * Calling this function will enable power and deassert any reset signals to
  * the panel. After this has completed it is possible to communicate with any
  * integrated circuitry via a command bus. This function cannot fail (as it is
  * called from the pre_enable call chain). There will always be a call to
- * drm_panel_disable() afterwards.
+ * drm_panel_atomic_disable() afterwards.
  */
-void drm_panel_prepare(struct drm_panel *panel)
+void drm_panel_atomic_prepare(struct drm_panel *panel,
+			      struct drm_crtc *crtc,
+			      struct drm_atomic_state *state)
 {
 	struct drm_panel_follower *follower;
 	int ret;
@@ -126,11 +130,15 @@ void drm_panel_prepare(struct drm_panel *panel)
 
 	mutex_lock(&panel->follower_lock);
 
-	if (panel->funcs && panel->funcs->prepare) {
+	if (panel->funcs && panel->funcs->atomic_prepare) {
+		ret = panel->funcs->atomic_prepare(panel, crtc, state);
+	} else if (panel->funcs && panel->funcs->prepare) {
 		ret = panel->funcs->prepare(panel);
-		if (ret < 0)
-			goto exit;
+	} else {
+		ret = 0;
 	}
+	if (ret < 0)
+		goto exit;
 	panel->prepared = true;
 
 	list_for_each_entry(follower, &panel->followers, list) {
@@ -146,18 +154,22 @@ void drm_panel_prepare(struct drm_panel *panel)
 exit:
 	mutex_unlock(&panel->follower_lock);
 }
-EXPORT_SYMBOL(drm_panel_prepare);
+EXPORT_SYMBOL(drm_panel_atomic_prepare);
 
 /**
- * drm_panel_unprepare - power off a panel
+ * drm_panel_atomic_unprepare - power off a panel
  * @panel: DRM panel
+ * @crtc: the CRTC used to drive the panel, may be NULL
+ * @state: current atomic commit state, may be NULL
  *
  * Calling this function will completely power off a panel (assert the panel's
  * reset, turn off power supplies, ...). After this function has completed, it
  * is usually no longer possible to communicate with the panel until another
- * call to drm_panel_prepare().
+ * call to drm_panel_atomic_prepare().
  */
-void drm_panel_unprepare(struct drm_panel *panel)
+void drm_panel_atomic_unprepare(struct drm_panel *panel,
+				struct drm_crtc *crtc,
+				struct drm_atomic_state *state)
 {
 	struct drm_panel_follower *follower;
 	int ret;
@@ -191,29 +203,37 @@ void drm_panel_unprepare(struct drm_panel *panel)
 				 follower->funcs->panel_unpreparing, ret);
 	}
 
-	if (panel->funcs && panel->funcs->unprepare) {
+	if (panel->funcs && panel->funcs->atomic_unprepare) {
+		ret = panel->funcs->atomic_unprepare(panel, crtc, state);
+	} else if (panel->funcs && panel->funcs->unprepare) {
 		ret = panel->funcs->unprepare(panel);
-		if (ret < 0)
-			goto exit;
+	} else {
+		ret = 0;
 	}
+	if (ret < 0)
+		goto exit;
 	panel->prepared = false;
 
 exit:
 	mutex_unlock(&panel->follower_lock);
 }
-EXPORT_SYMBOL(drm_panel_unprepare);
+EXPORT_SYMBOL(drm_panel_atomic_unprepare);
 
 /**
- * drm_panel_enable - enable a panel
+ * drm_panel_atomic_enable - enable a panel
  * @panel: DRM panel
+ * @crtc: the CRTC used to drive the panel, may be NULL
+ * @state: current atomic commit state, may be NULL
  *
  * Calling this function will cause the panel display drivers to be turned on
  * and the backlight to be enabled. Content will be visible on screen after
  * this call completes. This function cannot fail (as it is called from the
- * enable call chain). There will always be a call to drm_panel_disable()
- * afterwards.
+ * enable call chain). There will always be a call to
+ * drm_panel_atomic_disable() afterwards.
  */
-void drm_panel_enable(struct drm_panel *panel)
+void drm_panel_atomic_enable(struct drm_panel *panel,
+			     struct drm_crtc *crtc,
+			     struct drm_atomic_state *state)
 {
 	struct drm_panel_follower *follower;
 	int ret;
@@ -228,11 +248,15 @@ void drm_panel_enable(struct drm_panel *panel)
 
 	mutex_lock(&panel->follower_lock);
 
-	if (panel->funcs && panel->funcs->enable) {
+	if (panel->funcs && panel->funcs->atomic_enable) {
+		ret = panel->funcs->atomic_enable(panel, crtc, state);
+	} else if (panel->funcs && panel->funcs->enable) {
 		ret = panel->funcs->enable(panel);
-		if (ret < 0)
-			goto exit;
+	} else {
+		ret = 0;
 	}
+	if (ret < 0)
+		goto exit;
 	panel->enabled = true;
 
 	ret = backlight_enable(panel->backlight);
@@ -253,17 +277,21 @@ void drm_panel_enable(struct drm_panel *panel)
 exit:
 	mutex_unlock(&panel->follower_lock);
 }
-EXPORT_SYMBOL(drm_panel_enable);
+EXPORT_SYMBOL(drm_panel_atomic_enable);
 
 /**
- * drm_panel_disable - disable a panel
+ * drm_panel_atomic_disable - disable a panel
  * @panel: DRM panel
+ * @crtc: the CRTC used to drive the panel, may be NULL
+ * @state: current atomic commit state, may be NULL
  *
  * This will typically turn off the panel's backlight or disable the display
  * drivers. For smart panels it should still be possible to communicate with
  * the integrated circuitry via any command bus after this call.
  */
-void drm_panel_disable(struct drm_panel *panel)
+void drm_panel_atomic_disable(struct drm_panel *panel,
+			      struct drm_crtc *crtc,
+			      struct drm_atomic_state *state)
 {
 	struct drm_panel_follower *follower;
 	int ret;
@@ -302,17 +330,21 @@ void drm_panel_disable(struct drm_panel *panel)
 		DRM_DEV_INFO(panel->dev, "failed to disable backlight: %d\n",
 			     ret);
 
-	if (panel->funcs && panel->funcs->disable) {
+	if (panel->funcs && panel->funcs->atomic_disable) {
+		ret = panel->funcs->atomic_disable(panel, crtc, state);
+	} else if (panel->funcs && panel->funcs->disable) {
 		ret = panel->funcs->disable(panel);
-		if (ret < 0)
-			goto exit;
+	} else {
+		ret = 0;
 	}
+	if (ret < 0)
+		goto exit;
 	panel->enabled = false;
 
 exit:
 	mutex_unlock(&panel->follower_lock);
 }
-EXPORT_SYMBOL(drm_panel_disable);
+EXPORT_SYMBOL(drm_panel_atomic_disable);
 
 /**
  * drm_panel_get_modes - probe the available display modes of a panel
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 2407bfa60236..696df57cdd37 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -33,7 +33,9 @@
 struct backlight_device;
 struct dentry;
 struct device_node;
+struct drm_atomic_state;
 struct drm_connector;
+struct drm_crtc;
 struct drm_panel_follower;
 struct drm_panel;
 struct display_timing;
@@ -80,6 +82,19 @@ struct drm_panel_funcs {
 	 */
 	int (*prepare)(struct drm_panel *panel);
 
+	/**
+	 * @atomic_prepare:
+	 *
+	 * Turn on panel and perform setup with access to atomic commit state.
+	 * Consumers will prefer this function over @prepare if both are provided.
+	 * The state may be NULL due to the caller not being aware of it.
+	 *
+	 * This function is optional.
+	 */
+	int (*atomic_prepare)(struct drm_panel *panel,
+			      struct drm_crtc *crtc,
+			      struct drm_atomic_state *state);
+
 	/**
 	 * @enable:
 	 *
@@ -89,6 +104,19 @@ struct drm_panel_funcs {
 	 */
 	int (*enable)(struct drm_panel *panel);
 
+	/**
+	 * @atomic_enable:
+	 *
+	 * Enable panel (turn on backlight, etc.) with access to atomic commit state.
+	 * Consumers will prefer this function over @enable if both are provided.
+	 * The state may be NULL due to the caller not being aware of it.
+	 *
+	 * This function is optional.
+	 */
+	int (*atomic_enable)(struct drm_panel *panel,
+			     struct drm_crtc *crtc,
+			     struct drm_atomic_state *state);
+
 	/**
 	 * @disable:
 	 *
@@ -98,6 +126,19 @@ struct drm_panel_funcs {
 	 */
 	int (*disable)(struct drm_panel *panel);
 
+	/**
+	 * @atomic_disable:
+	 *
+	 * Disable panel (turn off backlight, etc.) with access to atomic commit state.
+	 * Consumers will prefer this function over @disable if both are provided.
+	 * The state may be NULL due to the caller not being aware of it.
+	 *
+	 * This function is optional.
+	 */
+	int (*atomic_disable)(struct drm_panel *panel,
+			      struct drm_crtc *crtc,
+			      struct drm_atomic_state *state);
+
 	/**
 	 * @unprepare:
 	 *
@@ -107,6 +148,19 @@ struct drm_panel_funcs {
 	 */
 	int (*unprepare)(struct drm_panel *panel);
 
+	/**
+	 * @atomic_unprepare:
+	 *
+	 * Turn off panel with access to atomic commit state.
+	 * Consumers will prefer this function over @unprepare if both are provided.
+	 * The state may be NULL due to the caller not being aware of it.
+	 *
+	 * This function is optional.
+	 */
+	int (*atomic_unprepare)(struct drm_panel *panel,
+			        struct drm_crtc *crtc,
+			        struct drm_atomic_state *state);
+
 	/**
 	 * @get_modes:
 	 *
@@ -330,11 +384,86 @@ void drm_panel_put(struct drm_panel *panel);
 void drm_panel_add(struct drm_panel *panel);
 void drm_panel_remove(struct drm_panel *panel);
 
-void drm_panel_prepare(struct drm_panel *panel);
-void drm_panel_unprepare(struct drm_panel *panel);
+void drm_panel_atomic_prepare(struct drm_panel *panel,
+			      struct drm_crtc *crtc,
+			      struct drm_atomic_state *state);
 
-void drm_panel_enable(struct drm_panel *panel);
-void drm_panel_disable(struct drm_panel *panel);
+/**
+ * drm_panel_prepare - power on a panel
+ * @panel: DRM panel
+ *
+ * Calling this function will enable power and deassert any reset signals to
+ * the panel. After this has completed it is possible to communicate with any
+ * integrated circuitry via a command bus. This function cannot fail (as it is
+ * called from the pre_enable call chain). There will always be a call to
+ * drm_panel_disable() afterwards.
+ *
+ * If atomic commit state is available, call drm_panel_atomic_prepare instead.
+ */
+static inline void drm_panel_prepare(struct drm_panel *panel)
+{
+	drm_panel_atomic_prepare(panel, NULL, NULL);
+}
+
+void drm_panel_atomic_unprepare(struct drm_panel *panel,
+				struct drm_crtc *crtc,
+				struct drm_atomic_state *state);
+
+/**
+ * drm_panel_unprepare - power off a panel
+ * @panel: DRM panel
+ *
+ * Calling this function will completely power off a panel (assert the panel's
+ * reset, turn off power supplies, ...). After this function has completed, it
+ * is usually no longer possible to communicate with the panel until another
+ * call to drm_panel_prepare().
+ *
+ * If atomic commit state is available, call drm_panel_atomic_unprepare instead.
+ */
+static inline void drm_panel_unprepare(struct drm_panel *panel)
+{
+	drm_panel_atomic_unprepare(panel, NULL, NULL);
+}
+
+void drm_panel_atomic_enable(struct drm_panel *panel,
+			     struct drm_crtc *crtc,
+			     struct drm_atomic_state *state);
+
+/**
+ * drm_panel_enable - enable a panel
+ * @panel: DRM panel
+ *
+ * Calling this function will cause the panel display drivers to be turned on
+ * and the backlight to be enabled. Content will be visible on screen after
+ * this call completes. This function cannot fail (as it is called from the
+ * enable call chain). There will always be a call to drm_panel_disable()
+ * afterwards.
+ *
+ * If atomic commit state is available, call drm_panel_atomic_enable instead.
+ */
+static inline void drm_panel_enable(struct drm_panel *panel)
+{
+	drm_panel_atomic_enable(panel, NULL, NULL);
+}
+
+void drm_panel_atomic_disable(struct drm_panel *panel,
+			      struct drm_crtc *crtc,
+			      struct drm_atomic_state *state);
+
+/**
+ * drm_panel_disable - disable a panel
+ * @panel: DRM panel
+ *
+ * This will typically turn off the panel's backlight or disable the display
+ * drivers. For smart panels it should still be possible to communicate with
+ * the integrated circuitry via any command bus after this call.
+ *
+ * If atomic commit state is available, call drm_panel_atomic_disable instead.
+ */
+static inline void drm_panel_disable(struct drm_panel *panel)
+{
+	drm_panel_atomic_disable(panel, NULL, NULL);
+}
 
 int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector);
 
-- 
2.53.0

