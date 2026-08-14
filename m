Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AB5C5DF6A
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 21:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 820F310F746;
	Fri, 14 Aug 2026 21:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZxJKoax";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013016.outbound.protection.outlook.com
 [40.107.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5F810F76E;
 Fri, 14 Aug 2026 21:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJSSMlOSl4yk9DXE8JDA5FBXFHm6uwhdehxnk4TsOhPzUov6oyrtiVMIwGj7vQTYnDejTFIHYSTRLGPmSGxHIyrvN7QTp8z6qHRyiN3vNw6V/TvRJPGewPSdPnrWKU2+xPrnD8IrImuh2niseX5md3WPk+mtFjKh2wEL3ebzAFpYirarpf40aOJ3cBw2gcaBms6UgK5YONuscI52pj6uaaHpHJJFDg/rXENsLOA/h/dRolUYs9nSRF9cd6Ov4bUeadbZag1Iz7Pvym11Nsqj+gsy0KUy+c4Jh0cphXLL7cA7ZQeF9TZ/ISPpqGZAmKKb2g8NI/C6hwWO0TJulXkfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bOydhIu1UFHSIE0Ph/F0WEmjlx2cPBTeLN8ed2Kx2s=;
 b=F9GV+9NjWfoGRSPuQDIiJQBdjJbsFdAZiCFeTtGklA6UCmIyf33riqgrALZEGmCsZaBqt69fO6pr75+7/u9d+XC9D7sPSwo01LA3YgOvRj9UHh/kK+b/EepBYngwXrMwuBVJXA3zQ5NhIAnqzwiXnfM5M7GRXmxrkS4KEyO9t9+R+79NFZ+uPZOMCQsIN1m3pQJgUplB8hlWVKmff3Z8+TS6VjxrKn7JXZlJJ3riBnnXdQRvwOz3EKUrq9/H+Pfqur2JCquPYFRGyESTHm5Nhsnwr/3fGOa0MMqBhGSCEyYbN+LrxXsD1IBec38o0I5mw/rfVun0vCeI2pdE9jG2lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bOydhIu1UFHSIE0Ph/F0WEmjlx2cPBTeLN8ed2Kx2s=;
 b=wZxJKoaxAfyFusUN4AtUAlsqlz++yjBPA1mSe55znRRU1FuNX39jpWnl/zAhr+FATaRI1K6FHijZiS44+ugedWbLnctU8YchxYE8uKIX8BYJyrabmFWhLd7birYowtsmrLmk7ZGNyj+6ez9brgZEPCjK1VJQmYQmZgBOoNYbQIw=
Received: from CH0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:610:75::33)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.16; Fri, 14 Aug 2026 21:18:21 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::96) by CH0PR04CA0118.outlook.office365.com
 (2603:10b6:610:75::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:18:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:20 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:18:20 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v6 04/10] drm/vkms: Add atomic check and matrix handling for
 fixed matrix colorop
Date: Fri, 14 Aug 2026 17:18:10 -0400
Message-ID: <20260814211816.1219597-5-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814211816.1219597-1-harry.wentland@amd.com>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 39047593-a4b0-44b7-7281-08defa499176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vfuCHs/Os12ezKH+CxosxhITu6MUZQx7R3s2H9NcwTgFmLfzNRV3S4fBgvrrfCjf1reA8q3l0N+JRnMSnbNMaKaDZbTPM3PxX/y+DBcqoWQysaRBKja3QH5iDWCPdiwhyn6YvEuvHqvPENbt4WGsTR8OxoWxqT+w4R4DlUmFmYpj1T2mgFffEKM3Aznns/JJR0JqwLg0/tYbjGjhD7AxwF/kKvUdT1ZZ3WkpEYWS7dOrnkNEokIm+AK7c37VkTNIZ0kuqH+SZUQ/8ozY1HCKhA3yrE/UTIFzbRLCC23tLBpgURNbwlDvLbDEfXd+dBnhAQ3HbGDM703IW6MgypINFeoxDdTyhb6irde/0Uho1Q0XsiWOHXYeiH4mHpa3F2knKTGLBr+jDdS/MqPqZSnQtZVqWMqdaEd3PDrZXcKYIUNpcIJsGlgQFOwtVCpqoK167ei4OKTdobl8DuV1YYAA44fhS77jeEIiVMxMjEl8qnzP4q1Kk0p1Z8GsbStGGG5RFEON/I3FYfDRAv+ngb8y9r1K5/ae0tJIoup8PSu0sDOkBM27K8/D6tTryOiCQVs+9TPvXXHE+Q9ngjxt95h65qcFxR2NiQzOF8lX24WK2NI3VdaQ5KpdehsihkgQP2y7PBUjnWoG14rJhJ6p93NMdRawclzgJZYpv1W3m32V8+P4NvIvBaD+zOSahOMKidxDkOwqwiL1NLEwbCiQ8HqELw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IKQUIU2rz2Q0SfVG8s57r7blV6C/rxNTg/HwKuXWQBmwkgUQY2uEcpZABI/W9Pi4JjEuBcZr3AWH/ocOlNgUp/ypB9BfOm5AkpoGi3okYTNju+8j4oagan5ldAQqvHSd/jMuGV6MPoG6WZzczA9jUu/YzVNbdO5RMSiB+dssu+2UA5KgWuV0rxKRwJQdPPVbSgjaYQKWf816a3Y9IiqjoYCNFjlAFzmZ58T/FYnpr31Avax3D/ne1bZP/jl7TPK5BPGY+J1r0k3rZjS6qmIAzlfvcvVeL6SC9Y0wnlSOPphJvuChgU4FFk8VS4Wcve9kSMsKHaS4gkHS9JSoBnlQWObPImR6TCGtvarieY0/EU+oDzKPaOnfzOe6pcQ5VAKJZcPG/vY+JyB2c9KejK2Xpn5Zc+CQ+JG0ifrNG5XnsHfOKJhFH/6V93n7k83oVfaR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:21.2569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39047593-a4b0-44b7-7281-08defa499176
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
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

