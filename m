Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24499606A32F
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=qVcmkiyM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5399F10FC3B;
	Wed,  4 Nov 2026 14:16:16 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397A810E228
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 14:15:56 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jKSCZ6MQRz8vfR;
 Wed, 04 Nov 2026 15:15:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793801754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7ZRfHabF1wqcDZIZRI1bkdD0LTemsvtrF2LyfXizqA=;
 b=qVcmkiyMRkbNNNezAps0Uc+wX0k6kprl4OhgyDUC1NsdI5TbBtOWdyG0rICzRLJCw/xdWg
 du0GNVSUmBqfobOL6/PcnjgfoMCm+o6De0yL8pLzuNDgtAIdGVjNyUWuqM88rC9kX14jsn
 O2+PtCJObDi9yKAfzjkKGwQMdqT1Hu6XfcNo6c75Cw8YmHIWDlrX0Zpjqu8Rizxobm91mv
 wbkbwrCpAQAqooh4jRtsT2DXOOhQOoztoI9bVyyQpsZqV626nuOk5qWGauOcokKHb310QL
 8I7pN6NO9iG55SY5LvEVT3HnLVkxGnM8XKePQ/gU+6Phzw2bnLDaQ3SbSJU5/g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
Date: Mon,  2 Nov 2026 10:17:56 +0000
Subject: [PATCH 3/5] drm/amd/display: Give the panel_power_savings store
 tests a full pipe
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-abm-sysfs-commit-v1-3-e5addfd9539a@hsal.es>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5728; i=hugo@hsal.es;
 h=from:subject:message-id; bh=nM3p9/rHVitMZezwQQnoIFOacvMmc2B4orZJb2OywTw=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl4kh1X7atxy/p7wszN2I8/p1w+FFJ2frE5w3j6p9
 dAJptDLs+51lLIwiHExyIopsuje8GRgmTh5Zk7R8yUwc1iZQIYwcHEKwETOxTP8d1x4oq8ssZwj
 94Bi47blikfbBUzkX7TLfxI/4Bdc/UT4MsM/FY61LT6LYjgi5SU/2AYXq9sdUMlbZvqYwXT1b2P
 nN0bMAPQ4SQ4=
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Rspamd-Queue-Id: 4jKSCZ6MQRz8vfR
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

An upcoming patch makes the store apply the level with an atomic commit.
The store tests allocate their connector with kunit_kzalloc() instead of
initialising it on the DRM device, and have no CRTC, plane or encoder, so
a commit can't run on it

Build a primary plane, a CRTC, an encoder and an eDP connector on the
KUnit device instead, with runtime PM enabled as on a probed device, and
move the two store tests onto it. They check the same results as before

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 88 ++++++++++++++++++++--
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index c6d15fb8ad989..35e245b078f7a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -7,10 +7,14 @@
 
 #include <kunit/test.h>
 #include <linux/backlight.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
+#include <drm/drm_kunit_helpers.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_mode_config.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_property.h>
 
 #include "dc.h"
@@ -544,6 +548,75 @@ static struct drm_connector *setup_panel_power_savings_connector(struct kunit *t
 	return connector;
 }
 
+static const struct drm_connector_funcs dm_test_pps_connector_funcs = {
+	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int dm_test_pps_get_modes(struct drm_connector *connector)
+{
+	return 0;
+}
+
+/* update_connector_routing() dereferences the helper funcs unconditionally */
+static const struct drm_connector_helper_funcs dm_test_pps_connector_helper_funcs = {
+	.get_modes = dm_test_pps_get_modes,
+};
+
+/*
+ * Build a primary plane, a CRTC, an encoder and an eDP connector that the
+ * store can commit to. The KUnit device uses the generic atomic helpers, so a
+ * commit runs drm_atomic_helper_check() and drm_atomic_helper_commit() rather
+ * than the DM implementations
+ */
+static struct drm_connector *
+setup_panel_power_savings_pipe(struct kunit *test, struct device **device_out)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector *connector;
+	struct drm_encoder *encoder;
+	struct amdgpu_device *adev;
+	struct drm_plane *primary;
+	struct drm_crtc *crtc;
+	struct device *device;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, pm_runtime_set_active(adev->ddev.dev), 0);
+	KUNIT_ASSERT_EQ(test, devm_pm_runtime_enable(adev->ddev.dev), 0);
+
+	primary = drm_kunit_helper_create_primary_plane(test, &adev->ddev, NULL,
+							NULL, NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
+	crtc = drm_kunit_helper_create_crtc(test, &adev->ddev, primary, NULL,
+					    NULL, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+
+	encoder = drmm_kzalloc(&adev->ddev, sizeof(*encoder), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, encoder);
+	KUNIT_ASSERT_EQ(test, drmm_encoder_init(&adev->ddev, encoder, NULL,
+						DRM_MODE_ENCODER_TMDS, NULL), 0);
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
+	aconnector = drmm_kzalloc(&adev->ddev, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	connector = &aconnector->base;
+	KUNIT_ASSERT_EQ(test, drmm_connector_init(&adev->ddev, connector,
+						  &dm_test_pps_connector_funcs,
+						  DRM_MODE_CONNECTOR_eDP, NULL), 0);
+	drm_connector_helper_add(connector, &dm_test_pps_connector_helper_funcs);
+	KUNIT_ASSERT_EQ(test, drm_connector_attach_encoder(connector, encoder), 0);
+
+	drm_mode_config_reset(&adev->ddev);
+
+	device = kunit_kzalloc(test, sizeof(*device), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, device);
+	dev_set_drvdata(device, connector);
+	*device_out = device;
+
+	return connector;
+}
+
 static void dm_test_free_sysfs_buf(void *data)
 {
 	free_page((unsigned long)data);
@@ -607,15 +680,16 @@ static void dm_test_panel_power_savings_show_reports_level(struct kunit *test)
  */
 static void dm_test_panel_power_savings_store_sets_disable(struct kunit *test)
 {
-	struct dm_connector_state *state;
+	struct drm_connector *connector;
 	struct device *device;
 	size_t count = strlen("0");
 
-	setup_panel_power_savings_connector(test, &device, &state);
+	connector = setup_panel_power_savings_pipe(test, &device);
 
 	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "0", count),
 			 (ssize_t)count);
-	KUNIT_EXPECT_EQ(test, state->abm_level, ABM_LEVEL_IMMEDIATE_DISABLE);
+	KUNIT_EXPECT_EQ(test, to_dm_connector_state(connector->state)->abm_level,
+			ABM_LEVEL_IMMEDIATE_DISABLE);
 }
 
 /**
@@ -624,11 +698,13 @@ static void dm_test_panel_power_savings_store_sets_disable(struct kunit *test)
  */
 static void dm_test_panel_power_savings_store_forbidden(struct kunit *test)
 {
-	struct dm_connector_state *state;
+	struct dm_connector_state *dm_state;
+	struct drm_connector *connector;
 	struct device *device;
 
-	setup_panel_power_savings_connector(test, &device, &state);
-	state->abm_sysfs_forbidden = true;
+	connector = setup_panel_power_savings_pipe(test, &device);
+	dm_state = to_dm_connector_state(connector->state);
+	dm_state->abm_sysfs_forbidden = true;
 
 	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "1", 1), -EBUSY);
 }

-- 
2.56.0

