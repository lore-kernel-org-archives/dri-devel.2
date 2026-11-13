Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F50606A331
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7hBRbX2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A921410E7F4;
	Fri, 13 Nov 2026 20:24:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6F510E4BA;
 Fri, 13 Nov 2026 20:24:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A94FA45BBD;
 Fri, 13 Nov 2026 20:24:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794601490;
 b=nvEzO6TQk7PI0kNUhGwvKWEItUVJRCAOSbulJ4zBVSFnCrIbp10kMa4pjEVgAxgzsAsY
 FccD0zeVZemkgv4V2JjE7bIWKnXgn/mX4bypJvWFu1q+16KIZGcsIj3GfzTYF+Ob5pQi6
 fWFACE0ChP4HyQVbuOoJ+6Iu4UAbCYvCTV6wVQWcklheW7wxGcwrBMYBu0G6UrokSZHa6
 XV4ymRa2TSs6hhzqFoR35ggfI1AlOoix5Zi6w9+z2xza4bwDlpNkZsaHdF3ZxHym5p/yS
 VYzKQFYp2lXYaMifSwXAKzCWK8ENzUFymKfsyyALjraxDt5qf3izueKN49q4GE20wcA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794601490;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=uBDvoboRAa+cGYhUjtvMfpt40qRD3+IUF0PMhyvPSyQ=;
 b=TzogB12cRDAVd/OyPZ65YbJW2CL7ZEH4LmB7VXAotoRCLdAi8VsgSjXOZLq/8daMJcgA
 1khicnuPS5M8jlBzhQQtMU3fx7rUoOpYW2wPFIpoQ3oIdXDupkhTssoavdmdzPKBUkcGW
 fIu9kPngn6rYxgB4uiv6ajWppa2qi57WZt1T+CJLjJ3r2kLDVt7MM1OfdfFAynxoEJXgj
 4lezWClsfMd9ReuiEsiWBu7mtU9uWU+xJ+nMHAWD/mjZVlAl6/ak9+osbV7wc2ti+uHIm
 nVQhUgayqlINAgJ55IlRjtrwzvNe6eDaADEGGcf/aX1lJAM6ZioSKxyrX1KynBUIrFg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 60BC91F000C7;
 Fri, 13 Nov 2026 20:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794601490;
 bh=uBDvoboRAa+cGYhUjtvMfpt40qRD3+IUF0PMhyvPSyQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=D7hBRbX2eQeRifqqmVKUNLCp67VAoJftrxofPPsHZf8cOvUBapAm8W/BeNBLCqhGs
 wBe5Wqel2PCBD7tVvsGCfZJYUu1mZ6kqEo4snw1aewOiISJRJIK9UxGPGN49irKO5R
 wn9n/EI8Wm7yW/wB0awTmze7SzYZLYXaF6fia9w/1leJXpjyePFis1Ya1B1YtesCiA
 hK/KNtUU77U3LwTOdIcDT/FeE6/kxNSnUOQiMod9lR81HRsHBa6fmibZay0z2gxSUx
 g2ZF0lkxhkj2guo7SgJPbIBPlAZDeLg68Lza/R1yxBYMRPsrCtgZ4ULWcQQuXAcWEJ
 jkv4oqJ211FtQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E2C2249AD8;
 Fri, 13 Nov 2026 20:24:48 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Fri, 13 Nov 2026 20:24:50 +0000
Subject: [PATCH v2 3/5] drm/amd/display: Give the panel_power_savings store
 tests a full pipe
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-abm-sysfs-commit-v2-3-5808d17a7e89@hsal.es>
References: <20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es>
In-Reply-To: <20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
 Alex Hung <alex.hung@amd.com>, 
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Sales <hugo@hsal.es>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5947; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=K2pniu0qwhYm7o7bR6OLXAX4Z6rHj8qzx+ZmC3CtWCQ=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsr4XCRSd3Xg248/2vb6PkoOFF/CVqsy+cjvvXtu5R
 4UHtvoXHZ7XUcrCIMbFICumyKJ7w5OBZeLkmTlFz5fAzGFlAhnCwMUpABMRamP47z4reJfJJd+f
 IpsTrrFFcfOtYme9aFnh/FfEMLfv9PemPYwMW5Lf3u7c8mWrxgUb5XB3s/n1t57fzlrCcWHznk1
 qz/qZGQGpEU1y
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Endpoint-Received: by B4 Relay for hugo@hsal.es/default with auth_id=1417
X-Original-From: Hugo Sales <hugo@hsal.es>
Content-Transfer-Encoding: 7bit
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
Reply-To: hugo@hsal.es
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hugo Sales <hugo@hsal.es>

An upcoming patch makes the store apply the level with an atomic commit.
The store tests allocate their connector with kunit_kzalloc() instead of
initialising it on the DRM device, and have no CRTC, plane or encoder, so
a commit can't run on it

Build a primary plane, a CRTC, an encoder and an eDP connector on the
KUnit device instead, with runtime PM enabled as on a probed device, and
move the two store tests onto it. They check the same results as before.
The connector reset already leaves the disable sentinel, so the disable
test sets level 2 before the write

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 90 ++++++++++++++++++++--
 1 file changed, 84 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index c6d15fb8ad989..5133c8f251f53 100644
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
@@ -544,6 +548,76 @@ static struct drm_connector *setup_panel_power_savings_connector(struct kunit *t
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
+	KUNIT_ASSERT_NOT_NULL(test, connector->state);
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
@@ -607,15 +681,17 @@ static void dm_test_panel_power_savings_show_reports_level(struct kunit *test)
  */
 static void dm_test_panel_power_savings_store_sets_disable(struct kunit *test)
 {
-	struct dm_connector_state *state;
+	struct drm_connector *connector;
 	struct device *device;
 	size_t count = strlen("0");
 
-	setup_panel_power_savings_connector(test, &device, &state);
+	connector = setup_panel_power_savings_pipe(test, &device);
+	to_dm_connector_state(connector->state)->abm_level = 2;
 
 	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "0", count),
 			 (ssize_t)count);
-	KUNIT_EXPECT_EQ(test, state->abm_level, ABM_LEVEL_IMMEDIATE_DISABLE);
+	KUNIT_EXPECT_EQ(test, to_dm_connector_state(connector->state)->abm_level,
+			ABM_LEVEL_IMMEDIATE_DISABLE);
 }
 
 /**
@@ -624,11 +700,13 @@ static void dm_test_panel_power_savings_store_sets_disable(struct kunit *test)
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


