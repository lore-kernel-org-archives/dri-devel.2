Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15D9C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E838A10E73A;
	Mon, 20 Jul 2026 14:24:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i4WMSLMz";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B6310E73A
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:24:53 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso1107559466b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784557491; x=1785162291; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yjhONp4vcHwanca4KIrwdLgjwjxQalSG1/3dHOgzdVo=;
 b=i4WMSLMz/ymiow+DisbfcLnDulisTrftZHxW4awnnVbOYyJFKH8wBpAV67odVwwB2K
 OBnocDv4rJC5aJiqPMUDaFhYCNFdwKFfsZIlGRW38N0iUijAySHBPDiqSYv/Gi22zAJh
 xa1Tdk3KR/xnGEQU0Rt3mI89t3ATa/aNXPsp5mo+iFvMn6nWMhY3zeHa46bM5U6mQCxu
 4VUhswMQE8OWq4e0/4CcnyGGFrBuagGt4Le/nlWL6Uzs1WfgudBQoAwD/2bMWThXrGGq
 Qvc/LTtKqIT1hmq9jIwo9V/IGvAspVTIrAVcM+xWVjm+PXpaJkRDXsaIV7/S8xZLd5lw
 SUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784557491; x=1785162291;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yjhONp4vcHwanca4KIrwdLgjwjxQalSG1/3dHOgzdVo=;
 b=edPN9H7DRmnXohcPw7t4qoXQVOjr+KyoOiFA0/nV+NdY2QhJB6TxszyUlUU2dJLdiO
 jI1TFWVEceXjPJcqFOYgkEmnLdJUbWN9dsdZuhbupck3nZoPwaJTXBLpunmHq1ITkbWV
 zjM9qLxA+0JCRV1OJuAjoQaON/oQzk0p707FVpgJ4Et+f/FAlpREYnrvfkQuQrHiszKN
 6S6PoHPuVSbrVPWHvGRL84quIFb9M2Ch9vHgYbMx6AO1bqH01JO0fFajaknILux/npG9
 e8/rBoqrTpDdsFBu95rDaQefSOAR6TAEMLTrJahx7TyBiiX8TySrAk7MsNpM3AC774SW
 2UgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrw65ti/XB3rvi0MM3UUtqRn5ujq9xBN9S26YKzMdsBEEDWOrfSrglEGJZJPzqmZ3M4j1nRJ+xDvUM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxcdNHrjrj2kGJK/oYgCuHJ4boYbLbVdZbKSEs6ptxgpguJSv8
 mdXwJ5Ok9X/19wUgzGeBk9A9zRBoJ1NoHjxyDS/Op9aQlvIdrnq6z+sH
X-Gm-Gg: AfdE7clcWeDmMSwM8BMyZ/dcOD+NDmRKgwn7HlefVqhUczQRKWPu3NYDEEuSSaWtgye
 DDa+rahuDk8amg6PILpcDpswyjocvcjxolwT3urf+t5hUH8uO920Pw5+RclCxDjuSBczxGAULey
 PWp1bF3e04hQEw2lxHebfxKXIVtBWJvvlMyvYb06sV8yj6gvXzluOtznQZHNQX2ZfkWV8mAjyr1
 ku7ebGtQJjOK7gS8wGyHt0HGsosSF26HKNrDBMnzl3kYi0YZpTe+9z3CstrGSmUmJ+brkiOcqb6
 s0vzxyg6+GiVCmL+oM1bg13WRdR2cEXCb1zebZGDvjcYfShbRYAS5x1CAS21e8riFk4++UrfA+a
 G/vPpkbE2Y6BMWi1COJZ8XUih18BYWayPrqXG3lw08TeNBMDVlGQTF8l8/LFElgXFhr/GcbBqto
 cbAA9AP8SeaI5PQAGzxpkc7XaPsiSi8xcdjpAskyASVOo=
X-Received: by 2002:a17:907:3ea2:b0:c16:5855:659b with SMTP id
 a640c23a62f3a-c16b49ed328mr594666266b.57.1784557491219; 
 Mon, 20 Jul 2026 07:24:51 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e6fff5efasm4999534a12.26.2026.07.20.07.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:24:50 -0700 (PDT)
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
Subject: [PATCH 3/4] drm/amd/display: Support DRM format modifiers on GFX6-8
Date: Mon, 20 Jul 2026 16:24:39 +0200
Message-ID: <20260720142440.22076-4-timur.kristof@gmail.com>
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

Expose displayable DRM format modifiers based on which
tiling modes are supported by the GFX block.

Technically, DCE (Display Controller Engine) could
support all possible permutations of all parameters
independently of what GFX supports, with the limitation
that it can only display LINEAR images and the
displayable micro tiling mode (MICROTILE == DISPLAY).
It doesn't make sense to expose all possible permutations
of macro tiling modes, so let's just expose what the GFX
block of the current chip supports.

The following modes will be advertised:
- 2D_TILED_THIN1 + DISPLAY + macrotile params [1]
- 1D_TILED_THIN1 + DISPLAY
- LINEAR

[1] The macro tiling parameters depend on how many
bits per pixel of the specific surface has and
how the chip is configured. There is only one set
of valid macrotile params for a given surface.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Link Mauve <linkmauve@linkmauve.fr>
Tested-by: Nikola Medić <nmedic89@gmail.com>
Tested-by: Dieter Nützel <Dieter@nuetzel-hh.de>
Reviewed-by: Marek Olšák <maraeo@gmail.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 322 +++++++++++++++++-
 1 file changed, 315 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 26f35434a92f..2706b2ea4eae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -180,6 +180,22 @@ STATIC_IFN_KUNIT void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *si
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier);
 
+STATIC_IFN_KUNIT void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64_t *size,
+							 uint64_t *cap, uint64_t mod)
+{
+	uint64_t i;
+
+	if (!*mods)
+		return;
+
+	for (i = 0; i < *size; ++i)
+		if ((*mods)[i] == mod)
+			return;
+
+	amdgpu_dm_plane_add_modifier(mods, size, cap, mod);
+}
+EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier_dedup);
+
 STATIC_IFN_KUNIT bool amdgpu_dm_plane_modifier_has_dcc(uint64_t modifier)
 {
 	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
@@ -228,6 +244,41 @@ STATIC_IFN_KUNIT void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(struct dc
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags);
 
+STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(
+						struct dc_tiling_info *tiling_info,
+						uint64_t modifier)
+{
+	if (modifier == DRM_FORMAT_MOD_LINEAR) {
+		tiling_info->gfx8.array_mode = DC_ARRAY_LINEAR_GENERAL;
+		tiling_info->gfxversion = DcGfxVersion8;
+
+		return 0;
+	}
+
+	if (!IS_AMD_FMT_MOD(modifier))
+		return -EINVAL;
+
+	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) != AMD_FMT_MOD_TILE_VER_GFX6)
+		return -EINVAL;
+
+	tiling_info->gfx8.array_mode = AMD_FMT_MOD_GET(TILE, modifier);
+	tiling_info->gfxversion = DcGfxVersion8;
+	tiling_info->gfx8.tile_mode = AMD_FMT_MOD_GET(MICROTILE, modifier);
+
+	if (AMD_FMT_MOD_GET(TILE, modifier) < AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1)
+		return 0;
+
+	tiling_info->gfx8.pipe_config = AMD_FMT_MOD_GET(PIPE_CONFIG, modifier);
+	tiling_info->gfx8.tile_split = AMD_FMT_MOD_GET(TILE_SPLIT, modifier);
+	tiling_info->gfx8.bank_width = AMD_FMT_MOD_GET(BANK_WIDTH, modifier);
+	tiling_info->gfx8.bank_height = AMD_FMT_MOD_GET(BANK_HEIGHT, modifier);
+	tiling_info->gfx8.tile_aspect = AMD_FMT_MOD_GET(MACRO_TILE_ASPECT, modifier);
+	tiling_info->gfx8.num_banks = AMD_FMT_MOD_GET(NUM_BANKS, modifier);
+
+	return 0;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier);
+
 STATIC_IFN_KUNIT void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
 									struct dc_tiling_info *tiling_info)
 {
@@ -468,6 +519,249 @@ static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_device *ad
 				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
 }
 
+/**
+ * amdgpu_dm_plane_get_gfx6_tile_idx() - Get tile mode index on GFX6-8
+ *
+ * @adev: amdgpu_device pointer
+ * @bpp: bits per pixel in the image
+ * @arr: array mode (aka. tile mode) of the image layout
+ *
+ * Select which tiling mode from the table is suitable for the given bits per pixel
+ * using the given array mode, assuming the displayable micro tile mode is used.
+ *
+ * On GFX6-8, the GFX block can only use pre-programmed tiling modes from GB_TILE_MODEn
+ * registers which are programmed by the kernel according to the tiling mode table.
+ * Note that the tiling table is uAPI and userspace relies on specific modes being
+ * present at specific indices.
+ * See SiLib::HwlSetupTileInfo() and CiLib::HwlSetupTileInfo() in addrlib.
+ */
+static u32 amdgpu_dm_plane_get_gfx6_tile_idx(const struct amdgpu_device *adev,
+					 const u32 bpp,
+					 const enum array_mode_values arr)
+{
+	/* Assume that the microtile mode is DISPLAY. */
+
+	if (arr == DC_ARRAY_1D_TILED_THIN1)
+		return 9;
+
+	ASSERT(arr == DC_ARRAY_2D_TILED_THIN1);
+
+	if (adev->family > AMDGPU_FAMILY_SI)
+		return 10;
+
+	switch (bpp) {
+	case 8:
+		return 10;
+	case 16:
+		return 11;
+	default:
+		return 12;
+	}
+}
+
+/**
+ * amdgpu_dm_plane_calc_gfx7_tile_split() - Calculate tile split on GFX7-8
+ *
+ * @adev: amdgpu_device pointer
+ * @bpp: bits per pixel in the image
+ * @gb_tile_mode: GB_TILE_MODEn register value for the current tiling mode
+ *
+ * Calculate the actual tile split value on GFX7-8, assuming 2D_TILED_THIN1 array mode
+ * with a non-depth micro tile mode.
+ *
+ * On GFX7-8, SAMPLE_SPLIT holds a factor from which the actual tile split bytes
+ * can be calculated. The TILE_SPLIT field is only used for the depth micro tile mode.
+ * See CiLib::HwlComputeMacroModeIndex() in addrlib.
+ */
+static u32 amdgpu_dm_plane_calc_gfx7_tile_split(const struct amdgpu_device *adev,
+						const u32 bpp,
+						const u32 gb_tile_mode)
+{
+	/* Assume 2D_TILED_THIN1 mode with non-DEPTH microtiles */
+	const u32 sample_split = (gb_tile_mode >> 25) & 0x3;
+	const u32 thickness = 1;
+	const u32 tile_size_pixels = 8 * 8;
+	const u32 tile_bytes_1x = tile_size_pixels * bpp * thickness / 8;
+	const u32 sample_split_factor = 1 << sample_split;
+
+	return clamp(tile_bytes_1x * sample_split_factor,
+		     256,
+		     adev->gfx.config.mem_row_size_in_kb * 1024);
+}
+
+/**
+ * amdgpu_dm_plane_get_gfx7_macro_tile_idx() - Get macro tile mode index on GFX7-8
+ *
+ * @bpp: bits per pixel in the image
+ * @tile_split_bytes: actual tile split bytes, see amdgpu_dm_plane_calc_gfx7_tile_split()
+ *
+ * Select which macro tiling mode from the table is suitable for the given bits per pixel,
+ * assuming 2D_TILED_THIN1 array mode and DISPLAY micro tile mode (and no multisampling).
+ * Note that the tiling table is uAPI and userspace relies on specific modes being
+ * present at specific indices.
+ * See CiLib::HwlComputeMacroModeIndex() in addrlib.
+ */
+static u32 amdgpu_dm_plane_get_gfx7_macro_tile_idx(const u32 bpp, const u32 tile_split_bytes)
+{
+	const u32 thickness = 1;
+	const u32 tile_size_pixels = 8 * 8;
+	const u32 tile_bytes_1x = thickness * tile_size_pixels * bpp / 8;
+	const u32 tile_bytes = clamp(tile_bytes_1x, 64, tile_split_bytes);
+	const u32 macro_tile_idx = ilog2(tile_bytes / 64);
+
+	WARN_ON(macro_tile_idx >= 16);
+
+	return macro_tile_idx;
+}
+
+/**
+ * amdgpu_dm_plane_calc_gfx6_mod() - Calculate a DRM format modifier for GFX6-8
+ *
+ * @adev: amdgpu_device pointer
+ * @bpp: bits per pixel in the image
+ * @arr: array mode (aka. tile mode) of the image layout
+ *
+ * Select suitable micro and macro tile modes for the given bits per pixel,
+ * and calculate the corresponding DRM format modifier.
+ */
+static u64 amdgpu_dm_plane_calc_gfx6_mod(const struct amdgpu_device *adev,
+					 const u32 bpp,
+					 const enum array_mode_values arr)
+{
+	u32 array_mode, micro_tile_mode, tile_split_bytes;
+	u32 gb_macrotile_mode, macrotile_idx;
+	u32 gb_tile_mode, tile_idx;
+
+	u64 modifier_base =
+		AMD_FMT_MOD |
+		AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+		AMD_FMT_MOD_SET(TILE, arr) |
+		AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY);
+
+	if (arr < DC_ARRAY_2D_TILED_THIN1)
+		return modifier_base;
+
+	tile_idx = amdgpu_dm_plane_get_gfx6_tile_idx(adev, bpp, arr);
+	gb_tile_mode = adev->gfx.config.tile_mode_array[tile_idx];
+	array_mode = (gb_tile_mode >> 2) & 0xf;
+
+	if (adev->family == AMDGPU_FAMILY_SI) {
+		micro_tile_mode = (gb_tile_mode >> 0) & 0x3;
+		tile_split_bytes = 64 << ((gb_tile_mode >> 11) & 0x7);
+	} else {
+		micro_tile_mode = (gb_tile_mode >> 22) & 0x7;
+		tile_split_bytes = amdgpu_dm_plane_calc_gfx7_tile_split(adev, bpp, gb_tile_mode);
+	}
+
+	ASSERT(array_mode == arr);
+	ASSERT(micro_tile_mode == AMD_FMT_MOD_MICROTILE_DISPLAY);
+
+	modifier_base |=
+		AMD_FMT_MOD_SET(PIPE_CONFIG, (gb_tile_mode >> 6) & 0x1f) |
+		AMD_FMT_MOD_SET(TILE_SPLIT, ilog2(tile_split_bytes / 64));
+
+	if (adev->family == AMDGPU_FAMILY_SI)
+		return modifier_base |
+			AMD_FMT_MOD_SET(BANK_WIDTH, (gb_tile_mode >> 14) & 0x3) |
+			AMD_FMT_MOD_SET(BANK_HEIGHT, (gb_tile_mode >> 16) & 0x3) |
+			AMD_FMT_MOD_SET(MACRO_TILE_ASPECT, (gb_tile_mode >> 18) & 0x3) |
+			AMD_FMT_MOD_SET(NUM_BANKS, (gb_tile_mode >> 20) & 0x3);
+
+	macrotile_idx = amdgpu_dm_plane_get_gfx7_macro_tile_idx(bpp, tile_split_bytes);
+	gb_macrotile_mode = adev->gfx.config.macrotile_mode_array[macrotile_idx];
+
+	return modifier_base |
+		AMD_FMT_MOD_SET(BANK_WIDTH, (gb_macrotile_mode >> 0) & 0x3) |
+		AMD_FMT_MOD_SET(BANK_HEIGHT, (gb_macrotile_mode >> 2) & 0x3) |
+		AMD_FMT_MOD_SET(MACRO_TILE_ASPECT, (gb_macrotile_mode >> 4) & 0x3) |
+		AMD_FMT_MOD_SET(NUM_BANKS, (gb_macrotile_mode >> 6) & 0x3);
+}
+
+/**
+ * amdgpu_dm_plane_gfx6_format_mod_supported() - Check if a modifier is supported on GFX6-8
+ *
+ * @adev: amdgpu_device pointer
+ * @bpp: bits per pixel in the image
+ * @modifier: the modifier whose support we check
+ *
+ * On GFX6-8, not all DRM format modifier can be used with all image formats.
+ * Check whether the specified modifier is supported with the given bits per pixel value.
+ */
+static bool amdgpu_dm_plane_gfx6_format_mod_supported(const struct amdgpu_device *adev,
+						      const u32 bpp,
+						      const u64 modifier)
+{
+	const u32 array_mode = AMD_FMT_MOD_GET(TILE, modifier);
+	const u32 micro_tile_mode = AMD_FMT_MOD_GET(MICROTILE, modifier);
+
+	if (!IS_AMD_FMT_MOD(modifier))
+		return false;
+
+	/* GFX9 and newer format modifiers are not supported on GFX6-8 yet. */
+	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) != AMD_FMT_MOD_TILE_VER_GFX6)
+		return false;
+
+	/* GFX8 and older format modifiers are not supported on GFX9+ yet. */
+	if (adev->family >= AMDGPU_FAMILY_AI)
+		return false;
+
+	/* GFX6-7 doesn't have any DCC, GFX8 doesn't have displayable DCC. */
+	if (AMD_FMT_MOD_GET(DCC, modifier))
+		return false;
+
+	/*
+	 * For now, only expose 1D and 2D tiles THIN array modes.
+	 * Linear is already exposed through DRM_FORMAT_MOD_LINEAR.
+	 */
+	if (array_mode != AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 &&
+	    array_mode != AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1)
+		return false;
+
+	/*
+	 * For now, only expose DISPLAY micro tile mode.
+	 * THIN, DEPTH and THICK modes are not displayable.
+	 * ROTATED has never been supported on Linux.
+	 */
+	if (micro_tile_mode != AMD_FMT_MOD_MICROTILE_DISPLAY)
+		return false;
+
+	/* Verify that the modifier is the same that we'd expose for this bpp */
+	return amdgpu_dm_plane_calc_gfx6_mod(adev, bpp, array_mode) == modifier;
+}
+
+/**
+ * amdgpu_dm_plane_add_gfx6_modifiers() - Expose modifiers for GFX6-8
+ *
+ * @adev: amdgpu_device pointer
+ * @mods: Pointer to array of format modifiers
+ * @size: Pointer to size of the array
+ * @capacity: Pointer to capacity of the array
+ *
+ * Calculate a DRM format modifier for macro tiled modes for each supported
+ * bits per pixel value. Use de-duplication because on some GPUs it may happen
+ * that different bpp results in the exact same macro tiling mode, depending
+ * on the tiling table.
+ *
+ * Also expose a micro tiled only mode. This is less optimal, but supported.
+ */
+static void amdgpu_dm_plane_add_gfx6_modifiers(const struct amdgpu_device *adev,
+					       u64 **mods,
+					       u64 *size,
+					       u64 *capacity)
+{
+	/* 2D tiled displayable */
+	amdgpu_dm_plane_add_modifier(mods, size, capacity,
+		amdgpu_dm_plane_calc_gfx6_mod(adev, 16, DC_ARRAY_2D_TILED_THIN1));
+	amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
+		amdgpu_dm_plane_calc_gfx6_mod(adev, 32, DC_ARRAY_2D_TILED_THIN1));
+	amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
+		amdgpu_dm_plane_calc_gfx6_mod(adev, 64, DC_ARRAY_2D_TILED_THIN1));
+
+	/* 1D tiled displayable */
+	amdgpu_dm_plane_add_modifier(mods, size, capacity,
+		amdgpu_dm_plane_calc_gfx6_mod(adev, 0, DC_ARRAY_1D_TILED_THIN1));
+}
+
 static void amdgpu_dm_plane_add_gfx9_modifiers(const struct amdgpu_device *adev,
 					       uint64_t **mods,
 					       uint64_t *size,
@@ -749,12 +1043,6 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(struct amdgpu_device *adev,
 STATIC_IFN_KUNIT int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
 {
 	uint64_t size = 0, capacity = 128;
-	*mods = NULL;
-
-	/* We have not hooked up any pre-GFX9 modifiers. */
-	if (adev->family < AMDGPU_FAMILY_AI)
-		return 0;
-
 	*mods = kmalloc_array(capacity, sizeof(uint64_t), GFP_KERNEL);
 
 	if (plane_type == DRM_PLANE_TYPE_CURSOR) {
@@ -764,6 +1052,13 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *a
 	}
 
 	switch (adev->family) {
+	case AMDGPU_FAMILY_SI:
+	case AMDGPU_FAMILY_CI:
+	case AMDGPU_FAMILY_KV:
+	case AMDGPU_FAMILY_VI:
+	case AMDGPU_FAMILY_CZ:
+		amdgpu_dm_plane_add_gfx6_modifiers(adev, mods, &size, &capacity);
+		break;
 	case AMDGPU_FAMILY_AI:
 	case AMDGPU_FAMILY_RV:
 		amdgpu_dm_plane_add_gfx9_modifiers(adev, mods, &size, &capacity);
@@ -940,8 +1235,13 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 										address);
 		if (ret)
 			return ret;
-	} else {
+	} else if (afb->base.modifier == DRM_FORMAT_MOD_INVALID) {
 		amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
+	} else {
+		ret = amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(tiling_info,
+									  afb->base.modifier);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -1587,6 +1887,7 @@ STATIC_IFN_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *pla
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	const struct drm_format_info *info = drm_format_info(format);
+	const u32 bpp = drm_format_info_bpp(info, 0);
 	int i;
 
 	if (!info)
@@ -1610,6 +1911,13 @@ STATIC_IFN_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *pla
 	if (i == plane->modifier_count)
 		return false;
 
+	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX6)
+		return amdgpu_dm_plane_gfx6_format_mod_supported(adev, bpp, modifier);
+
+	/* GFX9+ modifers are not supported on GFX8 and older yet. */
+	if (adev->family < AMDGPU_FAMILY_AI)
+		return false;
+
 	/* GFX12 doesn't have these limitations. */
 	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) <= AMD_FMT_MOD_TILE_VER_GFX11) {
 		enum dm_micro_swizzle microtile = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier) & 3;
-- 
2.55.0

