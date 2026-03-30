Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8CC1061B14
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E990110E5A0;
	Mon, 30 Mar 2026 15:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2OeztFM3";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B7910E235;
 Mon, 30 Mar 2026 15:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/5rDrjF5wp0sM3qRkM/DMwDZLdHQDgiQLxzCQF8pbK50ebwCXAS3+FW8jq9N8Ra/o+Tr98wOeUNhV5MvQHJeW9Kq2p0oVxnbzcWew5HW2+ShhSbj71hifn4XhDjm70AGnPI5YyXs7a4DFVXzdNyfgtrfy4c3duIQMq1myeGROLgXvBsmh70JT3DPwRgVA4KTqRy3AZDDFPPBFAQcu40DpnkmPNvkS+SyCpz7pLcpdflM7IUl7XUWA+rkKh/+X6ddG5+vF/SGIeRHkeKJnijCOMCjt9cNC/RAZar80cO4Ax+JkCctmE/HlpsdZfRXJZLghZF85iAkKhNS5apH5VBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsdO5yv9Z0O1Hqf/PpnjJsvpbkvcxlewvLdV7QiqEIE=;
 b=frop/jiesBr7jzG7Zka90gm9riRosNQjnpCuBrR5T6wKkJd/FR5KAj9uw8TqMqKVfFeigycfbIyIPr+PjoHS6oogvIGrzrusY++fvOAkmyMWAmJlbQH6aNY4fuP2KEnCYRc1mwzzxUUBV9NfHrJkDTYUW0ytyXCJOUsoMp/+6MGQvEdJft3jaAbJUuLyBxZpRfFVgoB8RZRjRpV6UW9G7DLeUT8YUQY6mMLeUGUDn1S0+sxp3X2YC/yUKMdJZK5e8oQoBmY5Rm1GqfYTQzrSHG+7tZ2kEmA4mV772BnTLkEx+bVDxu9QtA5ypygNAjoAyLoj84neD1l8Gb6dNQXMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsdO5yv9Z0O1Hqf/PpnjJsvpbkvcxlewvLdV7QiqEIE=;
 b=2OeztFM3gUj8498sYYmhU5IBF08QLpvZXsLqb+weSP97xNwpISHb+CcL2OydK73sMQiqE+GQIB7bR/upTETPOSnqZ70xnn2UNMC8AoyTf/1cs7cLpuy/x2JLwJSq3D3KTxe+01Hb2uSVDb166bWpNOv1q8f5PR2O4k84GHjprVk=
Received: from BY3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:254::24)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 15:34:59 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::92) by BY3PR05CA0019.outlook.office365.com
 (2603:10b6:a03:254::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 15:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 15:34:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 30 Mar
 2026 10:34:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Mar
 2026 10:34:57 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 10:34:57 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH v2 4/9] drm/vkms: Add atomic check and matrix handling for
 CSC FF colorop
Date: Mon, 30 Mar 2026 11:34:46 -0400
Message-ID: <20260330153451.99472-5-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330153451.99472-1-harry.wentland@amd.com>
References: <20260330153451.99472-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0c7454-eb32-41fe-b9a9-08de8e71e6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: dbHdr/3PLIteAybfzrwhBmp/JYUfJKw4AEmHNI3vycDhoYGOzpvfU+y1gDnaMAnDT3/OrrA9Et6BvxHy3A/8hLrekHEsdbDO39FSVQodub6rqnR2lXS9tFsdUcP/bNGqdavDE+h9JUUo/uaR7+Wo9IfF3QScQNIKtV8m0naHmwpgKvXMN+826Gl90IzITfyKqvb5M+LvgOLcznOluv83mxwQ15sMb38dmKNfonumBR1NtTnQGwZjPtxLXDmID6ezKHJyp6gaaV3ZEWCk8fefi3EK3zAvbZtEb+Iw9nPmb6QmjWfrEOwsV7AgXb9qmD8qU+ax+LY8apN0NdHXiE8AKrP++pujQ49Be/xAWRD+kljloLTFamn9EG0cfoqSvVwvdr7wWZLlOrHWfFP/mjAy6Zm3oY+P7Z61Chy2yUls/FqpvvVVevpsKq1rESnxO5+eX4wrXuXS4reYgfb4ckF9SjIIBLmJR9DIhyGinICgx1IrLVfqZlEgADDuEFHNqvEbiE0KEhPvbdQwimTMYxAK35GstSzKJKI7dGLuj1VEIziF4nI76b5Vwe2Uh5Hmic/+O2s4HPqSRLz6ckSJ8UWyaOpW0ZI/A64nVL4do7Yy167i2je1kCr/AN/yPnVq9g8bOkN8+raqPAJZJOqTta5DDuSny6dgO5s6+9O77a1DEMjoDJPphbjXaT1MjXiFD7RB6YrGMtRRqHLGZHFCrfnOdbpG4Whr1D4IfkZUGylJesPFv7k+K5qdjYoW4wxfHdOuw5itEUoylHIKug155cFqXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tB7hY6sdwAHEafzB+MJ77+CRSd9bZYCo0qFcrMFDf0Uvkm7q9u875UsIegW1SSgmQ3NFfhuJl2a9CmCavSZLlX7q1OvvNJ4yv6qRLGTQOjw5T7b08exDESIwCn9UJB3gZLB0A05F/XaVaQUVpmmb9dq7UPYkoc8zv9a1yNKoYjcp0nwi42/lOphrujlyX/SAPKC5BGLtdfxSwcn+34fanxM6cXGY/5zkp6FdIWD74T41bInlz4Kh587HobsxGYdnh1ntnxi/tHaQpw8EhUDaG1gRcALbmKdv4lQl3AOY6YphPfMfeBam72GIGbQK48cyDEFUg8zOfcj7XiTCEB55vZ0Z57wbKt4orm4OUT1fmap3uTO/TfJ+vES1Na+s92aM4YWykB/u3x+c5CD9C2+66ZIfzr8pQjiyFmuc/Q3GFKKAlmubuQsUCEkdM+X0cdCN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:34:58.4960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0c7454-eb32-41fe-b9a9-08de8e71e6ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
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
  - The first colorop must be DRM_COLOROP_CSC_FF
  - The CSC FF colorop must not be bypassed

In vkms_plane_atomic_update(), when a color pipeline is active,
read the csc_ff_type from the first colorop state and map it to
the appropriate (color_encoding, color_range) pair for the existing
get_conversion_matrix_to_argb_u16() function.

In apply_colorop(), add a no-op case for DRM_COLOROP_CSC_FF since
the actual YUV-to-RGB conversion is already performed at format
read time via the conversion matrix.

Assisted-by Claude:claude-opus-4.6

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c |  6 +++
 drivers/gpu/drm/vkms/vkms_plane.c    | 70 +++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 83d217085ad0..e29376f1cbd7 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -187,6 +187,12 @@ static void apply_colorop(struct pixel_argb_s32 *pixel, struct drm_colorop *colo
 		if (colorop_state->data)
 			apply_3x4_matrix(pixel,
 					 (struct drm_color_ctm_3x4 *)colorop_state->data->data);
+	} else if (colorop->type == DRM_COLOROP_CSC_FF) {
+		/*
+		 * CSC FF is a no-op here. YUV-to-RGB conversion is handled
+		 * at format read time via the conversion_matrix set in
+		 * vkms_plane_atomic_update().
+		 */
 	}
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index ca7aee101a95..0f1ebdd9e391 100644
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
@@ -148,8 +149,58 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	frame_info->rotation = new_state->rotation;
 
 	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
-	get_conversion_matrix_to_argb_u16(fmt, new_state->color_encoding, new_state->color_range,
-					  &vkms_plane_state->conversion_matrix);
+
+	if (new_state->color_pipeline) {
+		struct drm_colorop *colorop = new_state->color_pipeline;
+		struct drm_colorop_state *colorop_state;
+
+		drm_WARN_ON(plane->dev, colorop->type != DRM_COLOROP_CSC_FF);
+
+		colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+
+		if (colorop_state && !colorop_state->bypass) {
+			enum drm_color_encoding encoding;
+			enum drm_color_range range;
+
+			switch (colorop_state->csc_ff_type) {
+			case DRM_COLOROP_CSC_FF_YUV601_RGB601:
+				encoding = DRM_COLOR_YCBCR_BT601;
+				range = DRM_COLOR_YCBCR_FULL_RANGE;
+				break;
+			case DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601:
+				encoding = DRM_COLOR_YCBCR_BT601;
+				range = DRM_COLOR_YCBCR_LIMITED_RANGE;
+				break;
+			case DRM_COLOROP_CSC_FF_YUV709_RGB709:
+				encoding = DRM_COLOR_YCBCR_BT709;
+				range = DRM_COLOR_YCBCR_FULL_RANGE;
+				break;
+			case DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709:
+				encoding = DRM_COLOR_YCBCR_BT709;
+				range = DRM_COLOR_YCBCR_LIMITED_RANGE;
+				break;
+			case DRM_COLOROP_CSC_FF_YUV2020_RGB2020:
+				encoding = DRM_COLOR_YCBCR_BT2020;
+				range = DRM_COLOR_YCBCR_FULL_RANGE;
+				break;
+			case DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020:
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
@@ -175,6 +226,21 @@ static int vkms_plane_atomic_check(struct drm_plane *plane,
 	if (ret != 0)
 		return ret;
 
+	if (new_plane_state->color_pipeline && new_plane_state->fb->format->is_yuv) {
+		struct drm_colorop *colorop = new_plane_state->color_pipeline;
+		struct drm_colorop_state *colorop_state;
+
+		if (colorop->type != DRM_COLOROP_CSC_FF)
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
2.53.0

