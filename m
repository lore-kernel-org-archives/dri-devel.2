Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38796606E031
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FuPVt3/E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303B210F111;
	Mon,  2 Nov 2026 16:50:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CBEC10F0E3;
 Mon,  2 Nov 2026 16:49:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24EF143D67;
 Mon,  2 Nov 2026 16:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591FE1F01833;
 Mon,  2 Nov 2026 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793638188;
 bh=so0lGgQRgYqwEUOe7kSUad+RxOSJt9V6H5hwEO4IVXk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FuPVt3/Eb8wxZ8ltORT7bfVHmBxOsVmLUIfUTLjr16H7LO4VzDOhXSHvgGS+OJwoP
 o3txnWTtWcaF0xiampm36M47ckf6QJQVDF0nLcSJMYRIJ06sT2OuWnKOMeJZYS6Ct2
 bAeNkt92WYL9w1EAhtIW/bjLsC91jkut8zhMQ90bn+6ZRzQM2uAGXpehaRBwGoOQav
 dDhes+DgFJ0nOuTZGg8b1cLI3A0xuEvd8PyP69GY9fnXNE/qNIs79gA45P9WiR/sHA
 YaOYl19FdPtDzwIPzQTXfVcfg8bArGyT6V3I9xGKQEB4SO4n/MF3BxyC9uiD6kFWTa
 ZinH2mLR1B5/w==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 02 Nov 2026 10:49:26 -0600
Subject: [PATCH v10 10/15] drm/nouveau: add connector luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-superm1-backlight-property-v10-10-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
In-Reply-To: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
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
when DRM_LUMINANCE is enabled. Reuse the existing NV40, NV50, and DPCD
hardware paths while preserving the backlight class interface otherwise.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/nouveau/Kconfig             |   4 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |   2 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 110 ++++++++++++++++++++++------
 drivers/gpu/drm/nouveau/nouveau_connector.c |   2 +
 drivers/gpu/drm/nouveau/nouveau_connector.h |  14 ++++
 5 files changed, 108 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 3b5757aed9c84..2dcb7c5344f48 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -17,13 +17,13 @@ config DRM_NOUVEAU
 	select DRM_SCHED
 	select I2C
 	select I2C_ALGOBIT
-	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
+	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT && !DRM_LUMINANCE
 	select X86_PLATFORM_DEVICES if ACPI && X86
 	select ACPI_WMI if ACPI && X86
 	select MXM_WMI if ACPI && X86
 	select POWER_SUPPLY
 	# Similar to i915, we need to select ACPI_VIDEO and it's dependencies
-	select BACKLIGHT_CLASS_DEVICE if ACPI && X86
+	select BACKLIGHT_CLASS_DEVICE if ACPI && X86 && !DRM_LUMINANCE
 	select INPUT if ACPI && X86
 	select THERMAL if ACPI && X86
 	select ACPI_VIDEO if ACPI && X86
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e91130f93db67..79be7900a0794 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1838,7 +1838,7 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 		backlight = nv_connector->backlight;
 		if (backlight && backlight->uses_dpcd)
 			drm_edp_backlight_enable(&nv_connector->aux, &backlight->edp_info,
-						 backlight->dev->props.brightness);
+						 backlight->brightness);
 #endif
 
 		break;
diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index da1ee24a2531d..fefcfa8c2a3a9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -73,12 +73,10 @@ nv40_get_intensity(struct backlight_device *bd)
 }
 
 static int
-nv40_set_intensity(struct backlight_device *bd)
+nv40_set_intensity_value(struct nouveau_encoder *nv_encoder, int val)
 {
-	struct nouveau_encoder *nv_encoder = bl_get_data(bd);
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nvif_object *device = &drm->client.device.object;
-	int val = bd->props.brightness;
 	int reg = nvif_rd32(device, NV40_PMC_BACKLIGHT);
 
 	nvif_wr32(device, NV40_PMC_BACKLIGHT,
@@ -87,6 +85,12 @@ nv40_set_intensity(struct backlight_device *bd)
 	return 0;
 }
 
+static int
+nv40_set_intensity(struct backlight_device *bd)
+{
+	return nv40_set_intensity_value(bl_get_data(bd), bd->props.brightness);
+}
+
 static const struct backlight_ops nv40_bl_ops = {
 	.options = BL_CORE_SUSPENDRESUME,
 	.get_brightness = nv40_get_intensity,
@@ -105,6 +109,8 @@ nv40_backlight_init(struct nouveau_encoder *encoder,
 		return -ENODEV;
 
 	props->max_brightness = 31;
+	props->brightness = (nvif_rd32(device, NV40_PMC_BACKLIGHT) &
+			     NV40_PMC_BACKLIGHT_MASK) >> 16;
 	*ops = &nv40_bl_ops;
 	return 0;
 }
@@ -234,12 +240,15 @@ nv50_backlight_init(struct nouveau_backlight *bl,
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
 
@@ -284,6 +293,7 @@ nv50_backlight_init(struct nouveau_backlight *bl,
 
 	*ops = &nv50_bl_ops;
 	props->max_brightness = 100;
+	props->brightness = brightness;
 	return 0;
 }
 
@@ -317,10 +327,13 @@ nouveau_backlight_init(struct drm_connector *connector)
 	bl = kzalloc_obj(*bl);
 	if (!bl)
 		return -ENOMEM;
+	bl->id = -1;
+	bl->encoder = nv_encoder;
 
 	switch (device->info.family) {
 	case NV_DEVICE_INFO_V0_CURIE:
 		ret = nv40_backlight_init(nv_encoder, &props, &ops);
+		bl->uses_nv40 = true;
 		break;
 	case NV_DEVICE_INFO_V0_TESLA:
 	case NV_DEVICE_INFO_V0_FERMI:
@@ -349,26 +362,39 @@ nouveau_backlight_init(struct drm_connector *connector)
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
+	bl->brightness = props.brightness;
+	bl->max_brightness = props.max_brightness;
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
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
+		bl->brightness = bl->dev->props.brightness;
+		backlight_update_status(bl->dev);
+	}
 
 	return 0;
 
@@ -396,7 +422,9 @@ nouveau_backlight_fini(struct drm_connector *connector)
 	if (bl->id >= 0)
 		ida_free(&bl_ida, bl->id);
 
-	backlight_device_unregister(bl->dev);
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE))
+		backlight_device_unregister(bl->dev);
+
 	nv_conn->backlight = NULL;
 	kfree(bl);
 }
@@ -412,3 +440,43 @@ nouveau_backlight_dtor(void)
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
+	if (!bl || !bl->max_brightness)
+		return;
+
+	bl->brightness = luminance;
+	if (bl->uses_dpcd) {
+		drm_edp_backlight_set_level(&nv_connector->aux, &bl->edp_info,
+					    luminance);
+		return;
+	}
+
+	if (bl->uses_nv40)
+		nv40_set_intensity_value(bl->encoder, luminance);
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
+	else if (bl->uses_nv40)
+		nv40_set_intensity_value(bl->encoder, 0);
+	else
+		nvif_outp_bl_set(&bl->encoder->outp, 0);
+}
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index cc3caf8de64b0..56ee579ea7909 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1225,6 +1225,8 @@ nouveau_connector_helper_funcs = {
 	.mode_valid = nouveau_connector_mode_valid,
 	.best_encoder = nouveau_connector_best_encoder,
 	.atomic_check = nouveau_connector_atomic_check,
+	.set_luminance = nouveau_backlight_set_luminance,
+	.disable_luminance = nouveau_backlight_disable_luminance,
 };
 
 static const struct drm_connector_funcs
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index eb292d2ba4bcd..0cee3e4c1d11c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -50,9 +50,13 @@ struct nouveau_backlight {
 	struct backlight_device *dev;
 
 	struct drm_edp_backlight_info edp_info;
+	struct nouveau_encoder *encoder;
 	bool uses_dpcd : 1;
+	bool uses_nv40 : 1;
 
 	int id;
+	int brightness;
+	int max_brightness;
 };
 #endif
 
@@ -239,6 +243,8 @@ extern int nouveau_backlight_init(struct drm_connector *);
 extern void nouveau_backlight_fini(struct drm_connector *);
 extern void nouveau_backlight_ctor(void);
 extern void nouveau_backlight_dtor(void);
+void nouveau_backlight_set_luminance(const struct drm_connector_state *conn_state);
+void nouveau_backlight_disable_luminance(const struct drm_connector_state *conn_state);
 #else
 static inline int
 nouveau_backlight_init(struct drm_connector *connector)
@@ -257,6 +263,14 @@ nouveau_backlight_ctor(void) {
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

-- 
2.53.0

