Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF3606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCOaz2mn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F97A10F4AE;
	Tue, 24 Nov 2026 11:00:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08A710F4A4;
 Tue, 24 Nov 2026 11:00:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 15D79605F9;
 Tue, 24 Nov 2026 11:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D036F1F000C0;
 Tue, 24 Nov 2026 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795518021;
 bh=zkEVbF9o55qofcsMtZENaAjRPU3HNPmrHrLjPh7BD2I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DCOaz2mnbkJPldGTP2SsAhltEOiNzLN8husvUCt6hBF32O7tSerRg1Nxy/mZPp1d4
 KWcP3+hbSRvSPW3Edfjg3vWMr7peJSPnqFXm7t2kwgS+6StEtZz3/Zr7BVbl6EUCzt
 Wky9Qqm1lJO77fVpRyNi3CdBQVC5qb2HNJQoZk3/rXBKGtqw4g9/I1wGKygEquSVP7
 kaJM4hDfbUoT/iXD6TC2TXD+o/r89qVho71IzbpYmoaikW+BErBy368LtD3b7qDLo+
 6AKyXn6gaBCLIiX5yVbjHciiUBGo26yk+q12jDsDcRpt0RQwjPC6nn8jiWko4iMRsi
 KlytlqPMpVTsg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 24 Nov 2026 11:59:55 +0100
Subject: [PATCH 5/6] drm/i915: Implement connector atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-drm-i915-conversion-state-readout-v1-5-b7132f72644d@kernel.org>
References: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
In-Reply-To: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=17938; i=mripard@kernel.org;
 h=from:subject:message-id; bh=viVvP4d8TgqsPN1fAMsx3OAj/YmyTw0w6/c0CC5Sw28=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmseXpLf9yYdezgG+5bV0J5zYLWmKV+3XysR+hLmDpXu
 53p+qalHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiOccZG47U1s9VNM04vkD3
 nrjjm/XiK168e/fxgc61mSZX6jfJOAaeVfwhfjxQzXxOxL3a9zs/PGRsOLBQ4qSXf9K043vEVxY
 qcMpzfOaxjVpe8r2p1enMjmOdGp7/utYt2ti9iG2boHdsQeJfAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The atomic_create_state callback allocates a pristine, initialized,
state for the object it is called on, without any side effect.

The upcoming DRM_MODE_ATOMIC_RESET flag of the atomic ioctl relies on
it to bring the whole device back to its default state, by filling a
commit with such states through
drm_atomic_commit_fill_with_defaults(). Both the reset itself and the
DRM_CAP_ATOMIC_RESET capability reporting are gated on
drm_atomic_implements_create_state(), which requires every plane, CRTC
and connector of the device to implement the hook: without it, the
reset is rejected with -EOPNOTSUPP.

The other atomic_create_state() users don't apply to i915: it reads
the state the firmware left behind out of the hardware at probe time,
so it never goes through drm_mode_config_create_initial_state() nor
the hardware state readout helpers. The atomic reset is thus the only
user the hook enables here.

The i915 connector functions don't implement it, relying on the
connector initialization functions allocating and initializing the
state inline instead.

Provide an intel_digital_connector_create_state() function allocating
and initializing a pristine digital connector state, have
intel_connector_init() and the SDVO counterpart rely on it, and assign
atomic_create_state implementations to all the connector functions:
the digital connectors use the new function, the CRT and DVO
connectors use the default helper since they only rely on the base
connector state, and the TV and SDVO connectors get their own since
they subclass it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/i915/display/icl_dsi.c         |  1 +
 drivers/gpu/drm/i915/display/intel_atomic.c    | 23 +++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_atomic.h    |  2 ++
 drivers/gpu/drm/i915/display/intel_connector.c | 23 +++++++++++------------
 drivers/gpu/drm/i915/display/intel_crt.c       |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c        |  1 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c    |  1 +
 drivers/gpu/drm/i915/display/intel_dvo.c       |  1 +
 drivers/gpu/drm/i915/display/intel_hdmi.c      |  1 +
 drivers/gpu/drm/i915/display/intel_lvds.c      |  1 +
 drivers/gpu/drm/i915/display/intel_sdvo.c      | 26 +++++++++++++++++++-------
 drivers/gpu/drm/i915/display/intel_tv.c        | 15 +++++++++++++++
 drivers/gpu/drm/i915/display/vlv_dsi.c         |  1 +
 13 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index ea0cdb7822f3..a95ded302ec2 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1791,10 +1791,11 @@ static const struct drm_connector_funcs gen11_dsi_connector_funcs = {
 	.early_unregister = intel_connector_unregister,
 	.destroy = intel_connector_destroy,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_get_property = intel_digital_connector_atomic_get_property,
 	.atomic_set_property = intel_digital_connector_atomic_set_property,
+	.atomic_create_state = intel_digital_connector_create_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = intel_digital_connector_duplicate_state,
 };
 
 static const struct drm_connector_helper_funcs gen11_dsi_connector_helper_funcs = {
diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/i915/display/intel_atomic.c
index b66c2d4ba2b3..e752bbdda494 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic.c
@@ -168,10 +168,33 @@ intel_digital_connector_duplicate_state(struct drm_connector *connector)
 
 	__drm_atomic_helper_connector_duplicate_state(connector, &state->base);
 	return &state->base;
 }
 
+/**
+ * intel_digital_connector_create_state - allocate a pristine connector state
+ * @connector: digital connector
+ *
+ * Allocates and initializes a pristine &struct intel_digital_connector_state.
+ *
+ * Returns: The newly allocated connector state, or an error pointer on
+ * failure.
+ */
+struct drm_connector_state *
+intel_digital_connector_create_state(struct drm_connector *connector)
+{
+	struct intel_digital_connector_state *conn_state;
+
+	conn_state = kzalloc_obj(*conn_state);
+	if (!conn_state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_connector_state_init(&conn_state->base, connector);
+
+	return &conn_state->base;
+}
+
 /**
  * intel_connector_needs_modeset - check if connector needs a modeset
  * @state: the atomic state corresponding to this modeset
  * @connector: the connector
  */
diff --git a/drivers/gpu/drm/i915/display/intel_atomic.h b/drivers/gpu/drm/i915/display/intel_atomic.h
index 4dc5205a4733..50fbfe62071d 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.h
+++ b/drivers/gpu/drm/i915/display/intel_atomic.h
@@ -30,10 +30,12 @@ int intel_digital_connector_atomic_set_property(struct drm_connector *connector,
 						u64 val);
 int intel_digital_connector_atomic_check(struct drm_connector *conn,
 					 struct drm_atomic_commit *state);
 struct drm_connector_state *
 intel_digital_connector_duplicate_state(struct drm_connector *connector);
+struct drm_connector_state *
+intel_digital_connector_create_state(struct drm_connector *connector);
 bool intel_connector_needs_modeset(struct intel_atomic_state *state,
 				   struct drm_connector *connector);
 bool intel_any_crtc_needs_modeset(struct intel_atomic_state *state);
 struct intel_digital_connector_state *
 intel_atomic_get_digital_connector_state(struct intel_atomic_state *state,
diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers/gpu/drm/i915/display/intel_connector.c
index 388911850b03..22fde377fdd9 100644
--- a/drivers/gpu/drm/i915/display/intel_connector.c
+++ b/drivers/gpu/drm/i915/display/intel_connector.c
@@ -30,10 +30,11 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
+#include "intel_atomic.h"
 #include "intel_connector.h"
 #include "intel_display_core.h"
 #include "intel_display_debugfs.h"
 #include "intel_display_types.h"
 #include "intel_hdcp.h"
@@ -77,26 +78,24 @@ void intel_connector_cancel_modeset_retry_work(struct intel_connector *connector
 		drm_connector_put(&connector->base);
 }
 
 static int intel_connector_init(struct intel_connector *connector)
 {
-	struct intel_digital_connector_state *conn_state;
+	struct drm_connector_state *conn_state;
 
 	/*
-	 * Allocate enough memory to hold intel_digital_connector_state,
-	 * This might be a few bytes too many, but for connectors that don't
-	 * need it we'll free the state and allocate a smaller one on the first
-	 * successful commit anyway.
+	 * Allocate a state large enough to hold
+	 * intel_digital_connector_state. This might be a few bytes too
+	 * many, but for connectors that don't need it we'll free the
+	 * state and allocate a smaller one on the first successful
+	 * commit anyway.
 	 */
-	conn_state = kzalloc_obj(*conn_state);
-	if (!conn_state)
-		return -ENOMEM;
+	conn_state = intel_digital_connector_create_state(&connector->base);
+	if (IS_ERR(conn_state))
+		return PTR_ERR(conn_state);
 
-	__drm_atomic_helper_connector_state_init(&conn_state->base,
-						 &connector->base);
-
-	connector->base.state = &conn_state->base;
+	connector->base.state = conn_state;
 
 	intel_panel_init_alloc(connector);
 
 	INIT_WORK(&connector->modeset_retry_work,
 		  intel_connector_modeset_retry_work_fn);
diff --git a/drivers/gpu/drm/i915/display/intel_crt.c b/drivers/gpu/drm/i915/display/intel_crt.c
index 5b8968197fbc..f8e3ddb5dbec 100644
--- a/drivers/gpu/drm/i915/display/intel_crt.c
+++ b/drivers/gpu/drm/i915/display/intel_crt.c
@@ -993,10 +993,11 @@ void intel_crt_reset(struct drm_encoder *encoder)
 static const struct drm_connector_funcs intel_crt_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.late_register = intel_connector_register,
 	.early_unregister = intel_connector_unregister,
 	.destroy = intel_connector_destroy,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 };
 
 static const struct drm_connector_helper_funcs intel_crt_connector_helper_funcs = {
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 47741957935a..7da515a6fe3b 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6871,10 +6871,11 @@ static const struct drm_connector_funcs intel_dp_connector_funcs = {
 	.atomic_get_property = intel_digital_connector_atomic_get_property,
 	.atomic_set_property = intel_digital_connector_atomic_set_property,
 	.late_register = intel_dp_connector_register,
 	.early_unregister = intel_dp_connector_unregister,
 	.destroy = intel_connector_destroy,
+	.atomic_create_state = intel_digital_connector_create_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = intel_digital_connector_duplicate_state,
 	.oob_hotplug_event = intel_dp_oob_hotplug_event,
 };
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 7023619aaaba..2d3bf9a8ca50 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1493,10 +1493,11 @@ static const struct drm_connector_funcs mst_connector_funcs = {
 	.atomic_get_property = intel_digital_connector_atomic_get_property,
 	.atomic_set_property = intel_digital_connector_atomic_set_property,
 	.late_register = mst_connector_late_register,
 	.early_unregister = mst_connector_early_unregister,
 	.destroy = intel_connector_destroy,
+	.atomic_create_state = intel_digital_connector_create_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = intel_digital_connector_duplicate_state,
 };
 
 static int mst_connector_get_modes(struct drm_connector *_connector)
diff --git a/drivers/gpu/drm/i915/display/intel_dvo.c b/drivers/gpu/drm/i915/display/intel_dvo.c
index f157699a7c4c..f9c481d8b6de 100644
--- a/drivers/gpu/drm/i915/display/intel_dvo.c
+++ b/drivers/gpu/drm/i915/display/intel_dvo.c
@@ -347,10 +347,11 @@ static const struct drm_connector_funcs intel_dvo_connector_funcs = {
 	.detect = intel_dvo_detect,
 	.late_register = intel_connector_register,
 	.early_unregister = intel_connector_unregister,
 	.destroy = intel_connector_destroy,
 	.fill_modes = drm_helper_probe_single_connector_modes,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 };
 
 static const struct drm_connector_helper_funcs intel_dvo_connector_helper_funcs = {
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index b6fa1a1558b8..a965ad2ca3b9 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2684,10 +2684,11 @@ static const struct drm_connector_funcs intel_hdmi_connector_funcs = {
 	.atomic_get_property = intel_digital_connector_atomic_get_property,
 	.atomic_set_property = intel_digital_connector_atomic_set_property,
 	.late_register = intel_hdmi_connector_register,
 	.early_unregister = intel_hdmi_connector_unregister,
 	.destroy = intel_connector_destroy,
+	.atomic_create_state = intel_digital_connector_create_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = intel_digital_connector_duplicate_state,
 };
 
 static int intel_hdmi_connector_atomic_check(struct drm_connector *_connector,
diff --git a/drivers/gpu/drm/i915/display/intel_lvds.c b/drivers/gpu/drm/i915/display/intel_lvds.c
index 872753478cf2..e7d6e8e8337a 100644
--- a/drivers/gpu/drm/i915/display/intel_lvds.c
+++ b/drivers/gpu/drm/i915/display/intel_lvds.c
@@ -510,10 +510,11 @@ static const struct drm_connector_funcs intel_lvds_connector_funcs = {
 	.atomic_get_property = intel_digital_connector_atomic_get_property,
 	.atomic_set_property = intel_digital_connector_atomic_set_property,
 	.late_register = intel_connector_register,
 	.early_unregister = intel_connector_unregister,
 	.destroy = intel_connector_destroy,
+	.atomic_create_state = intel_digital_connector_create_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = intel_digital_connector_duplicate_state,
 };
 
 static const struct drm_encoder_funcs intel_lvds_enc_funcs = {
diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
index 7b97f531acbf..e276f00f74c5 100644
--- a/drivers/gpu/drm/i915/display/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
@@ -2503,18 +2503,33 @@ intel_sdvo_connector_duplicate_state(struct drm_connector *connector)
 
 	__drm_atomic_helper_connector_duplicate_state(connector, &state->base.base);
 	return &state->base.base;
 }
 
+static struct drm_connector_state *
+intel_sdvo_connector_create_state(struct drm_connector *connector)
+{
+	struct intel_sdvo_connector_state *state;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_connector_state_init(&state->base.base, connector);
+
+	return &state->base.base;
+}
+
 static const struct drm_connector_funcs intel_sdvo_connector_funcs = {
 	.detect = intel_sdvo_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_get_property = intel_sdvo_connector_atomic_get_property,
 	.atomic_set_property = intel_sdvo_connector_atomic_set_property,
 	.late_register = intel_connector_register,
 	.early_unregister = intel_connector_unregister,
 	.destroy = intel_connector_destroy,
+	.atomic_create_state = intel_sdvo_connector_create_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = intel_sdvo_connector_duplicate_state,
 };
 
 static int intel_sdvo_atomic_check(struct drm_connector *conn,
@@ -2775,27 +2790,24 @@ intel_sdvo_add_hdmi_properties(struct intel_sdvo *intel_sdvo,
 	intel_attach_aspect_ratio_property(&connector->base.base);
 }
 
 static struct intel_sdvo_connector *intel_sdvo_connector_alloc(void)
 {
+	struct drm_connector_state *conn_state;
 	struct intel_sdvo_connector *sdvo_connector;
-	struct intel_sdvo_connector_state *conn_state;
 
 	sdvo_connector = kzalloc_obj(*sdvo_connector);
 	if (!sdvo_connector)
 		return NULL;
 
-	conn_state = kzalloc_obj(*conn_state);
-	if (!conn_state) {
+	conn_state = intel_sdvo_connector_create_state(&sdvo_connector->base.base);
+	if (IS_ERR(conn_state)) {
 		kfree(sdvo_connector);
 		return NULL;
 	}
 
-	__drm_atomic_helper_connector_state_init(&conn_state->base.base,
-						 &sdvo_connector->base.base);
-
-	sdvo_connector->base.base.state = &conn_state->base.base;
+	sdvo_connector->base.base.state = conn_state;
 
 	intel_panel_init_alloc(&sdvo_connector->base);
 
 	return sdvo_connector;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
index 840e1dcdc2d0..d40a8d2c4185 100644
--- a/drivers/gpu/drm/i915/display/intel_tv.c
+++ b/drivers/gpu/drm/i915/display/intel_tv.c
@@ -900,10 +900,24 @@ intel_tv_connector_duplicate_state(struct drm_connector *connector)
 
 	__drm_atomic_helper_connector_duplicate_state(connector, &state->base);
 	return &state->base;
 }
 
+static struct drm_connector_state *
+intel_tv_connector_create_state(struct drm_connector *connector)
+{
+	struct intel_tv_connector_state *state;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_connector_state_init(&state->base, connector);
+
+	return &state->base;
+}
+
 static struct intel_tv *enc_to_tv(struct intel_encoder *encoder)
 {
 	return container_of(encoder, struct intel_tv, base);
 }
 
@@ -1839,10 +1853,11 @@ intel_tv_get_modes(struct drm_connector *connector)
 static const struct drm_connector_funcs intel_tv_connector_funcs = {
 	.late_register = intel_connector_register,
 	.early_unregister = intel_connector_unregister,
 	.destroy = intel_connector_destroy,
 	.fill_modes = drm_helper_probe_single_connector_modes,
+	.atomic_create_state = intel_tv_connector_create_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = intel_tv_connector_duplicate_state,
 };
 
 static int intel_tv_atomic_check(struct drm_connector *connector,
diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
index 8829f365592e..29c205910b32 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -1563,10 +1563,11 @@ static const struct drm_connector_funcs intel_dsi_connector_funcs = {
 	.early_unregister = intel_connector_unregister,
 	.destroy = intel_connector_destroy,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_get_property = intel_digital_connector_atomic_get_property,
 	.atomic_set_property = intel_digital_connector_atomic_set_property,
+	.atomic_create_state = intel_digital_connector_create_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = intel_digital_connector_duplicate_state,
 };
 
 static void vlv_dsi_add_properties(struct intel_connector *connector)

-- 
2.56.1

