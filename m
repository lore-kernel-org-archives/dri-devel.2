Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19BA606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=okQQdWMc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D156D10E3CE;
	Thu, 19 Nov 2026 19:52:14 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE5E410E0EC;
 Thu, 19 Nov 2026 19:52:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PA3Yb4hhBiXZjQM+nVbJggEaHVSGNSh07ChxEstSX9xdwUiHT0DPNU8V+p2btQfbFQu7AhRhjaiC9H/3CC34VZqGv8vABrEj6NKK45Av40bem8DpD/uD3ln8f9fwPUe6RzJ/FFveg30r5Vg+Jt5I3R2Jb+Pq2GxrdgzDLUswBPaXd1KG8yPlaBSza4c3XfqEbDYxdMXZYrRyWYSguHdRq/J4neHXcZlYTuRrYdn/9MM0Ipoj/AsKUVqWfLFWh0yqTLec7PhzGxRX8Xmazd7FGjHbQZ3PR77JYWF2cycc8qYPHjFljOh70Zp74bj6XQZV2pTrx10y3pXzE5Ibof19Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Eh8ehZYs5CKZTiO9JNOMSbCxi4CMsACO4XGI2gK8KU=;
 b=CGuYy9pP/aMyciPf1mFDsUcc7VJUSPszhUvNjpZ4wQvKbpeuwjB0Feb61SYts+VkcmgFZiw96Nzhb0JXUEyMupiQXoys1bLrqAjYb6csn+Zi60/YXb4X9okZkUBy0pTHU9IZoqsQNAxvXPVFC3zxOZJ/3XQnureCrpy3nnjDBZhmCg7IghCcLBdPiYq9u/xyHKH0CX+bsoWjh9F6MvkaIJiRq/tEsSUNHGS3Xe0Kq6Mebj0XdqXI3GD9oSHCQyR9QjtLxwRlkWlcaFF3A2E5ML51odzQokMorxBnFBVIQq0fmy52uqN2/+CC/F4cIflRVpZYUn7hazuzuP4/Yy9WwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Eh8ehZYs5CKZTiO9JNOMSbCxi4CMsACO4XGI2gK8KU=;
 b=okQQdWMc4zMoxbPhq5xkwuKfyKtVpQIeUsespI+FPGi0z4MHVGyX42tgGP0BAPVH8w2XAPMH7ZyS2jRKdEKp/BbE5SVsNVQQ+YBxGFjfMZI6wTCWzQkTxw6OtvuWRXGIqbTW34IN7VJZ13eQ7EXadaTBkbCtBORroszKke8HBQY=
Received: from SJ0PR03CA0163.namprd03.prod.outlook.com (2603:10b6:a03:338::18)
 by IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 19:52:03 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::a8) by SJ0PR03CA0163.outlook.office365.com
 (2603:10b6:a03:338::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 19:52:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:52:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:52:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:52:01 -0600
Received: from hwentlanrmb (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 13:52:01 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 3/4] drm/amd/display: Add support for 2.4 and 2.6 Gamma and
 its Inverse
Date: Thu, 19 Nov 2026 14:51:57 -0500
Message-ID: <20261119195158.2546927-4-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119195158.2546927-1-harry.wentland@amd.com>
References: <20261119195158.2546927-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|IA1PR12MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd851a4-c9bd-4ab2-858d-08df467694ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|6133799003|261009223027099003|18002099003|22082099003|261021123027099003|261021121427099003|261102123227099003|261102130727099003|56012099006|10067099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info: rVnY2YXJ/VK6qpXYmW6Yki48YJLSGCLyN0fZcNs1A5FZIZupk6GEYeua0mHGp2DBdnYtYJ3o2AzqX0U37MYsdVzZFTyhpikvbj0xCgguZ4ZdCmQRCzdZxCFHSrXlnk1/GTWDjS296duOSZ9WV6Z8nrqlLGtCSRKEeNidGSreEPLFP7N+fsZ690CqrnyTUlOTQ2bFWxuGkk55c3r11+TD27mtE8kjX6PakaTjC1SiYRvx0XCjLAVv2G/jSDPs2dD2SMN2CWYURTtLhsRmrW8CBSnXXuLmAEVyY8WvlTg9KtLbNDpzLXUdcT3fvUCI46v6B4RDKq8TFaFHEwRg8iofGvoGGQLyf9Ska9GTkU/8rHIDnnealO7egabuC808aYTvoP1zoyr8rOo/kKIUmGQ/0Fe0xo6yisX3C2/hd5/A3uaUfRhhzzgBP8XBz60qbiPlevM/l0shYW8WoNdRf58V7cLzRxXSzBdLH3f+0OSJGPQPsRrDeGwQirrjBPaSK8vlZwML8ViaVx5JYzyTPArpKdrsWaJ1y28keFONcfG1d7+HACZadwkdBY7+DZIwEyUTcYG7eNfZ0mPixAC+DiK4KiCopAHmQzrujwUGTKI05I+MWmnqPISbd8KIuGd98PCrx40hNSFLK6Or83kXNqaUiG/jyX5vNYum9ICv5JvzOKum0bH9GuDj0atK3g4CTmrfG2U6PztgsGb7EnKA9lspvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(6133799003)(261009223027099003)(18002099003)(22082099003)(261021123027099003)(261021121427099003)(261102123227099003)(261102130727099003)(56012099006)(10067099003)(261026121527099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WxCFseU+UPV7HFe+5e0cP/vgfI/VndjQX0I7g722E3NDX5MedyqH++z+/5PW/iWM036mNWSCur8Xe4SKeJOckbDvvRHDUTCWmiYIrFqzAlPp1AKMORoCTDCrljdhZhObdDszG6JzLFtP4IURGLuR2Yw73pt5MN4u2aneIuU0hZqin5AmbCII7qyh9Fn9K9EL4239AveG85kVl/oIp1hZfscNOx6FviiihsEP2HrkfARCjH74VKcHKVbNh9eypxeFbWRBhSJLFruMwpzbqiZpIywC9MdZSFn9ZZpGTt3Mgf20jMYi2AM4QGpAdJgctigemDcuSH9slBNIUuj2tTPBkkf4fY2yqlEGHR0uvgPCxsFdhs598t/mhafYNA5RLr8xDUExJPrEeQZNmVq6DN0hzKQnEr1YkeSfDhBHGZQaYc4sZ7Fy7WyLv3hDLmnJWgM0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:52:02.7281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd851a4-c9bd-4ab2-858d-08df467694ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068
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

Wire up the newly defined Gamma 2.4 and Gamma 2.6 curve types in the
amdgpu DM color pipeline. Map them to the corresponding DC transfer
functions and advertise them in the supported degamma, shaper, and
blend transfer function masks.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c  |  6 ++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c    | 12 +++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 45cea72111c7..c4df67aa421e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -945,6 +945,12 @@ amdgpu_colorop_tf_to_dc_tf(enum drm_colorop_curve_1d_type tf)
 	case DRM_COLOROP_1D_CURVE_GAMMA22:
 	case DRM_COLOROP_1D_CURVE_GAMMA22_INV:
 		return TRANSFER_FUNCTION_GAMMA22;
+	case DRM_COLOROP_1D_CURVE_GAMMA24:
+	case DRM_COLOROP_1D_CURVE_GAMMA24_INV:
+		return TRANSFER_FUNCTION_GAMMA24;
+	case DRM_COLOROP_1D_CURVE_GAMMA26:
+	case DRM_COLOROP_1D_CURVE_GAMMA26_INV:
+		return TRANSFER_FUNCTION_GAMMA26;
 	default:
 		return TRANSFER_FUNCTION_LINEAR;
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index d32bf2bf2847..935c041c1d31 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -38,21 +38,27 @@ const u64 amdgpu_dm_supported_degam_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
-	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA22) |
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA24) |
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA26);
 EXPORT_IF_KUNIT(amdgpu_dm_supported_degam_tfs);
 
 const u64 amdgpu_dm_supported_shaper_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
-	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV) |
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA24_INV) |
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA26_INV);
 EXPORT_IF_KUNIT(amdgpu_dm_supported_shaper_tfs);
 
 const u64 amdgpu_dm_supported_blnd_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
-	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA22) |
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA24) |
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA26);
 EXPORT_IF_KUNIT(amdgpu_dm_supported_blnd_tfs);
 
 #define MAX_COLOR_PIPELINE_OPS 10
-- 
2.56.1

