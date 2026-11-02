Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7946076F98
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZA1RK/Np
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E4710F0B5;
	Mon,  2 Nov 2026 16:49:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F3110E6B5;
 Mon,  2 Nov 2026 16:49:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3ED4E43552;
 Mon,  2 Nov 2026 16:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3691F00A18;
 Mon,  2 Nov 2026 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793638171;
 bh=qUaGMb9BdgelcdDxoXbWsgm7T5TRMJdRRCfL1Mt8Bo4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZA1RK/NprumKUmkgfMT6bojMueHKsHa0v59xL1k0pY5HFDyAtSAmLzq2thdpfHiVy
 aWw02P2FgyquslhGekVerwyXPcRRvR8npwqNlXykddmVKpeQ9ooTetHIVy0SWS3wq+
 FUFY66pGBAfJvWoverQXqj++XRBcJKOeFbkgAZrXQjmfVcEaKGTpoNEhozqZjXLSKQ
 v1V3iCGRoneOuxH5YpQdNP7UM0jieBvoL8J+fErQRR+VMh1kWYpI0Cfd+U8LwQJmvp
 FTtNNwgpx9sRiBnK33XfnMNqqy89Zyn19QEX3h3wYytqPUf83F0ikqCk/M9UJP1qge
 cjEo5KwyseYLg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 02 Nov 2026 10:49:17 -0600
Subject: [PATCH v10 01/15] drm: add connector LUMINANCE property
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-superm1-backlight-property-v10-1-b2a6f24131f5@kernel.org>
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

Panel brightness is a property of a display, and thus of a DRM
connector. Add an atomic per-connector LUMINANCE range property so
compositors can manage relative panel luminance together with the rest
of the display state.

Keep the core backend-agnostic. Drivers create the property with their
hardware range and implement connector helper callbacks to set luminance
or disable panel emission. The atomic helpers sequence those callbacks
around pipeline enable and disable, including luminance-only commits.

The stored property value is independent of display power. A commit made
while the connector is inactive is retained and applied on the next
enable; disabling the pipeline does not overwrite it.

LUMINANCE values are relative, driver-defined levels rather than
absolute luminance in cd/m^2. The interface supports emissive panels as
well as panels with a separate backlight.

Keep the interface behind a default-off DRM_LUMINANCE option. Migrated
drivers retain their legacy backlight class ABI unless the new interface
is explicitly selected, allowing the DRM UAPI and legacy compatibility
policy to remain separate.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v10:
 * Add tag
---
 drivers/gpu/drm/Kconfig                    | 14 ++++++
 drivers/gpu/drm/drm_atomic_helper.c        | 73 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/drm_atomic_state_helper.c  |  7 +++
 drivers/gpu/drm/drm_atomic_uapi.c          |  5 ++
 drivers/gpu/drm/drm_connector.c            | 57 +++++++++++++++++++++++
 drivers/gpu/drm/tests/drm_connector_test.c | 28 ++++++++++++
 include/drm/drm_atomic_helper.h            |  3 ++
 include/drm/drm_connector.h                | 16 +++++++
 include/drm/drm_modeset_helper_vtables.h   | 25 ++++++++++
 9 files changed, 227 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 61111d50b1c65..1bbe2c2d7c76f 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -33,6 +33,20 @@ endmenu
 
 if DRM
 
+config DRM_LUMINANCE
+	bool "DRM connector luminance support"
+	help
+	  Expose relative luminance as an atomic DRM connector property. Values
+	  are driver-defined levels rather than absolute luminance in cd/m^2.
+	  Drivers provide connector helper callbacks to program their hardware;
+	  the DRM core does not depend on a particular backend.
+
+	  Drivers migrated to this interface will use it instead of registering
+	  a legacy backlight class device. Leave this disabled to preserve the
+	  de-facto userspace ABI in /sys/class/backlight.
+
+	  If in doubt, say N.
+
 config DRM_MIPI_DBI
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 9d006f98413a5..1e9b7b8acccfe 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1375,6 +1375,8 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_encoder_bridge_post_disable);
 static void
 disable_outputs(struct drm_device *dev, struct drm_atomic_commit *state)
 {
+	drm_atomic_helper_commit_luminance_disables(state);
+
 	drm_atomic_helper_commit_encoder_bridge_disable(dev, state);
 
 	drm_atomic_helper_commit_encoder_bridge_post_disable(dev, state);
@@ -1382,6 +1384,45 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_commit *state)
 	drm_atomic_helper_commit_crtc_disable(dev, state);
 }
 
+/**
+ * drm_atomic_helper_commit_luminance_disables - disable panel emission
+ * @state: atomic state object being committed
+ *
+ * Invokes each connector driver's luminance disable callback before a
+ * display pipeline is disabled. The connector property's stored value is left
+ * untouched so it can be restored when the pipeline is enabled again.
+ */
+void drm_atomic_helper_commit_luminance_disables(struct drm_atomic_commit *state)
+{
+	struct drm_connector_state *old_conn_state, *new_conn_state;
+	struct drm_connector *connector;
+	int i;
+
+	for_each_oldnew_connector_in_state(state, connector, old_conn_state,
+					   new_conn_state, i) {
+		const struct drm_connector_helper_funcs *funcs;
+		struct drm_crtc_state *old_crtc_state, *new_crtc_state = NULL;
+
+		if (!connector->luminance_property || !old_conn_state->crtc)
+			continue;
+
+		old_crtc_state =
+			drm_atomic_get_old_crtc_state(state, old_conn_state->crtc);
+		if (new_conn_state->crtc)
+			new_crtc_state =
+				drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
+
+		if (!crtc_needs_disable(old_crtc_state, new_crtc_state) ||
+		    !drm_atomic_crtc_needs_modeset(old_conn_state->crtc->state))
+			continue;
+
+		funcs = connector->helper_private;
+		if (funcs && funcs->disable_luminance)
+			funcs->disable_luminance(old_conn_state);
+	}
+}
+EXPORT_SYMBOL(drm_atomic_helper_commit_luminance_disables);
+
 /**
  * drm_atomic_helper_update_legacy_modeset_state - update legacy modeset state
  * @dev: DRM device
@@ -1771,10 +1812,41 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 
 	drm_atomic_helper_commit_encoder_bridge_enable(dev, state);
 
+	drm_atomic_helper_commit_luminance_enables(state);
+
 	drm_atomic_helper_commit_writebacks(dev, state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
 
+/**
+ * drm_atomic_helper_commit_luminance_enables - apply luminance
+ * @state: atomic state object being committed
+ *
+ * Invokes each connector driver's luminance callback after the display
+ * pipeline has been enabled. The callback is also invoked for brightness-only
+ * commits while the connector remains active. Changes committed while the
+ * connector is inactive remain stored in atomic state until a later enable.
+ */
+void drm_atomic_helper_commit_luminance_enables(struct drm_atomic_commit *state)
+{
+	struct drm_connector_state *new_conn_state;
+	struct drm_connector *connector;
+	int i;
+
+	for_each_new_connector_in_state(state, connector, new_conn_state, i) {
+		const struct drm_connector_helper_funcs *funcs;
+
+		if (!connector->luminance_property || !new_conn_state->crtc ||
+		    !new_conn_state->crtc->state->active)
+			continue;
+
+		funcs = connector->helper_private;
+		if (funcs && funcs->set_luminance)
+			funcs->set_luminance(new_conn_state);
+	}
+}
+EXPORT_SYMBOL(drm_atomic_helper_commit_luminance_enables);
+
 /*
  * For atomic updates which touch just a single CRTC, calculate the time of the
  * next vblank, and inform all the fences of the deadline.
@@ -4187,4 +4259,3 @@ drm_atomic_helper_bridge_get_hdmi_output_bus_fmts(struct drm_bridge *bridge,
 	return out_fmts;
 }
 EXPORT_SYMBOL(drm_atomic_helper_bridge_get_hdmi_output_bus_fmts);
-
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 406157a3660fd..5c31bf2bdbe76 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -408,7 +408,14 @@ void
 __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
 					 struct drm_connector *connector)
 {
+	u64 value;
+
 	conn_state->connector = connector;
+	if (connector->luminance_property &&
+	    !drm_object_property_get_default_value(&connector->base,
+						   connector->luminance_property,
+						   &value))
+		conn_state->luminance = value;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_connector_state_init);
 
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eebcf6f5e05b..dffc51cd8d13c 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -30,6 +30,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
@@ -969,6 +970,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->hdmi.broadcast_rgb = val;
 	} else if (property == connector->color_format_property) {
 		state->color_format = val;
+	} else if (property == connector->luminance_property) {
+		state->luminance = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -1056,6 +1059,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->hdmi.broadcast_rgb;
 	} else if (property == connector->color_format_property) {
 		*val = state->color_format;
+	} else if (property == connector->luminance_property) {
+		*val = state->luminance;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 893716a9e4895..ab75e8bd9991a 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -810,6 +810,47 @@ void drm_connector_attach_edid_property(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_connector_attach_edid_property);
 
+/**
+ * drm_connector_attach_luminance_property - attach luminance property
+ * @connector: connector to attach the property to
+ * @min: minimum supported relative brightness
+ * @max: maximum supported relative brightness
+ * @value: initial relative brightness
+ *
+ * Creates the atomic ``LUMINANCE`` range property for @connector.
+ * Drivers should call this during connector initialization. The property's
+ * units are driver-defined; they do not represent absolute luminance.
+ *
+ * Returns:
+ * Zero on success, a negative errno otherwise.
+ */
+int drm_connector_attach_luminance_property(struct drm_connector *connector,
+					    unsigned int min,
+					    unsigned int max,
+					    unsigned int value)
+{
+	struct drm_property *property;
+
+	if (drm_WARN_ON(connector->dev, min > max || value < min || value > max))
+		return -EINVAL;
+
+	if (connector->luminance_property)
+		return 0;
+
+	property = drm_property_create_range(connector->dev, DRM_MODE_PROP_ATOMIC,
+					     "LUMINANCE", min, max);
+	if (!property)
+		return -ENOMEM;
+
+	connector->luminance_property = property;
+	drm_object_attach_property(&connector->base, property, value);
+	if (connector->state)
+		connector->state->luminance = value;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_luminance_property);
+
 /**
  * drm_connector_attach_encoder - attach a connector to an encoder
  * @connector: connector to attach
@@ -1681,6 +1722,22 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
  * 	Summarizing: Only set "DPMS" when the connector is known to be enabled,
  * 	assume that a successful SETCONFIG call also sets "DPMS" to on, and
  * 	never read back the value of "DPMS" because it can be incorrect.
+ * LUMINANCE:
+ *     Atomic range property for controlling a panel's relative luminance.
+ *     The unit and range are driver-defined and do not represent an absolute
+ *     luminance in cd/m^2. This name therefore also applies to emissive panels
+ *     that do not contain a separate backlight.
+ *
+ *     The property is independent of the connector's display-power state.
+ *     Changing it while the connector is inactive stores the new value without
+ *     turning the display on. The atomic helpers apply the stored value after
+ *     the display pipeline is enabled and invoke a separate driver callback
+ *     before disabling the pipeline; neither action changes the property value.
+ *
+ *     Drivers create the property with
+ *     drm_connector_attach_luminance_property() and implement the
+ *     corresponding &drm_connector_helper_funcs callbacks. Connectors that do
+ *     not support luminance control do not expose the property.
  * panel_type:
  * 	Immutable enum property to indicate the type of connected panel.
  * 	Possible values are "unknown" (default), "OLED", and "LCD".
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 3368aedd4e669..e43692d38ebb8 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -137,6 +137,33 @@ static void drm_test_drmm_connector_init_null_ddc(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
+static void drm_test_connector_attach_luminance_property(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	struct drm_connector *connector = &priv->connector;
+	struct drm_property *property;
+	u64 value;
+	int ret;
+
+	ret = drmm_connector_init(&priv->drm, connector, &dummy_funcs,
+				  DRM_MODE_CONNECTOR_eDP, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NULL(test, connector->state);
+
+	ret = drm_connector_attach_luminance_property(connector, 10, 100, 50);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	property = connector->luminance_property;
+	KUNIT_ASSERT_NOT_NULL(test, property);
+
+	ret = drm_object_property_get_default_value(&connector->base, property, &value);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, value, (u64)50);
+
+	drm_atomic_helper_connector_reset(connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	KUNIT_EXPECT_EQ(test, connector->state->luminance, 50u);
+}
+
 /*
  * Test that the registration of a connector succeeds for all possible
  * connector types.
@@ -190,6 +217,7 @@ KUNIT_ARRAY_PARAM(drm_connector_init_type_valid,
 static struct kunit_case drmm_connector_init_tests[] = {
 	KUNIT_CASE(drm_test_drmm_connector_init),
 	KUNIT_CASE(drm_test_drmm_connector_init_null_ddc),
+	KUNIT_CASE(drm_test_connector_attach_luminance_property),
 	KUNIT_CASE_PARAM(drm_test_drmm_connector_init_type_valid,
 			 drm_connector_init_type_valid_gen_params),
 	{ }
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 4cfeec70d648a..3084dd5cd6a1f 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -116,6 +116,9 @@ void drm_atomic_helper_commit_encoder_bridge_enable(struct drm_device *dev,
 void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 					  struct drm_atomic_commit *old_state);
 
+void drm_atomic_helper_commit_luminance_disables(struct drm_atomic_commit *state);
+void drm_atomic_helper_commit_luminance_enables(struct drm_atomic_commit *state);
+
 int drm_atomic_helper_prepare_planes(struct drm_device *dev,
 				     struct drm_atomic_commit *state);
 void drm_atomic_helper_unprepare_planes(struct drm_device *dev,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aae..7f7d115b65f9f 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1369,6 +1369,11 @@ struct drm_connector_state {
 	 * @drm_atomic_helper_connector_hdmi_check().
 	 */
 	struct drm_connector_hdmi_state hdmi;
+
+	/**
+	 * @luminance: Relative panel luminance requested by userspace.
+	 */
+	unsigned int luminance;
 };
 
 struct drm_connector_hdmi_audio_funcs {
@@ -2714,6 +2719,13 @@ struct drm_connector {
 	 * @cec: CEC-related data.
 	 */
 	struct drm_connector_cec cec;
+
+	/**
+	 * @luminance_property: Optional atomic range property for relative panel
+	 * luminance. Drivers create it with
+	 * drm_connector_attach_luminance_property().
+	 */
+	struct drm_property *luminance_property;
 };
 
 #define obj_to_connector(x) container_of(x, struct drm_connector, base)
@@ -2980,6 +2992,10 @@ const char *drm_get_colorspace_name(enum drm_colorspace colorspace);
 
 int drm_connector_attach_color_format_property(struct drm_connector *connector,
 					       unsigned long supported_color_formats);
+int drm_connector_attach_luminance_property(struct drm_connector *connector,
+					    unsigned int min,
+					    unsigned int max,
+					    unsigned int value);
 
 /**
  * drm_for_each_connector_iter - connector_list iterator macro
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 60b30cc269404..cecacc1755a36 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1147,6 +1147,31 @@ struct drm_connector_helper_funcs {
 	void (*atomic_commit)(struct drm_connector *connector,
 			      struct drm_atomic_commit *state);
 
+	/**
+	 * @set_luminance:
+	 *
+	 * Apply &drm_connector_state.luminance to an active panel. The
+	 * atomic helpers call this after enabling the display pipeline and for
+	 * brightness-only commits while the connector remains active.
+	 *
+	 * This callback is optional and is only used by connectors exposing the
+	 * ``LUMINANCE`` property.
+	 */
+	void (*set_luminance)(const struct drm_connector_state *new_state);
+
+	/**
+	 * @disable_luminance:
+	 *
+	 * Turn panel light emission off before disabling the display pipeline.
+	 * This callback does not change the ``LUMINANCE`` property; the
+	 * stored value is restored through @set_luminance when the panel
+	 * is enabled again.
+	 *
+	 * This callback is optional and is only used by connectors exposing the
+	 * ``LUMINANCE`` property.
+	 */
+	void (*disable_luminance)(const struct drm_connector_state *old_state);
+
 	/**
 	 * @prepare_writeback_job:
 	 *

-- 
2.53.0

