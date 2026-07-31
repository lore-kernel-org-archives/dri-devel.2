Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F26AC55175
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F8910F39A;
	Fri, 31 Jul 2026 18:15:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dG82A7Z4";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B4E10F390;
 Fri, 31 Jul 2026 18:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rw+1/vWAmC0hkImMWwmix4gAKli0JDXwZ19sLaTd7LvKjkMmNR3FSp9KESMtfR4OOlc/J4one1SYSEoMFzgcGHzH87xKUwZue5VUmG9fcoRJ9TPHifZvYO5IBV1XLLGSZgarhAdawIsNlfyrsRObjGKckAE4BMW5Rt+nb/roZ28nvZ08k2jX1t4zynlG0X3bMmI+UuqMAFkTrYgIPfK6KCwyx8YNea0rj+WKNIIq49dRC1+NVHpxI+relXsD4/GwNQpsmmKeqg2QDeQ6in80taecVFXEGXE5p1/xMZmaM51V1g4qRizs3GSBkXjG7beYvDYul4azycefpdotJfGXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bOydhIu1UFHSIE0Ph/F0WEmjlx2cPBTeLN8ed2Kx2s=;
 b=Riw10pmrUPnG4cO3LUGg6MsM0VKIQ8te7YOAVEKoLsMiZ9ukgrvGvrRpRWxYDJXv6LIjZz4lAUbsQEOjD64nqd7ijRtG4t4703r+LO3AuhOAY8aBjCQEo1znNnkkNWmteTf/hEVnj5FQ4VIocNyIsy9JC7PVkQxGSHC/FbWChrrGIu1Zh/V5HgrzW/rpEDeLQMxS08WxslmttPeGR+It+dn0YPCrFunaLytWG7mmqcA41zE24JwnNQDwdj2QJ6V3Qou3TcSSoC3USS5KywmzElADJCQGZicoKdQGb6nm7h5xuWnOHVQyrQAIK2aTc0B/cIFclkjwi5ZX5n1LdOxGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bOydhIu1UFHSIE0Ph/F0WEmjlx2cPBTeLN8ed2Kx2s=;
 b=dG82A7Z4/OhxKjlA6LZFCrL8z7aGQLrX0TAKzSxJ3QghZOEExCjTrnbL/qzrvv7PW3V/q+/2Aku3lnfrqHECzJb7u/834C39qYUSEi0dp3hBliG4X3HHfdZOvIsk5d7tu8gOaA4ryg4DkdIPEmtnSodWwXlqtxQVHLIxFSkVwdo=
Received: from BLAPR03CA0060.namprd03.prod.outlook.com (2603:10b6:208:32d::35)
 by LVXPR12MB999196.namprd12.prod.outlook.com (2603:10b6:408:3dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Fri, 31 Jul
 2026 18:15:29 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::95) by BLAPR03CA0060.outlook.office365.com
 (2603:10b6:208:32d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 18:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 18:15:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:28 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 13:15:28 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v5 04/10] drm/vkms: Add atomic check and matrix handling for
 fixed matrix colorop
Date: Fri, 31 Jul 2026 14:15:15 -0400
Message-ID: <20260731181521.681990-5-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731181521.681990-1-harry.wentland@amd.com>
References: <20260731181521.681990-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|LVXPR12MB999196:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb81431-e9df-401d-7541-08deef2fb410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8Lb8sd56cpsJ9uUn3bBy6ubmdxCQr68hq5a1AZ+HwGIV+7pjtrR5AymDKFxlAWTCmwxstCinv5H9XNdItd9Usa9CdSnjADPNX1k1bHdyGCQSJ/H1ec98wHbrZ2lkFHxuCVUhnupZNWxeLi6YtFTXtdAcVkICgGCn9YLGjGW8EGRhBWx+y+uMwUKKlyTnUNouAHNyAWurdB70eRJ9kHHtm8mv0vZyzoYOWsmqfQXgwXCeroXsH0Sn59qCXWHuCBZTB49O1J/X83S6ajc96ha6sdBv+NUOpeZhdLHvSexeB6mU8ukVHeomrpBf4WS8bSH543UqMZZpivhQsh0cbyhCn+mrOnTqCYel9L8wPLOr+CjO6VXhe0bFeyAqZVD/iAfiVCF8Cp3wXZ1lyP9ZRVnwCrR21f9zpVvOfrjjz0QGQRtqZlfNzVs8tP4yZkcRzx+4fg6i82wVuZFXO97ftv5wj0oRi7mxW6k/Y6B8uU/AwwbweImLVY5ClqdUl2VAET/wjW47LdinaxebCb0eJz3b1Ja3aYLhXCsaUJ1se8XLWT8Bnh/ymxzCqdsYYnRdU1ihcfAwySuWzW9vG5+HE1RTBRPDEOEMdJrSGZTZnGBnNg37RYrfY9isvszxwGBgvZ1k1QIBqhl7qa2Fxj+jpAWKyrCgYG0auTYhY3FCwx2WOLtvGkauS7S5795qnSofTAo4WTlQlyFJ7Tr7Rz+e0kA1tA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: salfSX1qMR6y5EuAkFN6LY73VL99gAcwGdlWENBNrd5wHOfZOUD6jdwFWBLj0FcwVQsCVzhXnTBwzlaTQoE46XvW6dKUsZ4hrhjyXR/nGDuMYxpIKKW3mHqO3SYRfDmMd6lMCK0BMmyPHk7NvNxKHMkI8npLmY6vd3XvjXyFSELCanv9A9ahckU24DKKZkGpcbyuKOknfDeKB0bUrqQ7C2yyQhnK0JxdJucjBCuhuUmDqRMYcPsm3I7t0gBs15Ya8/BEAqwdSuQSGirQOudBBzQkV8Ks5RjYblbH2UkyaFreSLPewpJiM0JKtoFROAMuIOE9RcxK6EbM9FVHhY9UMeOOFKBFw4XBmPNzZU0U7IEXZ58xwhoBcGqNWI/0mpDZkUfBkr3wy0C1jya/PQZfYb4lN3hfUuRNYi8Sl6zxvOoBUIrcHdWZoefMd4RsjMJ7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:15:29.6220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb81431-e9df-401d-7541-08deef2fb410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999196
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

In vkms_plane_atomic_check(), validate that when a color pipeline
is active and the framebuffer format is YUV:
  - The first colorop must be DRM_COLOROP_FIXED_MATRIX
  - The fixed matrix colorop must not be bypassed

In vkms_plane_atomic_update(), when a color pipeline is active,
read the fixed_matrix_type from the first colorop state and map
it to the appropriate (color_encoding, color_range) pair for the
existing get_conversion_matrix_to_argb_u16() function.

In apply_colorop(), add a no-op case for DRM_COLOROP_FIXED_MATRIX
since the actual YUV-to-RGB conversion is already performed at
format read time via the conversion matrix.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/gpu/drm/vkms/tests/vkms_format_test.c |  2 +-
 drivers/gpu/drm/vkms/vkms_composer.c          |  6 ++
 drivers/gpu/drm/vkms/vkms_formats.c           |  9 +++
 drivers/gpu/drm/vkms/vkms_formats.h           |  2 +-
 drivers/gpu/drm/vkms/vkms_plane.c             | 55 ++++++++++++++++++-
 5 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
index d2ae6321383b..bbb1ad18c99f 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -234,7 +234,7 @@ static void vkms_format_test_yuv_u16_to_argb_u16(struct kunit *test)
 		struct conversion_matrix matrix;
 
 		get_conversion_matrix_to_argb_u16
-			(DRM_FORMAT_NV12, param->encoding, param->range, &matrix);
+			(DRM_FORMAT_NV12, param->encoding, param->range, false, &matrix);
 
 		argb = argb_u16_from_yuv161616(&matrix, color->yuv.y, color->yuv.u,
 					       color->yuv.v);
diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 83d217085ad0..899120cd07ac 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -187,6 +187,12 @@ static void apply_colorop(struct pixel_argb_s32 *pixel, struct drm_colorop *colo
 		if (colorop_state->data)
 			apply_3x4_matrix(pixel,
 					 (struct drm_color_ctm_3x4 *)colorop_state->data->data);
+	} else if (colorop->type == DRM_COLOROP_FIXED_MATRIX) {
+		/*
+		 * Fixed Matrix is a no-op here. YUV-to-RGB conversion
+		 * is handled at format read time via the
+		 * conversion_matrix set in vkms_plane_atomic_update().
+		 */
 	}
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 4d5fcaeb82c5..964b574d9ed7 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -895,16 +895,25 @@ static void swap_uv_columns(struct conversion_matrix *matrix)
  * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
  * @encoding: DRM_COLOR_* value for which to obtain a conversion matrix
  * @range: DRM_COLOR_*_RANGE value for which to obtain a conversion matrix
+ * @bypass: If true, return an identity (no-op) matrix that passes the samples
+ *          through unchanged, ignoring @encoding and @range. Used when a fixed
+ *          matrix colorop is present but bypassed.
  * @matrix: Pointer to store the value into
  */
 void get_conversion_matrix_to_argb_u16(u32 format,
 				       enum drm_color_encoding encoding,
 				       enum drm_color_range range,
+				       bool bypass,
 				       struct conversion_matrix *matrix)
 {
 	const struct conversion_matrix *matrix_to_copy;
 	bool limited_range;
 
+	if (bypass) {
+		memcpy(matrix, &no_operation, sizeof(no_operation));
+		return;
+	}
+
 	switch (range) {
 	case DRM_COLOR_YCBCR_LIMITED_RANGE:
 		limited_range = true;
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index eeb208cdd6b1..d969cc669a5e 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -10,7 +10,7 @@ pixel_read_line_t get_pixel_read_line_function(u32 format);
 pixel_write_t get_pixel_write_function(u32 format);
 
 void get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
-				       enum drm_color_range range,
+				       enum drm_color_range range, bool bypass,
 				       struct conversion_matrix *matrix);
 
 #if IS_ENABLED(CONFIG_KUNIT)
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 68cb2a3335e6..6ee5c3f3207c 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -6,6 +6,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
+#include <drm/drm_colorop.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -131,6 +132,9 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	struct drm_framebuffer *fb = new_state->fb;
 	struct vkms_frame_info *frame_info;
 	u32 fmt;
+	enum drm_color_encoding encoding = new_state->color_encoding;
+	enum drm_color_range range = new_state->color_range;
+	bool bypass = false;
 
 	if (!new_state->crtc || !fb)
 		return;
@@ -148,7 +152,49 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	frame_info->rotation = new_state->rotation;
 
 	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
-	get_conversion_matrix_to_argb_u16(fmt, new_state->color_encoding, new_state->color_range,
+
+	if (new_state->color_pipeline) {
+		struct drm_colorop *colorop = new_state->color_pipeline;
+		struct drm_colorop_state *colorop_state;
+
+		colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+		bypass = !colorop_state || colorop_state->bypass;
+
+		if (!bypass) {
+			switch (colorop_state->fixed_matrix_type) {
+			case DRM_COLOROP_FM_YCBCR601_FULL_RGB:
+				encoding = DRM_COLOR_YCBCR_BT601;
+				range = DRM_COLOR_YCBCR_FULL_RANGE;
+				break;
+			case DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
+				encoding = DRM_COLOR_YCBCR_BT601;
+				range = DRM_COLOR_YCBCR_LIMITED_RANGE;
+				break;
+			case DRM_COLOROP_FM_YCBCR709_FULL_RGB:
+				encoding = DRM_COLOR_YCBCR_BT709;
+				range = DRM_COLOR_YCBCR_FULL_RANGE;
+				break;
+			case DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
+				encoding = DRM_COLOR_YCBCR_BT709;
+				range = DRM_COLOR_YCBCR_LIMITED_RANGE;
+				break;
+			case DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
+				encoding = DRM_COLOR_YCBCR_BT2020;
+				range = DRM_COLOR_YCBCR_FULL_RANGE;
+				break;
+			case DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
+				encoding = DRM_COLOR_YCBCR_BT2020;
+				range = DRM_COLOR_YCBCR_LIMITED_RANGE;
+				break;
+			default:
+				encoding = DRM_COLOR_YCBCR_BT709;
+				range = DRM_COLOR_YCBCR_LIMITED_RANGE;
+				break;
+			}
+		}
+	}
+
+	get_conversion_matrix_to_argb_u16(fmt, encoding, range, bypass,
 					  &vkms_plane_state->conversion_matrix);
 }
 
@@ -175,6 +221,13 @@ static int vkms_plane_atomic_check(struct drm_plane *plane,
 	if (ret != 0)
 		return ret;
 
+	if (new_plane_state->color_pipeline && new_plane_state->fb->format->is_yuv) {
+		struct drm_colorop *colorop = new_plane_state->color_pipeline;
+
+		if (colorop->type != DRM_COLOROP_FIXED_MATRIX)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.55.0

