Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA776606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9XsEXkx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D9831128BD;
	Fri, 30 Oct 2026 15:15:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE6001128B4;
 Fri, 30 Oct 2026 15:15:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 40FF76061A;
 Fri, 30 Oct 2026 15:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657CB1F0093A;
 Fri, 30 Oct 2026 15:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373350;
 bh=/omz53eTzACcTUmzlC6FL94xP+yqFuT0k8W0FixAkaw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=V9XsEXkxvASbruAvyi6JxRJDOxkyLBRrJCHMKZXhRUueu+1mieowqHi6fwoLpUWPL
 aVf/rBJVuejQia6IgMSovOjLdhbN1dBdYJpLCWmJu0H/ykHsll4P1qxRl6qxuKs3UP
 rQKujR0zKn2O0bbhsVGwBH7b+yFtPPyGuCTEY6RSF7P0jAsX6bSk8K68U2h4CQ47M1
 YlTMXEjKWGAYwtBeb/B1SGZ1kuGOwlhS3yArE7i5hFbOJW5+QAu0sQjnEay5DP3hf+
 0qECFcu8jXkR8LpALD427khtxpupHGBO068pJN1wgvXSADw7v7v/ZDYaZabez4YyFR
 tVGR3VhX+Swuw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:14:02 +0100
Subject: [PATCH v3 32/37] drm/amdgpu: dm: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-32-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=18703; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Z2oBJtj8vhpSCC6Jn+p0S2V2nYmgRGEA02ZKMw6AimE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtmgnh5vFdfZ0hYXnWe2ylrYsbfh7YVXcj7OKTZJ9r
 1fcUPLomMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABPZzczYcGfhR4e1t8QXcN23
 NlmwkKn6WKufxKMLnQZzv8itrHt2ZVeogXV5/JY3zg9/+5z4zNa+gbGhmyfinv3C61vvcMsdP7U
 xYVmb7sXqSTmil7QZA5YyJrrN711ZUCYy+WL4q0rWA/NEghYDAA==
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
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  32 ++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  11 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  17 +++-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 102 ++++++++++++++-------
 5 files changed, 113 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 3a4e98b08ac1..e59595b5e39b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1942,20 +1942,14 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
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
@@ -1973,6 +1967,8 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 			state->abm_level = amdgpu_dm_abm_level;
 	}
+
+	return &state->base;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_funcs_reset);
+EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_create_state);
 
 struct drm_connector_state *
@@ -2073,8 +2069,8 @@ EXPORT_IF_KUNIT(amdgpu_dm_connector_funcs_force);
 
 static const struct drm_connector_funcs amdgpu_dm_connector_funcs = {
-	.reset = amdgpu_dm_connector_funcs_reset,
 	.detect = amdgpu_dm_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = amdgpu_dm_connector_destroy,
+	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -3200,6 +3196,14 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
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
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 79698deacf61..4a73fc607f38 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -51,5 +51,6 @@ struct drm_edid;
 struct drm_property;
 
-void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector);
+struct drm_connector_state *
+amdgpu_dm_connector_atomic_create_state(struct drm_connector *connector);
 
 struct drm_connector_state *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index a5b15bef8aa0..e28fbd1b6790 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -259,5 +259,5 @@ static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = dm_dp_mst_connector_destroy,
-	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -672,4 +672,5 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *conn_state;
 	struct drm_connector *connector;
 	int i;
@@ -739,5 +740,11 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	 * framebuffer lists
 	 */
-	amdgpu_dm_connector_funcs_reset(connector);
+	conn_state = amdgpu_dm_connector_atomic_create_state(connector);
+	if (!IS_ERR(conn_state)) {
+		if (connector->state)
+			connector->funcs->atomic_destroy_state(connector, connector->state);
+
+		connector->state = conn_state;
+	}
 
 	drm_dp_mst_get_port_malloc(port);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 6f91a992d43f..39b7b3e49f6b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -226,5 +226,5 @@ static const struct drm_connector_funcs amdgpu_dm_wb_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -241,4 +241,5 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 				uint32_t link_index)
 {
+	struct drm_connector *connector;
 	struct dc *dc = dm->dc;
 	struct dc_link *link = dc_get_link_at_index(dc, link_index);
@@ -262,6 +263,16 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 	 * Allocate some default initial connector state with our reset helper.
 	 */
-	if (wbcon->base.base.funcs->reset)
-		wbcon->base.base.funcs->reset(&wbcon->base.base);
+	connector = &wbcon->base.base;
+	if (connector->funcs->atomic_create_state) {
+		struct drm_connector_state *conn_state;
+
+		conn_state = amdgpu_dm_connector_atomic_create_state(connector);
+		if (!IS_ERR(conn_state)) {
+			if (connector->state)
+				connector->funcs->atomic_destroy_state(connector, connector->state);
+
+			connector->state = conn_state;
+		}
+	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 8117aaf41f22..8ebe37ec83bf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -1469,8 +1469,8 @@ static void dm_test_decide_crtc_timing_no_crtc_clock(struct kunit *test)
 }
 
-/* Tests for amdgpu_dm_connector_funcs_reset() */
+/* Tests for amdgpu_dm_connector_atomic_create_state() */
 
 static const struct drm_connector_funcs dm_test_connector_funcs = {
-	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -1478,12 +1478,13 @@ static const struct drm_connector_funcs dm_test_connector_funcs = {
 
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
+	struct drm_connector_state *conn_state;
 	struct dm_connector_state *dm_state;
 
@@ -1502,7 +1503,9 @@ static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
 			    DRM_MODE_CONNECTOR_DisplayPort, NULL);
 
-	amdgpu_dm_connector_funcs_reset(connector);
+	conn_state = amdgpu_dm_connector_atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	connector->state = conn_state;
 
-	KUNIT_ASSERT_NOT_NULL(test, connector->state);
 	dm_state = to_dm_connector_state(connector->state);
 	KUNIT_EXPECT_EQ(test, (int)dm_state->scaling, (int)RMX_OFF);
@@ -1516,12 +1519,13 @@ static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
 
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
+	struct drm_connector_state *conn_state;
 	struct dm_connector_state *dm_state;
 	int saved_abm_level = amdgpu_dm_get_abm_level_param();
@@ -1543,7 +1547,10 @@ static void dm_test_funcs_reset_edp_abm_level(struct kunit *test)
 	/* Test with abm_level > 0 */
 	amdgpu_dm_set_abm_level_param(3);
-	amdgpu_dm_connector_funcs_reset(connector);
 
-	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	conn_state = amdgpu_dm_connector_atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	connector->state = conn_state;
+
 	dm_state = to_dm_connector_state(connector->state);
 	KUNIT_EXPECT_EQ(test, (int)dm_state->abm_level, 3);
@@ -1553,13 +1560,14 @@ static void dm_test_funcs_reset_edp_abm_level(struct kunit *test)
 
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
+	struct drm_connector_state *conn_state;
 	struct dm_connector_state *dm_state;
 	int saved_abm_level = amdgpu_dm_get_abm_level_param();
@@ -1581,7 +1589,10 @@ static void dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
 	/* Test with abm_level <= 0 → immediate disable */
 	amdgpu_dm_set_abm_level_param(-1);
-	amdgpu_dm_connector_funcs_reset(connector);
 
-	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	conn_state = amdgpu_dm_connector_atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	connector->state = conn_state;
+
 	dm_state = to_dm_connector_state(connector->state);
 	KUNIT_EXPECT_EQ(test, (int)dm_state->abm_level,
@@ -1603,4 +1614,5 @@ static void dm_test_atomic_dup_state_copies_fields(struct kunit *test)
 	struct drm_device *drm;
 	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
 	struct dm_connector_state *dm_state;
 	struct dm_connector_state *new_dm_state;
@@ -1621,6 +1633,8 @@ static void dm_test_atomic_dup_state_copies_fields(struct kunit *test)
 			    DRM_MODE_CONNECTOR_HDMIA, NULL);
 
-	amdgpu_dm_connector_funcs_reset(connector);
-	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	conn_state = amdgpu_dm_connector_atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	connector->state = conn_state;
 
 	/* Modify original state fields */
@@ -4887,5 +4901,5 @@ static struct dm_test_destroy_ctx *dm_test_destroy_ctx_alloc(struct kunit *test)
  */
 static const struct drm_connector_funcs dm_test_destroy_funcs = {
-	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -6254,4 +6268,5 @@ static void dm_test_restore_state_no_encoder(struct kunit *test)
 	struct drm_device *drm = dm_test_alloc_drm(test);
 	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *conn_state;
 
 	aconnector = dm_test_add_connector(test, drm,
@@ -6259,6 +6274,9 @@ static void dm_test_restore_state_no_encoder(struct kunit *test)
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
 
@@ -6278,4 +6296,5 @@ static void dm_test_restore_state_no_stream(struct kunit *test)
 {
 	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct drm_connector_state *conn_state;
 	struct amdgpu_dm_connector *aconnector;
 	struct dm_crtc_state *acrtc_state;
@@ -6287,5 +6306,9 @@ static void dm_test_restore_state_no_stream(struct kunit *test)
 	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
-	aconnector->base.funcs->reset(&aconnector->base);
+
+	conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	aconnector->base.state = conn_state;
 
 	enc = kunit_kzalloc(test, sizeof(*enc), GFP_KERNEL);
@@ -6316,4 +6339,5 @@ static void dm_test_restore_state_same_sink(struct kunit *test)
 {
 	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct drm_connector_state *conn_state;
 	struct amdgpu_dm_connector *aconnector;
 	struct dm_crtc_state *acrtc_state;
@@ -6326,5 +6350,9 @@ static void dm_test_restore_state_same_sink(struct kunit *test)
 	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
-	aconnector->base.funcs->reset(&aconnector->base);
+
+	conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	aconnector->base.state = conn_state;
 
 	enc = kunit_kzalloc(test, sizeof(*enc), GFP_KERNEL);
@@ -7033,4 +7061,5 @@ static void dm_test_mode_valid_force_on_no_stream(struct kunit *test)
 	struct dm_test_cvs_ctx *ctx =
 		dm_test_cvs_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct drm_connector_state *conn_state;
 	struct dc_sink *em_sink;
 
@@ -7045,6 +7074,8 @@ static void dm_test_mode_valid_force_on_no_stream(struct kunit *test)
 	 * point at KUnit-managed memory.
 	 */
-	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
-	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
+	conn_state = amdgpu_dm_connector_atomic_create_state(&ctx->aconnector->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	ctx->aconnector->base.state = conn_state;
 	ctx->aconnector->base.state->max_requested_bpc = 4;
 
@@ -7560,4 +7591,5 @@ static void dm_test_update_after_detect_disconnect(struct kunit *test)
 	struct dc_sink *old_sink = dm_test_uad_owned_sink();
 	struct dc_crtc_timing *timing = kzalloc_obj(*timing, GFP_KERNEL);
+	struct drm_connector_state *conn_state;
 
 	KUNIT_ASSERT_NOT_NULL(test, old_sink);
@@ -7571,6 +7603,8 @@ static void dm_test_update_after_detect_disconnect(struct kunit *test)
 	ctx->link->local_sink = NULL;
 
-	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
-	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
+	conn_state = amdgpu_dm_connector_atomic_create_state(&ctx->aconnector->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	ctx->aconnector->base.state = conn_state;
 	ctx->aconnector->base.state->content_protection =
 		DRM_MODE_CONTENT_PROTECTION_ENABLED;
@@ -9200,4 +9234,5 @@ static struct dm_test_fs_caps_ctx *
 dm_test_fs_caps_ctx_alloc(struct kunit *test, enum signal_type sink_signal)
 {
+	struct drm_connector_state *conn_state;
 	struct dm_test_fs_caps_ctx *ctx;
 	struct dc_context *dc_ctx;
@@ -9225,6 +9260,9 @@ dm_test_fs_caps_ctx_alloc(struct kunit *test, enum signal_type sink_signal)
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
@@ -9631,5 +9669,5 @@ dm_test_force_dup_state_fail(struct drm_connector *connector)
 
 static const struct drm_connector_funcs dm_test_force_fail_funcs = {
-	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
 	.atomic_duplicate_state = dm_test_force_dup_state_fail,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -9848,8 +9886,8 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
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

-- 
2.55.0

