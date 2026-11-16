Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2B606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NYSA38n+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A453910ED94;
	Mon, 16 Nov 2026 09:12:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7458010E9DC;
 Mon, 16 Nov 2026 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794820326; x=1826356326;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=joTNcElyLEy0KYsrpvdRlQKUIURGkJYStCjNdNg52V0=;
 b=NYSA38n+heBV362Nb827cykGM8cTq3HnAVp54fMjDslsAKPb1KQMKhRJ
 xXvPBTcLUTbvlyIZY6RbStyDdit7EuWkMp//rU3xVksy1xqjez5cm1rYh
 4nMTYh7TfyJZoDqH/VqDmPuqwk9cWCE10TahSJ5bJT9TPBPP2tufcB4rC
 kWxuDLwoP4SYa0Rdr4MFwQpaYj65A4xkBGwIKIfkv6iDp9VVrJB2cvmA7
 JJ5gC+GB5aoNi2t9DCAV2HDYXhIZU0RNPs5Fj1o2+aM4aNUfuMFw/xi6O
 GFuVuPZ9ndwpY02sQfd+LgDMqIh9IqC/4ZiJCrWT6OwZ7ZCVRYi7kOphq g==;
X-CSE-ConnectionGUID: 7IqTvQAWSzGZzBjdUIZ/XQ==
X-CSE-MsgGUID: v7pe/2AIQfWiAUd0JxIIuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3428552"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3428552"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:12:05 -0800
X-CSE-ConnectionGUID: N9wFlgdFQUWTV3uB4eoPIA==
X-CSE-MsgGUID: CyaMevGNSCqTvorvOffqMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9486379"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:11:56 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Erwin Springer <aot.lerwin@gmail.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Christopher Snowhill <chris@kode54.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Dharma Balasubiramani <dharma.b@microchip.com>,
 Dmitry Baryshkov <lumag@kernel.org>, freedreno@lists.freedesktop.org,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Jianmin Lv <lvjianmin@loongson.cn>, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Maxime Ripard <mripard@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 nouveau@lists.freedesktop.org, Qianhai Wu <wuqianhai@loongson.cn>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Simon Ser <contact@emersion.fr>, wayland-devel@lists.freedesktop.org,
 Xaver Hugl <xaver.hugl@kde.org>, Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 02/12] drm/atomic: s/async/bypass/
Date: Mon, 16 Nov 2026 11:11:20 +0200
Message-ID: <20261116091130.13950-3-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116091130.13950-1-ville.syrjala@linux.intel.com>
References: <20261116091130.13950-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

The "async update" stuff has nothing to do with async vs.
sync updates as far as the hardware is concerned (as in
tearing vs. not). What it does is bypass the normal commit
machinery and just let the driver directly perform the
update (as it sees fit) and swap the plane state without
involving the whole crtc commit machinery.

The actual hardware update it does could be an async flip
(as in tearing) or a mailbox flip, depending on how the
driver decides to do it.

Rename the framework to talk about "bypass updates" rather
than "async updates" to avoid confusion.

Cc: amd-gfx@lists.freedesktop.org
Cc: André Almeida <andrealmeid@igalia.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Christopher Snowhill <chris@kode54.net>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: freedreno@lists.freedesktop.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-tegra@vger.kernel.org
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Mingcong Bai <jeffbai@aosc.io>
Cc: nouveau@lists.freedesktop.org
Cc: Qianhai Wu <wuqianhai@loongson.cn>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: wayland-devel@lists.freedesktop.org
Cc: Xaver Hugl <xaver.hugl@kde.org>
Cc: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 20 ++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |  6 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 16 +++----
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 32 ++++++-------
 drivers/gpu/drm/drm_atomic_helper.c           | 48 +++++++++----------
 drivers/gpu/drm/drm_atomic_uapi.c             |  4 +-
 drivers/gpu/drm/drm_self_refresh_helper.c     |  4 +-
 drivers/gpu/drm/loongson/lsdc_plane.c         | 18 +++----
 drivers/gpu/drm/mediatek/mtk_plane.c          | 12 ++---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c    | 12 ++---
 drivers/gpu/drm/msm/msm_atomic.c              |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   | 12 ++---
 drivers/gpu/drm/tegra/dc.c                    | 12 ++---
 drivers/gpu/drm/vc4/vc4_plane.c               | 16 +++----
 include/drm/drm_atomic.h                      |  4 +-
 include/drm/drm_atomic_helper.h               |  8 ++--
 include/drm/drm_modeset_helper_vtables.h      | 38 +++++++--------
 18 files changed, 138 insertions(+), 138 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 94d45e5d2a3b..d43ca823e905 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6581,20 +6581,20 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 	if (state->legacy_cursor_update) {
 		/*
 		 * This is a fast cursor update coming from the plane update
-		 * helper, check if it can be done asynchronously for better
-		 * performance.
+		 * helper, check if it can be bypass the atomic machinery
+		 * for better performance.
 		 */
-		state->async_update =
-			!drm_atomic_helper_async_check(dev, state);
+		state->bypass_update =
+			!drm_atomic_helper_bypass_check(dev, state);
 
 		/*
-		 * Skip the remaining global validation if this is an async
+		 * Skip the remaining global validation if this is a bypass
 		 * update. Cursor updates can be done without affecting
 		 * state or bandwidth calcs and this avoids the performance
 		 * penalty of locking the private state object and
 		 * allocating a new dc_state.
 		 */
-		if (state->async_update)
+		if (state->bypass_update)
 			return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index b224d9596fd2..0936594c651c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1565,8 +1565,8 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_check);
 
-STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
-							struct drm_atomic_commit *state, bool flip)
+STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_bypass_check(struct drm_plane *plane,
+							 struct drm_atomic_commit *state, bool flip)
 {
 	struct drm_crtc_state *new_crtc_state;
 	struct drm_plane_state *new_plane_state;
@@ -1588,7 +1588,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_async_check);
+EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_bypass_check);
 
 int amdgpu_dm_plane_get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
 					struct dc_cursor_position *position)
@@ -1725,8 +1725,8 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_handle_cursor_update);
 
-STATIC_IFN_KUNIT void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
-							  struct drm_atomic_commit *state)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_atomic_bypass_update(struct drm_plane *plane,
+							   struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
@@ -1748,7 +1748,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plan
 
 	amdgpu_dm_plane_handle_cursor_update(plane, old_state);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_async_update);
+EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_bypass_update);
 
 STATIC_IFN_KUNIT void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
 {
@@ -1769,16 +1769,16 @@ static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
 	.prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
 	.cleanup_fb = amdgpu_dm_plane_helper_cleanup_fb,
 	.atomic_check = amdgpu_dm_plane_atomic_check,
-	.atomic_async_check = amdgpu_dm_plane_atomic_async_check,
-	.atomic_async_update = amdgpu_dm_plane_atomic_async_update
+	.atomic_bypass_check = amdgpu_dm_plane_atomic_bypass_check,
+	.atomic_bypass_update = amdgpu_dm_plane_atomic_bypass_update
 };
 
 static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
 	.prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
 	.cleanup_fb = amdgpu_dm_plane_helper_cleanup_fb,
 	.atomic_check = amdgpu_dm_plane_atomic_check,
-	.atomic_async_check = amdgpu_dm_plane_atomic_async_check,
-	.atomic_async_update = amdgpu_dm_plane_atomic_async_update,
+	.atomic_bypass_check = amdgpu_dm_plane_atomic_bypass_check,
+	.atomic_bypass_update = amdgpu_dm_plane_atomic_bypass_update,
 	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
 	.panic_flush = amdgpu_dm_plane_panic_flush,
 };
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index a432aad41b8f..7e85195d42fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -112,8 +112,8 @@ void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
 						  struct drm_framebuffer *fb,
 						  int *min_downscale,
 						  int *max_upscale);
-int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
-				       struct drm_atomic_commit *state, bool flip);
+int amdgpu_dm_plane_atomic_bypass_check(struct drm_plane *plane,
+					struct drm_atomic_commit *state, bool flip);
 int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 				 struct drm_atomic_commit *state);
 void amdgpu_dm_plane_panic_flush(struct drm_plane *plane);
@@ -136,6 +136,6 @@ bool amdgpu_dm_plane_gfx6_format_mod_supported(const struct amdgpu_device *adev,
 					       const u64 modifier);
 int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane, struct drm_plane_state *new_state);
 void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane, struct drm_plane_state *old_state);
-void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane, struct drm_atomic_commit *state);
+void amdgpu_dm_plane_atomic_bypass_update(struct drm_plane *plane, struct drm_atomic_commit *state);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 9027933cec3f..b075cabfaaf5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -316,7 +316,7 @@ DECLARE_EVENT_CLASS(amdgpu_dm_atomic_state_template,
 		    TP_STRUCT__entry(__field(const struct drm_atomic_commit *, state)
 				     __field(bool, allow_modeset)
 				     __field(bool, legacy_cursor_update)
-				     __field(bool, async_update)
+				     __field(bool, bypass_update)
 				     __field(bool, duplicated)
 				     __field(int, num_connector)
 				     __field(int, num_private_objs)
@@ -324,16 +324,16 @@ DECLARE_EVENT_CLASS(amdgpu_dm_atomic_state_template,
 		    TP_fast_assign(__entry->state = state;
 				   __entry->allow_modeset = state->allow_modeset;
 				   __entry->legacy_cursor_update = state->legacy_cursor_update;
-				   __entry->async_update = state->async_update;
+				   __entry->bypass_update = state->bypass_update;
 				   __entry->duplicated = state->duplicated;
 				   __entry->num_connector = state->num_connector;
 				   __entry->num_private_objs = state->num_private_objs;
 		    ),
 		    TP_printk("state=%p allow_modeset=%d legacy_cursor_update=%d "
-			      "async_update=%d duplicated=%d num_connector=%d "
+			      "bypass_update=%d duplicated=%d num_connector=%d "
 			      "num_private_objs=%d",
 			      __entry->state, __entry->allow_modeset,
-			      __entry->legacy_cursor_update, __entry->async_update,
+			      __entry->legacy_cursor_update, __entry->bypass_update,
 			      __entry->duplicated, __entry->num_connector,
 			      __entry->num_private_objs)
 );
@@ -357,20 +357,20 @@ TRACE_EVENT(amdgpu_dm_atomic_check_finish,
 	    TP_STRUCT__entry(
 			     __field(const struct drm_atomic_commit *, state)
 			     __field(int, res)
-			     __field(bool, async_update)
+			     __field(bool, bypass_update)
 			     __field(bool, allow_modeset)
 	    ),
 
 	    TP_fast_assign(
 			   __entry->state = state;
 			   __entry->res = res;
-			   __entry->async_update = state->async_update;
+			   __entry->bypass_update = state->bypass_update;
 			   __entry->allow_modeset = state->allow_modeset;
 	    ),
 
-	    TP_printk("state=%p res=%d async_update=%d allow_modeset=%d",
+	    TP_printk("state=%p res=%d bypass_update=%d allow_modeset=%d",
 		      __entry->state, __entry->res,
-		      __entry->async_update, __entry->allow_modeset)
+		      __entry->bypass_update, __entry->allow_modeset)
 );
 
 TRACE_EVENT(amdgpu_dm_dc_pipe_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 1f5ee7a0d741..d6b00aeade3b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -1936,13 +1936,13 @@ static void dm_test_format_mod_supported_d_swizzle_reject(struct kunit *test)
 }
 
 /**
- * dm_test_atomic_async_check_rejects() - Verify async check rejections.
+ * dm_test_atomic_bypass_check_rejects() - Verify async check rejections.
  * @test: KUnit test context.
  *
  * Verify if async flip on non-overlay planes and async cursor update on
  * non-cursor planes are rejected.
  */
-static void dm_test_atomic_async_check_rejects(struct kunit *test)
+static void dm_test_atomic_bypass_check_rejects(struct kunit *test)
 {
 	struct drm_plane *plane;
 
@@ -1951,21 +1951,21 @@ static void dm_test_atomic_async_check_rejects(struct kunit *test)
 
 	plane->type = DRM_PLANE_TYPE_PRIMARY;
 	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_atomic_async_check(plane, NULL, true),
+			amdgpu_dm_plane_atomic_bypass_check(plane, NULL, true),
 			-EINVAL);
 	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_atomic_async_check(plane, NULL, false),
+			amdgpu_dm_plane_atomic_bypass_check(plane, NULL, false),
 			-EINVAL);
 }
 
 /**
- * dm_test_atomic_async_check_overlay_cursor() - Verify overlay cursor rejection.
+ * dm_test_atomic_bypass_check_overlay_cursor() - Verify overlay cursor rejection.
  * @test: KUnit test context.
  *
  * Verify if async cursor updates are rejected while the CRTC is using an
  * overlay cursor mode.
  */
-static void dm_test_atomic_async_check_overlay_cursor(struct kunit *test)
+static void dm_test_atomic_bypass_check_overlay_cursor(struct kunit *test)
 {
 	struct drm_atomic_commit *state;
 	struct __drm_planes_state *planes;
@@ -2001,12 +2001,12 @@ static void dm_test_atomic_async_check_overlay_cursor(struct kunit *test)
 	state->crtcs[0].new_state = &dm_crtc_state->base;
 
 	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_atomic_async_check(plane, state, false),
+			amdgpu_dm_plane_atomic_bypass_check(plane, state, false),
 			-EINVAL);
 
 	dm_crtc_state->cursor_mode = DM_CURSOR_NATIVE_MODE;
 	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_atomic_async_check(plane, state, false),
+			amdgpu_dm_plane_atomic_bypass_check(plane, state, false),
 			0);
 }
 
@@ -2878,13 +2878,13 @@ static void dm_test_handle_cursor_update_no_fb(struct kunit *test)
 }
 
 /**
- * dm_test_atomic_async_update_copies_state() - Verify async cursor state copy.
+ * dm_test_atomic_bypass_update_copies_state() - Verify async cursor state copy.
  * @test: KUnit test context.
  *
  * Verify if the async update swaps the framebuffer and copies the source and
  * CRTC rectangles from the new state into the current plane state.
  */
-static void dm_test_atomic_async_update_copies_state(struct kunit *test)
+static void dm_test_atomic_bypass_update_copies_state(struct kunit *test)
 {
 	struct amdgpu_device *adev;
 	struct drm_atomic_commit *state;
@@ -2928,7 +2928,7 @@ static void dm_test_atomic_async_update_copies_state(struct kunit *test)
 	state->planes[0].new_state = new_state;
 	state->planes[0].old_state = old_state;
 
-	amdgpu_dm_plane_atomic_async_update(plane, state);
+	amdgpu_dm_plane_atomic_bypass_update(plane, state);
 
 	KUNIT_EXPECT_PTR_EQ(test, cur_state->fb, NULL);
 	KUNIT_EXPECT_PTR_EQ(test, new_state->fb, &afb->base);
@@ -3294,11 +3294,11 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_handle_cursor_update_no_fb),
 	KUNIT_CASE(dm_test_handle_cursor_update_disabled),
 	KUNIT_CASE(dm_test_handle_cursor_update_no_stream),
-	/* amdgpu_dm_plane_atomic_async_update() */
-	KUNIT_CASE(dm_test_atomic_async_update_copies_state),
-	/* amdgpu_dm_plane_atomic_async_check() */
-	KUNIT_CASE(dm_test_atomic_async_check_rejects),
-	KUNIT_CASE(dm_test_atomic_async_check_overlay_cursor),
+	/* amdgpu_dm_plane_atomic_bypass_update() */
+	KUNIT_CASE(dm_test_atomic_bypass_update_copies_state),
+	/* amdgpu_dm_plane_atomic_bypass_check() */
+	KUNIT_CASE(dm_test_atomic_bypass_check_rejects),
+	KUNIT_CASE(dm_test_atomic_bypass_check_overlay_cursor),
 	/* amdgpu_dm_plane_atomic_check() */
 	KUNIT_CASE(dm_test_atomic_check_no_dc_state),
 	KUNIT_CASE(dm_test_atomic_check_missing_crtc_state),
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index f81eb29d9ac8..4e6dade4fb39 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1130,7 +1130,7 @@ int drm_atomic_helper_check(struct drm_device *dev,
 		return ret;
 
 	if (state->legacy_cursor_update)
-		state->async_update = !drm_atomic_helper_async_check(dev, state);
+		state->bypass_update = !drm_atomic_helper_bypass_check(dev, state);
 
 	drm_self_refresh_helper_alter_state(state);
 
@@ -2099,7 +2099,7 @@ static void commit_work(struct work_struct *work)
 }
 
 /**
- * drm_atomic_helper_async_check - check if state can be committed asynchronously
+ * drm_atomic_helper_bypass_check - check if state can be committed bypassing the normal commit tracking
  * @dev: DRM device
  * @state: the driver state object
  *
@@ -2111,7 +2111,7 @@ static void commit_work(struct work_struct *work)
  * if not. Note that error just mean it can't be committed asynchronously, if it
  * fails the commit should be treated like a normal synchronous commit.
  */
-int drm_atomic_helper_async_check(struct drm_device *dev,
+int drm_atomic_helper_bypass_check(struct drm_device *dev,
 				   struct drm_atomic_commit *state)
 {
 	struct drm_crtc *crtc;
@@ -2146,56 +2146,56 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
 	}
 
 	funcs = plane->helper_private;
-	if (!funcs->atomic_async_update) {
+	if (!funcs->atomic_bypass_update) {
 		drm_dbg_atomic(dev,
-			       "[PLANE:%d:%s] driver does not support async updates\n",
+			       "[PLANE:%d:%s] driver does not support bypass updates\n",
 			       plane->base.id, plane->name);
 		return -EINVAL;
 	}
 
 	if (new_plane_state->fence) {
 		drm_dbg_atomic(dev,
-			       "[PLANE:%d:%s] missing fence for async update\n",
+			       "[PLANE:%d:%s] missing fence for bypass update\n",
 			       plane->base.id, plane->name);
 		return -EINVAL;
 	}
 
 	/*
 	 * Don't do an async update if there is an outstanding commit modifying
-	 * the plane.  This prevents our async update's changes from getting
-	 * overridden by a previous synchronous update's state.
+	 * the plane.  This prevents our bypass update's changes from getting
+	 * overridden by a previous normal update's state.
 	 */
 	if (old_plane_state->commit &&
 	    !try_wait_for_completion(&old_plane_state->commit->hw_done)) {
 		drm_dbg_atomic(dev,
-			       "[PLANE:%d:%s] inflight previous commit preventing async commit\n",
+			       "[PLANE:%d:%s] inflight previous commit preventing bypass commit\n",
 			       plane->base.id, plane->name);
 		return -EBUSY;
 	}
 
-	ret = funcs->atomic_async_check(plane, state, false);
+	ret = funcs->atomic_bypass_check(plane, state, false);
 	if (ret != 0)
 		drm_dbg_atomic(dev,
-			       "[PLANE:%d:%s] driver async check failed\n",
+			       "[PLANE:%d:%s] driver bypass check failed\n",
 			       plane->base.id, plane->name);
 	return ret;
 }
-EXPORT_SYMBOL(drm_atomic_helper_async_check);
+EXPORT_SYMBOL(drm_atomic_helper_bypass_check);
 
 /**
- * drm_atomic_helper_async_commit - commit state asynchronously
+ * drm_atomic_helper_bypass_commit - commit state asynchronously bypassing normal commit tracking
  * @dev: DRM device
  * @state: the driver state object
  *
- * This function commits a state asynchronously. It should be used on a state
- * only when drm_atomic_async_check() succeeds. Async commits are not supposed
- * to swap the states like normal sync commits, but just do in-place changes
- * on the current state.
+ * This function commits a state asynchronously bypassing the normal commit
+ * tracking. It should be used on a state only when drm_atomic_bypass_check()
+ * succeeds. Bypass commits are not supposed to swap the states like normal
+ * commits, but just do in-place changes on the current state.
  *
  * TODO: Implement full swap instead of doing in-place changes.
  */
-void drm_atomic_helper_async_commit(struct drm_device *dev,
-				    struct drm_atomic_commit *state)
+void drm_atomic_helper_bypass_commit(struct drm_device *dev,
+				     struct drm_atomic_commit *state)
 {
 	struct drm_plane *plane;
 	struct drm_plane_state *plane_state;
@@ -2207,10 +2207,10 @@ void drm_atomic_helper_async_commit(struct drm_device *dev,
 		struct drm_framebuffer *old_fb = plane->state->fb;
 
 		funcs = plane->helper_private;
-		funcs->atomic_async_update(plane, state);
+		funcs->atomic_bypass_update(plane, state);
 
 		/*
-		 * ->atomic_async_update() is supposed to update the
+		 * ->atomic_bypass_update() is supposed to update the
 		 * plane->state in-place, make sure at least common
 		 * properties have been properly updated.
 		 */
@@ -2227,7 +2227,7 @@ void drm_atomic_helper_async_commit(struct drm_device *dev,
 		WARN_ON_ONCE(plane_state->fb != old_fb);
 	}
 }
-EXPORT_SYMBOL(drm_atomic_helper_async_commit);
+EXPORT_SYMBOL(drm_atomic_helper_bypass_commit);
 
 /**
  * drm_atomic_helper_commit - commit validated state object
@@ -2253,12 +2253,12 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 {
 	int ret;
 
-	if (state->async_update) {
+	if (state->bypass_update) {
 		ret = drm_atomic_helper_prepare_planes(dev, state);
 		if (ret)
 			return ret;
 
-		drm_atomic_helper_async_commit(dev, state);
+		drm_atomic_helper_bypass_commit(dev, state);
 		drm_atomic_helper_unprepare_planes(dev, state);
 
 		return 0;
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eebcf6f5e05..04fcaa72c46f 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1292,8 +1292,8 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 
 			if (ret && plane->type != DRM_PLANE_TYPE_PRIMARY) {
 				/* ask the driver if this non-primary plane is supported */
-				if (plane_funcs && plane_funcs->atomic_async_check)
-					ret = plane_funcs->atomic_async_check(plane, state, true);
+				if (plane_funcs && plane_funcs->atomic_bypass_check)
+					ret = plane_funcs->atomic_bypass_check(plane, state, true);
 
 				if (ret) {
 					drm_dbg_atomic(prop->dev,
diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
index 37ec7fb00f03..9cc7f0526df5 100644
--- a/drivers/gpu/drm/drm_self_refresh_helper.c
+++ b/drivers/gpu/drm/drm_self_refresh_helper.c
@@ -191,10 +191,10 @@ void drm_self_refresh_helper_alter_state(struct drm_atomic_commit *state)
 	struct drm_crtc_state *crtc_state;
 	int i;
 
-	if (state->async_update || !state->allow_modeset) {
+	if (state->bypass_update || !state->allow_modeset) {
 		for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
 			if (crtc_state->self_refresh_active) {
-				state->async_update = false;
+				state->bypass_update = false;
 				state->allow_modeset = true;
 				break;
 			}
diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loongson/lsdc_plane.c
index c425288ba490..59f85072273a 100644
--- a/drivers/gpu/drm/loongson/lsdc_plane.c
+++ b/drivers/gpu/drm/loongson/lsdc_plane.c
@@ -172,9 +172,9 @@ static const struct drm_plane_helper_funcs lsdc_primary_helper_funcs = {
 	.atomic_disable = lsdc_primary_atomic_disable,
 };
 
-static int lsdc_cursor_plane_atomic_async_check(struct drm_plane *plane,
-						struct drm_atomic_commit *state,
-						bool flip)
+static int lsdc_cursor_plane_atomic_bypass_check(struct drm_plane *plane,
+						 struct drm_atomic_commit *state,
+						 bool flip)
 {
 	struct drm_plane_state *new_state;
 	struct drm_crtc_state *crtc_state;
@@ -219,8 +219,8 @@ static int lsdc_cursor_plane_atomic_async_check(struct drm_plane *plane,
 						   true, true);
 }
 
-static void lsdc_cursor_plane_atomic_async_update(struct drm_plane *plane,
-						  struct drm_atomic_commit *state)
+static void lsdc_cursor_plane_atomic_bypass_update(struct drm_plane *plane,
+						   struct drm_atomic_commit *state)
 {
 	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
 	const struct lsdc_cursor_plane_ops *ops = cursor->ops;
@@ -335,8 +335,8 @@ static const struct drm_plane_helper_funcs ls7a1000_cursor_plane_helper_funcs =
 	.atomic_check = ls7a1000_cursor_plane_atomic_check,
 	.atomic_update = ls7a1000_cursor_plane_atomic_update,
 	.atomic_disable = ls7a1000_cursor_plane_atomic_disable,
-	.atomic_async_check = lsdc_cursor_plane_atomic_async_check,
-	.atomic_async_update = lsdc_cursor_plane_atomic_async_update,
+	.atomic_bypass_check = lsdc_cursor_plane_atomic_bypass_check,
+	.atomic_bypass_update = lsdc_cursor_plane_atomic_bypass_update,
 };
 
 /* ls7a2000 cursor plane helpers */
@@ -431,8 +431,8 @@ static const struct drm_plane_helper_funcs ls7a2000_cursor_plane_helper_funcs =
 	.atomic_check = ls7a2000_cursor_plane_atomic_check,
 	.atomic_update = ls7a2000_cursor_plane_atomic_update,
 	.atomic_disable = ls7a2000_cursor_plane_atomic_disable,
-	.atomic_async_check = lsdc_cursor_plane_atomic_async_check,
-	.atomic_async_update = lsdc_cursor_plane_atomic_async_update,
+	.atomic_bypass_check = lsdc_cursor_plane_atomic_bypass_check,
+	.atomic_bypass_update = lsdc_cursor_plane_atomic_bypass_update,
 };
 
 static void lsdc_plane_atomic_print_state(struct drm_printer *p,
diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/mediatek/mtk_plane.c
index 3fad7f2ff004..18d22ab35184 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_plane.c
@@ -74,8 +74,8 @@ static void mtk_plane_destroy_state(struct drm_plane *plane,
 	kfree(to_mtk_plane_state(state));
 }
 
-static int mtk_plane_atomic_async_check(struct drm_plane *plane,
-					struct drm_atomic_commit *state, bool flip)
+static int mtk_plane_atomic_bypass_check(struct drm_plane *plane,
+					 struct drm_atomic_commit *state, bool flip)
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
@@ -187,8 +187,8 @@ static void mtk_plane_update_new_state(struct drm_plane_state *new_state,
 	mtk_plane_state->pending.color_encoding = new_state->color_encoding;
 }
 
-static void mtk_plane_atomic_async_update(struct drm_plane *plane,
-					  struct drm_atomic_commit *state)
+static void mtk_plane_atomic_bypass_update(struct drm_plane *plane,
+					   struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
@@ -295,8 +295,8 @@ static const struct drm_plane_helper_funcs mtk_plane_helper_funcs = {
 	.atomic_check = mtk_plane_atomic_check,
 	.atomic_update = mtk_plane_atomic_update,
 	.atomic_disable = mtk_plane_atomic_disable,
-	.atomic_async_update = mtk_plane_atomic_async_update,
-	.atomic_async_check = mtk_plane_atomic_async_check,
+	.atomic_bypass_update = mtk_plane_atomic_bypass_update,
+	.atomic_bypass_check = mtk_plane_atomic_bypass_check,
 };
 
 int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index 7e878c698247..55ef62999484 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -358,8 +358,8 @@ static void mdp5_plane_atomic_update(struct drm_plane *plane,
 	}
 }
 
-static int mdp5_plane_atomic_async_check(struct drm_plane *plane,
-					 struct drm_atomic_commit *state, bool flip)
+static int mdp5_plane_atomic_bypass_check(struct drm_plane *plane,
+					  struct drm_atomic_commit *state, bool flip)
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
@@ -412,8 +412,8 @@ static int mdp5_plane_atomic_async_check(struct drm_plane *plane,
 	return 0;
 }
 
-static void mdp5_plane_atomic_async_update(struct drm_plane *plane,
-					   struct drm_atomic_commit *state)
+static void mdp5_plane_atomic_bypass_update(struct drm_plane *plane,
+					    struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
@@ -450,8 +450,8 @@ static const struct drm_plane_helper_funcs mdp5_plane_helper_funcs = {
 		.cleanup_fb = mdp5_plane_cleanup_fb,
 		.atomic_check = mdp5_plane_atomic_check,
 		.atomic_update = mdp5_plane_atomic_update,
-		.atomic_async_check = mdp5_plane_atomic_async_check,
-		.atomic_async_update = mdp5_plane_atomic_async_update,
+		.atomic_bypass_check = mdp5_plane_atomic_bypass_check,
+		.atomic_bypass_update = mdp5_plane_atomic_bypass_update,
 };
 
 static void set_scanout_locked(struct mdp5_kms *mdp5_kms,
diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index a8babf1dbe0d..030f479b2246 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -145,7 +145,7 @@ static bool can_do_async(struct drm_atomic_commit *state,
 	struct drm_crtc *crtc;
 	int i, num_crtcs = 0;
 
-	if (!(state->legacy_cursor_update || state->async_update))
+	if (!(state->legacy_cursor_update || state->bypass_update))
 		return false;
 
 	/* any connector change, means slow path: */
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 69e72727da24..dd768f9c8934 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1070,8 +1070,8 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	spin_unlock(&vop->reg_lock);
 }
 
-static int vop_plane_atomic_async_check(struct drm_plane *plane,
-					struct drm_atomic_commit *state, bool flip)
+static int vop_plane_atomic_bypass_check(struct drm_plane *plane,
+					 struct drm_atomic_commit *state, bool flip)
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
@@ -1104,8 +1104,8 @@ static int vop_plane_atomic_async_check(struct drm_plane *plane,
 						   true, true);
 }
 
-static void vop_plane_atomic_async_update(struct drm_plane *plane,
-					  struct drm_atomic_commit *state)
+static void vop_plane_atomic_bypass_update(struct drm_plane *plane,
+					   struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
@@ -1149,8 +1149,8 @@ static const struct drm_plane_helper_funcs plane_helper_funcs = {
 	.atomic_check = vop_plane_atomic_check,
 	.atomic_update = vop_plane_atomic_update,
 	.atomic_disable = vop_plane_atomic_disable,
-	.atomic_async_check = vop_plane_atomic_async_check,
-	.atomic_async_update = vop_plane_atomic_async_update,
+	.atomic_bypass_check = vop_plane_atomic_bypass_check,
+	.atomic_bypass_update = vop_plane_atomic_bypass_update,
 };
 
 static const struct drm_plane_funcs vop_plane_funcs = {
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index c9df14544ced..9cd6399b85bb 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1127,8 +1127,8 @@ static void tegra_cursor_atomic_disable(struct drm_plane *plane,
 	tegra_dc_writel(dc, value, DC_DISP_DISP_WIN_OPTIONS);
 }
 
-static int tegra_cursor_atomic_async_check(struct drm_plane *plane, struct drm_atomic_commit *state,
-					   bool flip)
+static int tegra_cursor_atomic_bypass_check(struct drm_plane *plane, struct drm_atomic_commit *state,
+					    bool flip)
 {
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_crtc_state *crtc_state;
@@ -1165,8 +1165,8 @@ static int tegra_cursor_atomic_async_check(struct drm_plane *plane, struct drm_a
 	return 0;
 }
 
-static void tegra_cursor_atomic_async_update(struct drm_plane *plane,
-					     struct drm_atomic_commit *state)
+static void tegra_cursor_atomic_bypass_update(struct drm_plane *plane,
+					      struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
 	struct tegra_dc *dc = to_tegra_dc(new_state->crtc);
@@ -1198,8 +1198,8 @@ static const struct drm_plane_helper_funcs tegra_cursor_plane_helper_funcs = {
 	.atomic_check = tegra_cursor_atomic_check,
 	.atomic_update = tegra_cursor_atomic_update,
 	.atomic_disable = tegra_cursor_atomic_disable,
-	.atomic_async_check = tegra_cursor_atomic_async_check,
-	.atomic_async_update = tegra_cursor_atomic_async_update,
+	.atomic_bypass_check = tegra_cursor_atomic_bypass_check,
+	.atomic_bypass_update = tegra_cursor_atomic_bypass_update,
 };
 
 static const uint64_t linear_modifiers[] = {
diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 20c9fc9283a8..c90b9921a617 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -2257,8 +2257,8 @@ void vc4_plane_async_set_fb(struct drm_plane *plane, struct drm_framebuffer *fb)
 	drm_dev_exit(idx);
 }
 
-static void vc4_plane_atomic_async_update(struct drm_plane *plane,
-					  struct drm_atomic_commit *state)
+static void vc4_plane_atomic_bypass_update(struct drm_plane *plane,
+					   struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
@@ -2331,8 +2331,8 @@ static void vc4_plane_atomic_async_update(struct drm_plane *plane,
 	drm_dev_exit(idx);
 }
 
-static int vc4_plane_atomic_async_check(struct drm_plane *plane,
-					struct drm_atomic_commit *state, bool flip)
+static int vc4_plane_atomic_bypass_check(struct drm_plane *plane,
+					 struct drm_atomic_commit *state, bool flip)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(plane->dev);
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
@@ -2414,15 +2414,15 @@ static const struct drm_plane_helper_funcs vc4_plane_helper_funcs = {
 	.atomic_update = vc4_plane_atomic_update,
 	.prepare_fb = vc4_prepare_fb,
 	.cleanup_fb = vc4_cleanup_fb,
-	.atomic_async_check = vc4_plane_atomic_async_check,
-	.atomic_async_update = vc4_plane_atomic_async_update,
+	.atomic_bypass_check = vc4_plane_atomic_bypass_check,
+	.atomic_bypass_update = vc4_plane_atomic_bypass_update,
 };
 
 static const struct drm_plane_helper_funcs vc5_plane_helper_funcs = {
 	.atomic_check = vc4_plane_atomic_check,
 	.atomic_update = vc4_plane_atomic_update,
-	.atomic_async_check = vc4_plane_atomic_async_check,
-	.atomic_async_update = vc4_plane_atomic_async_update,
+	.atomic_bypass_check = vc4_plane_atomic_bypass_check,
+	.atomic_bypass_update = vc4_plane_atomic_bypass_update,
 };
 
 static bool vc4_format_mod_supported(struct drm_plane *plane,
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 3ae35b09c0cf..f60a77ad9b9b 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -551,9 +551,9 @@ struct drm_atomic_commit {
 	bool legacy_cursor_update : 1;
 
 	/**
-	 * @async_update: hint for asynchronous plane update
+	 * @bypass_update: hint for bypass plane update
 	 */
-	bool async_update : 1;
+	bool bypass_update : 1;
 
 	/**
 	 * @duplicated:
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 4cfeec70d648..278560760e6e 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -73,10 +73,10 @@ void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_commit *state);
 int drm_atomic_helper_commit(struct drm_device *dev,
 			     struct drm_atomic_commit *state,
 			     bool nonblock);
-int drm_atomic_helper_async_check(struct drm_device *dev,
-				  struct drm_atomic_commit *state);
-void drm_atomic_helper_async_commit(struct drm_device *dev,
-				    struct drm_atomic_commit *state);
+int drm_atomic_helper_bypass_check(struct drm_device *dev,
+				   struct drm_atomic_commit *state);
+void drm_atomic_helper_bypass_commit(struct drm_device *dev,
+				     struct drm_atomic_commit *state);
 
 int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
 					struct drm_atomic_commit *state,
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index c2431c08a60a..cc511068f53a 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1237,7 +1237,7 @@ struct drm_plane_helper_funcs {
 	 * VRAM. Other possible preparatory work includes flushing caches.
 	 *
 	 * This function must not block for outstanding rendering, since it is
-	 * called in the context of the atomic IOCTL even for async commits to
+	 * called in the context of the atomic IOCTL even for bypass commits to
 	 * be able to return any errors to userspace. Instead the recommended
 	 * way is to fill out the &drm_plane_state.fence of the passed-in
 	 * &drm_plane_state. If the driver doesn't support native fences then
@@ -1421,14 +1421,14 @@ struct drm_plane_helper_funcs {
 			       struct drm_atomic_commit *state);
 
 	/**
-	 * @atomic_async_check:
+	 * @atomic_bypass_check:
 	 *
 	 * Drivers should set this function pointer to check if the plane's
-	 * atomic state can be updated in a async fashion.
+	 * atomic state can be updated in a bypass fashion.
 	 *
-	 * This hook is called by drm_atomic_async_check() to establish if a
-	 * given update can be committed asynchronously, that is, if it can
-	 * jump ahead of the state currently queued for update.
+	 * This hook is called by drm_atomic_bypass_check() to establish if a
+	 * given update can be committed bypassing the atomic commit machinery.
+	 * That is, if it can jump ahead of the state currently queued for update.
 	 *
 	 * This function is also used by drm_atomic_set_property() to determine
 	 * if the plane can be flipped in async. The flip flag is used to
@@ -1438,35 +1438,35 @@ struct drm_plane_helper_funcs {
 	 * RETURNS:
 	 *
 	 * Return 0 on success and any error returned indicates that the update
-	 * can not be applied in asynchronous manner.
+	 * can not be applied bypassing the normal machinery.
 	 */
-	int (*atomic_async_check)(struct drm_plane *plane,
-				  struct drm_atomic_commit *state, bool flip);
+	int (*atomic_bypass_check)(struct drm_plane *plane,
+				   struct drm_atomic_commit *state, bool flip);
 
 	/**
-	 * @atomic_async_update:
+	 * @atomic_bypass_update:
 	 *
 	 * Drivers should set this function pointer to perform asynchronous
-	 * updates of planes, that is, jump ahead of the currently queued
-	 * state and update the plane.
+	 * updates of planes, bypassing the commit machinery. That is, jump
+	 * ahead of the currently queued state and update the plane.
 	 *
-	 * This hook is called by drm_atomic_helper_async_commit().
+	 * This hook is called by drm_atomic_helper_bypass_commit().
 	 *
-	 * An async update will happen on legacy cursor updates. An async
+	 * A bypass update will happen on legacy cursor updates. A bypass
 	 * update won't happen if there is an outstanding commit modifying
 	 * the same plane.
 	 *
-	 * When doing async_update drivers shouldn't replace the
+	 * When doing bypass_update drivers shouldn't replace the
 	 * &drm_plane_state but update the current one with the new plane
 	 * configurations in the new plane_state.
 	 *
 	 * Drivers should also swap the framebuffers between current plane
 	 * state (&drm_plane.state) and new_state.
-	 * This is required since cleanup for async commits is performed on
+	 * This is required since cleanup for bypass commits is performed on
 	 * the new state, rather than old state like for traditional commits.
 	 * Since we want to give up the reference on the current (old) fb
 	 * instead of our brand new one, swap them in the driver during the
-	 * async commit.
+	 * bypass commit.
 	 *
 	 * FIXME:
 	 *  - It only works for single plane updates
@@ -1476,8 +1476,8 @@ struct drm_plane_helper_funcs {
 	 *    we run this hook. For now drivers must implement their own workers
 	 *    for deferring if needed, until a common solution is created.
 	 */
-	void (*atomic_async_update)(struct drm_plane *plane,
-				    struct drm_atomic_commit *state);
+	void (*atomic_bypass_update)(struct drm_plane *plane,
+				     struct drm_atomic_commit *state);
 
 	/**
 	 * @get_scanout_buffer:
-- 
2.56.0

