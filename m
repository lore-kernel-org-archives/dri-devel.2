Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0342CC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42DDB10EFAD;
	Wed, 15 Jul 2026 10:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JsYjdxdS";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E12D10EFAD
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:58:05 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47df440fcd5so2990412f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 03:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784113083; x=1784717883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rDxUFhcdBO0e8D9o6B1XXkO4RN1Rci1Nx7BcXRe7aE0=;
 b=JsYjdxdS8YwFNc4+OW6MQl/9kOhJtx927eHQFYXpcZBFJrFgAdS02YH6G9CCPjczgg
 qz2nN/yZFJcpU7pebaVFF1ovdeYO8myP2WP1ykEH01BWRmkYrjWBtH5Y6UcA8HPEnwzI
 amW3gxiD5cLBxxO3xGzD39639n7ekI+4pb1fFJbFO0JGw0uzZqDlCxMf718YsZ20aVys
 h5WMa4Ysj2Fjc8C0gRtcGfG7vHsseSsq7VyiLjojKhXryP9CZafURD3+rOfLcfjpbzRK
 lkipgyx/VkukQ0/Y9hZMo2cYf8wUe+oJugyQV84HWmzRWUHpvBrCY1TNc2kimnd5PTjE
 zpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784113083; x=1784717883;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rDxUFhcdBO0e8D9o6B1XXkO4RN1Rci1Nx7BcXRe7aE0=;
 b=JAfusGiotWQw/JiINCLXTjrGj+TNPT7d3o6+5kUB89Wl0JL1MLwEEr+fmNNYQHsPpe
 Rnhbj8DwRcXJX2RfTaTQ89kIfn0MrvXNLknVN4774uhbZN+6g4y5+kosWQlTfcIgZp2+
 15RWvFCYgvr8kQyQN7Q29diD0sF3s/1Bar4mxNBUo7W/sl/SzHr8CbFii/wfnbLHqQ9e
 lp8GMxQADN8vrHes+ASvGZBIqsRjTZJuBheTTJnTOoN2P1PAUNTjQCrNZaTVAwrZvZkt
 ZoYMH1CX5GzTNaYSh9Ml693nl02G3cu3g0dhdtrxiTMz5ElH1PRPxh0DBNK+KXbajcqh
 +1dQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFr7BA7R0LBV+js1LCqH4Pnb/5UkhKbYjiwS4cLSUV7VFoGAHrbQUE14FCjS7nZbv/WEKmDHUZgaM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCuHX2vyxpqTFR1DhN6WD6hY5atEr1TiVQB+p6GyUcQsTaMaNl
 U/fJd/7hUX3mYKAkXvk0gSiWtjfQ2tIfYNVCycrk8Q9W2+NHW++moywy
X-Gm-Gg: AfdE7ck2F/Vb0oqP56PtWMvoYMg3NfmAGyXvcmN9RSV/fPCHOAC4fOUSF+kzgfNldt6
 xlODa37W3iafW9QyzSNiA5DbjPS75SgUJiFI6SoeY6OPDUopGTSJ+Xeysu4dyg0tZnW5KwL2Xgq
 qjtCpWvlejR/2TKnLRatb5K3lyWOgAA9KnpqtqW3NpLUKrk82j/72zOISELfiPEuI7PMJRQ0/e/
 SsUtcZPNlHcPQ+Rc0riD2ZpBTU6xWV7tA8B6M8LKYrM39d4i+lRT8QCW2TBHXM4njacQLsR2b1n
 JQlO0KpccNKAT+5Cki/FvQw0vUNMThhGz614iSLJYixZathvOiykTHv7x53drhoQnlsmiZjIM/6
 HaSChHn7ZpxBqcTTDGMlGw8mWQu6iO4si1bj0Nv7js8V5dHzsTS3ov44iuhri3oeYoO1bBpaZ/U
 Ll68lLEblzXx2Dj1wWzOHCML+V/n6/ej1iBzfoYZgsYfuYjUTNGaneYA==
X-Received: by 2002:a5d:588d:0:b0:464:8d68:618a with SMTP id
 ffacd0b85a97d-47f4fce471dmr2472326f8f.32.1784113083259; 
 Wed, 15 Jul 2026 03:58:03 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c4320sm15091094f8f.32.2026.07.15.03.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:58:02 -0700 (PDT)
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
Subject: [PATCH 2/4] drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
Date: Wed, 15 Jul 2026 12:57:55 +0200
Message-ID: <20260715105757.13125-3-timur.kristof@gmail.com>
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

This is done for consistency between different GPU generations.

Tiling flags are "implicit modifiers" which are used on AMD GPUs
to let the kernel know the tiling information without modifiers.
Convert the tiling flags to modifers on GFX8 and older, so that
the DC display driver can rely on them like on newer generations.

Note that this code path will only be taken when DC actually
exposes any modifiers on GFX6-8, which is handled in a subsequent
commit after this one.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Link Mauve <linkmauve@linkmauve.fr>
Tested-by: Nikola Medić <nmedic89@gmail.com>
Reviewed-by: Marek Olšák <maraeo@gmail.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 111 +++++++++++++++++++-
 1 file changed, 108 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 950937b363fb..dcca930ed3c0 100644
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
+		drm_err(&adev->ddev, "array mode 0x%x not supported by DCE\n", array_mode);
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
@@ -1093,7 +1142,7 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 
 			get_block_dimensions(block_size_log2, format_info->cpp[i],
 					     &block_width, &block_height);
-		} else {
+		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) >= AMD_FMT_MOD_TILE_VER_GFX9) {
 			int swizzle = AMD_FMT_MOD_GET(TILE, modifier);
 
 			switch ((swizzle & ~3) + 1) {
@@ -1120,6 +1169,60 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 
 			get_block_dimensions(block_size_log2, format_info->cpp[i],
 					     &block_width, &block_height);
+		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX6) {
+			const u32 display_micro_tile_pitch = 32; /* required by DCE */
+			const u32 micro_tile_width = 8;
+			const u32 micro_tile_height = 8;
+			const u32 micro_tile_mode = AMD_FMT_MOD_GET(MICROTILE, modifier);
+			const u32 array_mode = AMD_FMT_MOD_GET(TILE, modifier);
+			u32 num_banks, bank_width, bank_height, pipe_config, macro_tile_aspect;
+			u32 num_pipes;
+
+			if (AMD_FMT_MOD_GET(DCC, modifier)) {
+				drm_dbg_kms(rfb->base.dev, "DCC is not displayable on GFX6-8\n");
+				return -EINVAL;
+			}
+			if (array_mode != AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 &&
+			    array_mode != AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
+				drm_dbg_kms(rfb->base.dev,
+					"Array mode %u is not supported by the display driver\n",
+					array_mode);
+				return -EINVAL;
+			}
+			if (micro_tile_mode != AMD_FMT_MOD_MICROTILE_DISPLAY) {
+				drm_dbg_kms(rfb->base.dev,
+					"Micro tile mode %u is not displayable on GFX6-8\n",
+					micro_tile_mode);
+				return -EINVAL;
+			}
+
+			num_banks = 2 << AMD_FMT_MOD_GET(NUM_BANKS, modifier);
+			bank_width = 1 << AMD_FMT_MOD_GET(BANK_WIDTH, modifier);
+			bank_height = 1 << AMD_FMT_MOD_GET(BANK_HEIGHT, modifier);
+			pipe_config = AMD_FMT_MOD_GET(PIPE_CONFIG, modifier);
+			macro_tile_aspect = 1 << AMD_FMT_MOD_GET(MACRO_TILE_ASPECT, modifier);
+
+			if (pipe_config >= AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_8x16)
+				num_pipes = 16;
+			else if (pipe_config >= AMD_FMT_MOD_PIPE_CONFIG_P8_16x16_8x16)
+				num_pipes = 8;
+			else if (pipe_config >= AMD_FMT_MOD_PIPE_CONFIG_P4_8x16)
+				num_pipes = 4;
+			else if (pipe_config == AMD_FMT_MOD_PIPE_CONFIG_P2)
+				num_pipes = 2;
+			else
+				unreachable();
+
+			if (array_mode < AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
+				block_width = display_micro_tile_pitch;
+				block_height = micro_tile_height;
+			} else {
+				/* Assume non-PRT macro tiling modes */
+				block_width = num_pipes * micro_tile_width *
+					      bank_width * macro_tile_aspect;
+				block_height = micro_tile_height * bank_height *
+					       num_banks / macro_tile_aspect;
+			}
 		}
 
 		ret = amdgpu_display_verify_plane(rfb, i, format_info,
@@ -1271,8 +1374,10 @@ static int amdgpu_display_framebuffer_init(struct drm_device *dev,
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

