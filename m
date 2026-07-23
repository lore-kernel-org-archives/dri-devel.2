Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A6BC531FA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 23:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F5E10F257;
	Thu, 23 Jul 2026 23:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pOcuRlTw";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D383810F255;
 Thu, 23 Jul 2026 23:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=Ek/7ha9nYx7nF4x7Mfvv+yu77d1iC2nPQYMX/1iUF6U=; b=
 pOcuRlTw5SFhoNo9c9K4Tx0Qfc5Ucv5wCerijSzJfFqGnuwJgrGkj7+Y7Y1i1NDUIaNv+SRs0Zusw
 UbHh3IoQgRku17Y7vtrR0KbTPKM/wIOWG5ZBV+8EJkVy/yVDx8+KP9YHpvp80HDZR3bvkVrxsLCbs
 gu6foGM6p5RTggvWrknfInXSPQtufORrKEmCxLGGriB65fQ6XAcZLXGAUsGlUxhdGH7Db3kWDKbVu
 HK4PtBGyHgqau+uHZhQFHcfmAb+dEymEmcNawJd1lnEjVBAG3g3GL92pLHH+LjZUo4SMEFTAmE+Nr
 PLNa+9QjWUXt6JtzUUHklXB1wkeKOQU1yg==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wn2xy-003eJT-Ia; Fri, 24 Jul 2026 01:36:38 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix use-after-free bugs in KUnit tests
Date: Thu, 23 Jul 2026 16:35:48 -0700
Message-ID: <20260723233548.580891-1-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When running the KUnit tests with memory debugging enabled, a bunch of
use-after-free errors are hit. These are due to using KUnit managed
memory for the test objects but then giving them over to DRM managed
objects. The KUnit stuff is deallocated first and when the DRM side
calls its clean up helpers, it hits memory that has been freed already.

NB: There is still a use-after-free bug in the writeback tests.
However, fixing that requires driver side changes as well as test side
changes. Those changes are part of:
  https://patchwork.freedesktop.org/series/152420/

Signed-off-by: John Harrison <John.Harrison@Igalia.com>
CC: Alex Hung <alex.hung@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 37 ++++++++++---------
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |  3 +-
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |  5 ++-
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 0a5d439f66c3..93a854d4fdfa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -12,6 +12,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_kunit_helpers.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_mode_object.h>
 #include <drm/drm_property.h>
 #include <linux/hdmi.h>
@@ -1449,7 +1450,7 @@ static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
 						   DRIVER_MODESET);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
@@ -1488,7 +1489,7 @@ static void dm_test_funcs_reset_edp_abm_level(struct kunit *test)
 						   DRIVER_MODESET);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
@@ -1526,7 +1527,7 @@ static void dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
 						   DRIVER_MODESET);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
@@ -1568,7 +1569,7 @@ static void dm_test_atomic_dup_state_copies_fields(struct kunit *test)
 						   DRIVER_MODESET);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
@@ -2359,8 +2360,8 @@ static void setup_panel_type_fixture(struct kunit *test,
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->drm);
 	fixture->adev = drm_to_adev(fixture->drm);
 
-	fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture->aconnector),
-					    GFP_KERNEL);
+	fixture->aconnector = drmm_kzalloc(fixture->drm, sizeof(*fixture->aconnector),
+					   GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
 	fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
@@ -2554,9 +2555,9 @@ static void dm_test_update_subconnector_dp_with_sink(struct kunit *test)
 						   DRIVER_MODESET);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
-	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	drmm_connector_init(drm, &aconnector->base, &dm_test_connector_funcs,
@@ -2598,9 +2599,9 @@ static void dm_test_update_subconnector_dp_no_sink(struct kunit *test)
 						   DRIVER_MODESET);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
-	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	drmm_connector_init(drm, &aconnector->base, &dm_test_connector_funcs,
@@ -2641,9 +2642,9 @@ static void dm_test_update_subconnector_non_dp_noop(struct kunit *test)
 						   DRIVER_MODESET);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
-	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	drmm_connector_init(drm, &aconnector->base, &dm_test_connector_funcs,
@@ -2657,7 +2658,7 @@ static void dm_test_update_subconnector_non_dp_noop(struct kunit *test)
 
 	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
 	aconnector->dc_link = link;
-	aconnector->dc_sink = kunit_kzalloc(test, sizeof(*aconnector->dc_sink), GFP_KERNEL);
+	aconnector->dc_sink = drmm_kzalloc(drm, sizeof(*aconnector->dc_sink), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
 
 	update_subconnector_property(aconnector);
@@ -2804,7 +2805,7 @@ static struct amdgpu_dm_connector *dm_test_add_connector(struct kunit *test,
 {
 	struct amdgpu_dm_connector *aconnector;
 
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
 	KUNIT_ASSERT_EQ(test,
@@ -3103,7 +3104,7 @@ static struct dm_test_panel_ctx *dm_test_panel_ctx_alloc(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, prop);
 	ctx->drm->mode_config.panel_type_property = prop;
 
-	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx->aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
 	KUNIT_ASSERT_EQ(test,
 		drmm_connector_init(ctx->drm, &ctx->aconnector->base,
@@ -3112,7 +3113,7 @@ static struct dm_test_panel_ctx *dm_test_panel_ctx_alloc(struct kunit *test)
 	drm_object_attach_property(&ctx->aconnector->base.base, prop,
 				   DRM_MODE_PANEL_TYPE_UNKNOWN);
 
-	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	ctx->link = drmm_kzalloc(ctx->drm, sizeof(*ctx->link), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
 	ctx->aconnector->dc_link = ctx->link;
 
@@ -3376,14 +3377,14 @@ static struct dm_test_fill_ctx *dm_test_fill_ctx_alloc(struct kunit *test)
 						       DRIVER_MODESET);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
 
-	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx->aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
 	KUNIT_ASSERT_EQ(test,
 		drmm_connector_init(ctx->drm, &ctx->aconnector->base,
 				    &dm_test_connector_funcs,
 				    DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
 
-	ctx->conn_state = kunit_kzalloc(test, sizeof(*ctx->conn_state), GFP_KERNEL);
+	ctx->conn_state = drmm_kzalloc(ctx->drm, sizeof(*ctx->conn_state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->conn_state);
 	ctx->stream = kunit_kzalloc(test, sizeof(*ctx->stream), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->stream);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
index 58615cdbe854..7d5e3823b33b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
@@ -8,6 +8,7 @@
 #include <kunit/test.h>
 #include <linux/module.h>
 #include <drm/drm_kunit_helpers.h>
+#include <drm/drm_managed.h>
 
 #include "dc.h"
 #include "core_types.h"
@@ -127,7 +128,7 @@ struct amdgpu_dm_connector *dm_kunit_alloc_connector(struct kunit *test,
 {
 	struct amdgpu_dm_connector *aconnector;
 
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	aconnector = drmm_kzalloc(adev_to_drm(adev), sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
 	if (adev)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
index b43bc244487e..3454cf371414 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -12,6 +12,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_kunit_helpers.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_writeback.h>
@@ -266,7 +267,7 @@ static void dm_test_wb_get_modes_returns_modes(struct kunit *test)
 						   DRIVER_MODESET | DRIVER_ATOMIC);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	drmm_connector_init(drm, connector, &dm_wb_test_connector_funcs,
@@ -301,7 +302,7 @@ static void dm_test_wb_get_modes_bounded_by_max(struct kunit *test)
 						   DRIVER_MODESET | DRIVER_ATOMIC);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	drmm_connector_init(drm, connector, &dm_wb_test_connector_funcs,
-- 
2.43.0

