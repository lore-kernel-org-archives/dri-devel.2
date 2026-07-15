Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2850C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381D110EFAC;
	Wed, 15 Jul 2026 10:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dePPj3nS";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 218B310EFC4
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:58:08 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47df6a5202bso3359795f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784113086; x=1784717886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NBdJYZF0LxhZafRoTdm1Af0bajENGQ1sRQ7yFEfXmu8=;
 b=dePPj3nSA2ocetQKHGmVWX+juboGwHtJVLEBPYTF8qy7agUD4UlwxGo7DdY+2gDMWY
 UWFEDUx+7lomwk8bg4CFhvSoVqJU0DWH4yXz6MDS0V6aWKgqdgmdO6CbKmkdVFc+34p5
 KM+EcZz7GOFtz1noB6DUKHnbP/tK52fbqfvOBcLf41VG3MuYb2bVt9XTM7UWdLiwDwX8
 f4Z8XLOok+sfHqBTag2mY+RRDXahQHZStTlt1XJQ7X+kqyVS67VxXUXPTNNFGj0LPLJJ
 EEyWDSFEy38QkX058vGHAxUn+uTIMm7ATQsu0BRyR9IH9afbEmF8iC0hF4lPAkeVMUe8
 JTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784113086; x=1784717886;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NBdJYZF0LxhZafRoTdm1Af0bajENGQ1sRQ7yFEfXmu8=;
 b=ZKRKPJ3ay+oZgQYQVu9mYnr5wcHzWB2yn6GKCxFRs3LaN8dGiOqZBbzgPgTODwe0aA
 cVdD0RxLKzFubtGAjDCHJooTSS4I7SB2ZeBnuToiMrRP2Gkbcg/EDnqwiKqR/wJ+KKdb
 9fCS67Ty17pkMm3KOh3thGKbPPbqQtRDbPuHd0D3kjxj3DfNk/D9ZChY+lVPRoGqqCww
 ZAR/726NYtDlrFYce+uSa4kDRvK6i5hX3wXE9XiDONSc0cQ/ExKALI8TSReA1fZOuT+e
 CBkmrPt9I3nGF1IAbfi3yZNfET6XZ6Fd1GlOL6cKoY2RWns+IllUl4BtEcYftcNFFxZi
 MgLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIlk4mD2o/6hf29gatuU9Gr2LAZBG2UP0iw5uGTpp3P/10vxI0GOCD3K6vdmLUWmgL54FiIp+noZU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxxot/yjMdllXO6h4E0/kL92Fx0KPALFWeehk5VadtDuY5mcO3x
 bowalIJ+698nuFMlyC93FzD2lXZCLfHCrm3A4nQOiNMTOK4YYIZN/DcC
X-Gm-Gg: AfdE7ckB9rrzxxrOPsNWyu3jkvsZL493VGHxZ+ccoMN/ZvyYwmdffDOilaZ9t7KcwUN
 08C27nkg/XlaRyMOLVeaj2oI5m0apESMNs3iy1Lm1XMOWC8+R9AsGjW3+odAbCn+ocsap/dmRtu
 7sWS6AvyfUbofFQa2oDTlttYHnkJcRYKFPGO+VH4+j2U8PeUGOgUWsrhrSbYnPyEdiuVGVzzL7L
 Rba1BdBaxH3+ORBrgHkZofQnDfPgl57RegImFks1l/ofo2QJUSBRN6b5rPG88Vd4GjFID+pI1DT
 5G4lQd+ZiFQh0w6++3HXorCykokh3so4vViWQlk9nVS7qCSO6cC5vlDxzNLohLg9+Xl2veThoTP
 y0pmnUyAQ+Uy5mqro9BgFbAv96uONFebR8KThvGrOhIBickMsygr09RApjY8lDQwLhQugECBhm9
 cZRVzU88gnfuc5wmS5nLTgvi+W4MZwIu4ZRPSE1Uw1f1r9Gp0Tsb3p3Q==
X-Received: by 2002:a05:6000:4282:b0:47f:2bc3:8cf7 with SMTP id
 ffacd0b85a97d-47f4fcb69e3mr2673154f8f.19.1784113086329; 
 Wed, 15 Jul 2026 03:58:06 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c4320sm15091094f8f.32.2026.07.15.03.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:58:05 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Dieter@nuetzel-hh.de
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Link Mauve <linkmauve@linkmauve.fr>,
 =?UTF-8?q?Nikola=20Medi=C4=87?= <nmedic89@gmail.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Daniel Stone <daniels@collabora.com>
Subject: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymore
Date: Wed, 15 Jul 2026 12:57:57 +0200
Message-ID: <20260715105757.13125-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715105757.13125-1-timur.kristof@gmail.com>
References: <20260715105757.13125-1-timur.kristof@gmail.com>
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
Reviewed-by: Marek Olšák <maraeo@gmail.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 37 --------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |  3 -
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 84 -------------------
 4 files changed, 2 insertions(+), 151 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c643cc542857..2f7388c47d02 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3057,7 +3057,6 @@ EXPORT_IF_KUNIT(fill_plane_color_attributes);
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    const struct drm_plane_state *plane_state,
-			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
 			    struct dc_plane_address *address,
 			    bool tmz_surface)
@@ -3155,7 +3154,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 		return ret;
 
 	ret = amdgpu_dm_plane_fill_plane_buffer_attributes(adev, afb, plane_info->format,
-					   plane_info->rotation, tiling_flags,
+					   plane_info->rotation,
 					   &plane_info->tiling_info,
 					   &plane_info->plane_size,
 					   &plane_info->dcc, address,
@@ -3191,7 +3190,6 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
 
 	ret = fill_dc_plane_info_and_addr(adev, plane_state,
-					  afb->tiling_flags,
 					  &plane_info,
 					  &dc_plane_state->address,
 					  afb->tmz_surface);
@@ -4279,7 +4277,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 		fill_dc_plane_info_and_addr(
 			dm->adev, new_plane_state,
-			afb->tiling_flags,
 			&bundle->plane_infos[planes_count],
 			&bundle->flip_addrs[planes_count].address,
 			afb->tmz_surface);
@@ -6248,8 +6245,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 		new_afb = (struct amdgpu_framebuffer *)new_other_state->fb;
 
 		/* Tiling and DCC changes also require bandwidth updates. */
-		if (old_afb->tiling_flags != new_afb->tiling_flags ||
-		    old_afb->base.modifier != new_afb->base.modifier)
+		if (old_afb->base.modifier != new_afb->base.modifier)
 			return true;
 	}
 
@@ -6261,9 +6257,7 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 			      struct drm_framebuffer *fb)
 {
 	struct amdgpu_device *adev = drm_to_adev(new_acrtc->base.dev);
-	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(fb);
 	unsigned int pitch;
-	bool linear;
 
 	if (fb->width > new_acrtc->max_cursor_width ||
 	    fb->height > new_acrtc->max_cursor_height) {
@@ -6298,25 +6292,6 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
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
index 9d56ce635cbd..d066947f59e1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -208,39 +208,6 @@ STATIC_IFN_KUNIT unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_
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
@@ -1154,7 +1121,6 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			     const struct amdgpu_framebuffer *afb,
 			     const enum surface_pixel_format format,
 			     const enum dc_rotation_angle rotation,
-			     const uint64_t tiling_flags,
 			     struct dc_tiling_info *tiling_info,
 			     struct plane_size *plane_size,
 			     struct dc_plane_dcc_param *dcc,
@@ -1229,8 +1195,6 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 										address);
 		if (ret)
 			return ret;
-	} else if (afb->base.modifier == DRM_FORMAT_MOD_INVALID) {
-		amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
 	} else {
 		ret = amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(tiling_info,
 									  afb->base.modifier);
@@ -1326,7 +1290,6 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 
 		amdgpu_dm_plane_fill_plane_buffer_attributes(
 			adev, afb, plane_state->format, plane_state->rotation,
-			afb->tiling_flags,
 			&plane_state->tiling_info, &plane_state->plane_size,
 			&plane_state->dcc, &plane_state->address,
 			afb->tmz_surface);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 45230df1947e..c20ed57dbe63 100644
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
index b89e1224b266..068bf94a6b25 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -998,86 +998,6 @@ static void dm_test_add_modifier_noop_when_mods_null(struct kunit *test)
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
@@ -3251,10 +3171,6 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
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

