Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94429C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1A110FF0E;
	Wed, 14 Oct 2026 17:31:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE37D10FF0E;
 Wed, 14 Oct 2026 17:31:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A043843515;
 Wed, 14 Oct 2026 17:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C451F000C6;
 Wed, 14 Oct 2026 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999072;
 bh=oVVOMHrERMDX9koBk1hnn01tSo6N+oZo/mEpSvp2Xks=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jlbLpPZx8BUdJJVaTRF99xzglrkoZhSkeyM075sVE7YuvVbQIRjUBJth/fK1JdKNl
 VThKj3YNlE/TppSSDvAtQvVkNc7BgfCiz0DITyC1gSQPyrA67ENslnVF6zW1Hwq2Bw
 +79xxVL31U07yJll/1972gbxgbStgemplhxKL/jU6idcuWVBa7pLZaBYu/kQ2+7so7
 bXaIQUkhjT9QMiOB9PYnMcoo6OThNCookG4ncqgn2Sn5i7UoHwTjzJK0RnxsED+xxk
 vYAPcnhOxylFbPwIeV7EKzlRtvLL54GXU7aWPDVBy9LzVuaeLfEeMc1TEhNVnRI3QR
 j3reIDb0Mk9Lg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:29 +0200
Subject: [PATCH 66/75] drm/amdgpu: dm: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-66-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=22595; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pz7cQfvpDAnOYLiJ4HPxMIm/04oAokhlI4kBOoefa0c=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd6f732BavHedz8qloQeDFwekel2PmW338BD/h/tGk
 sH/itp8OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE5r1mrGKa17A96IVv4+0m
 d8mM60KtB1qdpze9m3bKI2TV7zmfSjZrb0xuX5pj/kto93Qhhub78owN/zXnrjy+/3/M6jV75cW
 jr2/2Ep4xiUtY7fAVl7u2JlpreHbeKhLcUF4/+6HMisVrdBRUAQ==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The amdgpu_dm connector reset implementation creates a custom state
subclass, but only initializes a pristine state without resetting any
hardware. This is equivalent to what atomic_create_state expects.
Convert to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
---
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 32 ++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 14 +++-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 90 ++++++++++++++--------
 5 files changed, 91 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 3a4e98b08ac1..2c22f00f521c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1939,26 +1939,20 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
 
 	kfree(connector);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_destroy);
 
-void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
+struct drm_connector_state *
+amdgpu_dm_connector_atomic_create_state(struct drm_connector *connector)
 {
-	struct dm_connector_state *old_state =
-		to_dm_connector_state(connector->state);
 	struct dm_connector_state *state;
 
 	state = kzalloc_obj(*state);
 	if (!state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	if (connector->state)
-		__drm_atomic_helper_connector_destroy_state(connector->state);
-
-	kfree(old_state);
-
-	__drm_atomic_helper_connector_reset(connector, &state->base);
+	__drm_atomic_helper_connector_state_init(&state->base, connector);
 
 	state->scaling = RMX_OFF;
 	state->underscan_enable = false;
 	state->underscan_hborder = 0;
 	state->underscan_vborder = 0;
@@ -1970,12 +1964,14 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 		if (amdgpu_dm_abm_level <= 0)
 			state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
 		else
 			state->abm_level = amdgpu_dm_abm_level;
 	}
+
+	return &state->base;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_funcs_reset);
+EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_create_state);
 
 struct drm_connector_state *
 amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
 {
 	struct dm_connector_state *state =
@@ -2070,11 +2066,11 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_funcs_force(struct drm_connector *conn
 	}
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_funcs_force);
 
 static const struct drm_connector_funcs amdgpu_dm_connector_funcs = {
-	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
 	.detect = amdgpu_dm_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = amdgpu_dm_connector_destroy,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -3197,12 +3193,20 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 
 	/*
 	 * Some of the properties below require access to state, like bpc.
 	 * Allocate some default initial connector state with our reset helper.
 	 */
-	if (aconnector->base.funcs->reset)
-		aconnector->base.funcs->reset(&aconnector->base);
+	if (!aconnector->base.state &&
+	    aconnector->base.funcs->atomic_create_state) {
+		struct drm_connector_state *conn_state;
+
+		conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
+		if (IS_ERR(conn_state))
+			return;
+
+		aconnector->base.state = conn_state;
+	}
 
 	aconnector->connector_id = link_index;
 	aconnector->bl_idx = -1;
 	aconnector->dc_link = link;
 	aconnector->base.interlace_allowed = false;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 79698deacf61..4a73fc607f38 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -48,11 +48,12 @@ struct drm_crtc;
 struct drm_device;
 struct drm_display_mode;
 struct drm_edid;
 struct drm_property;
 
-void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector);
+struct drm_connector_state *
+amdgpu_dm_connector_atomic_create_state(struct drm_connector *connector);
 
 struct drm_connector_state *
 amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector);
 
 int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index a5b15bef8aa0..cb189c098ec3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -256,11 +256,11 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 EXPORT_IF_KUNIT(amdgpu_dm_mst_connector_early_unregister);
 
 static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = dm_dp_mst_connector_destroy,
-	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_set_property = amdgpu_dm_connector_atomic_set_property,
 	.atomic_get_property = amdgpu_dm_connector_atomic_get_property,
 	.late_register = amdgpu_dm_mst_connector_late_register,
@@ -736,11 +736,11 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 
 	/*
 	 * Initialize connector state before adding the connectror to drm and
 	 * framebuffer lists
 	 */
-	amdgpu_dm_connector_funcs_reset(connector);
+	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
 
 	drm_dp_mst_get_port_malloc(port);
 
 	return connector;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 6f91a992d43f..8181fcac299d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -223,11 +223,11 @@ static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs =
 };
 
 static const struct drm_connector_funcs amdgpu_dm_wb_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static const struct drm_connector_helper_funcs amdgpu_dm_wb_conn_helper_funcs = {
@@ -259,11 +259,19 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 		return res;
 	/*
 	 * Some of the properties below require access to state, like bpc.
 	 * Allocate some default initial connector state with our reset helper.
 	 */
-	if (wbcon->base.base.funcs->reset)
-		wbcon->base.base.funcs->reset(&wbcon->base.base);
+	if (!wbcon->base.base.state &&
+	    wbcon->base.base.funcs->atomic_create_state) {
+		struct drm_connector_state *conn_state;
+
+		conn_state = amdgpu_dm_connector_atomic_create_state(&wbcon->base.base);
+		if (IS_ERR(conn_state))
+			return PTR_ERR(conn_state);
+
+		wbcon->base.base.state = conn_state;
+	}
 
 	return 0;
 }
 EXPORT_IF_KUNIT(amdgpu_dm_wb_connector_init);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 8117aaf41f22..ebf8155326cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -1466,23 +1466,23 @@ static void dm_test_decide_crtc_timing_no_crtc_clock(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, drm_mode.crtc_clock, 0);
 	KUNIT_EXPECT_EQ(test, drm_mode.crtc_hdisplay, 0);
 }
 
-/* Tests for amdgpu_dm_connector_funcs_reset() */
+/* Tests for amdgpu_dm_connector_atomic_create_state() */
 
 static const struct drm_connector_funcs dm_test_connector_funcs = {
-	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 /**
- * dm_test_funcs_reset_sets_defaults - Test funcs_reset sets defaults
+ * dm_test_atomic_create_sets_defaults - Test funcs_reset sets defaults
  * @test: The KUnit test context
  */
-static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
+static void dm_test_atomic_create_sets_defaults(struct kunit *test)
 {
 	struct device *dev;
 	struct drm_device *drm;
 	struct drm_connector *connector;
 	struct dm_connector_state *dm_state;
@@ -1499,13 +1499,13 @@ static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
 			    DRM_MODE_CONNECTOR_DisplayPort, NULL);
 
-	amdgpu_dm_connector_funcs_reset(connector);
+	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
 
-	KUNIT_ASSERT_NOT_NULL(test, connector->state);
 	dm_state = to_dm_connector_state(connector->state);
 	KUNIT_EXPECT_EQ(test, (int)dm_state->scaling, (int)RMX_OFF);
 	KUNIT_EXPECT_FALSE(test, dm_state->underscan_enable);
 	KUNIT_EXPECT_EQ(test, (int)dm_state->underscan_hborder, 0);
 	KUNIT_EXPECT_EQ(test, (int)dm_state->underscan_vborder, 0);
@@ -1513,14 +1513,14 @@ static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_state->vcpi_slots, 0);
 	KUNIT_EXPECT_EQ(test, (int)dm_state->pbn, 0);
 }
 
 /**
- * dm_test_funcs_reset_edp_abm_level - Test funcs_reset eDP sets ABM
+ * dm_test_atomic_create_edp_abm_level - Test funcs_reset eDP sets ABM
  * @test: The KUnit test context
  */
-static void dm_test_funcs_reset_edp_abm_level(struct kunit *test)
+static void dm_test_atomic_create_edp_abm_level(struct kunit *test)
 {
 	struct device *dev;
 	struct drm_device *drm;
 	struct drm_connector *connector;
 	struct dm_connector_state *dm_state;
@@ -1540,25 +1540,26 @@ static void dm_test_funcs_reset_edp_abm_level(struct kunit *test)
 	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
 			    DRM_MODE_CONNECTOR_eDP, NULL);
 
 	/* Test with abm_level > 0 */
 	amdgpu_dm_set_abm_level_param(3);
-	amdgpu_dm_connector_funcs_reset(connector);
 
-	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
+
 	dm_state = to_dm_connector_state(connector->state);
 	KUNIT_EXPECT_EQ(test, (int)dm_state->abm_level, 3);
 
 	amdgpu_dm_set_abm_level_param(saved_abm_level);
 }
 
 /**
- * dm_test_funcs_reset_edp_abm_disabled - Test funcs_reset eDP ABM
+ * dm_test_atomic_create_edp_abm_disabled - Test funcs_reset eDP ABM
  * disabled
  * @test: The KUnit test context
  */
-static void dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
+static void dm_test_atomic_create_edp_abm_disabled(struct kunit *test)
 {
 	struct device *dev;
 	struct drm_device *drm;
 	struct drm_connector *connector;
 	struct dm_connector_state *dm_state;
@@ -1578,13 +1579,14 @@ static void dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
 	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
 			    DRM_MODE_CONNECTOR_eDP, NULL);
 
 	/* Test with abm_level <= 0 → immediate disable */
 	amdgpu_dm_set_abm_level_param(-1);
-	amdgpu_dm_connector_funcs_reset(connector);
 
-	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
+
 	dm_state = to_dm_connector_state(connector->state);
 	KUNIT_EXPECT_EQ(test, (int)dm_state->abm_level,
 			(int)ABM_LEVEL_IMMEDIATE_DISABLE);
 
 	amdgpu_dm_set_abm_level_param(saved_abm_level);
@@ -1618,12 +1620,12 @@ static void dm_test_atomic_dup_state_copies_fields(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
 			    DRM_MODE_CONNECTOR_HDMIA, NULL);
 
-	amdgpu_dm_connector_funcs_reset(connector);
-	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
 
 	/* Modify original state fields */
 	dm_state = to_dm_connector_state(connector->state);
 	dm_state->scaling = RMX_CENTER;
 	dm_state->underscan_enable = true;
@@ -4884,11 +4886,11 @@ static struct dm_test_destroy_ctx *dm_test_destroy_ctx_alloc(struct kunit *test)
  * drm_connector_init() requires funcs->destroy to be set, so a dedicated funcs
  * table wires it to amdgpu_dm_connector_destroy() (the test invokes it
  * directly; the connector is removed from the device before teardown).
  */
 static const struct drm_connector_funcs dm_test_destroy_funcs = {
-	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.destroy = amdgpu_dm_connector_destroy,
 };
 
@@ -6251,17 +6253,21 @@ static void dm_test_restore_state_no_connector_state(struct kunit *test)
  */
 static void dm_test_restore_state_no_encoder(struct kunit *test)
 {
 	struct drm_device *drm = dm_test_alloc_drm(test);
 	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *conn_state;
 
 	aconnector = dm_test_add_connector(test, drm,
 					   DRM_MODE_CONNECTOR_HDMIA);
 	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
-	aconnector->base.funcs->reset(&aconnector->base);
-	KUNIT_ASSERT_NOT_NULL(test, aconnector->base.state);
+
+	conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	aconnector->base.state = conn_state;
 	/* connector->encoder left NULL. */
 
 	dm_restore_drm_connector_state(drm, &aconnector->base);
 
 	KUNIT_EXPECT_NULL(test, aconnector->base.encoder);
@@ -6275,20 +6281,25 @@ static void dm_test_restore_state_no_encoder(struct kunit *test)
  * dc stream, so the function returns before comparing sinks.
  */
 static void dm_test_restore_state_no_stream(struct kunit *test)
 {
 	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct drm_connector_state *conn_state;
 	struct amdgpu_dm_connector *aconnector;
 	struct dm_crtc_state *acrtc_state;
 	struct drm_encoder *enc;
 	struct drm_crtc *crtc;
 
 	aconnector = dm_test_add_connector(test, drm,
 					   DRM_MODE_CONNECTOR_HDMIA);
 	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
-	aconnector->base.funcs->reset(&aconnector->base);
+
+	conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	aconnector->base.state = conn_state;
 
 	enc = kunit_kzalloc(test, sizeof(*enc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, enc);
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, crtc);
@@ -6313,21 +6324,26 @@ static void dm_test_restore_state_no_stream(struct kunit *test)
  * nothing to restore, so the forced atomic commit is not issued.
  */
 static void dm_test_restore_state_same_sink(struct kunit *test)
 {
 	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct drm_connector_state *conn_state;
 	struct amdgpu_dm_connector *aconnector;
 	struct dm_crtc_state *acrtc_state;
 	struct dc_stream_state *stream;
 	struct drm_encoder *enc;
 	struct drm_crtc *crtc;
 
 	aconnector = dm_test_add_connector(test, drm,
 					   DRM_MODE_CONNECTOR_HDMIA);
 	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
-	aconnector->base.funcs->reset(&aconnector->base);
+
+	conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	aconnector->base.state = conn_state;
 
 	enc = kunit_kzalloc(test, sizeof(*enc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, enc);
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, crtc);
@@ -7030,10 +7046,11 @@ static void dm_test_mode_valid_no_dc_sink(struct kunit *test)
  */
 static void dm_test_mode_valid_force_on_no_stream(struct kunit *test)
 {
 	struct dm_test_cvs_ctx *ctx =
 		dm_test_cvs_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct drm_connector_state *conn_state;
 	struct dc_sink *em_sink;
 
 	em_sink = kunit_kzalloc(test, sizeof(*em_sink), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, em_sink);
 
@@ -7042,12 +7059,14 @@ static void dm_test_mode_valid_force_on_no_stream(struct kunit *test)
 	ctx->aconnector->base.force = DRM_FORCE_ON;
 
 	/* drm_connector_cleanup() kfree()s connector->state, so it must not
 	 * point at KUnit-managed memory.
 	 */
-	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
-	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
+	conn_state = amdgpu_dm_connector_atomic_create_state(&ctx->aconnector->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	ctx->aconnector->base.state = conn_state;
 	ctx->aconnector->base.state->max_requested_bpc = 4;
 
 	KUNIT_EXPECT_EQ(test,
 			amdgpu_dm_connector_mode_valid(&ctx->aconnector->base,
 						       ctx->mode),
@@ -7557,10 +7576,11 @@ static void dm_test_update_after_detect_disconnect(struct kunit *test)
 {
 	struct dm_test_uad_ctx *ctx =
 		dm_test_uad_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
 	struct dc_sink *old_sink = dm_test_uad_owned_sink();
 	struct dc_crtc_timing *timing = kzalloc_obj(*timing, GFP_KERNEL);
+	struct drm_connector_state *conn_state;
 
 	KUNIT_ASSERT_NOT_NULL(test, old_sink);
 	KUNIT_ASSERT_NOT_NULL(test, timing);
 
 	mutex_init(&ctx->adev->dm.audio_lock);
@@ -7568,12 +7588,14 @@ static void dm_test_update_after_detect_disconnect(struct kunit *test)
 	ctx->aconnector->timing_requested = timing;
 	ctx->aconnector->num_modes = 3;
 	ctx->aconnector->audio_inst = 5;
 	ctx->link->local_sink = NULL;
 
-	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
-	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
+	conn_state = amdgpu_dm_connector_atomic_create_state(&ctx->aconnector->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	ctx->aconnector->base.state = conn_state;
 	ctx->aconnector->base.state->content_protection =
 		DRM_MODE_CONTENT_PROTECTION_ENABLED;
 
 	amdgpu_dm_update_connector_after_detect(ctx->aconnector);
 
@@ -9197,10 +9219,11 @@ struct dm_test_fs_caps_ctx {
  * parser to succeed install one.
  */
 static struct dm_test_fs_caps_ctx *
 dm_test_fs_caps_ctx_alloc(struct kunit *test, enum signal_type sink_signal)
 {
+	struct drm_connector_state *conn_state;
 	struct dm_test_fs_caps_ctx *ctx;
 	struct dc_context *dc_ctx;
 	struct device *dev;
 	struct dc *dc;
 
@@ -9222,12 +9245,15 @@ dm_test_fs_caps_ctx_alloc(struct kunit *test, enum signal_type sink_signal)
 	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
 	KUNIT_ASSERT_EQ(test,
 			drmm_connector_init(ctx->drm, &ctx->aconnector->base,
 					    &dm_test_connector_funcs,
 					    DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
-	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
-	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
+
+	conn_state = amdgpu_dm_connector_atomic_create_state(&ctx->aconnector->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	ctx->aconnector->base.state = conn_state;
 	KUNIT_ASSERT_EQ(test,
 			drm_connector_attach_vrr_capable_property(&ctx->aconnector->base), 0);
 
 	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dc_ctx);
@@ -9628,11 +9654,11 @@ dm_test_force_dup_state_fail(struct drm_connector *connector)
 {
 	return NULL;
 }
 
 static const struct drm_connector_funcs dm_test_force_fail_funcs = {
-	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
 	.atomic_duplicate_state = dm_test_force_dup_state_fail,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 /* The atomic modeset check dereferences the helper funcs unconditionally. */
@@ -9845,14 +9871,14 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* decide_crtc_timing_for_drm_display_mode */
 	KUNIT_CASE(dm_test_decide_crtc_timing_scale_enabled),
 	KUNIT_CASE(dm_test_decide_crtc_timing_matching_mode),
 	KUNIT_CASE(dm_test_decide_crtc_timing_no_copy),
 	KUNIT_CASE(dm_test_decide_crtc_timing_no_crtc_clock),
-	/* amdgpu_dm_connector_funcs_reset */
-	KUNIT_CASE(dm_test_funcs_reset_sets_defaults),
-	KUNIT_CASE(dm_test_funcs_reset_edp_abm_level),
-	KUNIT_CASE(dm_test_funcs_reset_edp_abm_disabled),
+	/* amdgpu_dm_connector_atomic_create_state */
+	KUNIT_CASE(dm_test_atomic_create_sets_defaults),
+	KUNIT_CASE(dm_test_atomic_create_edp_abm_level),
+	KUNIT_CASE(dm_test_atomic_create_edp_abm_disabled),
 	/* amdgpu_dm_connector_atomic_duplicate_state */
 	KUNIT_CASE(dm_test_atomic_dup_state_copies_fields),
 	/* amdgpu_dm_fill_hdr_info_packet */
 	KUNIT_CASE(dm_test_fill_hdr_null_metadata),
 	KUNIT_CASE(dm_test_fill_hdr_zeroes_output),

-- 
2.55.0

