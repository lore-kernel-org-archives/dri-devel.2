Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F9606A32F
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=HQzqO7cb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0777810FC47;
	Wed,  4 Nov 2026 14:16:17 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A8710FC3C
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 14:15:58 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jKSCd2V56zMlrQ;
 Wed, 04 Nov 2026 15:15:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793801757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGWSQ0SF02Bk2CMtwISbmSt6ej2GWOV5zGIuMa8VKjI=;
 b=HQzqO7cbeSgAzQamvIVrcxucsenOhnrM3hwxMsabbMvHErMSUVTiCXCJfxsRHNPI7De37T
 rzIgwuk9RJf6Mn3tPmvhIyBWFA7ytkfclqiO6ujBUCTRloErhGaUobTPSoquw2w6FFRxWL
 c+3i5In+Che72kOG4IaUFYbwngX4x8acqsp2WIEz1aI3djlRhw3Q91UNvIHw3x/7LTxgey
 B7Fs4/Ta0IfdwFlEol7CdPER+qol9kR4lxZ+tO2zXLBuWMLQGW8bLNKKZx6uQAKPLkiJw0
 SBF1GQFRQh1fNNrplL9H+5vphe5+rMkUbfG4kHgTzRWsYfm86ibM1fxNJhKAvg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
Date: Mon,  2 Nov 2026 10:17:58 +0000
Subject: [PATCH 5/5] drm/amd/display: Test panel_power_savings commits
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-abm-sysfs-commit-v1-5-e5addfd9539a@hsal.es>
References: <20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es>
In-Reply-To: <20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es>
To: sunpeng.li@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, harry.wentland@amd.com
Cc: Hugo Sales <hugo@hsal.es>, airlied@gmail.com, 
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, 
 christian.koenig@amd.com, simona@ffwll.ch, linux-doc@vger.kernel.org, 
 bhawanpreet.lakha@amd.com, ivan.lipski@amd.com, 
 dri-devel@lists.freedesktop.org, ray.wu@amd.com, alex.hung@amd.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11397; i=hugo@hsal.es;
 h=from:subject:message-id; bh=VkgZkwvVFb+iY9fUt+ZfzsaTq3i7sJOzmPQ9wbmNYFE=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl4kh8nfnfcx77oYD/s/x43puqHrbMrE/a3j8zaI9
 RhEf0j5t7+jlIVBjItBVkyRRfeGJwPLxMkzc4qeL4GZw8oEMoSBi1MAJqJsz8jQdHv7dgVtjam/
 t7Qv843/kXh3hbeNXd/miWKBkmHfkiULGRlum6i7LgvRE4j3FC05bZhrE9xpXqOfscJK/JtKZ1i
 kDAcALwtDYw==
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Rspamd-Queue-Id: 4jKSCd2V56zMlrQ
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_48_96,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add KUnit cases for a panel_power_savings write to a connector bound to a
CRTC. With the CRTC on or off, the store commits a connector state that
carries the level. When atomic check rejects the commit, the write returns
the error and the connector keeps its old level. The existing store tests
also check that a write replaces the connector state, and that a forbidden
write keeps the state and level and drops its runtime PM reference. For
the new cases, the pipe helper can route the connector to the CRTC, set
whether the CRTC is active and take CRTC helper funcs

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 157 ++++++++++++++++++++-
 1 file changed, 150 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 35e245b078f7a..d58418c88592c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -10,6 +10,7 @@
 #include <linux/pm_runtime.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_managed.h>
@@ -564,16 +565,43 @@ static const struct drm_connector_helper_funcs dm_test_pps_connector_helper_func
 	.get_modes = dm_test_pps_get_modes,
 };
 
+static int dm_test_pps_crtc_atomic_check_fail(struct drm_crtc *crtc,
+					      struct drm_atomic_commit *state)
+{
+	return -ENOSPC;
+}
+
+static const struct drm_crtc_helper_funcs dm_test_pps_crtc_helper_funcs_fail = {
+	.atomic_check = dm_test_pps_crtc_atomic_check_fail,
+};
+
+/* The generic helpers accept a commit that allows a modeset it doesn't need */
+static int dm_test_pps_crtc_atomic_check_no_modeset(struct drm_crtc *crtc,
+						    struct drm_atomic_commit *state)
+{
+	return state->allow_modeset ? -EINVAL : 0;
+}
+
+static const struct drm_crtc_helper_funcs dm_test_pps_crtc_helper_funcs_no_modeset = {
+	.atomic_check = dm_test_pps_crtc_atomic_check_no_modeset,
+};
+
 /*
  * Build a primary plane, a CRTC, an encoder and an eDP connector that the
- * store can commit to. The KUnit device uses the generic atomic helpers, so a
- * commit runs drm_atomic_helper_check() and drm_atomic_helper_commit() rather
- * than the DM implementations
+ * store can commit to. With @bound, the connector's current state is routed
+ * to the CRTC, which is enabled and has @active as its active state. The KUnit
+ * device uses the generic atomic helpers, so a commit runs
+ * drm_atomic_helper_check() and drm_atomic_helper_commit() rather than the DM
+ * implementations. A NULL @crtc_helper_funcs gives the KUnit helper's defaults
  */
 static struct drm_connector *
-setup_panel_power_savings_pipe(struct kunit *test, struct device **device_out)
+setup_panel_power_savings_pipe(struct kunit *test, struct device **device_out,
+			       bool bound, bool active,
+			       const struct drm_crtc_helper_funcs *crtc_helper_funcs)
 {
 	struct amdgpu_dm_connector *aconnector;
+	struct drm_display_mode *mode;
+	struct drm_crtc_state *crtc_state;
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
 	struct amdgpu_device *adev;
@@ -589,7 +617,7 @@ setup_panel_power_savings_pipe(struct kunit *test, struct device **device_out)
 							NULL, NULL, 0, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
 	crtc = drm_kunit_helper_create_crtc(test, &adev->ddev, primary, NULL,
-					    NULL, NULL);
+					    NULL, crtc_helper_funcs);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
 
 	encoder = drmm_kzalloc(&adev->ddev, sizeof(*encoder), GFP_KERNEL);
@@ -609,6 +637,21 @@ setup_panel_power_savings_pipe(struct kunit *test, struct device **device_out)
 
 	drm_mode_config_reset(&adev->ddev);
 
+	if (bound) {
+		/* A connector state bound to a CRTC holds a connector reference */
+		connector->state->crtc = crtc;
+		drm_connector_get(connector);
+		connector->state->best_encoder = encoder;
+		crtc_state = crtc->state;
+		crtc_state->connector_mask = drm_connector_mask(connector);
+		crtc_state->encoder_mask = drm_encoder_mask(encoder);
+		crtc_state->enable = true;
+		crtc_state->active = active;
+		mode = drm_kunit_display_mode_from_cea_vic(test, &adev->ddev, 1);
+		KUNIT_ASSERT_NOT_NULL(test, mode);
+		KUNIT_ASSERT_EQ(test, drm_atomic_set_mode_for_crtc(crtc_state, mode), 0);
+	}
+
 	device = kunit_kzalloc(test, sizeof(*device), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, device);
 	dev_set_drvdata(device, connector);
@@ -617,6 +660,14 @@ setup_panel_power_savings_pipe(struct kunit *test, struct device **device_out)
 	return connector;
 }
 
+static void dm_test_pps_expect_no_pm_reference(struct kunit *test,
+					       struct drm_connector *connector)
+{
+#ifdef CONFIG_PM
+	KUNIT_EXPECT_EQ(test, atomic_read(&connector->dev->dev->power.usage_count), 0);
+#endif
+}
+
 static void dm_test_free_sysfs_buf(void *data)
 {
 	free_page((unsigned long)data);
@@ -677,17 +728,24 @@ static void dm_test_panel_power_savings_show_reports_level(struct kunit *test)
 /**
  * dm_test_panel_power_savings_store_sets_disable - Test zero maps to disable
  * @test: The KUnit test context
+ *
+ * With no CRTC on the connector, the store commits a connector state that
+ * carries the disable sentinel
  */
 static void dm_test_panel_power_savings_store_sets_disable(struct kunit *test)
 {
+	struct drm_connector_state *old_state;
 	struct drm_connector *connector;
 	struct device *device;
 	size_t count = strlen("0");
 
-	connector = setup_panel_power_savings_pipe(test, &device);
+	connector = setup_panel_power_savings_pipe(test, &device, false, false, NULL);
+	to_dm_connector_state(connector->state)->abm_level = 2;
+	old_state = connector->state;
 
 	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "0", count),
 			 (ssize_t)count);
+	KUNIT_EXPECT_PTR_NE(test, connector->state, old_state);
 	KUNIT_EXPECT_EQ(test, to_dm_connector_state(connector->state)->abm_level,
 			ABM_LEVEL_IMMEDIATE_DISABLE);
 }
@@ -695,6 +753,9 @@ static void dm_test_panel_power_savings_store_sets_disable(struct kunit *test)
 /**
  * dm_test_panel_power_savings_store_forbidden - Test forbidden update
  * @test: The KUnit test context
+ *
+ * Once the DRM master owns the level, the store fails without committing and
+ * drops its runtime PM reference
  */
 static void dm_test_panel_power_savings_store_forbidden(struct kunit *test)
 {
@@ -702,11 +763,15 @@ static void dm_test_panel_power_savings_store_forbidden(struct kunit *test)
 	struct drm_connector *connector;
 	struct device *device;
 
-	connector = setup_panel_power_savings_pipe(test, &device);
+	connector = setup_panel_power_savings_pipe(test, &device, false, false, NULL);
 	dm_state = to_dm_connector_state(connector->state);
 	dm_state->abm_sysfs_forbidden = true;
+	dm_state->abm_level = 2;
 
 	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "1", 1), -EBUSY);
+	KUNIT_EXPECT_PTR_EQ(test, connector->state, &dm_state->base);
+	KUNIT_EXPECT_EQ(test, dm_state->abm_level, 2);
+	dm_test_pps_expect_no_pm_reference(test, connector);
 }
 
 /**
@@ -755,6 +820,81 @@ static void dm_test_panel_power_savings_store_rejects_out_of_range(struct kunit
 	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "5", 1), -EINVAL);
 }
 
+/**
+ * dm_test_panel_power_savings_store_inactive_crtc - Test store with the CRTC off
+ * @test: The KUnit test context
+ *
+ * With the connector's CRTC enabled but inactive, the store still commits a
+ * connector state that carries the level, without allowing a modeset, and
+ * drops its runtime PM reference
+ */
+static void dm_test_panel_power_savings_store_inactive_crtc(struct kunit *test)
+{
+	struct drm_connector_state *old_state;
+	struct drm_connector *connector;
+	struct device *device;
+
+	connector = setup_panel_power_savings_pipe(test, &device, true, false,
+						   &dm_test_pps_crtc_helper_funcs_no_modeset);
+	old_state = connector->state;
+
+	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "3", 1), 1);
+	KUNIT_EXPECT_PTR_NE(test, connector->state, old_state);
+	KUNIT_EXPECT_EQ(test, to_dm_connector_state(connector->state)->abm_level, 3);
+	KUNIT_EXPECT_FALSE(test, drm_atomic_crtc_needs_modeset(connector->state->crtc->state));
+	dm_test_pps_expect_no_pm_reference(test, connector);
+}
+
+/**
+ * dm_test_panel_power_savings_store_active_crtc - Test store with the CRTC on
+ * @test: The KUnit test context
+ *
+ * With the connector's CRTC active, the store commits a connector state that
+ * carries the level, without allowing a modeset, and drops its runtime PM
+ * reference
+ */
+static void dm_test_panel_power_savings_store_active_crtc(struct kunit *test)
+{
+	struct drm_connector_state *old_state;
+	struct drm_connector *connector;
+	struct device *device;
+
+	connector = setup_panel_power_savings_pipe(test, &device, true, true,
+						   &dm_test_pps_crtc_helper_funcs_no_modeset);
+	old_state = connector->state;
+
+	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "2", 1), 1);
+	KUNIT_EXPECT_PTR_NE(test, connector->state, old_state);
+	KUNIT_EXPECT_EQ(test, to_dm_connector_state(connector->state)->abm_level, 2);
+	KUNIT_EXPECT_FALSE(test, drm_atomic_crtc_needs_modeset(connector->state->crtc->state));
+	dm_test_pps_expect_no_pm_reference(test, connector);
+}
+
+/**
+ * dm_test_panel_power_savings_store_commit_fails - Test store when the commit fails
+ * @test: The KUnit test context
+ *
+ * When atomic check rejects the commit, the write returns the error, the
+ * current connector state keeps the old level and the runtime PM reference is
+ * dropped
+ */
+static void dm_test_panel_power_savings_store_commit_fails(struct kunit *test)
+{
+	struct drm_connector_state *old_state;
+	struct drm_connector *connector;
+	struct device *device;
+
+	connector = setup_panel_power_savings_pipe(test, &device, true, true,
+						   &dm_test_pps_crtc_helper_funcs_fail);
+	to_dm_connector_state(connector->state)->abm_level = 1;
+	old_state = connector->state;
+
+	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "4", 1), -ENOSPC);
+	KUNIT_EXPECT_PTR_EQ(test, connector->state, old_state);
+	KUNIT_EXPECT_EQ(test, to_dm_connector_state(connector->state)->abm_level, 1);
+	dm_test_pps_expect_no_pm_reference(test, connector);
+}
+
 /* Tests for amdgpu_dm_backlight_get_device_index() */
 
 /**
@@ -2017,6 +2157,9 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_panel_power_savings_store_forbidden),
 	KUNIT_CASE(dm_test_panel_power_savings_store_rejects_invalid_text),
 	KUNIT_CASE(dm_test_panel_power_savings_store_rejects_out_of_range),
+	KUNIT_CASE(dm_test_panel_power_savings_store_inactive_crtc),
+	KUNIT_CASE(dm_test_panel_power_savings_store_active_crtc),
+	KUNIT_CASE(dm_test_panel_power_savings_store_commit_fails),
 	/* amdgpu_dm_backlight_get_device_index */
 	KUNIT_CASE(dm_test_backlight_device_index_matches_second),
 	KUNIT_CASE(dm_test_backlight_device_index_missing_fallback),

-- 
2.56.0

