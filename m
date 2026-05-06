Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D16CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 19:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C733110E580;
	Wed,  6 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GpHqL5E4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6464B10E57F;
 Wed,  6 May 2026 19:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KULPWTSaGUqqUtwef27b10JhBMrOgEU4AiWufFKRIb4=; b=GpHqL5E43+vfK0f3yWjQ5LK/LP
 Dy4GNI3YcNdgbKguR9X88CY0R2piJofQqgSh7xYB2jaarEIWNB8ii8FVUJ5lolZ5DBAohrD6/ZEJ9
 WC9bl9OmlulCAVDBOsKaZVGrWU2eJ3fgQUwuRqkWR1YAjHWepdbQNvBi9Aexs5u9VkfZ3XPLLOUGD
 qIb7lq1yd8G8ZSxsyfKml7qkkjqIxefGiWIvsX29x3W7imfLGfgUT+mXnlvjkjUHJww3FIPHey3ei
 dAnUvWlaMLCUOh/rd0Xd1x7mhlwkMIwBur6d5an/vUrUUS5+6Upop8iFW0TAJhe3UL4GkRMImX04E
 Z5vcV2YQ==;
Received: from [186.208.73.228] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wKhjO-0072Pg-I7; Wed, 06 May 2026 21:16:26 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 pekka.paalanen@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: [PATCH v2 1/5] drm/amd/display: use GAMCOR for degamma private props
 in subsampled format
Date: Wed,  6 May 2026 16:11:48 -0300
Message-ID: <20260506191606.15022-2-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506191606.15022-1-mwen@igalia.com>
References: <20260506191606.15022-1-mwen@igalia.com>
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

When setting plane degamma TF via AMD driver-specific color properties,
the driver uses PRE_DEGAM color block (ROM). However, this block cannot
be used with subsampled formats as it affects the linearity of color
space in which HW scaler operates. For subsampled format, use the AMD
color module to map plane degamma predefined curve to LUT and use GAMCOR
block instead (RAM).

This is based on Harry's implementation for Fixed Matrix Colorop.

Link: https://lore.kernel.org/dri-devel/20260330153451.99472-1-harry.wentland@amd.com/
Co-developed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c  | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 20a76d81d532..4e5b664bbec0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1424,7 +1424,7 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
 	const struct drm_color_lut *degamma_lut;
 	enum amdgpu_transfer_function tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
 	uint32_t degamma_size;
-	bool has_degamma_lut;
+	bool has_degamma_lut, is_subsampled_format;
 	int ret;
 
 	degamma_lut = __extract_blob_lut(dm_plane_state->degamma_lut,
@@ -1454,12 +1454,20 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
 		if (ret)
 			return ret;
        } else {
-		dc_plane_state->in_transfer_func.type =
-			TF_TYPE_PREDEFINED;
+	       /* Check if format requires post-scale color processing (subsampled formats) */
+		is_subsampled_format = (dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
+					dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
+
+		dc_plane_state->in_transfer_func.type = TF_TYPE_PREDEFINED;
 
 		if (!mod_color_calculate_degamma_params(color_caps,
-		    &dc_plane_state->in_transfer_func, NULL, false))
+							&dc_plane_state->in_transfer_func,
+							NULL,
+							is_subsampled_format)) {
+			drm_err(plane_state->state->dev,
+				"Failed to calculate degamma params.\n");
 			return -ENOMEM;
+		}
 	}
 	return 0;
 }
-- 
2.53.0

