Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4828AC44532
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8333810EE56;
	Wed, 22 Jul 2026 16:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CsPFZhul";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DA4710EE5C
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 16:59:45 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4955484387cso27508885e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784739583; x=1785344383; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/96Ieu4FAIJpaUjMB4g5v0GyhswXQ/yoIJZlBXa/SOw=;
 b=CsPFZhulKyJwGHNV5s1QvafhOpoApn7LuuEz55xHXHLhKS6jx01QCYuN62qMQ4FUz1
 rx7OY7z8qAJc9dECAb+U4m5+29/7B1re2tLVDVhIhgHhQ5YnVTg0clg+XBvzb/T0WIZo
 kqOtvBRMeXMAkcT5fnXtNIB7+k0mIAtrvHUxWnYEOI6lDobU1/5nPFOP1TC6pdN5v0Xb
 CFAOzv6DB4Jv8aGYlwxHfnKaq8Ap/yo/15b89MfK3o71gNGQU+8vNyGtNozODv+q6ziv
 GJVoHm1wD9nQVINjqSGUhauwzWLk+m4t3a722sXNt44mio2kdWp0C2TqUNgswayra+ch
 huVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739583; x=1785344383;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/96Ieu4FAIJpaUjMB4g5v0GyhswXQ/yoIJZlBXa/SOw=;
 b=Cx+/3SsaEHkaXcn/qVhDlqydFfHi8Cr+VUcgm90zbqLvtUgxlEQZh1JanRdtQPd0W7
 fYNB8YcKEaYQdjvVbUainUVmqZUllmHVbjwPN/Bfk9ivrt9Nd6TQlA96jT9vnwtDs/32
 mbcprGTRSM+kwgrX1EiS5uSUxYw1a7Xz4dLTdVynKkbzEY2PWtGgaQSMqhMAI0qZUl7q
 pzqggW8VjcJyS1Q4HUkJvIQfuCLBVoTGMPYirdrrG5QstIQs1259PPbJAeQZU449NBr9
 qN2CAmCljfxGmxTrCBx35llaxdqq9F9EKO7z2ZAbBs/TICTlmiT4Jv9bbdjPin5dzw7w
 4H0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTIpL+nc4O69uZDE/r+v3NWvAnk/OrhvbrP+FIXZ+70wJaHMIPFlCk9mH3+BIfQqiv0gUmb0Af/pY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyw+60wtoubi+yKb2UozXGu961K4LADJI/1fE4dFkUpsHOxwALA
 f2pIAdn8Wp4j90yUFLuvpv42GMG7nsFUoq0/ZTBNU7hhN0fIGW6reGo/
X-Gm-Gg: AR+sD12Z2VBD4RZLlLONoZxVdSj6eeq0aaigx1kZCDoUwKwexpUiSiWs2OMW+JCiQpb
 aua3XRq3zS328yDO/dVUAC1QVpQRz2XSnzYu1+oY7XREY830gB1q4kUN8nwz7Fqfv6SCYLTWN08
 KX4qQAxDIkDFrciU2y1OBfv2ZaNwpPlohnf/jQMeyc+Xze8HMt43VhzJFXONIbQdNwb897PL4kF
 hVzh04ECig3NyVqouEdRoG4NrS6IS54f4rPE+6EXTm3omRlD13dMH/xlD/pAC0Z2bAd+vZzUUNJ
 KKY9k0Xgz2jNZFoOkExVrIrekZstf/TYJ8gifC9kwPMlBJaJAPk/qwsZrMzHP1JdHKg0xA85Iol
 89/p4suGn1ogFzOmDIrZtFdhCOyZDV37bQNFri0c17/toNjUvN22WwxIHfZ++JHfVo45MWWdN2r
 9zW+I=
X-Received: by 2002:a05:600c:4f92:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-4954a3d0ce2mr269214285e9.6.1784739583262; 
 Wed, 22 Jul 2026 09:59:43 -0700 (PDT)
Received: from Timur-Max ([62.77.225.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956ab41aa2sm68369615e9.1.2026.07.22.09.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:59:42 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Link Mauve <linkmauve@linkmauve.fr>,
 =?UTF-8?q?Nikola=20Medi=C4=87?= <nmedic89@gmail.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Daniel Stone <daniels@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Dieter=20N=C3=BCtzel?= <Dieter@nuetzel-hh.de>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, airlied@gmail.com,
 simona.vetter@ffwll.ch
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymore
Date: Wed, 22 Jul 2026 18:59:25 +0200
Message-ID: <20260722165925.15805-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722165925.15805-1-timur.kristof@gmail.com>
References: <20260722165925.15805-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

All supported GPU generations now support DRM format modifiers.
Remove all code from amdgpu_dm that dealt with tiling flags.

Note that the legacy non-DC display code still relies on
tiling flags, so we can't remove them outside of DC
until we also remove the legacy display code.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Link Mauve <linkmauve@linkmauve.fr>
Tested-by: Nikola Medić <nmedic89@gmail.com>
Tested-by: Dieter Nützel <Dieter@nuetzel-hh.de>
Reviewed-by: Marek Olšák <maraeo@gmail.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  29 +---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  37 -----
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   3 -
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 141 ------------------
 4 files changed, 2 insertions(+), 208 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f8d8132ea50e..200d6bd41a7a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3059,7 +3059,6 @@ EXPORT_IF_KUNIT(fill_plane_color_attributes);
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    const struct drm_plane_state *plane_state,
-			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
 			    struct dc_plane_address *address,
 			    bool tmz_surface)
@@ -3157,7 +3156,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 		return ret;
 
 	ret = amdgpu_dm_plane_fill_plane_buffer_attributes(adev, afb, plane_info->format,
-					   plane_info->rotation, tiling_flags,
+					   plane_info->rotation,
 					   &plane_info->tiling_info,
 					   &plane_info->plane_size,
 					   &plane_info->dcc, address,
@@ -3193,7 +3192,6 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
 
 	ret = fill_dc_plane_info_and_addr(adev, plane_state,
-					  afb->tiling_flags,
 					  &plane_info,
 					  &dc_plane_state->address,
 					  afb->tmz_surface);
@@ -4281,7 +4279,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 
 		fill_dc_plane_info_and_addr(
 			dm->adev, new_plane_state,
-			afb->tiling_flags,
 			&bundle->plane_infos[planes_count],
 			&bundle->flip_addrs[planes_count].address,
 			afb->tmz_surface);
@@ -6254,8 +6251,7 @@ static bool should_reset_plane(struct drm_atomic_commit *state,
 		new_afb = (struct amdgpu_framebuffer *)new_other_state->fb;
 
 		/* Tiling and DCC changes also require bandwidth updates. */
-		if (old_afb->tiling_flags != new_afb->tiling_flags ||
-		    old_afb->base.modifier != new_afb->base.modifier)
+		if (old_afb->base.modifier != new_afb->base.modifier)
 			return true;
 	}
 
@@ -6267,9 +6263,7 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 			      struct drm_framebuffer *fb)
 {
 	struct amdgpu_device *adev = drm_to_adev(new_acrtc->base.dev);
-	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(fb);
 	unsigned int pitch;
-	bool linear;
 
 	if (fb->width > new_acrtc->max_cursor_width ||
 	    fb->height > new_acrtc->max_cursor_height) {
@@ -6304,25 +6298,6 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 		return -EINVAL;
 	}
 
-	/* Core DRM takes care of checking FB modifiers, so we only need to
-	 * check tiling flags when the FB doesn't have a modifier.
-	 */
-	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
-		if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
-			linear = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE) == 0;
-		} else if (adev->family >= AMDGPU_FAMILY_AI) {
-			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
-		} else {
-			linear = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_2D_TILED_THIN1 &&
-				 AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
-				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
-		}
-		if (!linear) {
-			drm_dbg_atomic(adev_to_drm(adev), "Cursor FB not linear");
-			return -EINVAL;
-		}
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index a593a44ef97b..87187c965d55 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -211,39 +211,6 @@ STATIC_IFN_KUNIT unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_modifier_gfx9_swizzle_mode);
 
-STATIC_IFN_KUNIT void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(struct dc_tiling_info *tiling_info,
-								       uint64_t tiling_flags)
-{
-	/* Fill GFX8 params */
-	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == DC_ARRAY_2D_TILED_THIN1) {
-		unsigned int bankw, bankh, mtaspect, tile_split, num_banks;
-		bankw = AMDGPU_TILING_GET(tiling_flags, BANK_WIDTH);
-		bankh = AMDGPU_TILING_GET(tiling_flags, BANK_HEIGHT);
-		mtaspect = AMDGPU_TILING_GET(tiling_flags, MACRO_TILE_ASPECT);
-		tile_split = AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT);
-		num_banks = AMDGPU_TILING_GET(tiling_flags, NUM_BANKS);
-
-		tiling_info->gfxversion = DcGfxVersion8;
-		/* XXX fix me for VI */
-		tiling_info->gfx8.num_banks = num_banks;
-		tiling_info->gfx8.array_mode =
-				DC_ARRAY_2D_TILED_THIN1;
-		tiling_info->gfx8.tile_split = tile_split;
-		tiling_info->gfx8.bank_width = bankw;
-		tiling_info->gfx8.bank_height = bankh;
-		tiling_info->gfx8.tile_aspect = mtaspect;
-		tiling_info->gfx8.tile_mode =
-				DC_ADDR_SURF_MICRO_TILING_DISPLAY;
-	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE)
-			== DC_ARRAY_1D_TILED_THIN1) {
-		tiling_info->gfx8.array_mode = DC_ARRAY_1D_TILED_THIN1;
-	}
-
-	tiling_info->gfx8.pipe_config =
-			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
-}
-EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags);
-
 STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(
 						struct dc_tiling_info *tiling_info,
 						uint64_t modifier)
@@ -1160,7 +1127,6 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			     const struct amdgpu_framebuffer *afb,
 			     const enum surface_pixel_format format,
 			     const enum dc_rotation_angle rotation,
-			     const uint64_t tiling_flags,
 			     struct dc_tiling_info *tiling_info,
 			     struct plane_size *plane_size,
 			     struct dc_plane_dcc_param *dcc,
@@ -1235,8 +1201,6 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 										address);
 		if (ret)
 			return ret;
-	} else if (afb->base.modifier == DRM_FORMAT_MOD_INVALID) {
-		amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
 	} else {
 		ret = amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(tiling_info,
 									  afb->base.modifier);
@@ -1332,7 +1296,6 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 
 		amdgpu_dm_plane_fill_plane_buffer_attributes(
 			adev, afb, plane_state->format, plane_state->rotation,
-			afb->tiling_flags,
 			&plane_state->tiling_info, &plane_state->plane_size,
 			&plane_state->dcc, &plane_state->address,
 			afb->tmz_surface);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 365e306a52e7..2b9b5f250737 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -48,7 +48,6 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 				 const struct amdgpu_framebuffer *afb,
 				 const enum surface_pixel_format format,
 				 const enum dc_rotation_angle rotation,
-				 const uint64_t tiling_flags,
 				 struct dc_tiling_info *tiling_info,
 				 struct plane_size *plane_size,
 				 struct dc_plane_dcc_param *dcc,
@@ -71,8 +70,6 @@ bool amdgpu_dm_plane_is_video_format(uint32_t format);
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size,
 				  uint64_t *cap, uint64_t mod);
-void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(struct dc_tiling_info *tiling_info,
-						      uint64_t tiling_flags);
 void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
 						       struct dc_tiling_info *tiling_info);
 void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index c521960e5ca8..e54710d7252a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -406,62 +406,6 @@ static void dm_test_get_min_max_dc_plane_scaling(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, max_upscale, 1600);
 }
 
-/**
- * dm_test_fill_plane_buffer_attributes_gfx8() - Verify graphics path and GFX8 tiling fill.
- * @test: KUnit test context.
- *
- * Verify if GFX8 plane buffer attributes and tiling fields are filled correctly.
- */
-static void dm_test_fill_plane_buffer_attributes_gfx8(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct amdgpu_framebuffer *afb;
-	struct dc_tiling_info *tiling_info;
-	struct plane_size *plane_size;
-	struct dc_plane_dcc_param *dcc;
-	struct dc_plane_address *address;
-	uint64_t tiling_flags = 0;
-	int ret;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
-	tiling_info = kunit_kzalloc(test, sizeof(*tiling_info), GFP_KERNEL);
-	plane_size = kunit_kzalloc(test, sizeof(*plane_size), GFP_KERNEL);
-	dcc = kunit_kzalloc(test, sizeof(*dcc), GFP_KERNEL);
-	address = kunit_kzalloc(test, sizeof(*address), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, afb);
-	KUNIT_ASSERT_NOT_NULL(test, tiling_info);
-	KUNIT_ASSERT_NOT_NULL(test, plane_size);
-	KUNIT_ASSERT_NOT_NULL(test, dcc);
-	KUNIT_ASSERT_NOT_NULL(test, address);
-
-	adev->family = AMDGPU_FAMILY_SI;
-	afb->address = 0x12345000ULL;
-	afb->base.width = 1920;
-	afb->base.height = 1080;
-	afb->base.offsets[0] = 0x1000;
-	afb->base.pitches[0] = 7680;
-	afb->base.format = drm_format_info(DRM_FORMAT_XRGB8888);
-	KUNIT_ASSERT_NOT_NULL(test, afb->base.format);
-
-	tiling_flags |= AMDGPU_TILING_SET(ARRAY_MODE, DC_ARRAY_1D_TILED_THIN1);
-	tiling_flags |= AMDGPU_TILING_SET(PIPE_CONFIG, 5);
-
-	ret = amdgpu_dm_plane_fill_plane_buffer_attributes(adev, afb,
-		SURFACE_PIXEL_FORMAT_GRPH_ARGB8888, ROTATION_ANGLE_0,
-		tiling_flags, tiling_info, plane_size, dcc, address, true);
-
-	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_EQ(test, plane_size->surface_size.width, 1920);
-	KUNIT_EXPECT_EQ(test, plane_size->surface_size.height, 1080);
-	KUNIT_EXPECT_EQ(test, plane_size->surface_pitch, 1920);
-	KUNIT_EXPECT_EQ(test, address->type, (int)PLN_ADDR_TYPE_GRAPHICS);
-	KUNIT_EXPECT_TRUE(test, address->tmz_surface);
-	KUNIT_EXPECT_EQ(test, (int)tiling_info->gfx8.array_mode, (int)DC_ARRAY_1D_TILED_THIN1);
-	KUNIT_EXPECT_EQ(test, tiling_info->gfx8.pipe_config, 5U);
-}
-
 /**
  * dm_test_get_cursor_position() - Verify cursor clipping and off-screen handling.
  * @test: KUnit test context.
@@ -992,86 +936,6 @@ static void dm_test_add_modifier_noop_when_mods_null(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, cap, 7ULL);
 }
 
-/**
- * dm_test_fill_gfx8_tiling_info_2d_tiled() - Verify GFX8 2D tiled flag parsing.
- * @test: KUnit test context.
- *
- * Verify if 2D tiled GFX8 flags populate expected tiling fields.
- */
-static void dm_test_fill_gfx8_tiling_info_2d_tiled(struct kunit *test)
-{
-	struct dc_tiling_info tiling_info = {0};
-	uint64_t tiling_flags = 0;
-
-	tiling_flags |= AMDGPU_TILING_SET(ARRAY_MODE, DC_ARRAY_2D_TILED_THIN1);
-	tiling_flags |= AMDGPU_TILING_SET(BANK_WIDTH, 2);
-	tiling_flags |= AMDGPU_TILING_SET(BANK_HEIGHT, 1);
-	tiling_flags |= AMDGPU_TILING_SET(MACRO_TILE_ASPECT, 3);
-	tiling_flags |= AMDGPU_TILING_SET(TILE_SPLIT, 4);
-	tiling_flags |= AMDGPU_TILING_SET(NUM_BANKS, 2);
-	tiling_flags |= AMDGPU_TILING_SET(PIPE_CONFIG, 7);
-
-	amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(&tiling_info, tiling_flags);
-
-	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxVersion8);
-	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.array_mode, (int)DC_ARRAY_2D_TILED_THIN1);
-	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.bank_width, 2U);
-	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.bank_height, 1U);
-	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.tile_aspect, 3U);
-	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.tile_split, 4U);
-	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.num_banks, 2U);
-	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.tile_mode,
-			(int)DC_ADDR_SURF_MICRO_TILING_DISPLAY);
-	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.pipe_config, 7U);
-}
-
-/**
- * dm_test_fill_gfx8_tiling_info_1d_tiled() - Verify GFX8 1D tiled flag parsing.
- * @test: KUnit test context.
- *
- * Verify if 1D tiled GFX8 flags populate array mode and pipe config.
- */
-static void dm_test_fill_gfx8_tiling_info_1d_tiled(struct kunit *test)
-{
-	struct dc_tiling_info tiling_info = {0};
-	uint64_t tiling_flags = 0;
-
-	tiling_flags |= AMDGPU_TILING_SET(ARRAY_MODE, DC_ARRAY_1D_TILED_THIN1);
-	tiling_flags |= AMDGPU_TILING_SET(PIPE_CONFIG, 5);
-
-	amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(&tiling_info, tiling_flags);
-
-	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.array_mode, (int)DC_ARRAY_1D_TILED_THIN1);
-	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.pipe_config, 5U);
-}
-
-/**
- * dm_test_fill_gfx8_tiling_info_other_mode() - Verify non-1D/non-2D mode handling.
- * @test: KUnit test context.
- *
- * Verify if unsupported array mode keeps preset fields and updates pipe config.
- */
-static void dm_test_fill_gfx8_tiling_info_other_mode(struct kunit *test)
-{
-	struct dc_tiling_info tiling_info = {0};
-	uint64_t tiling_flags = 0;
-
-	tiling_info.gfxversion = 0x7f;
-	tiling_info.gfx8.array_mode = 0x7f;
-	tiling_info.gfx8.tile_mode = 0x7f;
-	tiling_info.gfx8.num_banks = 0x7f;
-
-	tiling_flags |= AMDGPU_TILING_SET(PIPE_CONFIG, 6);
-
-	amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(&tiling_info, tiling_flags);
-
-	KUNIT_EXPECT_EQ(test, tiling_info.gfxversion, 0x7f);
-	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.array_mode, 0x7f);
-	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.tile_mode, 0x7f);
-	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.num_banks, 0x7f);
-	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.pipe_config, 6U);
-}
-
 /**
  * dm_test_fill_gfx9_tiling_info_from_device_pre_10_3() - Verify GFX9 field copy before 10.3.
  * @test: KUnit test context.
@@ -3195,7 +3059,6 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_get_min_max_dc_plane_scaling),
 	KUNIT_CASE(dm_test_get_min_max_dc_plane_scaling_fp16),
 	/* amdgpu_dm_plane_fill_plane_buffer_attributes() */
-	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_gfx8),
 	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_video),
 	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_gfx12),
 	/* amdgpu_dm_plane_get_cursor_position() */
@@ -3245,10 +3108,6 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_add_modifier_appends_value),
 	KUNIT_CASE(dm_test_add_modifier_grows_capacity),
 	KUNIT_CASE(dm_test_add_modifier_noop_when_mods_null),
-	/* amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags() */
-	KUNIT_CASE(dm_test_fill_gfx8_tiling_info_2d_tiled),
-	KUNIT_CASE(dm_test_fill_gfx8_tiling_info_1d_tiled),
-	KUNIT_CASE(dm_test_fill_gfx8_tiling_info_other_mode),
 	/* amdgpu_dm_plane_fill_gfx9_tiling_info_from_device() */
 	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_pre_10_3),
 	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_10_3_plus),
-- 
2.55.0

