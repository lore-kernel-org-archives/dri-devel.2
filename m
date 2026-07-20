Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE9EC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42D9410E8C5;
	Mon, 20 Jul 2026 14:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jy6Bxvs9";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A95C10E8C5
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:24:51 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-699fbcd23ccso14773950a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784557489; x=1785162289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dIzV4mgVSA0M46unoHVr1GzcW4/BIOwaL4mFhmFAKKY=;
 b=jy6Bxvs9R1Fzs1fRAmWAs+zlOs3mxsetxBca0zMAMacCR7soN7bqcSxV9JSqiQORLo
 Odo9XhKfbmsH+dLf/OZEzvPc6AeEMzwsXmApUnJQEbItbbZ3y5GXe0mttL2bi+UNZHzl
 KoiY6ZvDCG+zv+/ZFc9RlkcBpaok+OKygMBZIVDo1Rt/k6lgCPv5AXli3viYMmv8K7Mk
 tiH7Cdx3scN//LdUQGcUPQCwYdNn8aktZ1wDtI2cdaXpsm3pfdBOhYaHdoQVZfOKTXFU
 gUdkgM80jq0M/WLDO7muqLsrC+NNgvaqk/qILTVm3/vj2gCLmpJSaiiEbtSqtHz1zEv+
 ARgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784557489; x=1785162289;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dIzV4mgVSA0M46unoHVr1GzcW4/BIOwaL4mFhmFAKKY=;
 b=h6cW+otirmlnoQr95++jsWR68j+avaiLZptwR7Nv0G4dQWxwQhIZfeog/eZnyR4T67
 JQfb1SXozoLe43103mDXsAmpMO4J6YlStFCxZYajXygJ897h7Ld0078s3MpOi1eaKqOp
 3HGUVDgCyAsFKRO9VyPUxsShDLcqk877yUUQOd095/+G0TmceGfw2+EB+T73dlISTNrb
 FwurUABTpFGFKX7AmNAMSgbpHqGwutQ1D2TOkYI7RGQeHCMEL5b+f8EBZ3e2nN3ZqMDq
 8bN0y8DLTsSCerP9GpHgg5Ka47jz7/weFw4dq4XbVI3d3vA43lKupmks+Yzxq9Q4FJEV
 3unQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/DZH6Rw/1wd58AC45fMVwbpa1CR+zYF1EKrrvwADwYHl7/49S7oMdM55M+JWwZSvmaqSUU8nmvQA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzATMA8jocrpeP2pf4rOdAJEIrdAf3I1YOBgSpx84/J4gBH/nf2
 99ExEO+pgw4rSLCv3/IzU332+OQAvAkHbhLCrqPSqfI/j4ruAW+MvCAY
X-Gm-Gg: AfdE7ckdX+PA5IFl1RZ7T/DKW4NQsaBSPSBZi+VgMTIBcku5/ZCKSHDSuqtUv/iOClr
 Ott33k+Ks4/4v2OwyiKRdQcKDUTqZcG4hBzR4rlU6P+gp0KUQIksnyFDQ3HXQouK5tyb21TrEhe
 BtCnLD3D727mp9PZgiQlNaugMeut27Y5WG3iMW528wrxTxHv5+Wwnzlb7I2zNsJ3ROLkCrfKa4W
 4OBY+RLCLDEz+A16KmpFYP4BzslRiDDTUqtTxCYVVh+0UYr8uUxmuqzkFx/4KcrGBGqBFxHL8cU
 KElND2V4bHkNXCvS+O38BVxULeq3Q1Iqy5JTkIByokb/GoSAisU0bnfeSbJt8V7LnheCTtfrCMk
 OeM+jHb+ZiheXABolh6jY37ZIOnI9B6bPewlu2Qf1sD6IsBp3lF2bGl8XDl/IwGeyKuS7yxjYiP
 IJCOXFZ1pWnCIWj0CHbwc3q10Jd5dSuUiKZDPWMzV2Mjs=
X-Received: by 2002:a05:6402:2686:b0:69c:4051:69e5 with SMTP id
 4fb4d7f45d1cf-69e65306589mr4997838a12.28.1784557489219; 
 Mon, 20 Jul 2026 07:24:49 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e6fff5efasm4999534a12.26.2026.07.20.07.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:24:48 -0700 (PDT)
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
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/4] drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
Date: Mon, 20 Jul 2026 16:24:38 +0200
Message-ID: <20260720142440.22076-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720142440.22076-1-timur.kristof@gmail.com>
References: <20260720142440.22076-1-timur.kristof@gmail.com>
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

This is done for consistency between different GPU generations.

Tiling flags are "implicit modifiers" which are used on AMD GPUs
to let the kernel know the tiling information without modifiers.
Convert the tiling flags to modifers on GFX8 and older, so that
the DC display driver can rely on them like on newer generations.

Note that this code path will only be taken when DC actually
exposes any modifiers on GFX6-8, which is handled in a subsequent
commit after this one.

This code path mainly exists for legacy compositors which
don't support explicit DRM format modifiers and rely on
the tiling flags.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Link Mauve <linkmauve@linkmauve.fr>
Tested-by: Nikola Medić <nmedic89@gmail.com>
Tested-by: Dieter Nützel <Dieter@nuetzel-hh.de>
Reviewed-by: Marek Olšák <maraeo@gmail.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 144 +++++++++++++++++++-
 1 file changed, 141 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index f5cd68542442..8e84e491e9d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -746,7 +746,7 @@ static int convert_tiling_flags_to_modifier_gfx12(struct amdgpu_framebuffer *afb
 	return 0;
 }
 
-static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
+static int convert_tiling_flags_to_modifier_gfx9(struct amdgpu_framebuffer *afb)
 {
 	struct amdgpu_device *adev = drm_to_adev(afb->base.dev);
 	uint64_t modifier = 0;
@@ -940,6 +940,55 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 	return 0;
 }
 
+static int convert_tiling_flags_to_modifier_gfx6(struct amdgpu_framebuffer *afb)
+{
+	const uint32_t array_mode = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE);
+	const uint32_t pipe_config = AMDGPU_TILING_GET(afb->tiling_flags, PIPE_CONFIG);
+	const uint32_t tile_split = AMDGPU_TILING_GET(afb->tiling_flags, TILE_SPLIT);
+	const uint32_t micro_tile_mode = AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE);
+	const uint32_t bank_width = AMDGPU_TILING_GET(afb->tiling_flags, BANK_WIDTH);
+	const uint32_t bank_height = AMDGPU_TILING_GET(afb->tiling_flags, BANK_HEIGHT);
+	const uint32_t macro_tile_aspect = AMDGPU_TILING_GET(afb->tiling_flags, MACRO_TILE_ASPECT);
+	const uint32_t num_banks = AMDGPU_TILING_GET(afb->tiling_flags, NUM_BANKS);
+	struct amdgpu_device *adev = drm_to_adev(afb->base.dev);
+	uint64_t modifier = 0;
+
+	switch (array_mode) {
+	case DC_ARRAY_LINEAR_GENERAL:
+	case DC_ARRAY_LINEAR_ALLIGNED:
+		modifier = DRM_FORMAT_MOD_LINEAR;
+		break;
+
+	case DC_ARRAY_2D_TILED_THIN1:
+		/* Macro tiled modes only */
+		modifier |=
+			AMD_FMT_MOD_SET(PIPE_CONFIG, pipe_config) |
+			AMD_FMT_MOD_SET(TILE_SPLIT, tile_split) |
+			AMD_FMT_MOD_SET(BANK_WIDTH, bank_width) |
+			AMD_FMT_MOD_SET(BANK_HEIGHT, bank_height) |
+			AMD_FMT_MOD_SET(MACRO_TILE_ASPECT, macro_tile_aspect) |
+			AMD_FMT_MOD_SET(NUM_BANKS, num_banks);
+		fallthrough;
+
+	case DC_ARRAY_1D_TILED_THIN1:
+		/* Micro and macro tiled modes */
+		modifier |=
+			AMD_FMT_MOD |
+			AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+			AMD_FMT_MOD_SET(TILE, array_mode) |
+			AMD_FMT_MOD_SET(MICROTILE, micro_tile_mode);
+		break;
+
+	default:
+		drm_dbg_kms(&adev->ddev, "array mode 0x%x not supported\n", array_mode);
+		return -EINVAL;
+	}
+
+	afb->base.modifier = modifier;
+	afb->base.flags |= DRM_MODE_FB_MODIFIERS;
+	return 0;
+}
+
 /* Mirrors the is_displayable check in radeonsi's gfx6_compute_surface */
 static int check_tiling_flags_gfx6(struct amdgpu_framebuffer *afb)
 {
@@ -1053,6 +1102,84 @@ static int amdgpu_display_verify_plane(struct amdgpu_framebuffer *rfb, int plane
 	return 0;
 }
 
+static int amdgpu_display_verify_sizes_gfx6(struct drm_device *dev,
+					    const u64 modifier,
+					    unsigned int *out_block_width,
+					    unsigned int *out_block_height)
+{
+	const u32 display_micro_tile_pitch = 32; /* required by DCE */
+	const u32 micro_tile_width = 8;
+	const u32 micro_tile_height = 8;
+	const u32 micro_tile_mode = AMD_FMT_MOD_GET(MICROTILE, modifier);
+	const u32 array_mode = AMD_FMT_MOD_GET(TILE, modifier);
+	u32 num_banks, bank_width, bank_height, pipe_config, macro_tile_aspect;
+	u32 num_pipes;
+
+	if (AMD_FMT_MOD_GET(DCC, modifier)) {
+		drm_dbg_kms(dev, "DCC is not displayable on GFX6-8\n");
+		return -EINVAL;
+	}
+	if (array_mode != AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 &&
+	    array_mode != AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
+		drm_dbg_kms(dev, "Array mode %u not supported by display driver\n", array_mode);
+		return -EINVAL;
+	}
+	if (micro_tile_mode != AMD_FMT_MOD_MICROTILE_DISPLAY) {
+		drm_dbg_kms(dev, "Microtile mode %u not displayable\n", micro_tile_mode);
+		return -EINVAL;
+	}
+
+	num_banks = 2 << AMD_FMT_MOD_GET(NUM_BANKS, modifier);
+	bank_width = 1 << AMD_FMT_MOD_GET(BANK_WIDTH, modifier);
+	bank_height = 1 << AMD_FMT_MOD_GET(BANK_HEIGHT, modifier);
+	pipe_config = AMD_FMT_MOD_GET(PIPE_CONFIG, modifier);
+	macro_tile_aspect = 1 << AMD_FMT_MOD_GET(MACRO_TILE_ASPECT, modifier);
+
+	switch (pipe_config) {
+	case AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_8x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_16x16:
+		num_pipes = 16;
+		break;
+
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_16x16_8x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_8x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_8x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_16x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x32:
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_32x64_32x32:
+		num_pipes = 8;
+		break;
+
+	case AMD_FMT_MOD_PIPE_CONFIG_P4_8x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P4_16x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P4_16x32:
+	case AMD_FMT_MOD_PIPE_CONFIG_P4_32x32:
+		num_pipes = 4;
+		break;
+
+	case AMD_FMT_MOD_PIPE_CONFIG_P2:
+		num_pipes = 2;
+		break;
+
+	default:
+		drm_dbg_kms(dev, "Pipe config %u invalid\n", pipe_config);
+		return -EINVAL;
+	}
+
+	if (array_mode < AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
+		*out_block_width = display_micro_tile_pitch;
+		*out_block_height = micro_tile_height;
+	} else {
+		/* Assume non-PRT macro tiling modes */
+		*out_block_width = num_pipes * micro_tile_width *
+				   bank_width * macro_tile_aspect;
+		*out_block_height = micro_tile_height * bank_height *
+				    num_banks / macro_tile_aspect;
+	}
+
+	return 0;
+}
 
 static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 {
@@ -1093,7 +1220,7 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 
 			get_block_dimensions(block_size_log2, format_info->cpp[i],
 					     &block_width, &block_height);
-		} else {
+		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) >= AMD_FMT_MOD_TILE_VER_GFX9) {
 			int swizzle = AMD_FMT_MOD_GET(TILE, modifier);
 
 			switch ((swizzle & ~3) + 1) {
@@ -1120,6 +1247,15 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 
 			get_block_dimensions(block_size_log2, format_info->cpp[i],
 					     &block_width, &block_height);
+		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX6) {
+			ret = amdgpu_display_verify_sizes_gfx6(rfb->base.dev, modifier,
+							       &block_width, &block_height);
+			if (ret)
+				return ret;
+
+			ASSERT(is_power_of_2(block_width));
+			ASSERT(is_power_of_2(block_height));
+			block_size_log2 = ilog2(block_width * block_height);
 		}
 
 		ret = amdgpu_display_verify_plane(rfb, i, format_info,
@@ -1271,8 +1407,10 @@ static int amdgpu_display_framebuffer_init(struct drm_device *dev,
 	    !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0))
 			ret = convert_tiling_flags_to_modifier_gfx12(rfb);
+		else if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 0, 0))
+			ret = convert_tiling_flags_to_modifier_gfx9(rfb);
 		else
-			ret = convert_tiling_flags_to_modifier(rfb);
+			ret = convert_tiling_flags_to_modifier_gfx6(rfb);
 
 		if (ret) {
 			drm_dbg_kms(dev, "Failed to convert tiling flags 0x%llX to a modifier",
-- 
2.55.0

