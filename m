Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918B0C55174
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5116C10F393;
	Fri, 31 Jul 2026 18:15:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tj0vaZyO";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A72810F390;
 Fri, 31 Jul 2026 18:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/qbXNtoh90MWBTpjNvy42Gq0LhvprBh2XdFd82u924jA9+Gkic0UploVK/Otyap1m0Dma5bFwzziKAXM5Eq10WGz9dbMzOd4C/IIsJ0ubfx7SXPWoFOu+PqIHOBTLM3Wvz4kGrE9eLTkfqBTJFj8yM94+JZvFODTWqGenXGXfkkZfctaM4SLHDxepgkdNgRdIWqwkGisUBf8YSLho4tq3g37/UVqltvkOp9+mHYCK4BIEgJCNLV6rXquldnga15CRdqxWTSMqlTVOVaktuv7OiAWaM0DyfMVQmx6rQaLTKTJBVfvx6cJnp9iX0Z7+0wbv9Iv5HpPJRiGA22NjSEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3F/jgbWDN3HjfAXofb3UKWvr06uQbjYF00rLn5MVHU=;
 b=sL3ZI8vW+fBQ/saUT2qIEqXkOrRqvMdZkg73J+96y2NmAJf6mzD1Bu0iNOTp6Tpyng5lQvlKD2Ds+/MzrKWSSbNB5OH1tW+poyPlUYXq3/fWhflakV/0LK8wA+WdDimZjvxoQuXez9VWA8+MRMVWwYTqH2seLH4ASGzfeAH/ZdeZeqO0ESjWpyHD5BYbZRZt2dc9wMdf8+RrDZ5K5U+mFAlnHhfO2iOP84NlEa1m87I75qbk3B+gBS0ul2ITVIV80LWwRetrHwVgbrcMM/uUSA/AN4igR9rdBwal80kvCOPIhmSwOIJgynZiDxYCkVSwGazoGXo8EQsiA+he29tOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3F/jgbWDN3HjfAXofb3UKWvr06uQbjYF00rLn5MVHU=;
 b=Tj0vaZyONyol7eyI5xc7KcJXYa0lm3EzkaJ4S4t2zoiNfn+Q+UIRzF6TVUt5IMfSCCI/AZyH6RTF9T9yikHA/AWjzJltss5RXatiXtWM2IFNn2OO+uDGzQAsV3VEJKBpZFtfDls/NF6My69Jt5w4Dt3kZt4/TU+WfkaE2OFgRoc=
Received: from MN2PR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:236::15)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 18:15:31 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::6e) by MN2PR05CA0046.outlook.office365.com
 (2603:10b6:208:236::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.10 via Frontend Transport; Fri,
 31 Jul 2026 18:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 18:15:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:31 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 13:15:30 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v5 07/10] drm/amd/display: Use GAMCOR for first TF if YUV
 conversion is needed
Date: Fri, 31 Jul 2026 14:15:18 -0400
Message-ID: <20260731181521.681990-8-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731181521.681990-1-harry.wentland@amd.com>
References: <20260731181521.681990-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: d50aa978-cec0-44dc-ad2e-08deef2fb52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UPCbK8uFq9Dw+4LxzKtsiZIXT4K5E69PHL/HFRmb/wVJV72aNisayqD8nwWKGjrut4o1/VVslSMnzuId7ANC+0H1fkMs+TVGU+DCJ+XBQpineg2a50iqAi/pv/tBFU4Da5gTgknTXvzqIidgwIXT/YGwh+povxmarO5jesX5zZNJSzMMBnmvT8OcPfR17M7dN8YLNIBUJrwQk5o24ykh6x5a85nlbM4r84IxM635JJMQ5+37kgka1xmZgDpS5QdMEC7BC5Ula7sLIAknsKmM1U0TgHTcPVlTll4u1bG/Yt44nEb+da7sofEz3WQDwFuLN/fyJVKbIiAiJnKU07u6m59i4k93QWWQCuSWIg2wo1KrdNk8qrJwifg13Ad2y9tzgyC1E9ioQyOzEFgpiLPqlpT5UENAlTXKfJ0dFLEAnId5Hw2B7+USTooER6O7tnRkCzZ4OXqeUOLdjXacIvReEU3DPAKuXEnhbekXLIwStxxfpUImuLs02BjxnNRwcZ0iqlQ8jaC474xqT+QD0BtRBdqxnzJYc76lM6GL5noiBjGFTTKJNxQOy3suKPkG2j+Xs9xm/cL4Zrw9do1EESfxXJFCAoAGyZrmXcMu4G4J2ZASEqDWiffp7kfBOxikv8HLzvVWpYeHq68mE7nLOqtyRkYrZwIntVXMY34VrNCtC1iqYyz9EVLZ2mdvZC0pVMQGY/YFOxMbMSt9ScGH9t8bfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: shdRSnCQ5wPRqfdRATBORMXASAqP3czjWM5JdQidPvauHmpb4BZqUUatpcHl5jRBrhcnF5e2uRmymeP8n0jGteySeeUmHKUVrEPhzLrz4bdO0ZXO5H34PUHsB3MvVZe2v0kBIRnX52mgW4k+5iPRSvWWds9NybhpFzdxQaDZqWV+sfSHBXJBpnx5pzdav7677cQ7oW0yLbK9to2shtnuD8oTT18ACBkhFUB+Gewn0pUQ8BdMzR/PcWFfR88zOo57iOD2ChkMZjJ91R+00MPPHiw8Z/eWR1CIFT/GSsSuL9mABeYKtkh9khAM1IPesvpl13Y0xdXhW2e+lKOh8D7XkBOq0Pc+AUgWt8+DzvY7R4cOY18i/o27VZPSA6UIXBLFjkGE6gy/MIBYYA4mFt4wcuecKKtKOiiDWaTPhuton/HtwmX3hlS1N+XumxvCVaeI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:15:31.4783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d50aa978-cec0-44dc-ad2e-08deef2fb52b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251
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

For subsampled formats we need to use GAMCOR instead of
the DEGAM block. The color module can create a LUT for
that if we set map_user_ramp to true. So do that when
we have subsampled formats.

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 62791077ceef..8913bc9f0f06 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1524,6 +1524,8 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 	struct dc_transfer_func *tf = &dc_plane_state->in_transfer_func;
 	struct drm_colorop *colorop = colorop_state->colorop;
 	struct drm_device *drm = colorop->dev;
+	struct dc_color_caps *color_caps = NULL;
+	bool is_subsampled_format;
 
 	if (colorop->type != DRM_COLOROP_1D_CURVE)
 		return -EINVAL;
@@ -1537,10 +1539,23 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 	}
 
 	drm_dbg(drm, "Degamma colorop with ID: %d\n", colorop->base.id);
-
 	tf->type = TF_TYPE_PREDEFINED;
+
+	/* Check if format requires post-scale color processing (subsampled formats) */
+	is_subsampled_format = (dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
+				dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
+
 	tf->tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
 
+	if (dc_plane_state->ctx && dc_plane_state->ctx->dc)
+		color_caps = &dc_plane_state->ctx->dc->caps.color;
+
+	if (!mod_color_calculate_degamma_params(color_caps, tf, NULL,
+						is_subsampled_format)) {
+		drm_err(drm, "Failed to calculate degamma params\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 EXPORT_IF_KUNIT(__set_colorop_in_tf_1d_curve);
-- 
2.55.0

