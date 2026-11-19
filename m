Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF362606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VutFSo+f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FDB112607;
	Thu, 19 Nov 2026 15:54:49 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80ED1125B4;
 Thu, 19 Nov 2026 15:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFE7o2FSmiqyKS5ujkbKkkyJzYfP8zSIG6iDw+mEm+1CfXxW4RTONAbp8y+u75K48lT7cM6/GLz0+pei4UnSO7P2ngm9DJeBhsrJbhl9ZHO2rcm05TydcP+FGQ28DZdugpgwBE9LrYWETCgv5vozvPMLNuAXX238PpGLm3cSl5fikRfRR4kwZzVnYS9cSGfIqMlyLLowt80KfPCMiwalGp/Ho5bPzwVs7sD/CN6nGrNyx5veCQlBdiO1I8OgvCH0ZWu9izQf+jd97uUky9nW5ndDHIzNumOxhvdfIEz+41u4fsj1Qga9wlc9Ly4suAkkYAe2V6LneNhk+otW9cA+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Eh8ehZYs5CKZTiO9JNOMSbCxi4CMsACO4XGI2gK8KU=;
 b=Tq1MI/zVZDjDksve19Kc/8SyRB5OvC+kofQoa+HTFYUqCqMvff/2u7WwRtMwqAAFvVBuR4mhivewISmdCafdigAymSx9O7NOpT/fWNovmVbUXBD7xt00vsYf94uwqnfzyLuPGXJfTFCOdjkUI7cxQ4k/UA42uU33mhY0HTXycjvFfg21BJmnDPallM/DgQuUVLgx73rgHkBmhonbWRdtZ7mhol3RjJXBYbjyAlY0dEU3zN5gfew22RkqO1p2McocolJwF1V3KQ96t59b4UVoAtFdI95+AkB6L9gjol+6jd2KvJ7XkFk0zeJhYPI/tHBd+UtTTjIj5zjptVQODW186g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Eh8ehZYs5CKZTiO9JNOMSbCxi4CMsACO4XGI2gK8KU=;
 b=VutFSo+fd+Uvgs2rts7Ztmenvp4nap1XkpsLAWBdN06pHmJFmHzJME8aP7jYhXK4eY1uxqHPZn/idsfvPXuVRjpgf1JLIr3NkHk5vtUKI1r4rk/lepcd76XW7RpNuE32mB3HRG4nxIDSpuHgj1A/B5yhGpERMVBgR4Pw3JAdvgc=
Received: from PH7P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::10)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 15:54:38 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::37) by PH7P221CA0007.outlook.office365.com
 (2603:10b6:510:32a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 15:54:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 15:54:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 09:54:37 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 09:54:37 -0600
Received: from hwentlanrmb (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 09:54:37 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 3/4] drm/amd/display: Add support for 2.4 and 2.6 Gamma and
 its Inverse
Date: Thu, 19 Nov 2026 10:54:26 -0500
Message-ID: <20261119155427.2494007-4-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119155427.2494007-1-harry.wentland@amd.com>
References: <20261119155427.2494007-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 65eb4b73-2ab6-44c4-5b33-08df46556a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|10067099003|11063799006|261021121427099003|261021123027099003|261102130727099003|261009223027099003|261102123227099003|261026121527099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: L7ssnS4cylaJt+oRYaPBD72xmkcE9BcDaRalOHZrt+76ej4qnMXQO+icEzDYjae8Q9HD8XJ4/pbSJrrZUAxg8gVs5uwyR8NN/cIDPtM8rZFxWFsnppa9AUoTdPNgmDnRYWDcqn8Z9gBMUyy63NPElUwbjbSKyABBZufdhiKdcIWxmzg61n/fdjRuuGSQa9BTtImk+gJJHhboROZ/I9KLFs6KGGP8PUyTRWn1+3VMjGGm4obqlUQESNF87uIM89X44M9bZUukDBP00viI5ktkbCQzMdq1mdvyH5IYS7xSXV+ja7At1uqdaFq963qw50GyLFj+lZUNI5buDw9LY5fuKA6gauVkuzhNd34dJ8Sp43e1+tYdCRv5bvQPzj2zLfk1WOnjcARpISzGFlPim/AFVnumWQnMl5KdwYulbhJiaZ47D/bLCcstQx9GTy6hZX5GUuKWbgSWIXTN6j223XmGSlNn3OCbD7s/Jp4AKG+N6aYuYMtL7RUhV8MpjqqLbnFTkFgWLvwg0Qi1mBDwV6rtWV/bduMpaWKbYf0+n1xQl9rAebRCcPu+0SoDtIiWrR4vn3rwUGGY7YDQZufoUAr+SWbExXfpAI7IlJX3uzsxnSM/iYLCXJd3/lDnIx9ra6URBCChCVm07yfNZ/HNkmoTn68XWMl4u1yQp+/3o4CPIXb3/sofuXZk9BY8iQE4apzXzD2/gFnqKucfvokI8/tJiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(10067099003)(11063799006)(261021121427099003)(261021123027099003)(261102130727099003)(261009223027099003)(261102123227099003)(261026121527099003)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 77eyMq6VKV6kAv8CWztNXjVv7VQF7tbzsWCoLmR1+LXN8MM0vH5i0Mw82qZbBgulPYmColGzeJv6cr6d3kjmqvEICGNOkgAKo9wmUwZYX7oVnVRdX4Oi39WGyMJdlqKX1pXhXPrL06rlfry1R8JojZWqMVf6UDxztCV4RvrirPdpu8yH/vFpjcNgmAd0D2fDLmhfpt9zimdBq77h62OQnmiYZZgU5q2GQlpgBvRBDNIypb+EO/eBp4rsfy+SMsDJweGl+ya1pzz9aCoRCaJVXZYWID6CuWS2ekCK8ZPOPAgTxGCku5sJcSTjdoU2a6R1mS4LGmNBgTQJIIEW/GnPhGcMPZprWGPkjxk9HL1x3LRYMe/lHvlDykL3GRVQyU/08rPbZkodwqN4q2m4faDZIBhJQl35x/ci0rVK/bs5c/iuVjIvikIvcEZF8dAp59qv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:54:38.3213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65eb4b73-2ab6-44c4-5b33-08df46556a99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
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

