Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08648606D82C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwUVdxdX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6142310F8BA;
	Tue,  3 Nov 2026 22:42:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 268C510F29A;
 Tue,  3 Nov 2026 22:42:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 039A940951;
 Tue,  3 Nov 2026 22:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C1D1F00A15;
 Tue,  3 Nov 2026 22:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793745742;
 bh=ONckf1oyDzGCVRUW7BFxneeAYQhrsAxD/nG7vYKe6ds=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GwUVdxdX56V/olAkHYMIK2z+Y19djp/ehwSsWX/0Qc1SJizKw+TSOkmHHduTUan/Q
 49VzL4kJ4QSAHI5griUqaXYQU5Sv8vnQUBDvohz45UFEhacT6gPMQZXNArqn/WGBJe
 IXyYrdK+EXhXpiEVjUsCVn4Vgkkwgt8sU28S7kwmNeBryJE1U3R/Jz0w58pjd/QQLV
 Qf5VtyULnLXxMkcN1aozWRnhEWnAgr4U/LciifYM2kESz1VKuJxspunJSosUqv3YXe
 AWpoE3rx/+bGgc28rYGPzVJPW1zT9lTILYT0aScmoza/2tXj/Awb3tWJCJn3TOfqVn
 0E5HLjrxntPdQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Tue, 03 Nov 2026 16:42:05 -0600
Subject: [PATCH v11 04/12] drm/amd: add luminance property support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-superm1-backlight-property-v11-4-00cce7b2ba22@kernel.org>
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

Expose the DRM LUMINANCE connector property for internal panels when
CONFIG_DRM_LUMINANCE is enabled. Keep registering the existing backlight
class device otherwise, preserving its userspace ABI.

Use the existing brightness scaling and programming paths from Display
Core connector helper callbacks. Apply atomic luminance after the display
pipeline is enabled so changes made while a connector is inactive take
effect on the next enable.

The legacy non-DC display path is not atomic, so it keeps registering the
backlight class device. Only attach LUMINANCE when ACPI video selects
native backlight control, otherwise keep the existing acpi_video fallback.
Reapply the cached level after modesets and GPU resets for both
interfaces.

With LUMINANCE, ATIF panel brightness change requests from firmware are
not forwarded, since there is no backlight device to update.

Update the backlight KUnit fixtures to initialise DRM mode configuration,
connector state and link service mocks needed by the LUMINANCE path.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11:
 * Drop the legacy (non-DC) changes; that path is not atomic and keeps the
   backlight class device (Sashiko)
 * Only attach LUMINANCE when acpi_video_backlight_use_native() allows it,
   otherwise register the class device or acpi_video fallback (Sashiko)
 * Restore brightness after GPU reset and modesets for LUMINANCE panels
   too, seeding dm->brightness[] with the initial value (Leo Li, Sashiko)
 * Skip programming an unchanged luminance to avoid PSR/Replay/IPS exits
   (Leo Li, Sashiko)
 * Keep selecting BACKLIGHT_CLASS_DEVICE (Sashiko)
 * Seed the property from the hardware level rather than the default
 * Leave the privacy screen update in commit_tail unchanged
 * Squash in "drm/amd/display: update KUnit luminance fixtures" so every
   commit passes KUnit, rebased on drm-tip fixture changes (Intel CI)
 * Initialise the KUnit test connector with the type matching the link
   signal to avoid freeing the ID into the wrong IDA (Sashiko)
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 16 ++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  7 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 78 +++++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |  3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  5 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 68 ++++++++++++++++---
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |  7 +-
 7 files changed, 160 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 56fca4e22df8d..2a9ddd1dc6f70 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1976,10 +1976,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		mutex_unlock(&dm->dc_lock);
 
 		/* set the backlight after a reset */
-		for (i = 0; i < dm->num_of_edps; i++) {
-			if (dm->backlight_dev[i])
-				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
-		}
+		amdgpu_dm_backlight_restore(dm);
 
 		return 0;
 	}
@@ -4802,12 +4799,8 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 	 * level. (the dm->brightness is the correct panel level)
 	 * So we set the backlight level with dm->brightness value after set mode
 	 */
-	if (set_backlight_level) {
-		for (i = 0; i < dm->num_of_edps; i++) {
-			if (dm->backlight_dev[i])
-				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
-		}
-	}
+	if (set_backlight_level)
+		amdgpu_dm_backlight_restore(dm);
 }
 
 STATIC_IFN_KUNIT void
@@ -5413,6 +5406,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 	/* Update audio instances for each connector. */
 	amdgpu_dm_commit_audio(dev, state);
 
+	/* Apply connector luminance after the display pipeline is enabled. */
+	drm_atomic_helper_commit_luminance_enables(state);
+
 	/* restore the backlight level */
 	for (i = 0; i < dm->num_of_edps; i++) {
 		if (dm->backlight_dev[i] &&
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index e4fed8c855abe..2e700cae52b67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -682,6 +682,13 @@ struct amdgpu_display_manager {
 	 * last successfully applied backlight values.
 	 */
 	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
+	/**
+	 * @luminance:
+	 *
+	 * backlight is controlled through the connector LUMINANCE property
+	 * instead of a backlight class device.
+	 */
+	bool luminance[AMDGPU_DM_MAX_NUM_EDP];
 
 	/**
 	 * @aux_hpd_discon_quirk:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 0f664c658a127..f61e69bbdf69f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -41,6 +41,7 @@
 #include <linux/backlight.h>
 #include <linux/minmax.h>
 #include <linux/power_supply.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_panel_quirks.h>
 
@@ -296,13 +297,17 @@ struct dc_stream_state *dm_find_stream_with_link(
 	struct amdgpu_display_manager *dm,
 	struct dc_link *link)
 {
-	struct dc_state *cur_dc_state = dm->dc->current_state;
+	struct dc_state *cur_dc_state;
 	struct dc_stream_state *stream = NULL;
 	int i;
 
+	if (!dm || !dm->dc || !dm->dc->current_state || !link)
+		return NULL;
+
+	cur_dc_state = dm->dc->current_state;
 	for (i = 0; i < cur_dc_state->stream_count; i++) {
 		stream = cur_dc_state->streams[i];
-		if (stream->link == link)
+		if (stream && stream->link == link)
 			return stream;
 	}
 
@@ -356,7 +361,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 
 	dm->brightness[bl_idx] = user_brightness;
 	/* update scratch register */
-	if (bl_idx == 0)
+	if (bl_idx == 0 && dm->adev && dm->adev->rmmio && dm->adev->bios_scratch_reg_offset)
 		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
 
 	link = (struct dc_link *)dm->backlight_link[bl_idx];
@@ -657,6 +662,10 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 {
 	struct dc_link *link = aconnector->dc_link;
 	int bl_idx = dm->num_of_edps;
+	struct backlight_properties props = { 0 };
+	struct amdgpu_dm_backlight_caps *caps;
+	struct drm_connector *connector = &aconnector->base;
+	int ret;
 
 	if (!(link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) ||
 	    link->type == dc_connection_none)
@@ -675,6 +684,30 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 
 	amdgpu_dm_update_connector_ext_caps(aconnector);
 
+	/*
+	 * The property must exist before the device is registered. If ACPI
+	 * video should handle the backlight, leave it to
+	 * amdgpu_dm_register_backlight_device() to register the fallback.
+	 */
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE) && acpi_video_backlight_use_native()) {
+		caps = &dm->backlight_caps[bl_idx];
+		amdgpu_dm_backlight_fill_props(caps, power_supply_is_system_supplied() > 0,
+					       !(amdgpu_dc_debug_mask &
+						 DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE),
+					       &props);
+		/* Start from the level the hardware is actually at */
+		ret = amdgpu_dm_backlight_get_level(dm, bl_idx);
+		if (ret >= 0 && ret <= props.max_brightness)
+			props.brightness = ret;
+		ret = drm_connector_attach_luminance_property(connector, 0,
+							      props.max_brightness,
+							      props.brightness);
+		if (!drm_WARN_ON(adev_to_drm(dm->adev), ret)) {
+			dm->brightness[bl_idx] = props.brightness;
+			dm->luminance[bl_idx] = true;
+		}
+	}
+
 	/* Offer ABM property when user didn't turn off by module parameter.
 	 * OLED panels are included to support CACP (Content Adaptive
 	 * Contrast and Power) feature via set_abm_level.
@@ -686,6 +719,45 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
 
+void amdgpu_dm_set_luminance(const struct drm_connector_state *state)
+{
+	struct amdgpu_dm_connector *aconnector =
+		to_amdgpu_dm_connector(state->connector);
+	struct amdgpu_display_manager *dm =
+		&drm_to_adev(state->connector->dev)->dm;
+
+	int bl_idx = aconnector->bl_idx;
+
+	if (bl_idx < 0)
+		return;
+
+	/* Skip if already applied, e.g. by amdgpu_dm_backlight_restore(). */
+	if (dm->brightness[bl_idx] == state->luminance &&
+	    dm->actual_brightness[bl_idx] == state->luminance)
+		return;
+
+	amdgpu_dm_backlight_set_level(dm, bl_idx, state->luminance);
+}
+
+/**
+ * amdgpu_dm_backlight_restore - reprogram the cached backlight levels
+ * @dm: display manager
+ *
+ * Display Core may reset the panel brightness when committing streams, so
+ * reapply the cached level of every panel whose backlight is controlled by
+ * the driver, either through a backlight class device or through the
+ * connector LUMINANCE property.
+ */
+void amdgpu_dm_backlight_restore(struct amdgpu_display_manager *dm)
+{
+	int i;
+
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (dm->backlight_dev[i] || dm->luminance[i])
+			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+	}
+}
+
 /**
  * DOC: panel power savings
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 891749322191c..69704e0ff5b25 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -33,6 +33,7 @@ struct dc_stream_state;
 struct device;
 struct device_attribute;
 struct drm_connector;
+struct drm_connector_state;
 struct attribute_group;
 
 #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
@@ -47,6 +48,8 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 void amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector);
 void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 			    struct amdgpu_dm_connector *aconnector);
+void amdgpu_dm_set_luminance(const struct drm_connector_state *state);
+void amdgpu_dm_backlight_restore(struct amdgpu_display_manager *dm);
 void amdgpu_dm_update_connector_ext_caps(struct amdgpu_dm_connector *aconnector);
 bool amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *aconnector);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 8db7956c01d32..71f7111dfb268 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1969,6 +1969,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
 	if (aconnector->bl_idx != -1) {
 		backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
+		dm->luminance[aconnector->bl_idx] = false;
 	}
 
 	if (aconnector->dc_em_sink)
@@ -2061,7 +2062,8 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 			return r;
 	}
 
-	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
+	if (!connector->luminance_property)
+		amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
 
 	if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
 	    (connector->connector_type == DRM_MODE_CONNECTOR_eDP)) {
@@ -2724,6 +2726,7 @@ amdgpu_dm_connector_helper_funcs = {
 	.get_modes = get_modes,
 	.mode_valid = amdgpu_dm_connector_mode_valid,
 	.atomic_check = amdgpu_dm_connector_atomic_check,
+	.set_luminance = amdgpu_dm_set_luminance,
 };
 
 int amdgpu_dm_convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 8fc1c2f997688..c33c121a19b25 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -37,16 +37,39 @@ static const struct drm_connector_funcs dm_backlight_test_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
+static int dm_test_signal_to_connector_type(enum signal_type signal)
+{
+	switch (signal) {
+	case SIGNAL_TYPE_EDP:
+		return DRM_MODE_CONNECTOR_eDP;
+	case SIGNAL_TYPE_LVDS:
+		return DRM_MODE_CONNECTOR_LVDS;
+	case SIGNAL_TYPE_HDMI_TYPE_A:
+		return DRM_MODE_CONNECTOR_HDMIA;
+	default:
+		return DRM_MODE_CONNECTOR_Unknown;
+	}
+}
+
 static void setup_test_connector(struct kunit *test,
 				 struct dm_backlight_connector_fixture *fixture,
 				 int bl_idx, enum signal_type signal)
 {
-	fixture->adev = kunit_kzalloc(test, sizeof(*fixture->adev), GFP_KERNEL);
-	fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture->aconnector), GFP_KERNEL);
+	int ret;
+
+	fixture->adev = dm_kunit_alloc_adev(test);
+	ret = drmm_mode_config_init(&fixture->adev->ddev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fixture->aconnector = dm_kunit_alloc_connector(test, fixture->adev, NULL);
 	fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, fixture->adev);
-	KUNIT_ASSERT_NOT_NULL(test, fixture->aconnector);
 	KUNIT_ASSERT_NOT_NULL(test, fixture->link);
+	ret = drmm_connector_init(&fixture->adev->ddev,
+				  &fixture->aconnector->base,
+				  &dm_backlight_test_connector_funcs,
+				  dm_test_signal_to_connector_type(signal), NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	drm_atomic_helper_connector_reset(&fixture->aconnector->base);
 
 	fixture->aconnector->bl_idx = bl_idx;
 	fixture->aconnector->dc_link = fixture->link;
@@ -483,12 +506,17 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
 	struct dc_link *link = dm_kunit_alloc_link(test);
 	struct drm_minor *primary;
 	unsigned int max;
+	int ret;
+
+	ret = drmm_mode_config_init(&adev->ddev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	setup_test_link_service(test, link);
 	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_error;
 	primary = kunit_kzalloc(test, sizeof(*primary), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, primary);
 	adev->ddev.primary = primary;
+	adev->dm.ddev = &adev->ddev;
 	adev->dm.backlight_link[0] = link;
 
 	aconnector = dm_kunit_alloc_connector(test, adev, link);
@@ -1667,7 +1695,6 @@ static void dm_test_should_create_sysfs_non_edp(struct kunit *test)
 
 	amdgpu_dm_set_abm_level_param(-1);
 	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_HDMI_TYPE_A);
-	fixture.aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
 
 	KUNIT_EXPECT_FALSE(test, amdgpu_dm_should_create_sysfs(fixture.aconnector));
 
@@ -1843,6 +1870,9 @@ static void dm_test_setup_backlight_device_oled_success(struct kunit *test)
 	setup_test_connector(test, &fixture, -1, SIGNAL_TYPE_EDP);
 	fixture.link->type = dc_connection_single;
 	fixture.link->dpcd_sink_ext_caps.bits.oled = 1;
+	setup_test_link_service(test, fixture.link);
+	fixture.link->dc->link_srv->edp_get_backlight_level_nits =
+		dm_test_get_backlight_level_nits;
 	dm = &fixture.adev->dm;
 	dm->adev = fixture.adev;
 	dm->num_of_edps = 0;
@@ -1872,6 +1902,7 @@ static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *t
 	struct dc_link *link;
 	int saved_abm_level = amdgpu_dm_get_abm_level_param();
 	int saved_backlight = amdgpu_dm_get_backlight_param();
+	int abm_index;
 	int old_count;
 	int ret;
 
@@ -1890,25 +1921,44 @@ static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *t
 				   &dm_backlight_test_connector_funcs,
 				   DRM_MODE_CONNECTOR_eDP, NULL);
 	KUNIT_ASSERT_EQ(test, ret, 0);
+	drm_atomic_helper_connector_reset(&aconnector->base);
 
 	link = dm_kunit_alloc_link(test);
 	link->connector_signal = SIGNAL_TYPE_EDP;
 	link->type = dc_connection_single;
+	setup_test_link_service(test, link);
+	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_mid;
 	aconnector->dc_link = link;
 	aconnector->bl_idx = -1;
 	dm = &adev->dm;
 	dm->adev = adev;
 	dm->ddev = &adev->ddev;
 	old_count = aconnector->base.base.properties->count;
+	abm_index = old_count + IS_ENABLED(CONFIG_DRM_LUMINANCE);
 
 	amdgpu_dm_setup_backlight_device(dm, aconnector);
 
 	KUNIT_EXPECT_EQ(test, dm->num_of_edps, 1);
 	KUNIT_EXPECT_EQ(test, aconnector->bl_idx, 0);
-	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->count, old_count + 1);
-	KUNIT_EXPECT_PTR_EQ(test, aconnector->base.base.properties->properties[old_count], prop);
-	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->values[old_count],
-			 (uint64_t)ABM_SYSFS_CONTROL);
+	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->count,
+			old_count + 1 + IS_ENABLED(CONFIG_DRM_LUMINANCE));
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		KUNIT_EXPECT_NOT_NULL(test,
+				      aconnector->base.luminance_property);
+		KUNIT_EXPECT_LE(test,
+				aconnector->base.state->luminance,
+				(uint64_t)MAX_BACKLIGHT_LEVEL);
+		/* Restores after reset/modeset must use the initial value */
+		KUNIT_EXPECT_EQ(test, dm->brightness[0],
+				aconnector->base.state->luminance);
+	}
+	KUNIT_EXPECT_EQ(test, dm->luminance[0],
+			IS_ENABLED(CONFIG_DRM_LUMINANCE));
+	KUNIT_EXPECT_PTR_EQ(test,
+			    aconnector->base.base.properties->properties[abm_index],
+			    prop);
+	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->values[abm_index],
+			(uint64_t)ABM_SYSFS_CONTROL);
 
 	amdgpu_dm_set_backlight_param(saved_backlight);
 	amdgpu_dm_set_abm_level_param(saved_abm_level);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
index f844b644bb776..7e9e8b1d0b10d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
@@ -20,6 +20,7 @@
 
 struct amdgpu_device *dm_kunit_alloc_adev(struct kunit *test)
 {
+	struct amdgpu_device *adev;
 	struct drm_device *drm;
 	struct device *dev;
 
@@ -32,7 +33,11 @@ struct amdgpu_device *dm_kunit_alloc_adev(struct kunit *test)
 						   DRIVER_MODESET | DRIVER_ATOMIC);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	return drm_to_adev(drm);
+	adev = drm_to_adev(drm);
+
+	mutex_init(&adev->dm.dc_lock);
+
+	return adev;
 }
 EXPORT_SYMBOL(dm_kunit_alloc_adev);
 

-- 
2.53.0

