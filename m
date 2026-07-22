Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE4CC4453F
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88BB810EDF6;
	Wed, 22 Jul 2026 13:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K39ESfqS";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E25A310EDEC;
 Wed, 22 Jul 2026 13:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEzjnSrp2sDvKUifoDRFiwuTEuuE51CMMvBtebyvBj+3XPdH/NxLle3LmoAmATm+5N3ZLfyCJjEjk892sp/iIV597o0+EINEcWYQdW6Bl3k4USZku44z4l9yCe9Nal/dBChE3/kobQMsgCFJg6Z3NyI+ucW4D4UNED7wkRLlzklWDdReGrfw3njPPjYnGGCdw4bWwO1+6qjs+Kk4r9zmNuiBDLNMyCifooV5WxsgbV9VeLooMppDdL3ny9+/xeBxnrQUQqDYv+9aRiPtHlSCBdn2WTSnEzQIgKyYtYTIDBDNiqDpD3fBUlkvilYWpTJjsIjY+t2AtQcQ6EoXeVloFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35e+IOeiBiSZBIgM1vbLy8v8yILaydojEG6euFhDxlg=;
 b=kxmKCk+lr9uE04M362DmOsu9ni42HDjtvfEhL4gDVmq+JQXeYWW598rogMzW6ubexIfZJi8xCG0PQaQFuSuBiz5uHVM8Zxl8Q0G5it/D6XdnycYeaZxowCmwlKvcVBIcgY5j4k1v3TXAEg7C54MVqaMXwold7CNlB8lVNtv0asvJEFinYaLWwljmGVjzBFh3OuoyRtErAsu8kcicT+hbyKLkDth4POus5dilovzElK7Prs9bjdjD6NQaTc069K1PcDh5MOyS9pOziY3eWyU5UuDWnr4iZ/8h8ez7W62iAlmGbbnUke9I2/8w5/5+oociPIRXSu6jqt6/unIciyLGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35e+IOeiBiSZBIgM1vbLy8v8yILaydojEG6euFhDxlg=;
 b=K39ESfqS+A3vYfA0/Z7fZw2RcEhLHrnedk44y6UdPnEcBlvftaP+VFusCGeoH3I9Ia+Pvuifo9+GM/r1WsMUOIMiTrovcFJeGW0vSWWkQKNFSAzHlBUhb2kEcOZi6oJvdJUHi39bf9xBemjBvCv6njR1dQnpe3rdlvhRWNz4eo8=
Received: from BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:46:18 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::25) by BY3PR10CA0004.outlook.office365.com
 (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 13:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 13:46:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:16 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 08:46:16 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v4 02/11] drm/vkms: Fix limited-range YCbCr to RGB conversion
 scaling
Date: Wed, 22 Jul 2026 09:45:58 -0400
Message-ID: <20260722134607.136293-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722134607.136293-1-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b57cfa5-e094-470f-b16f-08dee7f79b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7iZU9L+curDAlLCjhERWXNPK1IvmPNTiDHl5OTsUD9Yb0l0R3DPZ696XT/v94eG49Y7xBfFq/YcmU1SejJoAkkdkRj0ZhKS9/ugBYGNxwabVYhDdbutyoKmdxloBlM3smrVjRS8nQhcQsZTkVtmWRLIlVqPmOMCNJQFet1V6Y3oXw5ZCvq3ZzQd2hL6XYGd09uYjJdCtyJ9bdpKHu3tUJ1BKrll54iFtdqtL82YU4xzuI2mfQjmNDVps0Wp4x3R0lffKZGcCQ6HqTYoLxbknS5i8D1kIyiPRmElZbznsxY4MKD5BJWqgUMjGHe/SeKDYUstqnuYrVo5hFXZ6/RCWvO6RXDRcY1gAoV8kUCQzkUlTFF1ybQLD16SXwxYPNlpx61LA9hXDKR9UZUTQ5qs1IzqD88GSk5KZfXJu5alkMuePs7PpqWVw8GZJWZHNumaKbY0GFUVe8YtsMxZV+CIIgSHZr6nz+KMjou7smf8uV6jcqic27LjvnjHNZM0/pEaHCI/3tSn4ykD+dTc7iH/DhY0LQvU0lS0O32MbQemxmT2hqehX8FmDm8xyOMpZZ2oh4yt4RR95NuZjop9LC1v+LtNwbP9GrWInU4awdTLLxh+JUj0AnbG9iD7AzFj05Cqh5HTC833FZ1BBKBoPd7YoiXCzoBOj+846j6X/SO+sXQP75hvZitWBeIFLavHiK7VsUwbuPixqU/zwviMU2EN93Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 43o2gMCutcbontlq/I3yXiHS9YSvByFgfvy+QEnNGJX6hz9w8o4FD7IJqw7687wXOyNde7kSrLv9PBxC30Dau/sdwsmvvxQRRvHNCJiLmsGEJfc2eaTDp/8SsgSRx/vd41DjXQOvy4uDVhfvChHZ+fsIHFnBEAmvZV9bBmzn/JH2R/kB39SUqaAsI7r15pZoUWqC4PTOMgwDgHaPdB+S1XCjYT/CMjAXCAS2yPpH7rA2LMjzsKLimC6qiJ6wd64e77pR3c3hBnkRbSWUWOsAbVvwz7bxTY8tSQTJURDAJu5K+vrZhoiakWHLtZhgLvXOjMpEgyHuAlFwam7J6fzsdFs++enjAUzfbjEipkQ1SXBerlZUQNlpMZ/5+cWVrBXqMaIl7BZsGLl6c2QX3zYwuL2Rs0iN7uMPcEVHtpVLQWfYGHAbufYN1tlDZGxYeqJI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:46:18.5116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b57cfa5-e094-470f-b16f-08dee7f79b96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617
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

The limited-/studio-range YCbCr to RGB conversion matrices were generated
with colour.matrix_YCbCr(is_legal=True, bits=8), which normalises the
narrow range by 2^bits (256 for 8-bit) rather than by the full-range
maximum 2^bits - 1 (255). As a result the luma scale was 256/219 and the
chroma scale 256/224 instead of the correct 255/219 and 255/224.

This over-scales every limited-range conversion by a factor of 256/255,
producing an error of up to ~3/255 (8-bit) and causing IGT tests that
compare software-computed surfaces against VKMS-processed ones to fail.

Recompute the three limited-range matrices from first principles rather
than relying on colour's is_legal scaling:

 1. Start from the standard ITU-R YCbCr -> RGB relations for the luma
    weights Kr, Kb (Kg = 1 - Kr - Kb) of each encoding (BT.601, BT.709
    and BT.2020 non-constant luminance). These are the same relations
    that produce the existing full-range matrices.
 2. Expand the studio input range to full range relative to a full-range
    maximum of 2^n - 1: the luma coefficient by 255/(235 - 16) and the
    chroma coefficients by 255/(240 - 16). This matches the DRM UAPI
    definition and IGT's igt_ycbcr_to_rgb_matrix().
 3. Convert each coefficient to S31.32 fixed point (round(coeff * 2^32)).

The full-range matrices (is_legal=False) are unaffected as they use exact
1.0/2.0 scaling.

Update the limited-range reference values in the vkms-format KUnit test
accordingly: the expected YCbCr inputs now use the studio-range encoding
consistent with the corrected matrices (8-bit value v placed at v * 257,
i.e. relative to a full-range maximum of 255).

Fixes: fe22d21e9342 ("drm/vkms: Add YUV support")
Assisted-by: Copilot:claude-opus-4.8
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 36 ++++++------
 drivers/gpu/drm/vkms/vkms_formats.c           | 55 +++++++++++++------
 2 files changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
index a7788fbc45dc..789c59d07ffb 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -101,12 +101,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_argb_u16_cases[] = {
 		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
 		.n_colors = 6,
 		.colors = {
-			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
-			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
-			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
-			{ "red",   { 0x517b, 0x5a34, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
-			{ "green", { 0x908e, 0x35cc, 0x2237 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
-			{ "blue",  { 0x28f7, 0xf000, 0x6dc9 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x51cd, 0x5a8e, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0x911e, 0x3602, 0x2259 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x2920, 0xf0f0, 0x6e37 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
 		}
 	},
 	/*
@@ -151,12 +151,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_argb_u16_cases[] = {
 		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
 		.n_colors = 6,
 		.colors = {
-			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
-			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
-			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
-			{ "red",   { 0x3e8f, 0x6656, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
-			{ "green", { 0xaca1, 0x29aa, 0x1a45 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
-			{ "blue",  { 0x1fd0, 0xf000, 0x75bb }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x3ece, 0x66bc, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0xad4e, 0x29d4, 0x1a5f }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x1ff0, 0xf0f0, 0x7631 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
 		}
 	},
 	/*
@@ -201,12 +201,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_argb_u16_cases[] = {
 		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
 		.n_colors = 6,
 		.colors = {
-			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
-			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
-			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
-			{ "red",   { 0x4988, 0x60b9, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
-			{ "green", { 0xa47b, 0x2f47, 0x1902 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
-			{ "blue",  { 0x1cfd, 0xf000, 0x76fe }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x49d2, 0x611a, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0xa520, 0x2f76, 0x191b }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x1d1a, 0xf0f0, 0x7775 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
 		}
 	},
 };
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index dfb8e13cba87..4d5fcaeb82c5 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -788,15 +788,36 @@ static const struct conversion_matrix yuv_bt601_full = {
 };
 
 /*
- * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
- *                                  is_legal = True,
- *                                  bits = 8) * 2**32).astype(int)
+ * BT.601 limited-/studio-range YCbCr to full-range RGB.
+ *
+ * The coefficients are derived as follows:
+ *
+ *  1. Take the standard ITU-R YCbCr -> RGB relations for luma weights
+ *     Kr, Kb (Kg = 1 - Kr - Kb), with Y in [0, 1] and Cb, Cr in
+ *     [-0.5, 0.5]. For BT.601 Kr = 0.299 and Kb = 0.114:
+ *
+ *       R = Y                                + 2 * (1 - Kr)          * Cr
+ *       G = Y - 2 * (1 - Kb) * Kb / Kg * Cb - 2 * (1 - Kr) * Kr / Kg * Cr
+ *       B = Y + 2 * (1 - Kb)          * Cb
+ *
+ *     These are exactly the yuv_bt601_full coefficients above.
+ *
+ *  2. Expand the studio input range to full range, relative to a
+ *     full-range maximum of 2^n - 1 (255 for 8-bit): the luma
+ *     coefficient is scaled by 255/(235 - 16) and the chroma
+ *     coefficients by 255/(240 - 16). This matches the DRM UAPI
+ *     definition and IGT's igt_ycbcr_to_rgb_matrix(). Note this differs
+ *     from colour.matrix_YCbCr(is_legal=True), which normalises by 2^n
+ *     and is thus off by a factor of 256/255.
+ *
+ *  3. Convert each coefficient to S31.32 fixed point, i.e.
+ *     round(coeff * 2^32).
  */
 static const struct conversion_matrix yuv_bt601_limited = {
 	.matrix = {
-		{ 5020601039, 0,           6881764740 },
-		{ 5020601039, -1689204679, -3505362278 },
-		{ 5020601039, 8697922339,  0 },
+		{ 5000989317, 0,           6854882848 },
+		{ 5000989317, -1682606224, -3491669458 },
+		{ 5000989317, 8663946082,  0 },
 	},
 	.y_offset = 16,
 };
@@ -816,15 +837,14 @@ static const struct conversion_matrix yuv_bt709_full = {
 };
 
 /*
- * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
- *                                  is_legal = True,
- *                                  bits = 8) * 2**32).astype(int)
+ * BT.709 limited-range YCbCr to full-range RGB (Kr = 0.2126, Kb = 0.0722).
+ * Derived as described for yuv_bt601_limited.
  */
 static const struct conversion_matrix yuv_bt709_limited = {
 	.matrix = {
-		{ 5020601039, 0,          7729959424 },
-		{ 5020601039, -919487572, -2297803934 },
-		{ 5020601039, 9108275786, 0 },
+		{ 5000989317, 0,          7699764272 },
+		{ 5000989317, -915895824, -2288828138 },
+		{ 5000989317, 9072696586, 0 },
 	},
 	.y_offset = 16,
 };
@@ -844,15 +864,14 @@ static const struct conversion_matrix yuv_bt2020_full = {
 };
 
 /*
- * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
- *                                  is_legal = True,
- *                                  bits = 8) * 2**32).astype(int)
+ * BT.2020 non-constant-luminance limited-range YCbCr to full-range RGB
+ * (Kr = 0.2627, Kb = 0.0593). Derived as described for yuv_bt601_limited.
  */
 static const struct conversion_matrix yuv_bt2020_limited = {
 	.matrix = {
-		{ 5020601039, 0,          7238124312 },
-		{ 5020601039, -807714626, -2804506279 },
-		{ 5020601039, 9234915964, 0 },
+		{ 5000989317, 0,          7209850391 },
+		{ 5000989317, -804559491, -2793551177 },
+		{ 5000989317, 9198842076, 0 },
 	},
 	.y_offset = 16,
 };
-- 
2.55.0

