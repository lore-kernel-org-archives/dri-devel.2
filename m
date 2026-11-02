Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3091608B7DB
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gl+5X2Iq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50A410F0CE;
	Mon,  2 Nov 2026 16:49:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C27B910F0B3;
 Mon,  2 Nov 2026 16:49:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F0C540617;
 Mon,  2 Nov 2026 16:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28971F00A1D;
 Mon,  2 Nov 2026 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793638178;
 bh=iL/9+IJsslM1L/bOs4vmXJGfTH/cgGsVw1HQXn9znPw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gl+5X2Iqw6X0ig/FCYEyBOCFN41MGtnWyIkIJCI23Fd4KOTIxMBZ7yLq2UkMNDCE3
 WUZJ0OQrhopuBh1kHR2F11LIZ/nka0Oh05dwvQuUrPb5g1OVPnQTehI9LijRp/ZX2k
 Neef7uqKRxyfcA+PLaXC1lIGWADl4DRRCapCm7yQDXLVqqp13dTsvaO2wqkK5W3AAH
 wdSSTRNTUJb0zG1VY0EtJJ4XZK8XD/jw34go3BkH5ejjMHLEgGKsl1H9uVLxWLBLuS
 jMcmKaIM8jRLOpuAtvWMIdHiJ3ZsXdF1IR7L0SIMbyawt9hUFoz7s4RRyoniwlxUZf
 Efavn+Iza+KKg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 02 Nov 2026 10:49:21 -0600
Subject: [PATCH v10 05/15] drm/amd/display: update KUnit luminance fixtures
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-superm1-backlight-property-v10-5-b2a6f24131f5@kernel.org>
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
 nouveau@lists.freedesktop.org
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

Initialize complete DRM connector state in backlight test fixtures so
the atomic LUMINANCE property can be attached. Check the optional
property and keep the ABM property expectations correct with either
interface selected.

Also initialize the display-manager lock and mode configuration needed
by the existing backlight registration test.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 43 ++++++++++++++++++----
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |  7 +++-
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index b21850788f36f..8883010e8af9c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -41,12 +41,21 @@ static void setup_test_connector(struct kunit *test,
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
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
+	ret = drmm_connector_init(&fixture->adev->ddev,
+				  &fixture->aconnector->base,
+				  &dm_backlight_test_connector_funcs,
+				  DRM_MODE_CONNECTOR_eDP, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	drm_atomic_helper_connector_reset(&fixture->aconnector->base);
 
 	fixture->aconnector->bl_idx = bl_idx;
 	fixture->aconnector->dc_link = fixture->link;
@@ -483,12 +492,17 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
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
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
 	adev->ddev.primary = primary;
+	adev->dm.ddev = &adev->ddev;
 	adev->dm.backlight_link[0] = link;
 
 	aconnector = dm_kunit_alloc_connector(test, adev, link);
@@ -1872,6 +1886,7 @@ static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *t
 	struct dc_link *link;
 	int saved_abm_level = amdgpu_dm_get_abm_level_param();
 	int saved_backlight = amdgpu_dm_get_backlight_param();
+	int abm_index;
 	int old_count;
 	int ret;
 
@@ -1890,6 +1905,7 @@ static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *t
 				   &dm_backlight_test_connector_funcs,
 				   DRM_MODE_CONNECTOR_eDP, NULL);
 	KUNIT_ASSERT_EQ(test, ret, 0);
+	drm_atomic_helper_connector_reset(&aconnector->base);
 
 	link = dm_kunit_alloc_link(test);
 	link->connector_signal = SIGNAL_TYPE_EDP;
@@ -1900,15 +1916,26 @@ static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *t
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
+	}
+	KUNIT_EXPECT_PTR_EQ(test,
+			    aconnector->base.base.properties->properties[abm_index],
+			    prop);
+	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->values[abm_index],
+			(uint64_t)ABM_SYSFS_CONTROL);
 
 	amdgpu_dm_set_backlight_param(saved_backlight);
 	amdgpu_dm_set_abm_level_param(saved_abm_level);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
index aad122c7229f5..66c9b2cb70fcd 100644
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

