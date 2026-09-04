Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29B8C79F83
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 130FA10F9A4;
	Fri,  4 Sep 2026 09:08:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MIuwYVjl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E970C10F999;
 Fri,  4 Sep 2026 09:07:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D10E7416A6;
 Fri,  4 Sep 2026 09:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362EB1F00A3D;
 Fri,  4 Sep 2026 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788512878;
 bh=SW6D458IN7p93Mx23LiMLb3pNuhszwS31FL+pwdMNk0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MIuwYVjliqPF9SaORyeMsf/H3CDKR+wsTt1xo+MEy/mXIGpWPSwNxbfAlx1nQfMyg
 bk5z5I1BECrWtQ4kGYepPsn/mTYlXrPSlGkIEImAwH4tldPXBg0ucXw0SqmJUVRXbQ
 hwimdGZU1YPPRzbfzmcUm5JJakPpVqFY3SIEa7Aw/m5Smsw084rb0tkswIrDq1dbJQ
 LW/1QUr/TGJhoDZu2DF8PVJDI/iFam3pVIi/iAuWCiZXPtmmHYbi+PdKhlBDoe/MhO
 7WC9SD3xBEJCbLVpgMRZI7HP5RIl78pjLcFH3hSKymMQQmsB2uCOCwo5PoKN4Uz0Gh
 vx44GP7Y98q+Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 04 Sep 2026 11:07:25 +0200
Subject: [PATCH v3 07/13] drm/amdgpu: dm: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-drm-no-more-crtc-reset-v3-7-27d9891512ce@kernel.org>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7821; i=mripard@kernel.org;
 h=from:subject:message-id; bh=LPy8lRRV5Abh6gKv7GyAJSViTwYdkZ89CX2k4mLq6Do=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmzuvyaJytv6ee8sPAN25UE22Mv1TxP7U5zUiyY/ClXy
 P0E70brjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARfV7Ghgc6c3t2rJ4VsKAv
 5bmBS+pvr4NVRRWOItdMrvFl3+aK+6k8VeyJu4m54Tq9SP9NG/YeZmz4ETY54mV+I+vefwfn2lq
 HM99ecfnh/br8Sz230lb80Vi4SjfY0oZvh0jcjre9+qkConsB
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

The amdgpu display manager crtc implementation provides a custom reset
hook. However, this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 31 +++++++++++++++-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |  2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  | 23 ++++++++--------
 3 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 62eac6e65334..53910056da20 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -473,24 +473,23 @@ static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 
 	drm_crtc_cleanup(crtc);
 	kfree(crtc);
 }
 
-STATIC_IFN_KUNIT void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
+STATIC_IFN_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state;
 
 	state = kzalloc_obj(*state);
 	if (!state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	if (crtc->state)
-		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
+	__drm_atomic_helper_crtc_state_init(&state->base, crtc);
 
-	__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	return &state->base;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_reset_state);
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_create_state);
 
 #ifdef CONFIG_DEBUG_FS
 static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
 {
 	crtc_debugfs_init(crtc);
@@ -563,11 +562,11 @@ amdgpu_dm_atomic_crtc_get_property(struct drm_crtc *crtc,
 }
 #endif
 
 /* Implemented only the options currently available for the driver */
 static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
-	.reset = amdgpu_dm_crtc_reset_state,
+	.atomic_create_state = amdgpu_dm_crtc_create_state,
 	.destroy = amdgpu_dm_crtc_destroy,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = amdgpu_dm_crtc_duplicate_state,
 	.atomic_destroy_state = amdgpu_dm_crtc_destroy_state,
@@ -779,13 +778,22 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 
 	amdgpu_dm_ism_init(&acrtc->ism, &default_ism_config);
 
 	drm_crtc_helper_add(&acrtc->base, &amdgpu_dm_crtc_helper_funcs);
 
-	/* Create (reset) the plane state */
-	if (acrtc->base.funcs->reset)
-		acrtc->base.funcs->reset(&acrtc->base);
+	/* Create the plane state */
+	if (acrtc->base.funcs->atomic_create_state) {
+		struct drm_crtc_state *crtc_state;
+
+		crtc_state = acrtc->base.funcs->atomic_create_state(&acrtc->base);
+		if (IS_ERR(crtc_state)) {
+			res = PTR_ERR(crtc_state);
+			goto error_ism_fini;
+		}
+
+		acrtc->base.state = crtc_state;
+	}
 
 	acrtc->max_cursor_width = dm->adev->dm.dc->caps.max_cursor_size;
 	acrtc->max_cursor_height = dm->adev->dm.dc->caps.max_cursor_size;
 
 	acrtc->crtc_id = crtc_index;
@@ -813,10 +821,13 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 #ifdef AMD_PRIVATE_COLOR
 	dm_crtc_additional_color_mgmt(&acrtc->base);
 #endif
 	return 0;
 
+error_ism_fini:
+	amdgpu_dm_ism_fini(&acrtc->ism);
+	drm_crtc_cleanup(&acrtc->base);
 fail:
 	kfree(acrtc);
 	kfree(cursor_plane);
 	return res;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index 93c6d0d8d7fd..ad516aeb9798 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -47,11 +47,11 @@ bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
 				      const struct drm_display_mode *mode,
 				      struct drm_display_mode *adjusted_mode);
 void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 				  struct drm_crtc_state *state);
 struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc);
-void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc);
+struct drm_crtc_state *amdgpu_dm_crtc_create_state(struct drm_crtc *crtc);
 int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_crtc_state);
 void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 					      struct drm_crtc_state *new_crtc_state);
 void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work);
 void amdgpu_dm_idle_worker(struct work_struct *work);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 4dacddd23878..20ae31d2bf6a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -1402,35 +1402,34 @@ static void dm_test_crtc_duplicate_state_copies_fields(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, dm_dup->mpo_requested);
 
 	amdgpu_dm_crtc_destroy_state(crtc, dup);
 }
 
-/* Tests for amdgpu_dm_crtc_reset_state() */
+/* Tests for amdgpu_dm_crtc_create_state() */
 
 /**
- * dm_test_crtc_reset_state_allocates_state - Test reset installs a fresh state
+ * dm_test_crtc_create_state_allocates_state - Test create_state allocates a fresh state
  * @test: The KUnit test context
  *
- * Resetting a CRTC with no existing state must allocate and install a new
- * drm_crtc_state.
+ * Creating state for a CRTC must allocate a new drm_crtc_state.
  */
-static void dm_test_crtc_reset_state_allocates_state(struct kunit *test)
+static void dm_test_crtc_create_state_allocates_state(struct kunit *test)
 {
 	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_crtc_state *crtc_state;
 	struct drm_crtc *crtc;
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
 	crtc->dev = &adev->ddev;
 	crtc->state = NULL;
 
-	amdgpu_dm_crtc_reset_state(crtc);
+	crtc_state = amdgpu_dm_crtc_create_state(crtc);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, crtc_state);
 
-	KUNIT_EXPECT_NOT_NULL(test, crtc->state);
-
-	if (crtc->state)
-		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
+	if (!IS_ERR(crtc_state))
+		amdgpu_dm_crtc_destroy_state(crtc, crtc_state);
 }
 
 /* Tests for amdgpu_dm_crtc_destroy_state() */
 
 /**
@@ -1905,12 +1904,12 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_count_crtc_active_planes */
 	KUNIT_CASE(dm_test_count_crtc_active_planes_none),
 	KUNIT_CASE(dm_test_count_crtc_active_planes_mixed),
 	/* amdgpu_dm_crtc_duplicate_state */
 	KUNIT_CASE(dm_test_crtc_duplicate_state_copies_fields),
-	/* amdgpu_dm_crtc_reset_state */
-	KUNIT_CASE(dm_test_crtc_reset_state_allocates_state),
+	/* amdgpu_dm_crtc_create_state */
+	KUNIT_CASE(dm_test_crtc_create_state_allocates_state),
 	/* amdgpu_dm_crtc_destroy_state */
 	KUNIT_CASE(dm_test_crtc_destroy_state_no_stream),
 	KUNIT_CASE(dm_test_crtc_destroy_state_releases_stream),
 	/* amdgpu_dm_crtc_handle_vblank */
 	KUNIT_CASE(dm_test_crtc_handle_vblank_no_event),

-- 
2.55.0

