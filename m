Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5759F589DB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDB710F15E;
	Thu, 23 Apr 2026 14:21:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FUrqxXks";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204DB10E2B5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:21:52 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 02BF015AB;
 Thu, 23 Apr 2026 16:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776954011;
 bh=hCyv0tXAPLSXxkg6g/MXFWhjFE1z8zTbHbQQgreRYzo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FUrqxXksKnuR51MfvdmUans9zfwa3+LBjitbEwim0WsI73E40s7jziltNxgndekAe
 IihUQsHLtcpkUpUGCmHJbWaeTUt+196kW6FOVdKnJTFPgcYLVFXA7NESXqlH3WJwKQ
 p1apAvs5zG6IXFCiKnh92JXVFvCYnvrNUgnJR//4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 23 Apr 2026 17:21:16 +0300
Subject: [PATCH v10 05/11] drm/fourcc: Add DRM_FORMAT_T430
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-xilinx-formats-v10-5-c690c2b8ea89@ideasonboard.com>
References: <20260423-xilinx-formats-v10-0-c690c2b8ea89@ideasonboard.com>
In-Reply-To: <20260423-xilinx-formats-v10-0-c690c2b8ea89@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Pekka Paalanen <ppaalanen@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=hCyv0tXAPLSXxkg6g/MXFWhjFE1z8zTbHbQQgreRYzo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp6ir1Q+QgRnOE58i8kR2OvEJ8/VEm5fvV98pEl
 Ux3SpPFGIKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeoq9QAKCRD6PaqMvJYe
 9UaTD/45klGaGE244vl//O4+nLV0CRN/AMAYax3PBJ1yLNqa7RcLRaDUhbTxPGqnoQkFtmvXrCz
 CjyZL29TDFj08knYVnCwZfvDItF+Pb/dpRPeG44McCrgWR7uGXh1PkDYCbfVW6bcs9W72oNZPN0
 k57lL7LNl/V3sBuB4/m1vbIYzBoK/sshEUbEIpt4k+Ljem4SbNTOvMYFDCRPVwUeP0rPVDBkD/Z
 5XP8h8lB6veWMr751U27Sb+udy04Q0k3TYdo3EoDE3lBo9AnUX6G/X8RzeeOXXSEiDKubRFB68H
 1XsiqohgX0z5A8LoVDMwZAom8GICBYOO6zAkVUE/lza2q832ec3fzKDkIsfqlSXU7b69ECFCtPN
 iI5D7YITOBxtzvqdHeh9aA8yEWsIMOyhYrTwXqZwj7rTG6dKzrJGlo6ehYh6L9Zb7lt2rcN9glo
 qDLDp0oBCzkB6QcvgsO4Tp3gCR+egDv5MH/NzFWoIK0jquVX5bADU3QNQmfa8SmZ3/PMA89Xtmb
 H/0E+SAp4A2SgYXXa92TDzAM85/nmYze4HZuTWwYaBPwVJxkWqg9H8+I3KVF/RbdMZ95cOVHs7w
 3E/k5P0I3PJOkBVJJZ8dUElYU8au4bQ5TnJZCV/3WnIA2vdIJPGEv4kE1mJgUBxuDbQo6AQ7Wn/
 I7fk6nvK9tKCtIQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

Add T430, a 3 plane 10 bits per component non-subsampled YCbCr format.

A new initial letter was chosen for this one, as the format doesn't
match the existing P, Q or S formats. T is the next one in the alphabet.
It was definitely not chosen because of the initial letter in the
author's name.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 3 +++
 include/uapi/drm/drm_fourcc.h | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 01761c553e7e..20b84efc135e 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -388,6 +388,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_XYYY2101010,	.depth = 0,  .num_planes = 1,
 		  .char_per_block = { 4, 0, 0 }, .block_w = { 3, 0, 0 }, .block_h = { 1, 0, 0 },
 		  .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_T430,		.depth = 0,  .num_planes = 3,
+		  .char_per_block = { 4, 4, 4 }, .block_w = { 3, 3, 3 }, .block_h = { 1, 1, 1 },
+		  .hsub = 1, .vsub = 1, .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 472f95632640..07bfbc8a0300 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -403,6 +403,15 @@ extern "C" {
  */
 #define DRM_FORMAT_Q401		fourcc_code('Q', '4', '0', '1')
 
+/*
+ * 3 plane non-subsampled (444) YCbCr LSB aligned
+ * 10 bpc, 30 bits per sample image data in a single contiguous buffer.
+ * index 0: Y plane,  [31:0] x:Y2:Y1:Y0    [2:10:10:10] little endian
+ * index 1: Cb plane, [31:0] x:Cb2:Cb1:Cb0 [2:10:10:10] little endian
+ * index 2: Cr plane, [31:0] x:Cr2:Cr1:Cr0 [2:10:10:10] little endian
+ */
+#define DRM_FORMAT_T430		fourcc_code('T', '4', '3', '0')
+
 /*
  * 3 plane YCbCr LSB aligned
  * In order to use these formats in a similar fashion to MSB aligned ones

-- 
2.43.0

