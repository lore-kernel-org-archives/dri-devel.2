Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCD3CDB47F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C58510EC17;
	Tue, 23 Jun 2026 16:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eW8RsQEr";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9788810EC09;
 Tue, 23 Jun 2026 16:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTpJM91Mo1IlswQqa5M2WvpkZyveH5CUG73tNaUvZId/ivSZ0o2BzWshPcdkGWR9Om5Pk1/HSruN+H7zlOGr0Wpu8XKjwhE+s06j4tVWje/3NpI7inIE+T3lMSTqsA8Zxoi5peiGk4RNKiIa70MOP+w3OKzInfJedJSJQ6p6Er/ShIHAjxlYyDgPzJDlewlW71ortpKhwRHtSU71HcasxTmWRRQcgtbI35uVZtH/PTAH8Laqo0VXQfMlVso4Cj+8SXYiwhgItid/6nDvfjGGPQDbXfVO71Fd6VHZZtDfbczsEyXDvq08JX+TApPMHNz+2A0SEJy2zR3gVrOODS5SYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QLMAN0HKIZ9JZnzwgKmCRu6Sr9j5RpWN78RAx354CA=;
 b=w01fTPWszFEOnzjSVXUGE7hG5MjsK7fCQuRdj/fOzIYS2SUPsCi8HDySakWKae1Mw9NtbIu56NoPOzBB++qRUQ13P5vp3zgXby7ICqA6vaZMuyyofoePFd/mpSXjy/feF+jHLgXuKQ8cvX1VbNQu4Qum3UnDmjYtj4rbHd88QzxWRZrOX0VWR3hT/Wg75OPxFVGvdjtAjQwqH1ivXf6dbV/k2egSnS+lbyzCskOECr1HZFlHWE0kbpQup3dhCQfwvHHCNffcvy+RlByyFu/Tr/Ck7NfHI+H5pa2ZThK4Tjouyxe+DiwqT3O4kzoVf+d2LosZkwexX7KvEDxBiojlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QLMAN0HKIZ9JZnzwgKmCRu6Sr9j5RpWN78RAx354CA=;
 b=eW8RsQEr4jnW6Q5umiX2oCKVLjM8PpLL81k0pCmn0YcNC8OMsGejIdTYe8yW0shzSU+5p85BxI8n7iqGvzTl8IDOUz7lt3JYdHkNo8f1Bh58fKlyNdfgnfOjXAfc1RZO8H24iTiRJkKn8WqUawckTqwG1umHcvYIFm1K1O/xUzQ=
Received: from DS1P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::8) by
 SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 16:48:23 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:454:cafe::8) by DS1P222CA0014.outlook.office365.com
 (2603:10b6:8:454::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 16:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 16:48:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:18 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 11:48:18 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH v3 04/11] drm/vkms: Add atomic check and matrix handling for
 fixed matrix colorop
Date: Tue, 23 Jun 2026 12:48:05 -0400
Message-ID: <20260623164812.81110-5-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb11f56-30c2-4afb-4a9d-08ded1473ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: bv/UGq0LwUSlnf4dEu1hUUfFKA/AcpkSYJN3iWEQUxcRjgmW/0qX+269zZsXUR7b1869lK/Pra9ShHFfCZ0Qu/6CEd3m8Ui/5SDgaSUWysy01pgcVwITjjzg50VEkhNvpgoGyXq9zNkRV3dYIxSF5uqbtHgIkuY+X3kEwzqCQIlAp7btPvGh2cs63Vvd5iYyOXDIlBiSFlXPB85BQ/HmWlS2ByRBW8gkb94mpwUcZdetTFO3SjdNhwNodgLO3ggOZa4uV/dOuE8JiaIGpt6yqfOQC5OS9bUnWSm98is79oFFlaDJXXey39yVYR7k7jK0EU79YxsWdW1aMlYS5Z9HVnjuqaVRMT+L13aX/3m4k3Ca8uepnVxoWFdBQTXqWllJPMkNuEqtk35g+aq5nWhrQc7JLAAyVhFe/4bVctPX1SjbaMsl+BUtmMMcLqw5k7OQiH1CIjtWRXLzVUCUMX2Xluh020dMmzdIyifDRh9jYJq3hWpd494ocVeA83c+acIC/ffF0ODSP3CMrQ6i//atewh0hAf3pCfZUum7c5c6nj6XO8aArTikSg4LA0QgNWxU+1UCO4P/XYFopmWe3kuHW4A6n3x9kptcG/LM1Oy54UKUyIdHwdc8p+AymDbfDjcSIw9CUj+NXbp55HQ9UAMvKuML6KWLjARYfW3lLk975i3iLPiTeApvXAYiY4/jd0fajdMcunRS3QmPCpX3wvxXhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PfRljNVJKgQxu6axccDdJgo/NNYQumHnNTOMqVlraI0tYMHywCqm2YLNAMtK5PxbALjgXmwMe2K0iZ7nn6T6i206QuWHQcRdWQN0p9+ZW7izb0kI2vJ+MgB1KbBNvkFmPeagHrhtnK2nB/KE3KFOkmkjRTIa1HPlHeM9AX5u0Mng7eNsy8oXcIRPVH8kbhsYZelf5reb9SvlqUDK8Ep1hvtqjw3RYjwITJZL5caDQohPUY4EwfD8rTqUiCu6MsvKo/uucI3X+tfLhqjAgIQMt4TW6Kl2L7oKUh8EP4ZhymfjGVcxoFFO1ROeCOmMOUjwk9DLlHBP4SnkY7Y3xrJqOlsB73Q4RwWUuTVZI/lfO/pZf/NYwz520aC+UZNH84U5asuc8/N8GXuC6Tixru8kpP4XRUZMIDtOLOO45SRkwllEUXFZtEZKSLSqWDFrRguX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:48:22.7717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb11f56-30c2-4afb-4a9d-08ded1473ceb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
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
---
 drivers/gpu/drm/vkms/vkms_composer.c |  6 +++
 drivers/gpu/drm/vkms/vkms_plane.c    | 68 +++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 2 deletions(-)

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
 
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 68cb2a3335e6..4ef4cebe718b 100644
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
@@ -148,8 +149,56 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	frame_info->rotation = new_state->rotation;
 
 	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
-	get_conversion_matrix_to_argb_u16(fmt, new_state->color_encoding, new_state->color_range,
-					  &vkms_plane_state->conversion_matrix);
+
+	if (new_state->color_pipeline) {
+		struct drm_colorop *colorop = new_state->color_pipeline;
+		struct drm_colorop_state *colorop_state;
+
+		colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+
+		if (colorop_state && !colorop_state->bypass) {
+			enum drm_color_encoding encoding;
+			enum drm_color_range range;
+
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
+
+			get_conversion_matrix_to_argb_u16(fmt, encoding, range,
+							  &vkms_plane_state->conversion_matrix);
+		}
+	} else {
+		get_conversion_matrix_to_argb_u16(fmt, new_state->color_encoding,
+						  new_state->color_range,
+						  &vkms_plane_state->conversion_matrix);
+	}
 }
 
 static int vkms_plane_atomic_check(struct drm_plane *plane,
@@ -175,6 +224,21 @@ static int vkms_plane_atomic_check(struct drm_plane *plane,
 	if (ret != 0)
 		return ret;
 
+	if (new_plane_state->color_pipeline && new_plane_state->fb->format->is_yuv) {
+		struct drm_colorop *colorop = new_plane_state->color_pipeline;
+		struct drm_colorop_state *colorop_state;
+		if (colorop->type != DRM_COLOROP_FIXED_MATRIX)
+
+			return -EINVAL;
+
+		colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+		if (!colorop_state)
+			return -EINVAL;
+
+		if (colorop_state->bypass)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.54.0

