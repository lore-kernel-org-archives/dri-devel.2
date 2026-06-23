Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7CACDB479
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDED10EC16;
	Tue, 23 Jun 2026 16:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kATlePAk";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4F110EC08;
 Tue, 23 Jun 2026 16:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIhmEMKMOSpBIYx0IQlMKvJsDWJvwhtputc7YzCXgt6RwVvYfiW/Ty5UrAqbYSsyEDN5PDVv8ZqyBTyeH0+4ZOUkyAnb7FoADhyx2IPv5vx5a5S0o5g3HnUho/BYPYUWifYagWVLX+r5VOXsh5HWhOcf6B8+S030QnMHbeQz8YqK3JZMMXrG7EGv4Q5uxflXYyqXIJQ04uQxpw+t2GL7hV+qd8TXa+iKraaBugE0sc1YgwJrEtvYL97ECpkkNRnjTk/xglOdkdlIvfUpGTFfaXb+wHIFrlqUn+eAwzLUoGWzfYK/Z/rlIwcc1Pzef+Ct8P7CS0hTcoKDqkqztJkcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDBLES4Q56oMbj/TSFj94IvL4uIyFgUjB0vcse8KV4w=;
 b=wlZQZZPMag+4kl4N8SFFjh6cZ+/cA7JUlODtCXHrIp0pCOge24QuGUGm1REMUA9xc5w+sQYL8TiSvW/Z3Al24utvYqciqkM9D0K7M39eJ6MirNCGAaRoF0ohrfnPcL9die9f/dWgzreq+5FEZHQrPlPlDiVll1Q/fJd/hFBI3NGGw3f0niN1wswFEecenmjoB+V3ECMjodLwyVyMKhmbER1L92IqTcJygqzS4MNk8SkRaJdsoYKeqwenmG0OnF+U06BpWLRDDzgxDJ5uVSVOdgEzYRKS1dIDeVLqkV3qQ0fyb1I3ye7ZY/SsQhmu2LZFEL8fe9q7/jagtPSWyKBFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDBLES4Q56oMbj/TSFj94IvL4uIyFgUjB0vcse8KV4w=;
 b=kATlePAkp8OCGpq/YjbUJJgQeJKTf9lpoD14XwB5NUCxN7SJhcc/jCslYrMKJBGLYDUoqzC3ZxOc9H9peMiDMqEaDxyuma9wujmPtA9gJbr6sfOFsuTVrE90Cc7ZPeHkh1y/WTsaKFOWSDqjw1K9xAiXbcGKDu6em4fdWlQUyoc=
Received: from DS1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::10) by
 LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 16:48:24 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:454:cafe::17) by DS1P222CA0003.outlook.office365.com
 (2603:10b6:8:454::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 16:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 16:48:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 09:48:19 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 11:48:19 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH v3 05/11] drm/amd/display: Add fixed matrix colorop to color
 pipeline
Date: Tue, 23 Jun 2026 12:48:06 -0400
Message-ID: <20260623164812.81110-6-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6ed3ad-376d-489d-ad90-08ded1473dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: tqg8w7gawEvADZhedVE+lbnrtBXwV1IVulOzIv3JbsjLWNQrucnTvDW7B16wE29zTOgP9ZIIuFyGZ/vBa5xmLyJ/DsBQXgqOx+Oy6DvWmxIUSd4e/C9AKK6KmrZMtJmu4C2N8bH/P6cnecqfry+yLKET3h8uAIqxBoFogMxjOvI1L5VyZ+cpSOMU45pT6cVnFLIm8Gmf6x9AfXCQ+agRu8KzxT92bohZAsuVznGBGLc4f8RfBze1KSntJOgO11Iz9TZOTzIqArvA+HswUDrB8GMaHGCkxaipje/oaaspZeVNz3HVdOlrdHL1C4KY2TUVE0fPtbYTVaU/MA+XL66g9KqA9c+1YhdJ7GgcVOWzF+/oNxPkQnrN1DHT4irfmjKsPxgV2PvNzFf5xUCr56lwTb70W/FHNjCYy0Q38CeyqypvzYSIvRDCvq3fcKh+4PoosuXKENdkjJnbi8xgYYV7Ax5hvn0kU85rz9zgiwPDxefQuYNmy7alWksQUYLMv/wxHIUsczTHxTEnnpxAQ0BiwrFY8MAv6Tpoj/SyjeW4EAhcUMldWfGdN5TQb7K2IAIfV+qr04q7V8GkxXbggJrMyj7x3QRMSSKg2/IQy7r0kqCB0+0I/4xLckXJ4D1Mj9moTs7a1BA/TGnGB7KdD4Q+UbdFRrqIa++ny8C4Sg/0rRvIID+EGoozmcSuVgAkmNgEMD+pJpTGgiIF2D77DDvrYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pGj84lrLCyn25hUspdoJ1BSrkgqcemMJZYibmQOCiPTQvONigXPJ/rb4k0AiRUZ6I7oFpSkFpgeXisyd8A9F2u6t8zb5be961p0cTrYTCCwUk9Lb/qbrHTwhNhdALHs9uNDrMDKjLb9J1POiK6OZfaLB0IkNbBS0vic4i3PglGBJaOEVwnyhGJOkR0Cu4hlNXtNSkxt8xcAYmtgwa+lPT7MCNRznfAHmSNa+MlMh8nmSJe9IVT9+z0SV374rl7CSS5fnDevlllEXiTj5HJE0wDBhfEc2nmD/W5p6wO5h/VPbuPdXVLtX8BBsSpCtNfeWOvr/9+G5EgVmCZLijPlnuR4spU43AMHg9ADbEGCpx+q++QeTLf/HRcgqiI2/hFvp62ttrNMBuhnC6b12aFxc+1MakRnOdLYk7LzIotq4PUT9L4pCSlaI2HgOoTNH9wa3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:48:24.2488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6ed3ad-376d-489d-ad90-08ded1473dd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092
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
index 7ee051cb3c05..972fa96b4b9c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -51,6 +51,14 @@ const u64 amdgpu_dm_supported_blnd_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
 	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
 
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
@@ -70,6 +78,23 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 
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
@@ -83,7 +108,7 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 	if (ret)
 		goto cleanup;
 
-	list->type = ops[i]->base.id;
+	drm_colorop_set_next_property(ops[i - 1], ops[i]);
 
 	i++;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
index 2e1617ffc8ee..7b71d3144391 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
@@ -30,6 +30,7 @@
 extern const u64 amdgpu_dm_supported_degam_tfs;
 extern const u64 amdgpu_dm_supported_shaper_tfs;
 extern const u64 amdgpu_dm_supported_blnd_tfs;
+extern const u64 amdgpu_dm_supported_fm;
 
 int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
 
-- 
2.54.0

