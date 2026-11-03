Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3EF606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pl2o+BwW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74FA310F8A0;
	Tue,  3 Nov 2026 21:38:31 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B366D10F855;
 Tue,  3 Nov 2026 21:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0YR5OE/yiKaAGOumkoZuO60D4lMvxOcsHy6jVKt2K6ZpUAhp6X9OU+oy/ceuQOKIV7oec/SR5c9PAefyOqCsFAXTqX/dtUHMuIW2Cs4M/BCcQMW2qeoqT9GtUi/eWj/9QMvUJj8xJfL4A242ml2chjr/h/bo3qut2AS5c7r06Wen3zRHyt8mGIvI0oKGZFzg0xSlPBVZT+Ig8RLYADqX3JQo5322eJ368UCxwTWQawMOKe/d481V0q9QX60+Ev7eQZIRf1plC7Gjpx17K1Y02SpIY4HPwNwqdhQEfYxgK/jcb8IagGD+ua7A4QkcX4b7cdxlNLd+ABSbfdEa1lMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwnWWaGGTA+hQ+MUXu0N+hOTalQYSHiNAcawPgicyXk=;
 b=Q5Z652ZThY9C+08PXumjVxvrmrnYImWJkFkyL1tP1EpeosMsxGYXYC7kBmCQtXcioyoBGA6oFucisC0mTCQ93utvtR5JwV5CBFGJUUrwt+tA4TkeIpqWAkol5Rym37gPdqrAvoclQdIhgcb39zOmHaM6aCtEmcr/C8FNgMZ7ilKtjBNxcd7m7eCNFC5qVpnSS+N0hAk8lXjPRPA6Y9tI1GNT0N8DQcW+ahRk4+f+vSNQGp2+r83Sqg+e+t9PYD90NhRKigXKHp/QM997hNFGNek+iJa5qs6XTcndxEg9aorGiJEGHBdtKJJiUlscyLwxBLaIv8HsQNmOCW/hl889ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwnWWaGGTA+hQ+MUXu0N+hOTalQYSHiNAcawPgicyXk=;
 b=pl2o+BwWoNJRXedL5hLfPA3omRIc2SAjPnqtCRLlzGc44BAaSyCmK+D4AGXlE4jyXQAkU1jVmL5bJmj8C7DfTJ+eHkfYGeCmNI6fP03iD9Nw7k/Q7y8L3HPSiWsKgmFSVZegRstzB+F4blVrQJKS+WJk30PYx0F454rXdXQ8G4A=
Received: from BLAPR03CA0127.namprd03.prod.outlook.com (2603:10b6:208:32e::12)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:38:06 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::89) by BLAPR03CA0127.outlook.office365.com
 (2603:10b6:208:32e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:38:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:04 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:04 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 01/13] drm/colorop: Add DRM_COLOROP_3D_LUT_DMA
Date: Tue, 3 Nov 2026 16:37:44 -0500
Message-ID: <20261103213756.618024-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 894f4b03-e088-4e9b-6b4a-08df39f2bf25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|261022105027099003|261026140227099003|11063799006|56012099006|261026121527099003|261009223027099003|261021121427099003|261009221227099003|261102123227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: l13prc4ls12MVyWI1vLWJ/nTmV8lF/FFcf6Nzt2VTgEJspYvMBncb33wypV4via9V2Sih25pMh9bRc98bVLBQmJpsO6U0E3baR1Ew7Qk1nEW+V6C6Q0Fx7GJ1RUt1WP6AXZixC2OUMIF7UIMyAfYjzgPyZqXjDx79GJLhhOzKlMntkhaHFFYyeiNmzF9hAR/2f7II3t0ACSh60eeP23EJYECV2A5iuUQIzfl2vSvAlvdTv1JehoAuaT2Et01/9kUmqZcCHT412N8hQVhGNeHipDFC0oBWBOGeR6CUb7FkA0eRj/+kRzjBLVGb1rhMm7NaB7CKPfGKcK6SlCKRrHkFUp0JHvkinyM53gDLa+agMf/D/KlM5oSzni76JHEHHhPuv1sZG+Gepisbj/Z5weeFal+8g1F+k0zySp8WT8J8HfuOxIT81YTIRtAeTq3aEdt5ZLKJ4DH8W6aRhusCFojqcsDimwDhFsD+9FAEPACe9cDaVhvcUNCeeki5PJ+/P8ANsTMToX8cSMueCpXzZ1/y8FHDsjLpgORdooN9zFf3GQiA4arMlFqU7rGhL08Dy+hiRouOQmanBpflgZPZ2TDnlSNdVLOImzFtiuoTVExxRnOetyEBVoEHTg6SlxUI1Gnzm/OosCZ664Jb/INvgK6a2ERxH87XtgpwT9vczWi24VCsc++TvrgOCG87Wy1ZpYEgz77/BjgaTSNRiTMLHBYjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(261022105027099003)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261009223027099003)(261021121427099003)(261009221227099003)(261102123227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b4FaBPoyRbUsqcpOzTmYe5HY2LIVM6UkS6YdV2SVPizHINY9em9e8FPKt3IE2SqAnNadfOcTfRucUc/Q636PXCHlEKurqXicxRt6kEo4KnBNN3ok9VQFywnizlcQv7elndH4lfPynggEKFVzoKHSn+6mcRMugjAR3B2FL8vSJEO4DkDujbmrOfPHK7JBi0YdsVKV1hSGEc+35R2m+VzBMKTOnoS+ZKpS0ic2RZ/3HO/tlH6UOedxcMacVmxl+sf0BmAgMuiY3hT0YVjATb4h0scjtH94kPRmfWGM4iJlbUcbgwRMEvzbJFl7AaRs9a8u9TtvGRI5HMwrBWRYsEdUamTc65WEMXvn7aCl25TIrvSObICmLO4ktqCWnsToi+WIjZNTAQ8lqD5A1l7WIQf33xyUGRyRIiGZqlzY+E9T9Iem37UPy/oWEDzqYsy5PfRM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:06.1232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 894f4b03-e088-4e9b-6b4a-08df39f2bf25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
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

Add the uAPI for a fast-loading (DMA) 3D LUT colorop. Unlike the existing
DRM_COLOROP_3D_LUT, which carries its data inline in a DATA blob, the DMA
variant references a framebuffer (FB_ID) whose memory the HW DMAs into
its LUT RAM, replacing a large register-write sequence with an address
update.

The accepted buffer formats are advertised via a read-only LUT_3D_FORMATS
blob - an array of the new struct drm_mode_3dlut_mode describing the grid
size, entry encoding (fourcc), memory layout (modifier), row pitch,
traversal order and interpolation.

Removing the LUT framebuffer with RMFB, or closing the DRM file that
owns it, bypasses the colorop and clears FB_ID, so the plane stays
visible without the LUT. CLOSEFB leaves the colorop unchanged.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c |  4 ++
 drivers/gpu/drm/drm_colorop.c     |  2 +
 include/uapi/drm/drm_mode.h       | 79 +++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eebcf6f5e05..aca0edb42a5a 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1374,6 +1374,10 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
  *	If the Atomic Commit request has the DRM_MODE_ATOMIC_TEST_ONLY flag
  *	it will only check if the Sync File is a valid one.
  *
+ *	The fence also covers framebuffers referenced by the plane's colorops,
+ *	such as the FB_ID of a DRM_COLOROP_3D_LUT_DMA colorop. Userspace using
+ *	explicit sync for those merges their fences into IN_FENCE_FD.
+ *
  *	On the driver side the fence is stored on the @fence parameter of
  *	&struct drm_plane_state. Drivers which also support implicit fencing
  *	should extract the implicit fence using drm_gem_plane_helper_prepare_fb(),
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 95da03d6c65c..b30413ad797b 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -69,6 +69,7 @@ static const struct drm_prop_enum_list drm_colorop_type_enum_list[] = {
 	{ DRM_COLOROP_MULTIPLIER, "Multiplier"},
 	{ DRM_COLOROP_3D_LUT, "3D LUT"},
 	{ DRM_COLOROP_FIXED_MATRIX, "Fixed Matrix"},
+	{ DRM_COLOROP_3D_LUT_DMA, "3D LUT DMA"},
 };
 
 static const char * const colorop_curve_1d_type_names[] = {
@@ -688,6 +689,7 @@ static const char * const colorop_type_name[] = {
 	[DRM_COLOROP_MULTIPLIER] = "Multiplier",
 	[DRM_COLOROP_3D_LUT] = "3D LUT",
 	[DRM_COLOROP_FIXED_MATRIX] = "Fixed Matrix",
+	[DRM_COLOROP_3D_LUT_DMA] = "3D LUT DMA",
 };
 
 static const char * const colorop_lu3d_interpolation_name[] = {
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index ed1a660a3dfd..f788ece18d1f 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -967,6 +967,44 @@ enum drm_colorop_type {
 	 */
 	DRM_COLOROP_FIXED_MATRIX,
 
+	/**
+	 * @DRM_COLOROP_3D_LUT_DMA:
+	 *
+	 * enum string "3D LUT DMA"
+	 *
+	 * A 3D LUT whose data is DMA'd from a framebuffer (via the FB_ID
+	 * property) instead of being carried inline in a DATA blob. This lets
+	 * the driver load the LUT with an address update instead of a large
+	 * sequence of register writes.
+	 *
+	 * The accepted buffer formats are advertised via the read-only
+	 * LUT_3D_FORMATS blob property, an array of struct drm_mode_3dlut_mode.
+	 * Userspace selects one entry by index via the LUT_3D_FORMAT property
+	 * and points FB_ID at a matching framebuffer.
+	 *
+	 * Rendering to the LUT framebuffer is synchronized like rendering to a
+	 * plane framebuffer. With implicit sync the commit waits for the write
+	 * fences on the framebuffer's buffer objects. With explicit sync
+	 * userspace merges the fence for the LUT write into the IN_FENCE_FD of
+	 * the colorop's plane. If IN_FENCE_FD is set, implicit write fences on
+	 * the LUT framebuffer are ignored, as they are for the plane framebuffer.
+	 *
+	 * The hardware may read the LUT framebuffer at any time while a colorop
+	 * state referencing it is current, not only for the first frame.
+	 * Userspace must not write to a LUT framebuffer while it is attached. To
+	 * change the LUT, write a different framebuffer and point FB_ID at it.
+	 * The old framebuffer can be reused once the commit that replaced it has
+	 * completed, e.g. after its flip event or OUT_FENCE_PTR fence.
+	 *
+	 * Removing the LUT framebuffer with RMFB, or closing the DRM file that
+	 * owns it, clears FB_ID and sets BYPASS on every colorop using it, so
+	 * the plane is shown without the LUT. Re-enabling the colorop requires
+	 * a new FB_ID. CLOSEFB leaves the colorop unchanged. Closing the GEM
+	 * handle or a DMA-BUF file descriptor of the LUT buffer does not affect
+	 * the framebuffer.
+	 */
+	DRM_COLOROP_3D_LUT_DMA,
+
 };
 
 /**
@@ -981,6 +1019,47 @@ enum drm_colorop_lut3d_interpolation_type {
 	DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
 };
 
+/**
+ * enum drm_colorop_lut3d_traversal_order - cube axis enumeration order
+ *
+ * The order in which a 3D LUT's entries are to be traversed.
+ */
+enum drm_colorop_lut3d_traversal_order {
+	/**
+	 * @DRM_COLOROP_LUT3D_TRAVERSAL_RGB:
+	 *
+	 * R varies fastest, then G, then B (B slowest).
+	 */
+	DRM_COLOROP_LUT3D_TRAVERSAL_RGB,
+};
+
+/**
+ * struct drm_mode_3dlut_mode - fast-loadable 3D LUT format
+ * @lut_size: number of entries along one cube edge (e.g. 17 for a 17^3 LUT)
+ * @format: DRM fourcc describing the encoding of a single entry
+ * @modifier: DRM format modifier describing how the entries are laid
+ *	out in memory (e.g. DRM_FORMAT_MOD_LINEAR)
+ * @pitch: row stride in bytes
+ * @traversal_order: enum drm_colorop_lut3d_traversal_order describing how
+ *	entries are traversed
+ * @interpolation: enum drm_colorop_lut3d_interpolation_type specifying how
+ *	the HW interpolates between entries
+ * @flags: reserved, must be zero
+ *
+ * One entry of a &DRM_COLOROP_3D_LUT_DMA colorop's read-only LUT_3D_FORMATS
+ * blob. Userspace selects an entry by index via the LUT_3D_FORMAT property
+ * and points FB_ID at a matching framebuffer.
+ */
+struct drm_mode_3dlut_mode {
+	__u32 lut_size;
+	__u32 format;
+	__u64 modifier;
+	__u32 pitch;
+	__u16 traversal_order;
+	__u16 interpolation;
+	__u32 flags;
+};
+
 /**
  * enum drm_colorop_lut1d_interpolation_type - type of interpolation for 1D LUTs
  */
-- 
2.56.0

