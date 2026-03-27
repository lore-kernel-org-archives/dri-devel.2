Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F28A10AB832
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1583410EC1F;
	Fri, 27 Mar 2026 00:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="azZgb3gO";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCB810EB3D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF+TSgc0JMUzY00EwLl4mH+ucuiYk4XCUg3FWu/C6Px+0njmRLwBnSFaGYjt8BTjxuGp4c8DTYt9Yh52/4e7PES3FD9nADRegChqxmStTGXvmAKPrSsJaC0NDvp9fZ4w0C2lAs0ZS6JHsffpzTqra3L/o6GRSZMm8pEM4rGs3QBR/P8iEWq2qTHZyHr+jXVGXct58+HIJ/KreAv/Uo0zBW+5YGCm5P98Ih1oYUCfM6tNG6L8RyGe4EoyE7ZzK0aS/ryBmOMWYzyeMNa5eyAKeqLfFvedDvmVLk6m2CDzpoUDhYWel+zAfPooMThtfEiwIQ1HdT6pH5rK7yDwOda7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEkVjVnW2REG+PlmxIG0ELRn75T4B9Sy01HEhN/UlP4=;
 b=yRVqTEgtARQ/N6+TmxBsmYjoZB7zAb5Hf6UXa723WKbLHIetVyvO24AKhIKZWHo0zLr/DEp/UrrgINOZ1YnsNPsMghPsVW8vqBPrXnTIbUcTxUMk2gJTglI9KZb1nrKf9cCmA9Nt7bJRnfDsOJ4ZWd3HE5UlcMIKoQCMRF+0HQDzTmp7eVYpofWnQ9zRewDI7UNW6djb0sc9EW6Dr2XAo859vVLAaCWhOyBaF1mUkZIyYPUoeY+qtmCmEKs36v9Z371BwkeIH5VtdPWy8PmfZwjtagrZWE9h0/4rjqPm5o47Vkh8c29Oc46igTxQ24nqUTLQEm6u1oLhVKFZG/Vu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEkVjVnW2REG+PlmxIG0ELRn75T4B9Sy01HEhN/UlP4=;
 b=azZgb3gOoGw3Q+cWaQmAofP7FB7l0RYeQD/OUo01SdNyrbriw5Ur0ynjzK5AQQMWI2tFt+Xq5S/aw7PJAFfy7nkc3GaWPr84iKK4EtUrxfMWk5mC0cQhit+m5d7Rw5xQVEdJ5KgYip4U//pAfqySCUQEbOQwhn02anB7S5nMKL4=
Received: from CH2PR07CA0058.namprd07.prod.outlook.com (2603:10b6:610:5b::32)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 00:40:37 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::7f) by CH2PR07CA0058.outlook.office365.com
 (2603:10b6:610:5b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 00:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 00:40:36 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 19:40:34 -0500
From: Alex Hung <alex.hung@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <contact@emersion.fr>, <harry.wentland@amd.com>, <mwen@igalia.com>,
 <sebastian.wick@redhat.com>, <alex.hung@amd.com>, <daniels@collabora.com>,
 <chaitanya.kumar.borah@intel.com>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/colorop: Mark interpolation properties as immutable and
 atomic
Date: Thu, 26 Mar 2026 18:39:46 -0600
Message-ID: <20260327003946.3458610-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b1e4d7-b816-4d41-1247-08de8b997658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|13003099007|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yr1sH8gy/VHrC967t3jH6viTKrghFT+b1+NfeUtWLHnj9QJtW8SUh/2f06An2XBwOGxgDOoXIk1V6ztlIl5NG8Yw1mcL67BldLQUkYgNZYg0sRE24sRaDCFiQb5AUX8Rqe6mQ3HBh/LzMGWM8RLU+cq3osRgAnZVZA6JhTYlbzymkidGjBzjPyr+t1VxTb16ygNSXd+YN64xnjoA8iJ0QDefcUPkiW0yTM8gudCWh2XXjZ8U0NQQtwIXS2j4+f5cRNMMup2+HF/9lgk5UhVQ4fHDZPAdegBDjzFcAgZzUhvUJfhTL6dtShJ+DchNQTMbO4gbh7mLbHNZg4CPsOSd/53slRz1Z2/JgBRJXZxSLu7A6f31Cc9h8pGJV46SHOBCusHKWhKFHx1UZivxqA7/Zv5rGTLuvOyrglufsupfFd7DQ0Ouw2w7n7Wx5dXtn+vNyx150062eaG4lwu+GicvnrHIoLc8JOqGsZpDI2PiI6Clt69rEbi/NLEKgab/zLKnXD9A9Ml84UZS2+DBSed88purJuqh9l5jt78PqAcvVK3eF4YvTLqDd+E1OzmEUxgoX1WpwdqJ5BMecwfxQe6sE0CTiRThmCsoYAd3pepcKG8zn0HWp/uxok2kgJvDQ1DW5cvy2SxiF63u8/3IghwUWnj8r5D/4At0wY9Bp9DlQD5H9HRAFyLFXPxd8MHLJpO9hW/RRri5IV0QQUNm+4Zii4DsVdYj9ynmhTNhtPE3Xbw/yZ1LWVKHqXKQmU/C3KNcjXZ3JoJ9xPafY5GUbvk9kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(13003099007)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9DkRveSGLo8b5GgBibtvdlPqdv5ldJLZ2p6PRVETNlGRpTpmwMqCHvaOJbMykkq3GhyLikrHcjsPVquhhZh8pFCwaO5/nXrHU8CgNsRbe0Md+Gka8TWjlRPcZsC0XXeC19pC5ccdROxRX2CnBMHuK7seBsUHUtFQs6WxpUXqMhTyxy/C01a/9+YGxCDt+UAhsSJoF59NxmYjrGUCh2n5qrNC/Q2edqvA+s/X9N50Vk6QCbuq2rhxEgxkn1ZrhuDgs5F+ND5datRThGtghqwwCG+2WgaoRloc3VTznYz8pXmKC9DHDxxxTt3Y9GaoFpEkvtiQPntff++eKJplqUng3ufqlSldSVVxHMRx3lYO6Yh5yQn2mOAPlbZoa1uRVkhBYXcrSUwTLGO4R5ftlvm6oNVaoJwHhwSuJiZ7QYf+Xe4IJg7jRfteteuassII872D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 00:40:36.4179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b1e4d7-b816-4d41-1247-08de8b997658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238
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

LUT1D_INTERPOLATION and LUT3D_INTERPOLATION are read-only properties but
were missing DRM_MODE_PROP_IMMUTABLE and DRM_MODE_PROP_ATOMIC flags.

Add the correct flags and remove the now-unreachable set_property
handlers in drm_atomic_colorop_set_property().

Link: https://lore.kernel.org/amd-gfx/dbb27ec4-cdc6-4ead-9daf-664d97e86cd0@intel.com/
Fixes: 7fa3ee8c0a79 ("drm/colorop: Define LUT_1D interpolation")
Fixes: db971856bbe0 ("drm/colorop: Add 3D LUT support to color pipeline")
Suggested-by: Melissa Wen <mwen@igalia.com>
Suggested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 4 ----
 drivers/gpu/drm/drm_colorop.c     | 6 ++++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 713fa9e81732..e831894d5a51 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -758,8 +758,6 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
 			state->bypass = val;
 			*replaced = true;
 		}
-	} else if (property == colorop->lut1d_interpolation_property) {
-		colorop->lut1d_interpolation = val;
 	} else if (property == colorop->curve_1d_type_property) {
 		if (state->curve_1d_type != val) {
 			state->curve_1d_type = val;
@@ -770,8 +768,6 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
 			state->multiplier = val;
 			*replaced = true;
 		}
-	} else if (property == colorop->lut3d_interpolation_property) {
-		colorop->lut3d_interpolation = val;
 	} else if (property == colorop->data_property) {
 		return drm_atomic_color_set_data_property(colorop, state,
 							  property, val,
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 398cc81ae588..34998f393f2e 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -317,7 +317,8 @@ int drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev, struct drm_color
 	colorop->size = lut_size;
 
 	/* interpolation */
-	prop = drm_property_create_enum(dev, 0, "LUT1D_INTERPOLATION",
+	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC | DRM_MODE_PROP_IMMUTABLE,
+					"LUT1D_INTERPOLATION",
 					drm_colorop_lut1d_interpolation_list,
 					ARRAY_SIZE(drm_colorop_lut1d_interpolation_list));
 	if (!prop)
@@ -413,7 +414,8 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
 	colorop->size = lut_size;
 
 	/* interpolation */
-	prop = drm_property_create_enum(dev, 0, "LUT3D_INTERPOLATION",
+	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC | DRM_MODE_PROP_IMMUTABLE,
+					"LUT3D_INTERPOLATION",
 					drm_colorop_lut3d_interpolation_list,
 					ARRAY_SIZE(drm_colorop_lut3d_interpolation_list));
 	if (!prop)
-- 
2.43.0

