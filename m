Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A278DC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE0510EDF1;
	Wed, 22 Jul 2026 13:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zQRtKt4Z";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012027.outbound.protection.outlook.com
 [40.107.200.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038AD10EDE8;
 Wed, 22 Jul 2026 13:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhVU31DGxCuxFST1kRn36SOA9zALmKdjN2lGNDn3IfMd353c0EwhUjRWknn4B9n3LcrvigQ2DRhzafaj9kRRxCGr/1i8g7z53I27lj8y1jf8ahyw1CUoRQ9bajXZQYBSwLJNpVuJRcXXFkRRC5jhMxKNMD21aRRR0sleyZFvy3X9Od173lUpJ78Aush2nGzr7soeIWjYypZrUbVaktQ4mkDIZIdw1AN+Ml4QXeCv1Q5s1jJmH4c1QF2v99WqxMeM33QuHVRjvYt7hn/M9rad+vJJaGrw51Z3WpVvFlGnK3KhPanhivbgzjNczo8pc8JUE4sf9Gp+F0Q3naHRNOUsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGXFaQm0P+aflgr+MkifK2iIv277Tc8VuThND3rpRnc=;
 b=vbtMJOqVu8XNKcPFvqftL7CnmiANcbIpn+cBBK2mkUP5pQTtM796A4/9Hzcxh5Qg3eJJ4UNDSUmcMRo3ntma9T0TPTZwuhEU2AtPf32OWQ05W6c6/savsKsuYkkjugNaqIbmPGa6sL96ezNix54Eik7LsM9LgyZskcGLN7RX3NcgnUSB6xBvD9+P+W8v/mIk/y4H13kIiXnSNSlBVcNMaN8qdDXosk2mwrqkIkZ8pPq5HWnkljXo47T8QajMOcKjnIdXyg9Dh4Y6HUTWXoht4VtxiAkhxnIo2yaVrGjU3kwQIpXW0hpNFS7VVHfrS2nLJyulVa7ix9KEvW5p+xihZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGXFaQm0P+aflgr+MkifK2iIv277Tc8VuThND3rpRnc=;
 b=zQRtKt4Z6We45J/u9BvwiMTbemqnHbDmrRFw9GucqbRFX596hdlJdPxtX1j+eBdy8Ki7kgGAUVVScXpnjrRS5YppOG5W6IQLJGj9hInsu0hAtOND5KIzLkaWFwnkW9Ur34hU7a8U0SNpb2n5UUZKot2FUbPT8x9eLhgopKKfgMY=
Received: from BY3PR10CA0005.namprd10.prod.outlook.com (2603:10b6:a03:255::10)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:46:20 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::63) by BY3PR10CA0005.outlook.office365.com
 (2603:10b6:a03:255::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 13:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 13:46:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:18 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 08:46:18 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v4 05/11] drm/vkms: Add atomic check and matrix handling for
 fixed matrix colorop
Date: Wed, 22 Jul 2026 09:46:01 -0400
Message-ID: <20260722134607.136293-6-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722134607.136293-1-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 916a668f-d422-4eaf-aa7f-08dee7f79c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: HrvoaijATaD58h6i/x3MusLqGhzbwlc9sCMUYBnzTgD89fCdLR9K/VSxCrVUz73QrtRI0ZvTZDzQvDieyLDZ+ztw1VH4hJa3BG2RgF0IuzVXKlfBTQqfmycT9VYYf7mNRltgVHr9UezKhho/bRRXmAD8ghMp0iwcJZevQW8GnWfG1dk/VCLFiqLv6CKx1u1abLqSdsl6JVXRga9zelNf3gTo8vytZ4OQ7b7ZWH5EXk9VIO1UtJmIhi0G09s9F0AR9YpI3bZAsBhXHiGbr0Vgp+JcNZ936bWAs7dEyeHWYRQ/0sLpHGLCLRAtCtKv7xDTdJZoOa9XBE2XVSCqsf63h/Amxx6mmBT5wpZfHTagCKaqGEYsk4ZUOT4vGU75BVEBRIzcDy42wzZ9/QZO3u1nEoc0g1tE0Pw0YmIkxFnGZpM2Aru/3hpl6E8RDbBGJhmrvyM5a1eFybkwr0GRsy/gwvzLqcs5lbLaWfiTaqRlPPH71cZemGj8wcD87TdWv6b2TGs9X50OI8SSMbKRucPn2+AvFh4aqXQaz52Habdaq1clVpPoEViTRZxTJ1JaYUJC87P0IeRALf8TbCC+dl49NxiP4qEoJlWizYZ+46k7m9K2DC2XVBgx30CEpgX3v7Q8D+DxgQym3+ODcXPD5fFuun4s2236FmuHoRd8IM5mlrzOUCidnkgk88JfmL4LcNBM2BdhHXIb4EIvJK3jO1iIqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3Sk/pIJCVkkVam6N10SvAr9TyEromwg0ttLg8KP9zFsvaU/kv2D088o4gpc7b+JQL2HLjZoAMWS8Mpg7VhBJopDGf1xYQpYBepzK54Fd15vz/IfU2MMH516SmucBT2iE40HjMpJyv0D9FvYxyaX5oyKoBPHSqR+M1TMeZ0ryIjmk4ZDEqWBofCTKP+ky7TVibsP/eLkwK2dnNcg839RYuh8Bx9CdG8+d7ihavkbe0+uu1YhVT1tStueIWe+0m98UmiLeigYIY+jc9TjNgEmWSOiF+PA3gIPdTEtoUpR+VGFXMNGsh1EbRn/r/Hxuo4yAIjbP4rcg9J4Ld1hp9xAOw+YK9qQSCHh/BQPHu4LLmU9qY3J5jQh8t2TlG+sJ9Fx+yue8rApkr6UJUEGSqMCqZNhvGDOdJBE4FpGLHMSMS9T+U2mJ6lP5cY/E5psCn4pK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:46:19.7775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 916a668f-d422-4eaf-aa7f-08dee7f79c57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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
index e746b18bf37b..e931cdfafae7 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -232,7 +232,7 @@ static void vkms_format_test_yuv_u16_to_argb_u16(struct kunit *test)
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

