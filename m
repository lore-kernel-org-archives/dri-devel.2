Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E63FCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F8910FE87;
	Wed, 14 Oct 2026 17:27:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC1310EAA7;
 Wed, 14 Oct 2026 17:27:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D40460229;
 Wed, 14 Oct 2026 17:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3EA1F000C4;
 Wed, 14 Oct 2026 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998846;
 bh=BJbnbqvZZjKoLFAQbqCfnzx2c+AkzP7deBgF/39ycPE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lOGCf3BcTY2pKZI+YT2ZE57DiiTer25cBgfbCG6PA9u09zXHbq3q7HnqNNQfFxj+t
 SObITLSpQhd4GGWm8+hmJDQT/roOdloPdjp+yjW4iZtTh1N/O6uXHWdMY2go6hClHN
 bQDrVAiDDEg570ur9Pb0DsschrB7Scqq9vd8fpvEuPqhVjCX2/fou4rK3XQGEClMbi
 SLcXjvs98dJbzVjvIe3eeyaqeXFhUvR409twGvnJPt+26V2ZEFETfL4HZnBvIhdrfU
 Eu7QH7SlAyM63lD0ITkyXQHapisTGD0tE9Y9xyOi9X1SP1pnAffZPVZYP3Qi2DtzCk
 E0lPjqGscGBxw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:27 +0200
Subject: [PATCH 04/75] drm/amdgpu: dm: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-4-586c9c026823@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8998; i=mripard@kernel.org;
 h=from:subject:message-id; bh=uivlowmeJ5uOEzRQHFD36/CIhhkzfujkOv7nmsPNWyY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd/vErDsUvedxf9zDJ/bnzu1fJPt1+rq9l805vk9PO
 iKyQHhvdsdUFgZhTgZZMUWWJzJhp5e3L65ysF/5A2YOKxPIEAYuTgGYyO1bjA2T7l/047H03STK
 06th4fA98obllbprj21b1+ubfjjp6zj/Z4fBt7/6hfHsdqcni89h2c/YcKEhbP1NxuxQz2WX644
 472w/z1Dm/75w+6Xn0gtMZ3/q510ndJn77+djhW7H7iyVab3IAAA=
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

The amdgpu: dm connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c | 2 +-
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   | 7 ++++---
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c   | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   | 2 +-
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    | 2 +-
 7 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
index 040a7a9c0335..9d83b7b1ca80 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
@@ -25,11 +25,11 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_audio.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
 
 static const struct drm_connector_funcs dm_test_audio_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 };
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 5221050dec2f..6e9ee3c93943 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -30,11 +30,11 @@ struct dm_backlight_connector_fixture {
 	struct amdgpu_dm_connector *aconnector;
 	struct dc_link *link;
 };
 
 static const struct drm_connector_funcs dm_backlight_test_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static void setup_test_connector(struct kunit *test,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
index 29a513dab9cd..e47b4dd210b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
@@ -173,11 +173,11 @@ static struct amdgpu_crtc *dm_test_alloc_crc_crtc(struct kunit *test,
 
 	return acrtc;
 }
 
 static const struct drm_connector_funcs dm_test_crc_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 };
@@ -652,12 +652,13 @@ static void dm_test_crtc_set_crc_source_dprx_no_connector(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, wb_conn,
 						 &dm_test_crc_connector_funcs,
 						 DRM_MODE_CONNECTOR_WRITEBACK), 0);
 	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
 			dm_test_crc_connector_cleanup, wb_conn), 0);
-	drm_atomic_helper_connector_reset(wb_conn);
-	KUNIT_ASSERT_NOT_NULL(test, wb_conn->state);
+
+	wb_conn->state = drm_atomic_helper_connector_create_state(wb_conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb_conn->state);
 	wb_conn->state->crtc = &acrtc->base;
 	/*
 	 * __drm_atomic_helper_connector_destroy_state() drops a connector
 	 * reference when state->crtc is set. Balance it here since the CRTC is
 	 * assigned directly rather than via drm_atomic_set_crtc_for_connector(),
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 51c3995de76d..a369a3cbd4af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -4104,11 +4104,11 @@ static void dm_test_is_dp_sink_present_queries_link_service(struct kunit *test)
  * drm_edid_connector_update(), which needs a fully initialised connector so the
  * EDID property blob is published. dm_kunit_alloc_connector() only fills in the
  * device pointer, so build a real one here.
  */
 static const struct drm_connector_funcs dm_test_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 };
 
 static struct amdgpu_dm_connector *dm_test_alloc_real_connector(struct kunit *test,
 								struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index dc7d94f75ff4..3265b50abb46 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -479,11 +479,11 @@ static void dm_test_destroy_hpd_rx_wq(void *data)
 			destroy_workqueue(ctx->wq[i].wq);
 	kfree(ctx->wq);
 }
 
 static const struct drm_connector_funcs dm_test_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 };
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 382eafab2d43..10a213c36af4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -1160,11 +1160,11 @@ static bool dm_mst_test_dp_get_max_link_enc_cap(const struct dc_link *link,
 static void dm_mst_test_connector_destroy(struct drm_connector *connector)
 {
 }
 
 static const struct drm_connector_funcs dm_mst_test_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.destroy = dm_mst_test_connector_destroy,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
@@ -3698,11 +3698,11 @@ static void dm_mst_test_pre_compute_configs_no_recompute(struct kunit *test)
 }
 
 /* Tests for compute_mst_dsc_configs_for_link */
 
 static const struct drm_connector_funcs dm_mst_test_dsc_link_conn_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static enum dp_link_encoding dm_mst_test_mst_encoding_format(const struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
index 03036f906385..e1e7d4c29966 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -385,11 +385,11 @@ static void dm_test_wb_atomic_check_invalid_format(struct kunit *test)
 /* Tests for amdgpu_dm_wb_connector_get_modes using DRM mock */
 
 static const struct drm_connector_funcs dm_wb_test_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 };
 
 /**
  * dm_test_wb_get_modes_returns_modes - Verify at least one mode is returned
  * @test: KUnit test context

-- 
2.55.0

