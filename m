Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291B2106B53D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3CA510E7C8;
	Wed, 25 Mar 2026 14:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lTrq/akr";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EB310E7B7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:01:56 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 26B4B1ADE;
 Wed, 25 Mar 2026 15:00:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774447237;
 bh=nCrTvG2jfseeZ/eRmUeub8cMM55Js0Xo68tYrLSNyU0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lTrq/akrZ/cDvcHxIsphDGr1xlspwy4KQlGhnpeYZjrHA+vqHaMtAZm0UVn47eYlb
 oA249rla4McqX1KFp23MTowg4cvKYva33wdd547VJZ53zJhzIu1VE+XvLFmZhoLr07
 YbYaY3nfPo1Zx97u9uO9o53VJpF/mEiU6WgypR0o=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 25 Mar 2026 16:01:26 +0200
Subject: [PATCH v9 03/11] drm/fourcc: Add DRM_FORMAT_Y8
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-xilinx-formats-v9-3-d03b7e3752e4@ideasonboard.com>
References: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
In-Reply-To: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2939;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=nCrTvG2jfseeZ/eRmUeub8cMM55Js0Xo68tYrLSNyU0=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpw+rKOZh6y/kojehxYsu1HWilOVqtDOI1zCHIm
 kRARLOgjRmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacPqygAKCRD6PaqMvJYe
 9QGZEACQYzCy2nGRUT8yKGRzbuIC710UE8KODVctb7tXpLIm9grU6PfgDgIHuWwjs7z4Yo7Hp3B
 W849Je5MugW+xUqymZ6V/E184laVE98/MWU1kd9ZJX14uvVPQB/NavXhSwpt33cWiu2NUub3nKD
 UySvT9jOzNVI3j3CzUnlaTDySz51PrqopzSuaqiRHGGe2KeIggG05yP3zQGfBUcHMBR+eKxQffM
 UTG6D7gyE8QiHfvotyP1mJR4qnCLJcg8+lyMmE5MGYO4qsAbqcLRR/nMShbyK4aIoET91XAcaGk
 Uuey92Im3rx4zd5IIGEhRmRRAGoisaAtk44jBacwOkJL0vMjo4h4lmgZZ0c22pwE1nTRYYsCCEs
 DubTIgqCJZhipcMj2Fnscs2k/Dpg+kJNFJ/VvWeFnPKiQH3o0uWXFAWys5n0ddK5/HRqP4HQXS+
 6FVw2RMfd/TrUMZ1EQJh4uCIyEYLwUTIgPk3cw4F6VqEQAfouUi3feE1ZPIR+Z23EVVmOaq3P4X
 87aYXUfOs5ebjIF7YRXSTiAuecNgNNO7KODYfVF+q+whV6un0v0O0gQIenJ10NARum8WfIVIgzQ
 3+y87oPEreV8BbTzfUwqG9gxpLSe3a5OCuL9M5M2/UCAxntYrIPuRYIkVLfiwEtDhukP+CbBE7+
 A0KExLNkmQthvpA==
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

Add greyscale Y8 format.

The 8-bit greyscale format has been discussed before, and the earlier
guidance was to use DRM_FORMAT_R8, as a single-channel 8-bit pixel.

However, adding DRM_FORMAT_Y8 makes sense, we can mark it as 'is_yuv' in
the drm_format_info, and this can help the drivers handle e.g.
full/limited range. This will distinguish two single-channel formats:
R8, which is a RGB format with the same value for all components, and
Y8, which is a Y-only YCbCr format, with Cb and Cr being neutral.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 1 +
 include/uapi/drm/drm_fourcc.h | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 4fd37226b647..a8ea1f3660cb 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -275,6 +275,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_YVU422,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_YUV444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_YVU444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_Y8,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_NV12,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
 		{ .format = DRM_FORMAT_NV21,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
 		{ .format = DRM_FORMAT_NV16,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 10cc13bdb495..02205ec4a75a 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -458,6 +458,15 @@ extern "C" {
 #define DRM_FORMAT_YUV444	fourcc_code('Y', 'U', '2', '4') /* non-subsampled Cb (1) and Cr (2) planes */
 #define DRM_FORMAT_YVU444	fourcc_code('Y', 'V', '2', '4') /* non-subsampled Cr (1) and Cb (2) planes */
 
+/*
+ * Y-only (greyscale) formats
+ *
+ * The Y-only formats are handled similarly to the YCbCr formats in the display
+ * pipeline, with the Cb and Cr implicitly neutral (0.0 in nominal values). This
+ * also means that COLOR_RANGE property applies to the Y-only formats.
+ */
+
+#define DRM_FORMAT_Y8		fourcc_code('G', 'R', 'E', 'Y')  /* 8-bit Y-only */
 
 /*
  * Format Modifiers:

-- 
2.43.0

