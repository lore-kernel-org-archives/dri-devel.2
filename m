Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39495606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ik/Lxj1E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC80C10E728;
	Wed, 28 Oct 2026 22:54:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1AF10E6F1;
 Wed, 28 Oct 2026 22:54:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31CFE4369B;
 Wed, 28 Oct 2026 22:54:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793228059;
 b=fSMnSYf+LCzrgPlrIQwijd5F0dMaXEdXK2v7c/B4NEq23i2/FrZyUW/8a9/XNFa/HaDo
 4aDz/AQMvzyqWBrSAARHyRSk2mkVuxS/egNe16n6cbcNh+MgnLPJDAXo7aW3plLP0Y7BD
 ptHl2PSW5473uPEEBmZRhiFgMiD8REG0cQwErX3NFEUnD2IN/yhyUWxPrAsVcURVsdX1l
 rF+BK8E7dxVOeX05MKAEJYNEeWv1OhNZY0msQsIx/TcCwJGpd07mp80/EEt9dVHKcbJC9
 eVpoQDiSeqdRCJ+zMtfo8omyHDsf9u2FJhMkdtDwsXia6CNTPPm1a54Nl8wRujCoP+Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793228059;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=91VEYxrWpgwa4M+36Qjxp4NGzpInmkS9xDZHy4gVHAA=;
 b=GywoqSIBMvK5lO50y3uU12cSFA3R1IhPVIYOp+TuJPA4bgP6Bf31W3ZSXxkikzeu+qG/
 3o5XAEDX9Qs8tu3YQYuoKq4bV2WZW3tFiRrnLtyHlAL/7tmime9N1q5E1TIWG6mvXIPQ5
 zdjCuJ+/XxiAw1zzXcmU9hTb6J36O1kS5Hhqe1wdwPZ/bgqI9UPQJTLL4hRK/SmuxKi5m
 AfGSiAluSTIy/1TdXM6I+hT0SVDoCIRFDO8zCqWs3gaqRUUbj4ZWe5wPg1aVvbFec6C2X
 P0KQx1ZzjFsKOjYTNbi4WoNlgrN26PO1lrwQHL7uuIUPVk7YU7u2nQWea2FUxq8eOXg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 38B191F031ED;
 Wed, 28 Oct 2026 22:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793228059;
 bh=91VEYxrWpgwa4M+36Qjxp4NGzpInmkS9xDZHy4gVHAA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ik/Lxj1E1jIDMKadn6GpSBfe4IVsTCYFP2J3karEWXd5ZOVq3eGmArkpVznwy75Zi
 TPg/H86EjBBtbT6v0c9fhUTbReAlgMMO3FuCqOuHSEYM0zQ4OGgT1zuYDK39JWa9T1
 NY6gyNtKTbENjHf720I+q3RtGT34B092LHdvh3VhX9k18xaokOerjBEm9kEfkq4bAR
 UkwnN2en0g3cse4FljsjD20eXbzZ04Rqiil9D2/VuGrPYj1Ilm4O3Q2i5OAHY2pdGY
 xeHCW3VoiXg020oQHQHBV6umS/BoF4k2Nvv5+lo+VbU7jnusIOzzqH+CtrEo+2nUF2
 Dv0ycf1R8xyRg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id BC8F745600;
 Wed, 28 Oct 2026 22:54:15 +0000 (UTC)
From: Davey Hughes via B4 Relay <devnull+davidralphhughes.gmail.com@kernel.org>
Date: Wed, 28 Oct 2026 15:54:13 -0700
Subject: [PATCH v2 2/2] drm/amd/display: Test FreeSync flip timing across
 plane resets
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261028-freesync-plane-reset-time-v2-2-545a0f9b17df@gmail.com>
References: <20261028-freesync-plane-reset-time-v2-0-545a0f9b17df@gmail.com>
In-Reply-To: <20261028-freesync-plane-reset-time-v2-0-545a0f9b17df@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Davey Hughes <davidralphhughes@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793228055; l=10330;
 i=davidralphhughes@gmail.com; s=20261027; h=from:subject:message-id;
 bh=VwlawnVubKUzbzuNwhR+l0VX7d4WCNEFb37QZO4Cefs=;
 b=kua4b85fKrdZFATWOhGFy0r+pX8S2KzHTivHv8lGW49+y8+lD0jlLVGrMqjnrTHQNLGQmo7u/
 gXDH95Px61ACH+aWWywohmjYOn9YEkOP/ioIpoU7KVI4/W5444XFYF9
X-Developer-Key: i=davidralphhughes@gmail.com; a=ed25519;
 pk=y45yWVxpjjxFE2cXy96fGlXLfDlt6UKHFHS5szhrFAs=
X-Endpoint-Received: by B4 Relay for davidralphhughes@gmail.com/20261027
 with auth_id=1335
X-Original-From: Davey Hughes <davidralphhughes@gmail.com>
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
Reply-To: davidralphhughes@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Davey Hughes <davidralphhughes@gmail.com>

KUnit can't call amdgpu_dm_commit_planes(), so test the flip timing
copy through dm_plane_inherit_flip_time(), exposed to KUnit here. Test
that a plane reset on the same CRTC keeps its flip timing, and that a
newly enabled plane or one moved to another CRTC starts over.

Also flip a reset plane one 60 Hz frame after its last flip on a
48-165 Hz panel with BTR. With the inherited timing BTR stays off;
without it FreeSync engages BTR.

Signed-off-by: Davey Hughes <davidralphhughes@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   3 +
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   | 188 +++++++++++++++++++++
 3 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7a0afe6d1b8a..b655a3333b7b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3854,7 +3854,7 @@ EXPORT_IF_KUNIT(dm_arm_vblank_event_pre_programming);
  * this at commit time, not in atomic check: by then the previous commit
  * has finished writing it.
  */
-static void
+STATIC_IFN_KUNIT void
 dm_plane_inherit_flip_time(struct dc_plane_state *dc_plane_state,
 			   struct drm_plane_state *old_plane_state,
 			   struct drm_plane_state *new_plane_state)
@@ -3866,6 +3866,7 @@ dm_plane_inherit_flip_time(struct dc_plane_state *dc_plane_state,
 	    old_plane_state->crtc == new_plane_state->crtc)
 		dc_plane_state->time = old_dc_plane_state->time;
 }
+EXPORT_IF_KUNIT(dm_plane_inherit_flip_time);
 
 static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 				    struct drm_device *dev,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 594d275918d5..18dce8244af1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1266,6 +1266,9 @@ int dm_update_plane_state(struct dc *dc,
 			  bool enable,
 			  bool *lock_and_validation_needed,
 			  bool *is_top_most_overlay);
+void dm_plane_inherit_flip_time(struct dc_plane_state *dc_plane_state,
+				struct drm_plane_state *old_plane_state,
+				struct drm_plane_state *new_plane_state);
 int amdgpu_dm_atomic_check(struct drm_device *dev,
 			   struct drm_atomic_commit *state);
 void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commit *state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index a497cce332bb..eb1ce999ed83 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -34,6 +34,7 @@
 #include "atom.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_audio.h"
+#include "amdgpu_dm_freesync.h"
 #include "amdgpu_dm_hdcp.h"
 #include "amdgpu_dm_mst_types.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
@@ -3271,6 +3272,188 @@ static void dm_test_update_plane_state_detached(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, new_plane_state->dc_state);
 }
 
+/* Tests for dm_plane_inherit_flip_time() */
+
+struct dm_test_flip_time_ctx {
+	struct dm_plane_state *old_plane_state;
+	struct dm_plane_state *new_plane_state;
+	struct dc_plane_state *dc_plane_state;
+};
+
+/*
+ * A plane reset on one CRTC: the old DC plane has FreeSync flip history and
+ * the new one is freshly created.
+ */
+static struct dm_test_flip_time_ctx *
+dm_test_flip_time_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_flip_time_ctx *ctx;
+	struct dc_plane_state *old_dc;
+	struct drm_crtc *crtc;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	ctx->old_plane_state = kunit_kzalloc(test, sizeof(*ctx->old_plane_state),
+					     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->old_plane_state);
+	ctx->new_plane_state = kunit_kzalloc(test, sizeof(*ctx->new_plane_state),
+					     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->new_plane_state);
+	ctx->dc_plane_state = kunit_kzalloc(test, sizeof(*ctx->dc_plane_state),
+					    GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc_plane_state);
+	old_dc = kunit_kzalloc(test, sizeof(*old_dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_dc);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	old_dc->time.time_elapsed_in_us[0] = 16667;
+	old_dc->time.index = 1;
+	old_dc->time.prev_update_time_in_us = 1234567;
+	ctx->old_plane_state->dc_state = old_dc;
+	ctx->old_plane_state->base.crtc = crtc;
+	ctx->new_plane_state->base.crtc = crtc;
+
+	return ctx;
+}
+
+static void dm_test_flip_time_inherit(struct dm_test_flip_time_ctx *ctx)
+{
+	dm_plane_inherit_flip_time(ctx->dc_plane_state,
+				   &ctx->old_plane_state->base,
+				   &ctx->new_plane_state->base);
+}
+
+/**
+ * dm_test_flip_time_same_crtc - Test a reset plane keeps its flip history
+ * @test: The KUnit test context
+ */
+static void dm_test_flip_time_same_crtc(struct kunit *test)
+{
+	struct dm_test_flip_time_ctx *ctx = dm_test_flip_time_ctx_alloc(test);
+
+	dm_test_flip_time_inherit(ctx);
+
+	KUNIT_EXPECT_MEMEQ(test, &ctx->dc_plane_state->time,
+			   &ctx->old_plane_state->dc_state->time,
+			   sizeof(ctx->dc_plane_state->time));
+}
+
+/**
+ * dm_test_flip_time_crtc_changed - Test a plane moved between CRTCs starts over
+ * @test: The KUnit test context
+ */
+static void dm_test_flip_time_crtc_changed(struct kunit *test)
+{
+	struct dm_test_flip_time_ctx *ctx = dm_test_flip_time_ctx_alloc(test);
+	struct dc_plane_flip_time *time = &ctx->dc_plane_state->time;
+	struct drm_crtc *other_crtc;
+
+	other_crtc = kunit_kzalloc(test, sizeof(*other_crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other_crtc);
+	ctx->new_plane_state->base.crtc = other_crtc;
+
+	dm_test_flip_time_inherit(ctx);
+
+	KUNIT_EXPECT_NULL(test, memchr_inv(time, 0, sizeof(*time)));
+}
+
+/**
+ * dm_test_flip_time_no_old_dc_state - Test a newly enabled plane starts over
+ * @test: The KUnit test context
+ */
+static void dm_test_flip_time_no_old_dc_state(struct kunit *test)
+{
+	struct dm_test_flip_time_ctx *ctx = dm_test_flip_time_ctx_alloc(test);
+	struct dc_plane_flip_time *time = &ctx->dc_plane_state->time;
+
+	ctx->old_plane_state->dc_state = NULL;
+
+	dm_test_flip_time_inherit(ctx);
+
+	KUNIT_EXPECT_NULL(test, memchr_inv(time, 0, sizeof(*time)));
+}
+
+/*
+ * Flip the reset plane one 60 Hz frame after the old plane's last flip on a
+ * 48-165 Hz panel with below-the-range compensation, and report whether
+ * FreeSync engaged BTR.
+ */
+static bool dm_test_flip_time_btr_active(struct kunit *test,
+					 struct dm_test_flip_time_ctx *ctx)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
+	struct dm_crtc_state *crtc_state;
+	struct mod_vrr_params *vrr;
+	struct amdgpu_crtc *acrtc;
+	u32 flip_time_in_us;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+	adev->dm.adev = adev;
+	/* Only pre-AI flips dereference the module, so a stub will do. */
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->dm.freesync_module = kunit_kzalloc(test, sizeof(struct mod_freesync),
+						 GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.freesync_module);
+
+	/* 165 Hz nominal */
+	stream->ctx = dm_kunit_alloc_dc_with_ctx(test)->ctx;
+	stream->timing.pix_clk_100hz = 4083750;
+	stream->timing.h_total = 2200;
+	stream->timing.v_total = 1125;
+
+	crtc_state->base.crtc = &acrtc->base;
+	crtc_state->base.vrr_enabled = true;
+	crtc_state->stream = stream;
+	crtc_state->vrr_supported = true;
+	crtc_state->freesync_config.min_refresh_in_uhz = 48000000;
+	crtc_state->freesync_config.max_refresh_in_uhz = 165000000;
+	crtc_state->freesync_config.btr = true;
+
+	amdgpu_dm_update_stream_irq_parameters(&adev->dm, crtc_state);
+
+	vrr = &acrtc->dm_irq_params.vrr_params;
+	KUNIT_ASSERT_EQ(test, (int)vrr->state, (int)VRR_STATE_ACTIVE_VARIABLE);
+	KUNIT_ASSERT_TRUE(test, vrr->btr.btr_enabled);
+	KUNIT_ASSERT_FALSE(test, vrr->btr.btr_active);
+
+	flip_time_in_us =
+		ctx->old_plane_state->dc_state->time.prev_update_time_in_us + 16667;
+	amdgpu_dm_update_freesync_state_on_stream(&adev->dm, crtc_state, stream,
+						  ctx->dc_plane_state,
+						  flip_time_in_us);
+
+	return vrr->btr.btr_active;
+}
+
+/**
+ * dm_test_flip_time_btr_inherited - Test a reset plane's next flip stays out of BTR
+ * @test: The KUnit test context
+ */
+static void dm_test_flip_time_btr_inherited(struct kunit *test)
+{
+	struct dm_test_flip_time_ctx *ctx = dm_test_flip_time_ctx_alloc(test);
+
+	dm_test_flip_time_inherit(ctx);
+
+	KUNIT_EXPECT_FALSE(test, dm_test_flip_time_btr_active(test, ctx));
+}
+
+/**
+ * dm_test_flip_time_btr_no_history - Test a plane without flip history enters BTR
+ * @test: The KUnit test context
+ */
+static void dm_test_flip_time_btr_no_history(struct kunit *test)
+{
+	struct dm_test_flip_time_ctx *ctx = dm_test_flip_time_ctx_alloc(test);
+
+	KUNIT_EXPECT_TRUE(test, dm_test_flip_time_btr_active(test, ctx));
+}
+
 /**
  * dm_test_mod_power_update_streams_empty - Test an empty commit updates no streams
  * @test: The KUnit test context
@@ -5361,6 +5544,11 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_aquire_global_lock_waits_commit),
 	KUNIT_CASE(dm_test_update_crtc_state_unchanged),
 	KUNIT_CASE(dm_test_update_plane_state_detached),
+	KUNIT_CASE(dm_test_flip_time_same_crtc),
+	KUNIT_CASE(dm_test_flip_time_crtc_changed),
+	KUNIT_CASE(dm_test_flip_time_no_old_dc_state),
+	KUNIT_CASE(dm_test_flip_time_btr_inherited),
+	KUNIT_CASE(dm_test_flip_time_btr_no_history),
 	KUNIT_CASE(dm_test_mod_power_update_streams_empty),
 	KUNIT_CASE(dm_test_mod_power_update_streams_no_modeset),
 	KUNIT_CASE(dm_test_mod_power_update_streams_enable),

-- 
2.56.0


