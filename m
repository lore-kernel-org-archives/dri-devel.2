Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B4AFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E1D10F188;
	Wed, 29 Apr 2026 21:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PiBZtVYu";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69B9D10F182
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 21:04:12 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so1561115e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777496651; x=1778101451; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=87wY3atp/xRru7rN04VKTsllcBHojWcPtTLSUldgpCk=;
 b=PiBZtVYuH/rnZ3sS+HxPVlpQ8UlAE1jqfCGt1JC8x5nQO/r7E5TrMmXQC3coDGYAyl
 ZGUg5Fx533xpMDZEqfcTZwMjLGJmsqJmlpveMfNvlcXdQfhLnzYeqygX0JCcif5G+g8P
 zIMWnBi4wKvsXlL2KLzxnvdnqN4bZ43F2afJ7oywTtBHKZRTEaN7P+L1CqZtGlYXm3DO
 xF70m0laJLTQlLau5sHRWmznrU5sbaHCxiwPnSbalx4lsXCVkCxP1p0llqYVqkNju3LQ
 nFBprIsVNy6AQ+yhs/LF0w2DZvfKmI4hecDK666KiC/MR024GEHXlfzmNWFx/zYmOBwn
 KZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777496651; x=1778101451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87wY3atp/xRru7rN04VKTsllcBHojWcPtTLSUldgpCk=;
 b=IHWGdPSufoTGSCtfBXiIPtGPd+GnJ3h84IO7ALtqH8sWFF8V+H/IWYJdqZs4+GHI9y
 dA12hkEvNeJuO59hXWprvYCYwfwG9utDgIvaJTXvi/QbqBC14aSr3tLTsVGE7ssK48hp
 wInIKse6PDcm4YyQYgp5wpdadnz5KZRjaPkbogjLzJwKTNbT8ER1tKAXvobZmlvzvCLD
 96+ik+ZV9MMDtBb/nQpW8Tx6SITxr1cFUf9CvET3z6u9i6ZhNOB5YCixj5nc4+b9zStY
 9cJvkLNXRNyxR9VU0+DRnIeyLOzlc+yoKRwXARp+p9rHZY67EiRxWQeyrrC366BrIfzq
 ht1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2NePhkIB987UTvQ7Oe4RCp6xwq/vBp/zeCZmyscZE149nxgMfgPFr9l8++DDuvoAMEJ05/LFMNVs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylJ4i9inmAibGA+77+WIXwYfrnk/4Cz/ME4t8Dqix5B+X3A8Ae
 /3OCMfvFbdwHtdOxu5Af5AgeyuJPHrQTYrZZTszogA8os+dQmSDPruIo
X-Gm-Gg: AeBDieu4rjLw9FPkxTXUk8xPVcqEdWClQIy85D91zCVosWkcDOaqrllysznRVUr8YbJ
 656MYWrd/TzJaMcnFGgrO55JY6jyqw303SVBjnS4MoKKTjdHZl9fDgiOB0lHISC7omIWq3v1DPw
 PVqhXsxAhU0sgbTEpC8Smw/YYUqg9k+Koc6YK8vH4zHuzpTbakwtdAMxEqZc0a0bG4rsvhzDArl
 9Q9yaFZOyNAo1ZQ/K6AOgGRC5tNn2nU5HHlOzyUW99jrWDvBsbZmlRmFsy7NtGeVzvbaWnrDzdj
 njGM3fDO8Sd+MAA7RH3xTQNhzRd/7ruH3//tNBZv7JvShMj0q+vLLtD3axzOy0Ud6VlxNkFPkqL
 nuTopEzb1CGSuYV2ohDEpvpCN/Y/hWJLWBSNXHi/ami/xCT/FORe6SvixweEkkICpaF6Hp/c4Jt
 B4z+2/sgadVw4zM8LAeC9EpbFJpdJzXsUaQfw2Cd6Pu8+APlHxf25JCIx8X4dTIm/JLGsm+7D6m
 DWKj5Qi1s837TMMxWWr4r4guUHb4B8eNXZGW5nV8IfFMg==
X-Received: by 2002:a05:600c:5254:b0:486:fbdb:b718 with SMTP id
 5b1f17b1804b1-48a8445f451mr3880135e9.25.1777496650606; 
 Wed, 29 Apr 2026 14:04:10 -0700 (PDT)
Received: from fedora.homenet.telecomitalia.it
 (host-79-27-7-133.retail.telecomitalia.it. [79.27.7.133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b91b2bdsm29382575e9.7.2026.04.29.14.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 14:04:10 -0700 (PDT)
From: Adriano Vero <adri.vero.dev@gmail.com>
To: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com
Cc: siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Adriano Vero <adri.vero.dev@gmail.com>
Subject: [PATCH] drm/amd/display: clean up reversed type specifiers in
 dml2_core
Date: Wed, 29 Apr 2026 23:02:09 +0200
Message-ID: <20260429210209.42737-1-adri.vero.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

Replace non-standard reversed type specifiers with canonical C ordering:
- 'int unsigned' -> 'unsigned int'
- 'long int unsigned' cast -> 'unsigned long'

Affected sites:
- dml2_core_utils.c: function return type, parameter type, local
  variable, and two viewport height casts
- dml2_core_utils.h: matching declarations for the above functions
- dml2_core_dcn4.c: two viewport height casts and one local variable

No functional change.

Signed-off-by: Adriano Vero <adri.vero.dev@gmail.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c   |  6 +++---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c  | 12 +++++++-----
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h  |  6 ++++--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
index 858e7bbc511f..ad03e66f963d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -287,10 +287,10 @@ static void create_phantom_plane_from_main_plane(struct dml2_plane_parameters *p
 	phantom->stream_index = phantom_stream_index;
 	phantom->overrides.refresh_from_mall = dml2_refresh_from_mall_mode_override_force_disable;
 	phantom->overrides.legacy_svp_config = dml2_svp_mode_override_phantom_pipe_no_data_return;
-	phantom->composition.viewport.plane0.height = (long int unsigned) math_min2(math_ceil2(
+	phantom->composition.viewport.plane0.height = (unsigned long) math_min2(math_ceil2(
 		(double)main->composition.scaler_info.plane0.v_ratio * (double)phantom_stream->timing.v_active, 16.0),
 		(double)main->composition.viewport.plane0.height);
-	phantom->composition.viewport.plane1.height = (long int unsigned) math_min2(math_ceil2(
+	phantom->composition.viewport.plane1.height = (unsigned long) math_min2(math_ceil2(
 		(double)main->composition.scaler_info.plane1.v_ratio * (double)phantom_stream->timing.v_active, 16.0),
 		(double)main->composition.viewport.plane1.height);
 	phantom->immediate_flip = false;
@@ -527,7 +527,7 @@ bool core_dcn4_mode_support(struct dml2_core_mode_support_in_out *in_out)
 
 	bool result;
 	unsigned int i, stream_index, stream_bitmask;
-	int unsigned odm_count, num_odm_output_segments, dpp_count;
+	unsigned int odm_count, num_odm_output_segments, dpp_count;
 
 	expand_implict_subvp(in_out->display_cfg, &l->svp_expanded_display_cfg, &core->scratch);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
index 4f5533dc0430..77044c77fa44 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
@@ -384,7 +384,9 @@ unsigned int dml2_core_utils_round_to_multiple(unsigned int num, unsigned int mu
 		return (num - remainder);
 }
 
-unsigned int dml2_core_util_get_num_active_pipes(int unsigned num_planes, const struct core_display_cfg_support_info *cfg_support_info)
+unsigned int
+dml2_core_util_get_num_active_pipes(unsigned int num_planes,
+				    const struct core_display_cfg_support_info *cfg_support_info)
 {
 	unsigned int num_active_pipes = 0;
 
@@ -480,9 +482,9 @@ bool dml2_core_utils_is_vertical_rotation(enum dml2_rotation_angle Scan)
 	return is_vert;
 }
 
-int unsigned dml2_core_utils_get_gfx_version(enum dml2_swizzle_mode sw_mode)
+unsigned int dml2_core_utils_get_gfx_version(enum dml2_swizzle_mode sw_mode)
 {
-	int unsigned version = 0;
+	unsigned int version = 0;
 
 	if (sw_mode == dml2_sw_linear ||
 		sw_mode == dml2_sw_256b_2d ||
@@ -594,10 +596,10 @@ static void create_phantom_plane_from_main_plane(struct dml2_plane_parameters *p
 	phantom->stream_index = phantom_stream_index;
 	phantom->overrides.refresh_from_mall = dml2_refresh_from_mall_mode_override_force_disable;
 	phantom->overrides.legacy_svp_config = dml2_svp_mode_override_phantom_pipe_no_data_return;
-	phantom->composition.viewport.plane0.height = (long int unsigned) math_min2(math_ceil2(
+	phantom->composition.viewport.plane0.height = (unsigned long) math_min2(math_ceil2(
 		(double)main->composition.scaler_info.plane0.v_ratio * (double)phantom_stream->timing.v_active, 16.0),
 		(double)main->composition.viewport.plane0.height);
-	phantom->composition.viewport.plane1.height = (long int unsigned) math_min2(math_ceil2(
+	phantom->composition.viewport.plane1.height = (unsigned long) math_min2(math_ceil2(
 		(double)main->composition.scaler_info.plane1.v_ratio * (double)phantom_stream->timing.v_active, 16.0),
 		(double)main->composition.viewport.plane1.height);
 	phantom->immediate_flip = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h
index 60fa2abfef85..2a2177ad7cd9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h
@@ -17,14 +17,16 @@ void dml2_core_utils_print_mode_support_info(const struct dml2_core_internal_mod
 const char *dml2_core_utils_internal_soc_state_type_str(enum dml2_core_internal_soc_state_type dml2_core_internal_soc_state_type);
 void dml2_core_utils_get_stream_output_bpp(double *out_bpp, const struct dml2_display_cfg *display_cfg);
 unsigned int dml2_core_utils_round_to_multiple(unsigned int num, unsigned int multiple, bool up);
-unsigned int dml2_core_util_get_num_active_pipes(int unsigned num_planes, const struct core_display_cfg_support_info *cfg_support_info);
+unsigned int
+dml2_core_util_get_num_active_pipes(unsigned int num_planes,
+				    const struct core_display_cfg_support_info *cfg_support_info);
 void dml2_core_utils_pipe_plane_mapping(const struct core_display_cfg_support_info *cfg_support_info, unsigned int *pipe_plane);
 bool dml2_core_utils_is_phantom_pipe(const struct dml2_plane_parameters *plane_cfg);
 unsigned int dml2_core_utils_get_tile_block_size_bytes(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel);
 bool dml2_core_utils_get_segment_horizontal_contiguous(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel);
 bool dml2_core_utils_is_vertical_rotation(enum dml2_rotation_angle Scan);
 bool dml2_core_utils_is_linear(enum dml2_swizzle_mode sw_mode);
-int unsigned dml2_core_utils_get_gfx_version(enum dml2_swizzle_mode sw_mode);
+unsigned int dml2_core_utils_get_gfx_version(enum dml2_swizzle_mode sw_mode);
 unsigned int dml2_core_utils_get_qos_param_index(unsigned long uclk_freq_khz, const struct dml2_dcn4_uclk_dpm_dependent_qos_params *per_uclk_dpm_params);
 unsigned int dml2_core_utils_get_active_min_uclk_dpm_index(unsigned long uclk_freq_khz, const struct dml2_soc_state_table *clk_table);
 bool dml2_core_utils_is_dual_plane(enum dml2_source_format_class source_format);
-- 
2.53.0

