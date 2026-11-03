Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1514606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w6pb0aqU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D9210F894;
	Tue,  3 Nov 2026 21:39:18 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CED310F894;
 Tue,  3 Nov 2026 21:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbGb94hdy8JdLzx6y6VRwePAaZ3rI7j6vzR2rmvZuOqCHakDhK9HqV3w68cAdrAfezZxabXkjDG2XVzoY6szwiyirEG4rlWasgaO9iT8cWK+fnA/v/YOnt0R7vSCKgbvmrB9Lgmiv8hiZdowcy022eSi205gCc5924A7gD3Dxy+TQbETNOKe7VYmfYajxJOICmIPiChQsBDkUeX2c1JDdkKNjeeotXrFags0xn0gSKkqeYa59dVu3lPS7sS25RkUXLIaCRK5Vrf+G/yLD/J7HnZzYXBGFYFgfffSCIxYtSFG4dVzkAMwUznTvwPxZccCjPRMD+rWQF5Ce+hky2/mmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeGtIpEBfD5jg56Gyz2BJ7TrJMJCKKYR6HRVdU5BXG8=;
 b=NvUZNNIuO/MHlmCG0U/7fTAjuzMMr4PmxcWwfBUM0eB0JGdU9mz8i40avX4GMirhvvVdF93j5/iyFHpo7qIfNMK9x2Yan29D8q3EOswatqWOG8yXQyDqvJWuU4W0NNBg5u2xiO+ZkHXi/24NxkFpj6dQoBA6LUI8UnFDx7OGb1oryntvf9VS2KUppbNEv0DrDenM0MUphzgUH0lMwuicaj1MEjzh8QNT/zK8+161OHb199rZACZVt/Jje1UMg0nnpyC68eF2LxNIDh1Fdb2in8PQqDKMzh/qHMgMxkhL8QfVI3TiMHWisrDbXRvVP1LaLl+UKSBHaaZhsb0dTQm0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeGtIpEBfD5jg56Gyz2BJ7TrJMJCKKYR6HRVdU5BXG8=;
 b=w6pb0aqUhn8SMfIczVRmsWr2GFx+3UqKB6jy216dgba/nUYYnZJxlrndz4vJpVRewfL3pBJEvZqdmeq5xhHSVIuZsKI9a2tm/u4NYvRZFPjNIOGKtkMhE1k9/HwW17TRkBzc17oApN/645/tM9GShFMvQBPIwhslLfCS8wMnIUM=
Received: from BL1P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::29)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Tue, 3 Nov
 2026 21:38:12 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::6) by BL1P221CA0016.outlook.office365.com
 (2603:10b6:208:2c5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:38:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:07 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:07 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 09/13] drm/amd/display: program the DMA 3D LUT colorop
Date: Tue, 3 Nov 2026 16:37:52 -0500
Message-ID: <20261103213756.618024-10-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6605ca-3ffb-42e3-fbb1-08df39f2c1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|261102123227099003|11063799006|261009223027099003|56012099006|261021121427099003|261021123027099003|18002099003|10067099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: pfqNozKo3mkxdO3iTGsXnhjv3tWHqgs5Ml5YCpxTZOBl4mzNHrEXKGXANBbQS3/CumuvyIW2oNLYq6yNFVhPqyTuEsul31Xz8ztutmwH1Mwq4JlsD6xJECBKfUq+DlFnbIzUOFPj+BXopUN7Uf5H+Eb8DnEJlB4BeEZOaSpV+lPbUekHdUPtseiILbqLkCgGj8vX5dVfrf5lq4dyP6YF1ou+ZlRb76pVAbAGb6i3Lzcz9apMNapoMtrVkeDFaQH56zbwrQy3GKtZGezpoHaKmfs8/eXYheqrQ/+EkEkG1CRCio+y5GrZ6n1sIDcDS2FkaxbrMYrY5SrEnW5KvnMVqU6rVAUZWbeXXk8PdsvHVeXsOZnJMzdvgyQkrlzyt370PQFWOfkPYi4AqQsTksCB0c4uCl1aWRrFx6qx0zgace3jHsG8r+qvOLac5eugR6tOTiRo0P2JXmze5ykbYbA9sUtlm4PquvZABlVLihBhDT6pSQcBbspMRL9AR5JTjvwdawivtPd0GtN/ceWwyS6xi61aZCnqxVZi8KXoYijWe583OU6ihe+zA3SMlauANt6+GTdq3CtKuhlZIO2NuepIIz2bRauSvfqCrNuLUE0/+oQPeHJs2zWrbaZ23GRTiWPHQmHANS0E9L5CBWDLeH7W2tO9x38NgEvcPTLHffigpzcv7RwFvxk01Vr0/ivF3b7ZyQVfsj1Ze3SljmzZKXcTNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(261102123227099003)(11063799006)(261009223027099003)(56012099006)(261021121427099003)(261021123027099003)(18002099003)(10067099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LmBNXmZqzrVvXDc6fYPKAIq5wwZwBpniGX/azmO7EgI4GmKOMXjpuaQMYlKC0ZSDs+vcozNDpyHAwEOi12wFnVviquworWV8vD1X51AzwS/ZfqyH4a1UORYTt5/qcO4oY5709laHeMSireia+cZMG38TxmOlc974NTpyWeSKAIBdP6OE8HNIItPZq6CCxOt3Nrzs+FFIYGx0qBQzOdRL8uIWk0XcUplJPntbjqOXNSEJie2dmEc4uncyBckDcCRjGnh+Lhq+ORGZdwjkg2R2dvnAWqBieX6Y6wu2XH87t3xbjw1CcC1FAg7ILuISMV5+g2DQgE0qRRjt4gjHLhTqLMXGFG9dLVG8WNeKxDhNNYnpFS0/sPvkwad1+ksW01wBjeBl6dOSF5MnX2JL+yL5YAaXxe9QvBCDuCpN6I9460rcpGNNi3DnLvgjWIT3UmKq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:10.3909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6605ca-3ffb-42e3-fbb1-08df39f2c1af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Translate an enabled DRM_COLOROP_3D_LUT_DMA colorop into the DC fast-load
3D LUT config. __set_dm_plane_colorop_3dlut() now handles both the inline
3D LUT (DATA blob -> lut3d_func) and the DMA variant, which fills
dc_plane_state->cm.lut3d_dma from the pinned framebuffer's GPU address
(LINEAR_RGB swizzle, RGBA16161616 UNORM 12MSB, 17^3, neutral bias/scale)
and sets lut3d_dma_enable. Both 3D LUT variants map to the same MCM HW
block, so the rest of the per-colorop walk is shared; only this step
branches on the colorop type.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 68 ++++++++++++++-----
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index ebb05a20aa0c..8936b30e9eae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1868,25 +1868,60 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
 	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
 	const struct drm_device *dev = colorop->dev;
 	const struct drm_color_lut32 *lut3d;
+	struct amdgpu_framebuffer *afb;
 	uint32_t lut3d_size;
+	uint64_t addr;
 	int i = 0, ret = 0;
 
-	/* 3D LUT */
+	/* 3D LUT - inline or DMA (fast-load); both map to the same HW block */
 	old_colorop = colorop;
 	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
 		if (new_colorop_state->colorop == old_colorop &&
-		    new_colorop_state->colorop->type == DRM_COLOROP_3D_LUT) {
+		    (new_colorop_state->colorop->type == DRM_COLOROP_3D_LUT ||
+		     new_colorop_state->colorop->type == DRM_COLOROP_3D_LUT_DMA)) {
 			colorop_state = new_colorop_state;
 			break;
 		}
 	}
 
-	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_3D_LUT) {
-		if (!has_3dlut) {
-			drm_dbg(dev, "3D LUT is not supported by hardware\n");
+	if (!colorop_state || colorop_state->bypass) {
+		dc_plane_state->cm.flags.bits.lut3d_enable = 0;
+		dc_plane_state->cm.flags.bits.lut3d_dma_enable = 0;
+		return 0;
+	}
+
+	if (!has_3dlut) {
+		drm_dbg(dev, "3D LUT is not supported by hardware\n");
+		return -EINVAL;
+	}
+
+	if (colorop->type == DRM_COLOROP_3D_LUT_DMA) {
+		if (!colorop_state->fb) {
+			drm_dbg(dev, "DMA 3D LUT colorop %d has no framebuffer\n",
+				colorop->base.id);
 			return -EINVAL;
 		}
 
+		drm_dbg(dev, "DMA 3D LUT colorop with ID: %d\n", colorop->base.id);
+
+		/* Not pinned yet for a new FB; the plane's prepare_fb fixes up addr */
+		afb = to_amdgpu_framebuffer(colorop_state->fb);
+		addr = afb->address + colorop_state->fb->offsets[0];
+
+		memset(&dc_plane_state->cm.lut3d_dma, 0, sizeof(dc_plane_state->cm.lut3d_dma));
+		dc_plane_state->cm.lut3d_dma.addr.type = PLN_ADDR_TYPE_GRAPHICS;
+		dc_plane_state->cm.lut3d_dma.addr.grph.addr.low_part = lower_32_bits(addr);
+		dc_plane_state->cm.lut3d_dma.addr.grph.addr.high_part = upper_32_bits(addr);
+		dc_plane_state->cm.lut3d_dma.swizzle = CM_LUT_3D_SWIZZLE_LINEAR_RGB;
+		dc_plane_state->cm.lut3d_dma.format = CM_LUT_PIXEL_FORMAT_RGBA16161616_UNORM_12MSB;
+		dc_plane_state->cm.lut3d_dma.size = CM_LUT_SIZE_171717;
+		/* neutral bias/scale for UNORM input */
+		dc_plane_state->cm.lut3d_dma.bias = 0;
+		dc_plane_state->cm.lut3d_dma.scale = 0x3C00; /* 1.0 in FP1.5.10 */
+		dc_plane_state->cm.flags.bits.lut3d_dma_enable = 1;
+		/* lut3d_enable gates the fast-load trigger and MCM 3D LUT enable */
+		dc_plane_state->cm.flags.bits.lut3d_enable = 1;
+	} else {
 		drm_dbg(dev, "3D LUT colorop with ID: %d\n", colorop->base.id);
 		lut3d = __extract_blob_lut32(colorop_state->data, &lut3d_size);
 		lut3d_size = lut3d != NULL ? lut3d_size : 0;
@@ -1898,19 +1933,18 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
 		}
 
 		dc_plane_state->cm.flags.bits.lut3d_enable = 1;
+		dc_plane_state->cm.flags.bits.lut3d_dma_enable = 0;
+	}
 
-		/* 3D LUT requires shaper. If shaper colorop is bypassed, enable shaper curve
-		 * with TRANSFER_FUNCTION_LINEAR
-		 */
-		if (tf->type == TF_TYPE_BYPASS) {
-			tf->type = TF_TYPE_DISTRIBUTED_POINTS;
-			tf->tf = TRANSFER_FUNCTION_LINEAR;
-			tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
-			ret = __set_output_tf_32(tf, NULL, 0, false);
-			dc_plane_state->cm.flags.bits.shaper_enable = 1;
-		}
-	} else {
-		dc_plane_state->cm.flags.bits.lut3d_enable = 0;
+	/* 3D LUT requires shaper. If shaper colorop is bypassed, enable shaper curve
+	 * with TRANSFER_FUNCTION_LINEAR
+	 */
+	if (tf->type == TF_TYPE_BYPASS) {
+		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+		tf->tf = TRANSFER_FUNCTION_LINEAR;
+		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
+		ret = __set_output_tf_32(tf, NULL, 0, false);
+		dc_plane_state->cm.flags.bits.shaper_enable = 1;
 	}
 
 	return ret;
-- 
2.56.0

