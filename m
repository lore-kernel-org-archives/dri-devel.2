Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F11C1061B15
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CB010E668;
	Mon, 30 Mar 2026 15:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="svjrURkG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3CEE10E5A0;
 Mon, 30 Mar 2026 15:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHYrhntP3dtxRd0JRrb8IYNKmSNbUfzgG5agpifOXDBEepxT3R3I41eJDjwwkLXqgfHFM8ZdyMIH8J3uhlUgdX9Tfsp/8fBJmDuQMHtrgQyn0FLiFegwp3LE8hIEBPheZ++LlBgfmPsZJNWHr6CYSsoAscLtlWhbgynOcAThEaUvNzH8Rw8F7H6j0AGqq88JPg8TGJVQ335Ulwh6H0Yv7ACmRndDtjxAjXV3SS/F2bn6kKpv+22ZdXnRMiGngRNgL5FAqmFjQ/D+dDxh6bszeWaxLwqGUg3nOwT/ZoqbmguWN1LVNMh7rQPQvRzSKaYh2BDBX8/IFEdavHCbyEGU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5KfkUvYZSVynhRX3NMg3E9SWVK1BVBN1MeOVDx9Yeo=;
 b=wiq1YzNv28LgHeWbDiMBf33ABlpzL8pdxCIZ3vfDUL71d6CGXtEUEXQMJtVGxR8XO1JYT0udouvlT9ADyaeB3qlzk4ZAXClc+mntyBOALB4/abwMKPEgJzuKczpwR/P4BAAHrVPCDlKoA07dAsNX9YINMa+9evHJ9Gl72UgpexgIRpaSItJSKscaV7+nyrR3bDYD3SXyLa0I+DFB2/nQWGzhAtquYe+j4F6b+PQCVeNYZ6hTFxnP85RpQLnNRa18MNqBrfL5wL8PnfFccFZ6qfigo/OwAoUj9J/5OMugD+reaPE8ycTo1iEDN1W2faeysBHDxPwxLpAsheVGEzWeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5KfkUvYZSVynhRX3NMg3E9SWVK1BVBN1MeOVDx9Yeo=;
 b=svjrURkGMqx3z1UUdMrGquR8SdCjZ92YYGyetorx20x53nKUuho7vU6HEp42YF8u5U+wsbNwqurVUYJlqSv6qRXytN7I9PyuggBzoExITGlgtLAWqr7mVJ6RE3unaD6qfDnD0a0JC/ftakq6oL1NpIRrKXz7JwdioMQ8X/Mi4a0=
Received: from BY3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:254::14)
 by DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Mon, 30 Mar
 2026 15:34:59 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::72) by BY3PR05CA0009.outlook.office365.com
 (2603:10b6:a03:254::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 15:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 15:34:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 10:34:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 10:34:58 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 10:34:58 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH v2 5/9] drm/amd/display: Add CSC FF colorop to color
 pipeline
Date: Mon, 30 Mar 2026 11:34:47 -0400
Message-ID: <20260330153451.99472-6-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330153451.99472-1-harry.wentland@amd.com>
References: <20260330153451.99472-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|DM4PR12MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 1780e162-63f1-4203-0a49-08de8e71e74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1Q4hIIVQgOsmIDo6slvPKUCFh7SevZ5KqM1w7jenuqYvvAVK23DzwXSPOhbaZKAbgab46Gng/v59t7D+VlqrLN8wsi+byPjc9CK/zVTSKZyb1AVQMadfSkkwibk2NmXVK90rtnsrDjPDM/1VquC2umw4BgvT0bT/G72Tt5ISwwa7Sl+lEzPRwYrFTw9AykVU6X2tc7NMv2x8VW0WJAo9qyMxrQ2CJoPzb37lR/NGG0LLpxbnpSubyBhbsMcSYqe4seB7kwM1eGHJjfZRgPn8qGppl1sNcdwL6WuEH7cmO9vf5+a3wEIZgaSOmtsom4ZwlAZeWSOxQBE9tnuEvc4Ff6zTA3r+K/WIbMpjckAQW9D8Yqa9k7tTlvczY2nyAa+e4yOFbuyPmRh6F/E+NDmGF/ljpb7F9Lf+iQsVgK0PqHxCHKbN+dwGRCOc/PzFbLXPiyoUw1BTz+/xYcYlC5LcEvIC6lDndVyhCScDaU56vBtDimwcw86XNEbUnSa+lZfXpfEFhXTc/ke1kYlAXRjnWTh4mkjOINsk1j69qPz4xY+fhmAnnqfNqawBNL12CeToAoAp9tVCojfjUUplEo2WStpnnzqz7EPDkDvrS4mnqrkWQ5EnWIfUrshMH/9vPksGXRFOAdcyPAXrP016DEqK5fKV4GkU9IdvPCRKrh/SjaNaxNWyt1cW63n6sQDASo7BM18oGVzSqnWcSBe8P2NM13atbZ7czm6cJA4K1dQL6FZ2PLF0s/Rd+/N30ccl3bk3lkpjdpa6inUrhgLFSd1O6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Lcse+h8GXmczOjlWnE7SUie6fdapWvaBvw2DItDJzRm6reeSouclNbB5HIiHRszKzyIVCt1ARHQQ7UEoGp9PsEgcK5fq7Rkp4DfHURKhq7AJ6s+ZCSrUwvUij5bBRoHKUWWYCDC0DYkh+vwqRLE3s0xUpxbepve+82UqGR2fuQiFZ0LaFc9czRqdQSEbe/zng/7XDBhTCcOUIUsyX2H0Zd4kawSPpN8i8yKlTkyQ47SR41R6sIAeFo62S/CZlPOTJE8+6osmwU+TwxcRFnV4xoHWJeCLoRi24XXJvE6Mt3Bb5odeK6yubtdo5h+3pQVpoVvzoG5AtqMQdNgDNtNB779p7bKCNBPnBd3huMYM+udeDw5zh2pJ0oX3DZiaPSq4rozdRYC6625n6qfKRIVuOCjKG2npFI5vaqGnlp0pIRxCN64iGM0fey9KlHjhIInW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:34:59.4089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1780e162-63f1-4203-0a49-08de8e71e74f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9736
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

Insert a CSC Fixed-Function colorop as the first operation in the
amdgpu color pipeline, before the existing DEGAM 1D curve. This
allows userspace to select YUV-to-RGB conversion via the color
pipeline for YCbCr framebuffers.

The CSC FF colorop advertises support for all six YUV-to-RGB
conversion presets:
  - YUV601/709/2020 full-range to RGB
  - YUV601/709/2020 limited-range to RGB

Assisted-by Claude:claude-opus-4.6

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 27 ++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |  1 +
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 3e05e48a8792..13521095e021 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -51,6 +51,14 @@ const u64 amdgpu_dm_supported_blnd_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
 	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
 
+const u64 amdgpu_dm_supported_csc_ff =
+	BIT(DRM_COLOROP_CSC_FF_YUV601_RGB601) |
+	BIT(DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601) |
+	BIT(DRM_COLOROP_CSC_FF_YUV709_RGB709) |
+	BIT(DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709) |
+	BIT(DRM_COLOROP_CSC_FF_YUV2020_RGB2020) |
+	BIT(DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020);
+
 #define MAX_COLOR_PIPELINE_OPS 10
 
 #define LUT3D_SIZE		17
@@ -70,6 +78,23 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 
 	memset(ops, 0, sizeof(ops));
 
+	/* CSC Fixed-Function (YUV to RGB) */
+	ops[i] = kzalloc_obj(*ops[0]);
+	if (!ops[i]) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = drm_plane_colorop_csc_ff_init(dev, ops[i], plane, &dm_colorop_funcs,
+					    amdgpu_dm_supported_csc_ff,
+					    DRM_COLOROP_FLAG_ALLOW_BYPASS);
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
@@ -83,7 +108,7 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 	if (ret)
 		goto cleanup;
 
-	list->type = ops[i]->base.id;
+	drm_colorop_set_next_property(ops[i - 1], ops[i]);
 
 	i++;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
index 2e1617ffc8ee..e509646b5567 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
@@ -30,6 +30,7 @@
 extern const u64 amdgpu_dm_supported_degam_tfs;
 extern const u64 amdgpu_dm_supported_shaper_tfs;
 extern const u64 amdgpu_dm_supported_blnd_tfs;
+extern const u64 amdgpu_dm_supported_csc_ff;
 
 int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
 
-- 
2.53.0

