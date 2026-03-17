Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1255AFED9EA
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 297C810E6E2;
	Tue, 17 Mar 2026 16:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tIRo1YQd";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36BA710E6DD;
 Tue, 17 Mar 2026 16:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n00ANUyHqdLnPLnOEJzegkeE2Yg1ZivIDb7JSnLhcui051FH9sDc7sS54IgmZ2FMG89XP6+xR4/3vKk3PV7hwicJbw4u4KctfOr7BueIUxLddIrGZs3LJHIqHtbUX3Y/XCCOtxwDp2dBly6jzGY8CTDU+/SPkw1gQ9lk8zfalvZjQcczkTs2K850Ll8QdxEhhwA4isGq2c9y4lV5ss6A5ahiCR3jz53iLDplJBm+5woZNOU3hRZ/yJm+wI+eNLlSLh3He3aUaHxTd2jK3gQYwW57X8rEk0xbKyldF9KDZ2qhPY7uBoCH3HoIuy5h+s4p3/kWa715ATTUMuhDWkQeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTfmiNjExXdjCzvrYIeZ7Y+9HYpcGJVLrGTABGNDFzA=;
 b=eyACl3WIyygVA86XWODIxbzshVEv1jCVieKhPrD1upT4mSVjeRG9Ti/PbJUZ22SYBBxa4FHTYo1gqxvgDp+Y97vSgh3VK/Q+uNsFu6RBvgkPQtbAAEY9I771OUNtGxZnCSpYxyGQLmilZTYs4UEhsjOwtoQxCfwvZjLBlRHOUYLCY+eEYY2IzdFoeXtVOwTk7+xkYIMSghHdJuyIHXu4b4p5c7kmcNHWQ6fPzUB1C6zGlv/nXc9B2pdL+rRgxIrW719QVw+3xvu646J9oFSvaa/dVfC+So4lO2W4NoEzpsSzXFGNnJldKBoncDKWYNfFw1zyfyX6SDDgRGIqbmBDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTfmiNjExXdjCzvrYIeZ7Y+9HYpcGJVLrGTABGNDFzA=;
 b=tIRo1YQdMQfmvgCQc0k7ACygdnIa/JCCZT3sv4r+ZsA5PKJehXDnC48baWs7WLb8nxGFY/kuYqK0c221uTDZwJQNmnQMz7eNnJ0JWVBAeuOibdek92kAdhx0II0NzTXe/W0MZPTRIYNRD1/oFLD25dx6L8lu5V/rCQYtEwiYa7M=
Received: from SJ0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:2c0::7)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:04:02 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::f0) by SJ0PR13CA0002.outlook.office365.com
 (2603:10b6:a03:2c0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 16:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:04:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 11:04:01 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 11:04:00 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH 01/10] drm/colorop: Add CSC colorop type
Date: Tue, 17 Mar 2026 12:03:41 -0400
Message-ID: <20260317160350.229028-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317160350.229028-1-harry.wentland@amd.com>
References: <20260317160350.229028-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 1822df67-5202-4c63-5ef6-08de843ece39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: u3UQvqRDKtRP67OgMjNLrwyfJiGNAFdO5ppiVbp/4WcePNS85MScROoy4uWnS0dKvKvnB6FL3Xwz6vApiLtiUEROj0GItElanHrRoWz3aOZ8xnLnslyvCGp96iXlGIaU4Ds+ubHLvbbVp2Y+l9TGLzYpCK2K3hOqDjn437o9Ol9jeDUPGCyDTGQnoZqZkgGOuQxR5XDEnbBhOp6FiPxkVDJAwe8JYif0pok8iwhdNTMkpusx7QEBYFTzRb+ByPTATeriUhcGp1SY11XF+s4IDhV2JnXUWT2FnqnIm9tmAXlsdT60eW1fTnm48wo5iAbL+kV9TDD0p7ynwEpxAohPRUuX/4l3gxx6dZbjnhPqFi7bz7wN93TyiSa9EFy1nmT8ARWHd62Whml8MbR4IAoymG6btWzEXOe8pxu65F3rFOkPQOTcDcr5GcJZ/3EcX4AcjsnkE9YtCLBYY0kskCZtuAz8GQ5tYR78cT0PdGmwSLnXzJoxkzVDxTOOPcho3Fii5WAONrpt90Q8UKYU18mJc/T970mTwTYy3BAPobPShIlO9Zvu7hH/IkbLdX4swXBa0TDqtfmtjsyGtggOdGOd9c1hqdcZggg4m2raTfpzguToXKYzMswlKHjdb9bLVxlx4//6Nd12t0CfQJBX0BLUz3P+e86f4uz3JQ70fyvJLcNuvOhi/TtsnaZ2AlDodjSWry1aslD3GlcASKFmKyWe2PqZQr4hSYmgUb3c6QHlsNo4yLY4jB+r/QQGF5CpHhZ7orfS7LXdO8QViY0MLbdsMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VkQjSTTXzg3P3OKO2NUmY7cCWxIlQex08KKaDh+yvLSdnSIyw4xwN9D8f6vu0GARAceffOSjQilHOrD3xAUl1+dbkCK1GMiYjY1Tz9t+ocWScJZvA+NQz8l4Ec8hOT8GsY8aOgAMisO1s0Yc1ecelLtw6bVaXDqIj+iZKnsPvb1h4ZXDfur/IdV9Ki4ukSgimU8rgmvT383SzZQIFncHxlrdQHoC2j1No4UD6SRp/IXj0HP3hNM+VgV56zR/Od4QWF6oVb3NwUQiuj8EoGPcfw4jGSvIrEEzcLygn8lgNKvcplu+mIvqtlGDYO1K4bqmUSuvF1vpVuxlkiMaDUVjOmgHdP0u4Li0ElBR1/+0/NdCsNp4lDCYirjn2n9dY0WoHnyCWjq/l0Ap9MUS/sTKoUB9cRW29In9S4vRNdDqb6s/TOGcmA64nYDv25WHuodS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:04:01.4807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1822df67-5202-4c63-5ef6-08de843ece39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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

Add DRM_COLOROP_CSC to the colorop type enum and register it in the
colorop_type_name table for proper type name lookups.

This new colorop type will be used for Color Space Conversion (CSC)
operations, primarily for YUV to RGB conversion with configurable
color encoding and range properties.

Co-developed by Claude Sonnet 4.5.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_colorop.c | 2 ++
 include/uapi/drm/drm_mode.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 647cf881f413..11b2f11db874 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -68,6 +68,7 @@ static const struct drm_prop_enum_list drm_colorop_type_enum_list[] = {
 	{ DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
 	{ DRM_COLOROP_MULTIPLIER, "Multiplier"},
 	{ DRM_COLOROP_3D_LUT, "3D LUT"},
+	{ DRM_COLOROP_CSC, "CSC"},
 };
 
 static const char * const colorop_curve_1d_type_names[] = {
@@ -563,6 +564,7 @@ static const char * const colorop_type_name[] = {
 	[DRM_COLOROP_CTM_3X4] = "3x4 Matrix",
 	[DRM_COLOROP_MULTIPLIER] = "Multiplier",
 	[DRM_COLOROP_3D_LUT] = "3D LUT",
+	[DRM_COLOROP_CSC] = "CSC",
 };
 
 static const char * const colorop_lu3d_interpolation_name[] = {
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 3693d82b5279..80296dd437e6 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -968,6 +968,7 @@ enum drm_colorop_type {
 	 *         color = lut3d[index]
 	 */
 	DRM_COLOROP_3D_LUT,
+	DRM_COLOROP_CSC,
 };
 
 /**
-- 
2.53.0

