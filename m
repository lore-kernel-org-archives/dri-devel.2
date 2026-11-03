Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F43606A33A
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qy5uaxuE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A1A910F215;
	Tue,  3 Nov 2026 22:42:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCBF410F8D2;
 Tue,  3 Nov 2026 22:42:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B27BE43DA7;
 Tue,  3 Nov 2026 22:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E152D1F00A02;
 Tue,  3 Nov 2026 22:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793745752;
 bh=PE3JoFAsPWYzM/2VTWaCcmrBAhB5QjBCHLVh8VYps6c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Qy5uaxuEVoVv9knelReqa35dRFNHxzX5B85LqHbOGdaT7s+0YzGHAArT67qUaaN4W
 7phmYSgI6e9NET1p2a/RGn9Ap6FU2e11OfWjhT15pfXExpYJbLJyj3bsdpb2Ofg0QT
 MloHuhWSLb77Zhj9/I/JhQpKDnSE3ynu4b8koy6BKPOb9lOxc7lIGZoZm/z87Hsf4p
 9unACogQ9zkS+LnNd6z1LB1hCy4ijWf+8fyuh0VLMevjzqPCXcIxIvK6yW5ugxqCel
 0aFWsd3USz3Bfdo6xz8exXkkttBaIHYILr8hF19ieORtlMx5VWlw3t2jYHJuoKzlo2
 Cj39yBmJzJc3g==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Tue, 03 Nov 2026 16:42:10 -0600
Subject: [PATCH v11 09/12] drm/nouveau: add connector luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-superm1-backlight-property-v11-9-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
In-Reply-To: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
 Xaver Hugl <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mario Limonciello <mario.limonciello@amd.com>

Expose Nouveau panel brightness through the connector LUMINANCE property
when DRM_LUMINANCE is enabled and atomic modesetting is exposed. Reuse
the existing NV50 and DPCD hardware paths while preserving the backlight
class interface otherwise, including for pre-NV50 displays.

The panel backlight is probed and the property attached before the DRM
device is registered. The luminance helpers are called from the NV50
atomic commit tail.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11:
 * Call the luminance commit helpers from nv50_disp_atomic_commit_tail()
   (Sashiko)
 * Attach the property before drm_dev_register() (Sashiko)
 * Keep the class device for non-atomic NV04 and nouveau.atomic=0
   (Sashiko)
 * Fix stale brightness on eDP enable for the class device path (Sashiko)
 * Keep selecting BACKLIGHT_CLASS_DEVICE (Sashiko)
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  13 ++-
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 152 ++++++++++++++++++++++++----
 drivers/gpu/drm/nouveau/nouveau_connector.c |   3 +
 drivers/gpu/drm/nouveau/nouveau_connector.h |  23 +++++
 drivers/gpu/drm/nouveau/nouveau_drm.c       |   6 ++
 5 files changed, 174 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e91130f93db67..57653fe720d95 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1755,6 +1755,7 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 	struct nouveau_connector *nv_connector;
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	struct nouveau_backlight *backlight;
+	u16 level;
 #endif
 	struct nvbios *bios = &drm->vbios;
 	bool lvds_dual = false, lvds_8bpc = false, hda = false;
@@ -1836,9 +1837,14 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 		backlight = nv_connector->backlight;
-		if (backlight && backlight->uses_dpcd)
+		if (backlight && backlight->uses_dpcd) {
+			if (backlight->dev)
+				level = backlight->dev->props.brightness;
+			else
+				level = nv_connector->base.state->luminance;
 			drm_edp_backlight_enable(&nv_connector->aux, &backlight->edp_info,
-						 backlight->dev->props.brightness);
+						 level);
+		}
 #endif
 
 		break;
@@ -2188,6 +2194,7 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_commit *state)
 	drm_dp_mst_atomic_wait_for_dependencies(state);
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 	drm_atomic_helper_calc_timestamping_constants(state);
+	drm_atomic_helper_commit_luminance_disables(state);
 
 	if (atom->lock_core)
 		mutex_lock(&disp->mutex);
@@ -2370,6 +2377,8 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_commit *state)
 	if (atom->lock_core)
 		mutex_unlock(&disp->mutex);
 
+	drm_atomic_helper_commit_luminance_enables(state);
+
 	list_for_each_entry_safe(outp, outt, &atom->outp, head) {
 		list_del(&outp->head);
 		kfree(outp);
diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index da1ee24a2531d..2366901581077 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -234,12 +234,15 @@ nv50_backlight_init(struct nouveau_backlight *bl,
 		    const struct backlight_ops **ops)
 {
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
+	int brightness;
+
+	brightness = nvif_outp_bl_get(&nv_encoder->outp);
 
 	/*
 	 * Note when this runs the connectors have not been probed yet,
 	 * so nv_conn->base.status is not set yet.
 	 */
-	if (nvif_outp_bl_get(&nv_encoder->outp) < 0 ||
+	if (brightness < 0 ||
 	    drm_helper_probe_detect(&nv_conn->base, NULL, false) != connector_status_connected)
 		return -ENODEV;
 
@@ -284,11 +287,25 @@ nv50_backlight_init(struct nouveau_backlight *bl,
 
 	*ops = &nv50_bl_ops;
 	props->max_brightness = 100;
+	props->brightness = brightness;
 	return 0;
 }
 
-int
-nouveau_backlight_init(struct drm_connector *connector)
+/*
+ * LUMINANCE is an atomic connector property. Pre-NV50 hardware and
+ * nouveau.atomic=0 don't expose atomic modesetting to userspace (even though
+ * NV50+ still commits atomically internally), so keep the backlight class
+ * device there.
+ */
+static bool
+nouveau_backlight_use_luminance(struct drm_device *dev)
+{
+	return IS_ENABLED(CONFIG_DRM_LUMINANCE) &&
+	       drm_core_check_feature(dev, DRIVER_ATOMIC);
+}
+
+static int
+nouveau_backlight_create(struct drm_connector *connector)
 {
 	struct nouveau_drm *drm = nouveau_drm(connector->dev);
 	struct nouveau_backlight *bl;
@@ -317,6 +334,8 @@ nouveau_backlight_init(struct drm_connector *connector)
 	bl = kzalloc_obj(*bl);
 	if (!bl)
 		return -ENOMEM;
+	bl->id = -1;
+	bl->encoder = nv_encoder;
 
 	switch (device->info.family) {
 	case NV_DEVICE_INFO_V0_CURIE:
@@ -349,26 +368,36 @@ nouveau_backlight_init(struct drm_connector *connector)
 		goto fail_alloc;
 	}
 
-	if (!nouveau_get_backlight_name(backlight_name, bl)) {
-		NV_ERROR(drm, "Failed to retrieve a unique name for the backlight interface\n");
-		goto fail_alloc;
-	}
-
 	props.type = BACKLIGHT_RAW;
-	bl->dev = backlight_device_register(backlight_name, connector->kdev,
-					    nv_encoder, ops, &props);
-	if (IS_ERR(bl->dev)) {
-		if (bl->id >= 0)
-			ida_free(&bl_ida, bl->id);
-		ret = PTR_ERR(bl->dev);
-		goto fail_alloc;
+	if (nouveau_backlight_use_luminance(connector->dev)) {
+		ret = drm_connector_attach_luminance_property(connector, 0, props.max_brightness,
+							      props.brightness);
+		if (ret)
+			goto fail_alloc;
+	} else {
+		if (!nouveau_get_backlight_name(backlight_name, bl)) {
+			NV_ERROR(drm,
+				 "Failed to retrieve a unique name for the backlight interface\n");
+			goto fail_alloc;
+		}
+
+		bl->dev = backlight_device_register(backlight_name, connector->kdev,
+						    nv_encoder, ops, &props);
+		if (IS_ERR(bl->dev)) {
+			if (bl->id >= 0)
+				ida_free(&bl_ida, bl->id);
+			ret = PTR_ERR(bl->dev);
+			goto fail_alloc;
+		}
 	}
 
 	nouveau_connector(connector)->backlight = bl;
-	if (!bl->dev->props.brightness)
-		bl->dev->props.brightness =
-			bl->dev->ops->get_brightness(bl->dev);
-	backlight_update_status(bl->dev);
+	if (bl->dev) {
+		if (!bl->dev->props.brightness)
+			bl->dev->props.brightness =
+				bl->dev->ops->get_brightness(bl->dev);
+		backlight_update_status(bl->dev);
+	}
 
 	return 0;
 
@@ -384,8 +413,40 @@ nouveau_backlight_init(struct drm_connector *connector)
 	return ret;
 }
 
-void
-nouveau_backlight_fini(struct drm_connector *connector)
+/* Called from .late_register, the backlight class device needs connector->kdev */
+int
+nouveau_backlight_init(struct drm_connector *connector)
+{
+	if (nouveau_backlight_use_luminance(connector->dev))
+		return 0;
+
+	return nouveau_backlight_create(connector);
+}
+
+/* Called before drm_dev_register(), the LUMINANCE property must exist by then */
+int
+nouveau_backlight_luminance_init(struct drm_device *dev)
+{
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *connector;
+	int ret = 0;
+
+	if (!nouveau_backlight_use_luminance(dev))
+		return 0;
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
+		ret = nouveau_backlight_create(connector);
+		if (ret)
+			break;
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return ret;
+}
+
+static void
+nouveau_backlight_free(struct drm_connector *connector)
 {
 	struct nouveau_connector *nv_conn = nouveau_connector(connector);
 	struct nouveau_backlight *bl = nv_conn->backlight;
@@ -401,6 +462,23 @@ nouveau_backlight_fini(struct drm_connector *connector)
 	kfree(bl);
 }
 
+/* Called from .early_unregister */
+void
+nouveau_backlight_fini(struct drm_connector *connector)
+{
+	/* LUMINANCE state is needed by commits until the connector is destroyed */
+	if (nouveau_backlight_use_luminance(connector->dev))
+		return;
+
+	nouveau_backlight_free(connector);
+}
+
+void
+nouveau_backlight_destroy(struct drm_connector *connector)
+{
+	nouveau_backlight_free(connector);
+}
+
 void
 nouveau_backlight_ctor(void)
 {
@@ -412,3 +490,35 @@ nouveau_backlight_dtor(void)
 {
 	ida_destroy(&bl_ida);
 }
+
+void
+nouveau_backlight_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct nouveau_connector *nv_connector = nouveau_connector(conn_state->connector);
+	struct nouveau_backlight *bl = nv_connector->backlight;
+	unsigned int luminance = conn_state->luminance;
+
+	if (!bl)
+		return;
+
+	if (bl->uses_dpcd)
+		drm_edp_backlight_set_level(&nv_connector->aux, &bl->edp_info,
+					    luminance);
+	else
+		nvif_outp_bl_set(&bl->encoder->outp, luminance);
+}
+
+void
+nouveau_backlight_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct nouveau_connector *nv_connector = nouveau_connector(conn_state->connector);
+	struct nouveau_backlight *bl = nv_connector->backlight;
+
+	if (!bl)
+		return;
+
+	if (bl->uses_dpcd)
+		drm_edp_backlight_disable(&nv_connector->aux, &bl->edp_info);
+	else
+		nvif_outp_bl_set(&bl->encoder->outp, 0);
+}
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index cc3caf8de64b0..cbbdd36f49bb7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -400,6 +400,7 @@ nouveau_connector_destroy(struct drm_connector *connector)
 	cancel_work_sync(&nv_connector->irq_work);
 	drm_edid_free(nv_connector->drm_edid);
 	drm_connector_unregister(connector);
+	nouveau_backlight_destroy(connector);
 	drm_connector_cleanup(connector);
 	if (nv_connector->aux.transfer)
 		drm_dp_cec_unregister_connector(&nv_connector->aux);
@@ -1225,6 +1226,8 @@ nouveau_connector_helper_funcs = {
 	.mode_valid = nouveau_connector_mode_valid,
 	.best_encoder = nouveau_connector_best_encoder,
 	.atomic_check = nouveau_connector_atomic_check,
+	.set_luminance = nouveau_backlight_set_luminance,
+	.disable_luminance = nouveau_backlight_disable_luminance,
 };
 
 static const struct drm_connector_funcs
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index eb292d2ba4bcd..f53107ec0bf3f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -50,6 +50,7 @@ struct nouveau_backlight {
 	struct backlight_device *dev;
 
 	struct drm_edp_backlight_info edp_info;
+	struct nouveau_encoder *encoder;
 	bool uses_dpcd : 1;
 
 	int id;
@@ -237,8 +238,12 @@ nouveau_conn_mode_clock_valid(const struct drm_display_mode *,
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 extern int nouveau_backlight_init(struct drm_connector *);
 extern void nouveau_backlight_fini(struct drm_connector *);
+int nouveau_backlight_luminance_init(struct drm_device *dev);
+void nouveau_backlight_destroy(struct drm_connector *connector);
 extern void nouveau_backlight_ctor(void);
 extern void nouveau_backlight_dtor(void);
+void nouveau_backlight_set_luminance(const struct drm_connector_state *conn_state);
+void nouveau_backlight_disable_luminance(const struct drm_connector_state *conn_state);
 #else
 static inline int
 nouveau_backlight_init(struct drm_connector *connector)
@@ -250,6 +255,16 @@ static inline void
 nouveau_backlight_fini(struct drm_connector *connector) {
 }
 
+static inline int
+nouveau_backlight_luminance_init(struct drm_device *dev)
+{
+	return 0;
+}
+
+static inline void
+nouveau_backlight_destroy(struct drm_connector *connector) {
+}
+
 static inline void
 nouveau_backlight_ctor(void) {
 }
@@ -257,6 +272,14 @@ nouveau_backlight_ctor(void) {
 static inline void
 nouveau_backlight_dtor(void) {
 }
+
+static inline void
+nouveau_backlight_set_luminance(const struct drm_connector_state *conn_state) {
+}
+
+static inline void
+nouveau_backlight_disable_luminance(const struct drm_connector_state *conn_state) {
+}
 #endif
 
 #endif /* __NOUVEAU_CONNECTOR_H__ */
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5e1336615cf6d..53bf7c2caa164 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -673,6 +673,10 @@ nouveau_drm_device_init(struct nouveau_drm *drm)
 		ret = nouveau_display_init(dev, false, false);
 		if (ret)
 			goto fail_dispinit;
+
+		ret = nouveau_backlight_luminance_init(dev);
+		if (ret)
+			goto fail_backlight;
 	}
 
 	nouveau_debugfs_init(drm);
@@ -697,6 +701,8 @@ nouveau_drm_device_init(struct nouveau_drm *drm)
 	}
 
 	return 0;
+fail_backlight:
+	nouveau_display_fini(dev, false, false);
 fail_dispinit:
 	nouveau_display_destroy(dev);
 fail_dispctor:

-- 
2.53.0

