Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701E6CDB47F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 625A810EC07;
	Tue, 23 Jun 2026 16:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AOcTZ8dX";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB02010EC0E;
 Tue, 23 Jun 2026 16:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPTh9nXgE1aKaTpQsTeern/yJXvQ1LMqYdaIcA6qfJC+Q1eJrhC9qQybRjcz0FdMgv1Kd6oSZn6r0Of/0v6AYLeZBPvukC7CfL6311SdMly0WSkxDoayvByTboidk0Xdfsfm/mGVKYv8LN/IcG85TMT2M2H9iI3fSBGsBjMx71xrQvLCeRESquyznAvSJOOKtbH3gU4PPO22j4kx1DUjxOB2TecUr+9P84qPDS7RHP3yB8a/QMGxGXZcCLA9eb6PlO9GdKX6pb2pIR5lttnQy7eUOWTx8AO8Ttnw3Cy+OmZezVyjP4wGRXEsoAo6dZZmOIQdSRgeZuPQUooMuHaT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4fc439RZMxZ0E4bzNok3WR8fIvRjFcUm03kTszF4zg=;
 b=iKfQ0xtCtlxYMyB7yp1uTwDs732Xr1fD+8ecRzTj5rh1QwzNCpiDeYaJpAWosWiYniHT5mvKX2tzlPMX30BQ+fdtpA5wQIAcW0Obf7kzzfm9ILPyPYY0an5Zy9HdekP/uXkplxswhBclyQYoMqA3ysOJVGY68k8Rmmxvi9KvKcjod8r2rtKAR9fcnZwTt3nJJBBn/SOxU50PkslplFqkvBvMR2ARPvJYtrkRwc8Qp9cGEDsfE9Jj88laUSiSviZ2qwrc/e1QBwC2s7MS6uMloaRwqAX4mCUyUjfo6rsGOVSFUQsLpFHShQHMwgPZC5ekPkbrqv6sTlxy0kfAuq12Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4fc439RZMxZ0E4bzNok3WR8fIvRjFcUm03kTszF4zg=;
 b=AOcTZ8dXqxBg/7j596ozAcDpg42el9FHZ+KJR2mQhegp3BDMhMuU774dHyF4exwyo9rXpLImTAJv9B5z7qnsLFgh4flQNa5dpx0uOEci5IIU/Pru2A9pgMcqBhWORUcr6RH04ipZ/SEwpvIqtznxGmm0upjj9zk1Xa72PEr22a0=
Received: from DS1P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::11) by
 CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.18; Tue, 23 Jun 2026 16:48:25 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:454:cafe::a) by DS1P222CA0011.outlook.office365.com
 (2603:10b6:8:454::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
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
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:20 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 11:48:19 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH v3 06/11] drm/amd/display: Implement fixed matrix colorop
 color space mapping
Date: Tue, 23 Jun 2026 12:48:07 -0400
Message-ID: <20260623164812.81110-7-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff83f85-333b-47b5-46b4-08ded1473e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8J/q89tMiU8xd2PC4rmDfBngOxBKcXnnL3Q9IUlghAwQ7+PpLB1WE5FTnW2Jn26mdyHD7MTGHVY7SF1WV7v+o/ZhYpCVbSAwounOVtriq5uK3EtJlmOowD9XqbqbjVLJd617CVpKlCAzX3st7YlAO8CLCf98SOEquJo2RT6aKe5hquXed2eUF7r3oh6haOk/4qtDxtu4Ij4xe47ZueGSdARvnzhqe5TfW+SLeDupHpjNPivKlV27Sm8hmd+IDuhOMsY3XtlncA7sRx73Xh4iwnnYM3asZH88FFeR35HaH3TisL+q2DlGY80r74DKefbtalBGOXd9leU5og883OVRkNIK/QOhj7shjcIbxF3se7fmJ2FwFUCelrS3+pb67W5sfcuvUOuHwl5FQQIkH8qB4oNm4bV5j+p2UlG8fHaah/oyGZBFMoRvRpPv6A3tJRUqjsWh15ATAIVayJ//c0cP8vQQVmtbiGlWCs+sEUjxpiJhkCdkwW0lCr/sBturaQ/U0/d0J9yY45CxIt0ShXW7sh+ZCPS//wJXo5X8UGhBW6zJbEoHz+KRLhfA62XIOeWjoULJ19QolEOyzU0sE9mPUOsSlv97YA8cKnCkO+GjRMudG0q7HgDXh6Fw+9+8aqDgR45yUTS4PeUPEMbc9YRUWBGUh8rxzZQljJiiIrAKoqurOc6BdOKi4oprxLZczXlFivjb+QSpi3+C+d+j8ObDMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mertL2ATdt22fPLBO0MArcoqWxAhOKD7sqvyDOntaD+vhLlGzakfJ4vFBnzr/PjHv+9/ZAVVfyv3WYBFaA1u/G60m5jbWmZUHL4j23e1Z1joW9TWRUgQpnXZPQRfqDDxaE0NMaz8hUP+aRYnubGgsUBAydAAXEtCN0zIdjudpwe4duDLvbcH2a3GH1czvArJZUvScQ7138/JwOas3PCDXhUnrBDGh87GKcNzb0zVtVjvkj4WAsw8LxyzPGQubOpOmigCk12dUimu1ADx3j7uV3TEpRY55SDsNrn7RNoIEPb0JRwztVY9uxlYVBh47PWpJUd71WyszNCLZ8r9af6n3SM9U91+p/K7BtJ7LZXWTKeiUTYSDIb7bwHD3p0aOfP9uRZzi5su2mc6qCCzUj5u90IPXYM5nRFMXag6TfqCm/ACHGtu4HvE4fm0Ld8epyGh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:48:24.9062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff83f85-333b-47b5-46b4-08ded1473e31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924
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

Add __set_dm_plane_colorop_fixed_matrix() which maps the fixed matrix
type enum to the appropriate dc_color_space for DC programming:

  YCBCR601_FULL_RGB     -> COLOR_SPACE_YCBCR601
  YCBCR601_LIMITED_RGB  -> COLOR_SPACE_YCBCR601_LIMITED
  YCBCR709_FULL_RGB     -> COLOR_SPACE_YCBCR709
  YCBCR709_LIMITED_RGB  -> COLOR_SPACE_YCBCR709_LIMITED
  YCBCR2020_FULL_RGB_NC -> COLOR_SPACE_2020_YCBCR_FULL
  YCBCR2020_LIMITED_RGB_NC -> COLOR_SPACE_2020_YCBCR_LIMITED

When the fixed matrix is bypassed, color_space is set to
COLOR_SPACE_UNKNOWN.

Update amdgpu_dm_plane_set_colorop_properties() to process the
fixed matrix colorop first (before DEGAM), matching the new pipeline
order.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 68 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index fa6883ae4dfb..c54ca5188f68 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1492,6 +1492,61 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 	return 0;
 }
 
+static int
+__set_dm_plane_colorop_fixed_matrix(struct drm_plane_state *plane_state,
+				    struct dc_plane_state *dc_plane_state,
+				    struct drm_colorop *colorop)
+{
+	struct drm_colorop *old_colorop;
+	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
+	struct drm_atomic_commit *state = plane_state->state;
+	int i = 0;
+
+	old_colorop = colorop;
+
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
+		if (new_colorop_state->colorop == old_colorop) {
+			colorop_state = new_colorop_state;
+			break;
+		}
+	}
+
+	if (!colorop_state)
+		return -EINVAL;
+
+	if (colorop_state->bypass) {
+		dc_plane_state->color_space = COLOR_SPACE_UNKNOWN;
+		return 0;
+	}
+
+	switch (colorop_state->fixed_matrix_type) {
+	case DRM_COLOROP_FM_YCBCR601_FULL_RGB:
+		dc_plane_state->color_space = COLOR_SPACE_YCBCR601;
+		break;
+	case DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
+		dc_plane_state->color_space = COLOR_SPACE_YCBCR601_LIMITED;
+		break;
+	case DRM_COLOROP_FM_YCBCR709_FULL_RGB:
+		dc_plane_state->color_space = COLOR_SPACE_YCBCR709;
+		break;
+	case DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
+		dc_plane_state->color_space = COLOR_SPACE_YCBCR709_LIMITED;
+		break;
+	case DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
+		dc_plane_state->color_space = COLOR_SPACE_2020_YCBCR_FULL;
+		break;
+	case DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
+		dc_plane_state->color_space = COLOR_SPACE_2020_YCBCR_LIMITED;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dc_plane_state->update_flags.bits.full_update = 1;
+
+	return 0;
+}
+
 static int
 __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
 			       struct dc_plane_state *dc_plane_state,
@@ -1879,10 +1934,21 @@ amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
 	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
 	int ret;
 
-	/* 1D Curve - DEGAM TF */
+	/* Fixed Matrix (YUV to RGB) */
 	if (!colorop)
 		return -EINVAL;
 
+	ret = __set_dm_plane_colorop_fixed_matrix(plane_state, dc_plane_state, colorop);
+	if (ret)
+		return ret;
+
+	/* 1D Curve - DEGAM TF */
+	colorop = colorop->next;
+	if (!colorop) {
+		drm_dbg(dev, "no degamma colorop found\n");
+		return -EINVAL;
+	}
+
 	ret = __set_dm_plane_colorop_degamma(plane_state, dc_plane_state, colorop);
 	if (ret)
 		return ret;
-- 
2.54.0

