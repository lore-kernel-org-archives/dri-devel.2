Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413FFC55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2A510F399;
	Fri, 31 Jul 2026 18:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oVA2jj5S";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082BD10F391;
 Fri, 31 Jul 2026 18:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGyU8vWdJJl4ikosJyb48Py/yQ3opjqoq0HHwGcZ3E80OJ2DaDxX+rqmX6vcHAozmq3lJHZSlJ+bgW8TNGI0Xeb8qDDgUa4NQ9gn9WN3DAmpz83kNVVTizg+1N1TsMcTTyCElHvz832jU6rB7eXqGFlng6sAPdYzoAJRAWZUrDVAfOJpTjbTDMuvlrbaP73seAALC2XtaVYeZX848fM5J5C1MFWFj9DxZV6eddRuv7wvUWconqMSGBx9PBiZPRpDzYWDsV2Yw5n/tIulB4C1Y7JCSLeJg1ObPFZhTCJCWxRsoN4O/O7/1P954xrHHQDznSXa0JP14KBQRkJj+s0HrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aSp7BmYfKOqo2sKpO+hiUGRibOw9yNr+04opeqC8a8=;
 b=eX33Nio99xdJu1botRnBwyYs45j4Fu/3bp9xB7vrYDUP/uu4VMIY3T6CVOvtZ1eSxoQ5NxaQAoovLGeBTBUMMjt1HbTJSi+/V/ZjXMbQGNCqCj8XQn/J5q3EI554I1hcM7S4bc1ze3YAAocZMc+2K2b2WOM72HERWeyGBvsY3WCnZWDWN90Iea7XO6qvozgxlWvlacn7MikNqb36fXtep3efPlWht/fLs8wZC425En0Ce0lbB+c9FgyAlWnXnWfXuGtGv516nwlEU4SLAx4U48ryBExfn4G3HYYJWjbY7lNmdiZXxagafsSPfSPlsRMM8mqVwXBlHf2twf/rKWH7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aSp7BmYfKOqo2sKpO+hiUGRibOw9yNr+04opeqC8a8=;
 b=oVA2jj5S+lVEvWcF2BjoUeERrn3bQYE5pSJ7Obv24aD4Az1e3iyXU3drULzpyn82LE8S1uMfEhZl1KE0YjWIFJuRgOTBr8DhmtOjsQDLNAV8TveliVgYQpDYknQXrxNtGbQx0ttI9f5AQ38PBONUDoWUhMyqvBCedFAT248Cvww=
Received: from MN2PR05CA0040.namprd05.prod.outlook.com (2603:10b6:208:236::9)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:15:30 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::96) by MN2PR05CA0040.outlook.office365.com
 (2603:10b6:208:236::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.11 via Frontend Transport; Fri,
 31 Jul 2026 18:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 18:15:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:29 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 13:15:28 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v5 05/10] drm/amd/display: Add fixed matrix colorop to color
 pipeline
Date: Fri, 31 Jul 2026 14:15:16 -0400
Message-ID: <20260731181521.681990-6-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731181521.681990-1-harry.wentland@amd.com>
References: <20260731181521.681990-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 1364e899-2df2-4f23-5a33-08deef2fb432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uXyQ5ogat7+BrM3fsD8IC1WQk5DEgrgrd8V4lOPDf41Lu7fMKAoXoDGzrl3bEhV0g4bSsNyjyApxzy26k4dVoKN7HcWCWATBzqK8VxGu+e6tj4+YbUMA4BAWOALfGMlAk0IhR8ZbYuiKTwLg7ObjRZO1S7hdzCj8h8X3tKXQHx0BIAaMQlNwXqENTooXmSHBquBn1bN4rR1nn5BB+9yMnJdrcSTGyEaTbcAZ4zO9xt3zJztvUMD5xLRUr35AZ9adNEgG8up8aqSv4egv94royWPOJcy7rBGvCYTxMBsz9/VgJb3vFBRTCjXs55AJ0EeU2mPnJ+CXZ3b7at/VzFrDbCSUuv29XuPxfMlumETsUlmlrXBsylYOj4Mp3rEx2tjU0BH72fClLGLK0eOONPyt4R90RoghkHfqeSBuFBepAjyPjR7ju73s+UYNRUWBn6u4XOToB48MZwla2Y8Kc3akvE/GS7dWZ4n+dVq/mY6Azc8Y/oSEI95qToDJ4V1b/Rq/ITKYEDnWOglW0a+OZDlqsHrYs/Gw4jCo21RoZh6Snvn1DCivr+hJcJg6m6QSiYXpQMq1GCT1QKQKgpiv1Zff7Wytk4vQ37RJHuozRb6UjM9C4E5F2d5OOTJEk8LwGQ0o8N+uGoXdy+TzOVMVCZY+fAVWIbXGCg4K0Guvx9dN7CkmkkC00I8IjI8bUx8MODmYqGHcBmJChcYLVNsnwO8LfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Y58Yi7izOZJylaRyGdoTqT48aUfW6QhF91vluVfS+81npZAna3I4MNrtxYChPF4v3LBk94+rIsZEitNv4EPJbi75CUPnJqzKWzsV5ns0CJko2FNT35UY4hUYCd3XFg0H4qs/ef/FzaBdJsR0X7KYi/Nh1TwVhaP66zmqlawbboUIzERXvZVDUl8Bkl0lsPCCPrddzsxkKDKF2apSRlJdoUgZcf0lnpwgoM9KAyvMSKCSdXorIEUhwCGVA+UERsmhT12Nicdkp5tpzcOLxV1tn3CWbVYzf6D0fJjzSdUGCtiEVb72YreKipD1IfV8cFcb39R34GKtoZZjsSWPNpDtTiChkt5Fn9772KZpwNmF85ulxdLQ97QdPnksdM7DO9aNS09IslHFsD7Pt5GCvPrUYp1cTfKUIoLa27DBUmrExidAJjF1foBrTAP/ddq5kKL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:15:29.8458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1364e899-2df2-4f23-5a33-08deef2fb432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

Insert a fixed matrix colorop as the first operation in the
amdgpu color pipeline, before the existing DEGAM 1D curve. This
allows userspace to select YUV-to-RGB conversion via the color
pipeline for YCbCr framebuffers.

The fixed matrix colorop advertises support for all six YUV-to-RGB
conversion presets:
  - YUV601/709/2020 full-range to RGB
  - YUV601/709/2020 limited-range to RGB

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 27 ++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |  1 +
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 056a76b88f43..1ed12cdce317 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -55,6 +55,14 @@ const u64 amdgpu_dm_supported_blnd_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
 EXPORT_IF_KUNIT(amdgpu_dm_supported_blnd_tfs);
 
+const u64 amdgpu_dm_supported_fm =
+	BIT(DRM_COLOROP_FM_YCBCR601_FULL_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR601_LIMITED_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR709_FULL_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR709_LIMITED_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB);
+
 #define MAX_COLOR_PIPELINE_OPS 10
 
 #define LUT3D_SIZE		17
@@ -73,6 +81,23 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 
 	memset(ops, 0, sizeof(ops));
 
+	/* Fixed Matrix (YUV to RGB) */
+	ops[i] = kzalloc_obj(*ops[0]);
+	if (!ops[i]) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = drm_plane_colorop_fixed_matrix_init(dev, ops[i], plane, &dm_colorop_funcs,
+						  amdgpu_dm_supported_fm,
+						  DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	if (ret)
+		goto cleanup;
+
+	list->type = ops[i]->base.id;
+
+	i++;
+
 	/* 1D curve - DEGAM TF */
 	ops[i] = kzalloc_obj(*ops[0]);
 	if (!ops[i]) {
@@ -86,7 +111,7 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	if (ret)
 		goto cleanup;
 
-	list->type = ops[i]->base.id;
+	drm_colorop_set_next_property(ops[i - 1], ops[i]);
 
 	i++;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
index 77364d954d3b..7802efa5312d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
@@ -30,6 +30,7 @@
 extern const u64 amdgpu_dm_supported_degam_tfs;
 extern const u64 amdgpu_dm_supported_shaper_tfs;
 extern const u64 amdgpu_dm_supported_blnd_tfs;
+extern const u64 amdgpu_dm_supported_fm;
 
 int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
 
-- 
2.55.0

