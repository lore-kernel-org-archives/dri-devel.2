Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFD5CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF95110EC06;
	Tue, 23 Jun 2026 16:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tfWJtixB";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B81D10EC02;
 Tue, 23 Jun 2026 16:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QY2xm2Y1L8vE5ak99fGxpetMOiDw42b+3xliVWvp3DIRgQgCtjTZ0FUVTdrZus2BeFTIDHFB+yukr54ndWhQfPkYVY7XRnVtK/lBucONZRhCEMU+w3XwKnbWGCKfPfeOK1WFTRdoJUAbe2zEM9rfVUDZ4xoAeBVhQdbRuo+ptptpBjO3s9JDmPOXE3cO10wGbnh1cV7N/3cuL9RyJ6o7bChw0mkud8Lqyj39WPtoIIAlRkusu46MQyUjiy50LDjQZVpQiowejyVJywToYNWwGSdfaDhqbmxwkpaxBv+lvh3ko42yT9ET/4zeiKSAWkfbkEcW5gc2brDi97XEQXVVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mgvfisGGrEbvUcx0sdLaqPDXFRRCwfL7xIFD+JZPSU=;
 b=K85aAjSAOJ+sz2cSWC6a7++EKF9U0KOIMBfToTOs6g4ZuqZucQ+TMKOLVf67KJ6iG8EHC7OnNHjYCODFvouPivVCMy9ZdIchtGd22GWNrpI4K75kldLtZ4zow0+qaRPRAzR9JMECclZ6oQnhg+uo/l26/IA6IU84mYunNg77T5a5BFgamuomP5/z0GMC3KU01OI9kPzaPkib8qDWGsnc9fybq5/l4OUDrpVT8dFW0O9TDtKNR3LejqGTkWefADBB6M3DEGPQRNgl+jzAP4Bgeq7UVYWY7bE1zlaaeylG9eK7AeEhcC94eM/gcTGiDxd14unMyMKNYaQmoGHb5MQyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mgvfisGGrEbvUcx0sdLaqPDXFRRCwfL7xIFD+JZPSU=;
 b=tfWJtixB868QgavwG2zkA4sgz2N6Z6IUqY9i9FxsuOI8VLXSu1EkO1ZizYWFJTToADoY07W3utDT1WJSDM3F+1OMb5wFVN6z5W+stkm6CjJtAg/WlttgvUaL0n6M83SAQIOrDaqHLqYLk+TwpBJqLPAzHVNRDJXprPwZavmBHLs=
Received: from DS7PR05CA0050.namprd05.prod.outlook.com (2603:10b6:8:2f::9) by
 SA5PPF5D41D38AD.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cb)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 16:48:18 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::8a) by DS7PR05CA0050.outlook.office365.com
 (2603:10b6:8:2f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 16:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 16:48:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:17 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 11:48:17 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH v3 02/11] drm/colorop: Add limited-range YUV-to-RGB fixed
 matrix enum values
Date: Tue, 23 Jun 2026 12:48:03 -0400
Message-ID: <20260623164812.81110-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA5PPF5D41D38AD:EE_
X-MS-Office365-Filtering-Correlation-Id: 7740c1ef-7eb2-432d-c572-08ded1473a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Uu7aLUDn+rNTxbyy/B98npjmq6Zd3HNlRWGdkrNc7ZN60Oxwug2Q+fkbXZnVwf0Up3aPctSAcnHHpxndqj1IFLi4RdlNAlm+Q40IHD/z5nYrX3cmn7EmI0LT3Df5Rgg3vGDgSo0R7TFfbaESxj+gOw3MORvvN9oGiTJcId70LqCy/IG5I4XG4MDCv38MwhFlvonM/RR8CCnzxwKVml1fu2IXEV5HEPhnkEeb8U8sNYtsxzd25UWjjyZ+I52leM8XefBIht72VjgYIfb25SG+i+vkfE89+Eur9Pfz4WnR+x7+SGHfqhhnfMDm292zkf4ZNTsEB4eIDjkW0eO1p0N14rwQUGkTQtrGQG5wRQEP78TCF78B/OY/zAk5mrLr+6svbWHdlHfeEGgrD1K8oYwF/ye55o8PnRmu2mdSuw9/V71xJreiyul7uWfemhz+xg+objnfPY/ha7Za30Sc/BtyGA0bIosiBhYm5z2mgqu3Ho0JRJr7JmpZiwypeuw0et6te5WzRSe7Nl5PDjGMvz1I+f3+jtiY2YfpTBiLAsosRjbWK2cIwcQcBwwsoFkgwXf7n5NX+3SDWtAtmTObI0lURybvwYXjsAjHJI6hDI9BAtd3yNtrTMb5Zu5p8U7eQQLopTbdyfkCD9PsPzbzRwfu+TFD4ryYXjkXtYSu0Ehtiv2SkxPqyEH8yKm1rFW7sOtApaMBzGzJO/XtfH59qQ3ABw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V0b5A3uDITcFt5NR7JszhtRnwvkFqox6A2P0RLtN0/N22AiDiBK83xfDwVKgJe1THKJK2mwGTowxKHxEt88fURtobDRf3+uWCtliLBYKsFkVFgiWVr9c+uGZPYS8qQgL0MXNy8okF+G13pKBMSMdIG663SG+crfvzGWHVUjNIY23yLmFwfpKW8/+sCfSzPUVf5BqbZC3RUK2xJFJbgAUc8hdc/qwcaAtFtQkfifkfRnCUsDaeMK3+//W4sFiZVgmtLWzyL4/C4kHGPrytUS4dxB6L8uTqc2ZMJULBoZcvUhbUlU7L7sTBvWk1iBIt2Wqt7MvOrMDF3zpyizLl60haiNQ9b9v7+OkQ9scj/upOoNtT565BrD+x6evOuXHfy6PJTJ7tB8DwPOqZUwXbGD5O7pOUpp13yh+zlcTXJYJXtsymsv5CMI5C2jolVBq4mt8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:48:18.3444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7740c1ef-7eb2-432d-c572-08ded1473a4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5D41D38AD
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

Add three new limited-range YUV-to-RGB conversion presets to the
Fixed Matrix colorop enum:

  - DRM_COLOROP_FM_YCBCR601_LIMITED_RGB
  - DRM_COLOROP_FM_YCBCR709_LIMITED_RGB
  - DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/drm_colorop.c |  3 +++
 include/drm/drm_colorop.h     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index c11c3012fcc5..9cf89153b365 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -93,8 +93,11 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
 
 static const char * const colorop_fixed_matrix_type_names[] = {
 	[DRM_COLOROP_FM_YCBCR601_FULL_RGB] = "YCbCr 601 Full to RGB",
+	[DRM_COLOROP_FM_YCBCR601_LIMITED_RGB] = "YCbCr 601 Limited to RGB",
 	[DRM_COLOROP_FM_YCBCR709_FULL_RGB] = "YCbCr 709 Full to RGB",
+	[DRM_COLOROP_FM_YCBCR709_LIMITED_RGB] = "YCbCr 709 Limited to RGB",
 	[DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] = "YCbCr 2020 NC Full to RGB",
+	[DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB] = "YCbCr 2020 NC Limited to RGB",
 	[DRM_COLOROP_FM_YCBCR_LIMITED_FULL] = "YCbCr limited to full",
 	[DRM_COLOROP_FM_RGB709_RGB2020] = "RGB709 to RGB2020",
 };
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 88933d5b4d8b..5c542c264a36 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -150,6 +150,16 @@ enum drm_colorop_fixed_matrix_type {
 	 */
 	DRM_COLOROP_FM_YCBCR601_FULL_RGB,
 
+	/**
+	 * @DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
+	 *
+	 * enum string "YCbCr 601 Limited to RGB"
+	 *
+	 * This selects the matrix that converts limited range YCbCr into RGB
+	 * according to the BT.601 coefficients.
+	 */
+	DRM_COLOROP_FM_YCBCR601_LIMITED_RGB,
+
 	/**
 	 * @DRM_COLOROP_FM_YCBCR709_FULL_RGB:
 	 *
@@ -160,6 +170,16 @@ enum drm_colorop_fixed_matrix_type {
 	 */
 	DRM_COLOROP_FM_YCBCR709_FULL_RGB,
 
+	/**
+	 * @DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
+	 *
+	 * enum string "YCbCr 709 Limited to RGB"
+	 *
+	 * This selects the matrix that converts limited range YCbCr into RGB
+	 * according to the BT.709 coefficients.
+	 */
+	DRM_COLOROP_FM_YCBCR709_LIMITED_RGB,
+
 	/**
 	 * @DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
 	 *
@@ -170,6 +190,16 @@ enum drm_colorop_fixed_matrix_type {
 	 */
 	DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB,
 
+	/**
+	 * @DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
+	 *
+	 * enum string "YCbCr 2020 NC Limited to RGB"
+	 *
+	 * This selects the matrix that converts limited range YCbCr into RGB
+	 * according to the BT.2020 non-constant luminance coefficients.
+	 */
+	DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB,
+
 	/**
 	 * @DRM_COLOROP_FM_YCBCR_LIMITED_FULL:
 	 *
-- 
2.54.0

