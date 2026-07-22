Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501C2C531C7
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D304610EDEE;
	Wed, 22 Jul 2026 13:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GmkyVwOp";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F98A10EDE5;
 Wed, 22 Jul 2026 13:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzrB+r+Cl0oIsq0U8c7BOq+xevNTRwsshwCGkhh2E8xw3JfgrkT5vvWCUFA0uOXERWt0DW91eJkWmsFXrFwtR0EwZ1iysC+28BKriDmGN9mYYOsShV4KIntnyDrfaPsNlrOk7qdbTdK0uH0YswysiJx9WqxK0iubJK9dm5to9umzu44Bo3F3XAu79ighCIKsMImyJ0pXL2sR46tTcnwpxfDVOGRIhSd4UsKew46151inKwY8xLgLjRRMFUDvB2UGjacn+Q9BjfkCl6a7784z4fIy610WMP5Mw7FK+9cwHOjdJPHy699r5GhAAQEv/Jr0YmzVOUGzIy6HxfZPMLLYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHTE5nOih/f+Ce8BWHmGcKHuQJlhcFNC2JfcgXx5D+8=;
 b=yXqSTbeeNmVwbGaBvVEb+wg9avTyiSxKvFQNZtl9DtRc5tthHGgkDlxxGDqz766Fbwe/aJdJWyniLHuE2tMtT5rc02fHvN4DpeWWqI/C/RNbZmcFp1l0bvkTN8zvEcHSPxaduPsQEfaHXc9I2xNvI0W+u64G6V8Dyp8qlVvkwLGJtk8BqF9OD7Ca7iBNfsMdSghtdVE7iaOJeoaHMTwZ7S+iOpa51sjknN03KNuS2pyVNxJhbSLQbU/QCZUapKQDnkadJy+DRSzeL1//K8LTMrdIlSLssZdpBMCJbuI6lDFeocZi1iFsVcH5V5KnLNnaxq4uuYgu3eVr8yo0HTcs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHTE5nOih/f+Ce8BWHmGcKHuQJlhcFNC2JfcgXx5D+8=;
 b=GmkyVwOpUSlB4phK5m0gQlNb07/0NXOcl37oVwnBV5UqxhGIVhLzA+vpdUVZbTw4WH9CRI+HtTTOuppiaDXeuc51DJJZmtEZ+JRUptdIKtXUZZizbg/l5FNeTFFHd8mRtQY7D88MP11Nj3AyygnST33vcWgnQKTmlkPZIiDOxnY=
Received: from SJ0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:a03:3a1::26)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:46:22 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::5c) by SJ0PR03CA0381.outlook.office365.com
 (2603:10b6:a03:3a1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 13:46:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 13:46:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:19 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 08:46:18 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH v4 06/11] drm/amd/display: Add fixed matrix colorop to color
 pipeline
Date: Wed, 22 Jul 2026 09:46:02 -0400
Message-ID: <20260722134607.136293-7-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722134607.136293-1-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 10144a6b-7243-4721-3687-08dee7f79d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rtYriyu6iLy/AeWtSa+F/uoaAvpxr3Z6oJgLICAvWJzEAqvrgRWzPeZkbC+zn3ucycC8V8jdEXE/oSRvQ49YQVAfbv+AFtHDLkvFjwN9+XIdiO6jmp71u36Eq63daUTsdDyYl/sMAV33BspC7BY9Bd8gXQ3IWWDnLgxDXDrJqVusRV3PMFt+Dk6WoM233Lsuq3erPKXPkcYUuYw2EwE2MugKZU+FeYk1sCVpO1cb3zgkHdI3+lMbOIy5su4rhh0/5WHZBEleKAXpp/tmCzh1hAYWJ8+dd2+Ei8VA4JPmwF4LBT+JUnIlJrvtCQDMigr5Su4yxEsm5Ff/k2OK7zfyadMK2Nnvt/FdOmnQPfFItAUQ9nBb54yMVobbqrX3ldjWIz+y2WBjKwU3S+XsDKXYsN0C0tdyCzsXL3xWS7Hz/OMpTeW48e8dazDWHhbTk/nP4ypScJG9GpVCWwBShNx46oRXGuDxRsERxA1Nf+VWQn+8lzBygROdHyvJLXrUIisVMJ9waKAv05TOAX8vqPttbhLYEKhWjpiOn9CNfMG8o/bkqoPGzG57nHnK9cQTUWO+R2XqxPSqSOZK46qnwjmOUADdzmZk582YU8Ri5W3sXjHx5lhVaxoS2/Ufv69bcWFBDM1673mOw1WGFOfG+VH846CHBnY3n55xxv/UdyzdT2DRqu4qzsnv5i/O3ws88LOHT8uBKv324LwkNOd4/kVxhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WDI0d5gMw45pdnrrlu5YCm0KvXXBuCVixBeFpPkN5kk8mPr7bUatdpa4NSl30l8+Zgpkbb4bSpebbxwVBJl/wOLs8pyaNBi8EFzYH60KrtHK8Mo9piX0Q+75IBPEaO6w7lefQG56MLwMptDeVVMIDEKBlC+J2ohlekomzt+a3N/4dFGbf9/T+NwJzSbCdUJFb2WwOv3D2uB1stcqJC7DJsjGWylWG040M06mDxYFV1llY9HI9qjjlzLINZMCbgHsruK96CNvsTQopXtJ2eg1sICnhJtOvBc3YV+eUTFJDkFTHoixeYm/TqalptWI5KX7XJ72CGT1EITRJ25T13V4MCxhglLaFYMrJnt8omUxmC1tO7ROzZ0Jx8jJPeE4RgqNKqoJQ5RbBpHle9fCyoPu410EHcTdiZ2AUJQDbN+xjG3qMSnKz2R14Wn1JexwECDI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:46:20.9859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10144a6b-7243-4721-3687-08dee7f79d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
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

