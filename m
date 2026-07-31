Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D59C55175
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E0D10F394;
	Fri, 31 Jul 2026 18:15:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fTR5bBEI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 699F810F388;
 Fri, 31 Jul 2026 18:15:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffmlNpOSkWF1DxVuHRlfBo66wevHJfPUtvrbDdLP+kdaPvpr+HQKtNnaUdHOEK14GLVcdJtYeypyI4xIWUSke2x8nSwy8pLIgL4MfTBxnGeVB7lgCOqvOHUgbIwdOx/ITop7FS3A/PYMIVpVD+GLB0OeV4pjGOra5/M0/stY29aTadHOiiYMLgIFQm/xsqS4NEaYQw8jVzwPlkulqAj2he5yN2BduZRa7TJcFXPRf79sV+RnKgH/sELwiYbe/uqZvceIuelB0i6Ip6S2XOdug6iA7C1KHSHJz9sfmD1kjT9jZjsKgSl8UGFevLYrOdVjl0Cd57VSQMdzPkMM2M068Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dXwXGxs0XoNeCV6kj6eyhsV/3jB2tgJnWk7rl1DXjM=;
 b=G9+7m1I3eGwFEq0Kqh7/ve+Jz1Z6+dczMr7EAQiVkcgX+3wzoUluARxmLNzNOKk2jvFXZLx72nxF924ROl+/iYn3rdFEQ+UBKBFwdBd5DjQkFFwFEFQiE5hTozrs4I81rdo4sSa1EGkRj+bi3dwQKKsJwGTyu0XbOGzUMtyD7ft0TBOaFujE6ZCWx6VmB1qo8xB75DQ3+9lCh+a6lkOGcgQDE2/M/WIbraNOJyyya2VahSqu//SqyF9bQA/k1F2Xg8xEpOyGZqWrfVdq9truNT55BMQK3qqmjCLDp6GOP0oDdD3b0BFrgqWAIbm8XyKffkXJk2nPu5O1OfDES+kUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dXwXGxs0XoNeCV6kj6eyhsV/3jB2tgJnWk7rl1DXjM=;
 b=fTR5bBEIrR/Dbre2lsoSjDZqyFBJhsbyVqOvNUsuDA8l6smu9BsSmo/89scyiwWkcIajXVhm0EZX/gIPRtVldpfLNbz3AClB5F7YkLg720zNSeU3rcGmWBWWl0RfxMLBibmNlUvPfMKapjuWKcvYWD9jX+Hd4ZrCgUkvJLof7Zc=
Received: from MN2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:208:236::23)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:15:28 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::89) by MN2PR05CA0054.outlook.office365.com
 (2603:10b6:208:236::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.11 via Frontend Transport; Fri,
 31 Jul 2026 18:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 18:15:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:26 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 13:15:25 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>, Harry Wentland
 <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>, Robert Mader
 <robert.mader@collabora.com>, Alex Hung <alex.hung@amd.com>, Pekka Paalanen
 <pekka.paalanen@collabora.com>
Subject: [PATCH v5 01/10] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
Date: Fri, 31 Jul 2026 14:15:12 -0400
Message-ID: <20260731181521.681990-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731181521.681990-1-harry.wentland@amd.com>
References: <20260731181521.681990-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 15948657-e44f-48b8-bfb7-08deef2fb311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CkQwFuZ88d5e5UkTvXU2D+Uwd9E7PDlu5uolTiJTlV90lCtXTTGVk4uI0CvH14fOppkgyIHC7HEIIVkjJYCse5uDOwkDPzniQcF1ZNPHTFlmS0Z7kZQT0mdicK04dqr9hbZq8JXQuRY+cnk9Eru9Obd4RSkcDXPrFXP5uOWzKvrVkDhYJNMEM4nYWqshjGpeCKQnRAqKt5bH6KdmVVggmtFGW2Zp1hwuaMQiYD9mxjRQvYrny8EHADMhJUcoeQrrwq+mMbWb14pyirySSvXZAUO/8tlVm7zQhExp2eMFMNFNHD4vPHUanE4ZoIvYOCwhzyMHeT87Yt5Hp6/r5XDifmpuULtIPLUdSa7EP1v+gf05rOZaaI/rJqK9YYYoCJrjSzeOPgHPGSa1V7wdwNNx7/RuDSeFAYWuI8MfA4+Z6SYqX2kuYT8GI5Ayj28bbBrshW2QW/GnNll2O2DOZVzRtFufYaPbQ7L3tyiQ17ac9z5/W7d8xaYVbzXxVPt6QbdGfJWGWvJM0+9cwIzYNw13Owz4ydVUuY+usKM02+zxUxI53m0j+OWG2l+iz3akX9bBv22GoIO/n5kHNJOQfA0vrv/PXaTD/RNLQoSsDomRwI8bpqciLugpZAo5stQi49/0LJA51RXEjH2ZG9gs7MSNz+3naSKHcEwibiz/EhSX+6iaZ9I7W44FfDcHmhUv7pViBDq2aRhmeN+8+260A+o95Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MT0x/OYdBC/PywlwFeX/G1IxigvK/Ngc9HOAZm2nCtjYdWE/IPydtjEE/ftPBE0SNlyZY/YsKAM6s+pwfJtD1UMrbc6XfQ2NE4LkYQSR7rVrcfUYSPQlQv74V87bPI6zfvYq3ubsb6gZsfDZ9CPg4dsfHiIkAPbCAWY5LSlaovgwURIUtlpbOusGqG8EQFYIxSxN/BthzAQ4yu42O4yHChZuZzC1C4o/71IkPiJuZw7osQZNQEvQcZgWNouRcEffCU25v0KZGTfkj9HVXzOaGZitbYPS2jXuNlPz+YecQay+vMqxbwYf4ux+wzhy8pa2EQrFnrIMuwzXpGEyslcMopC1ZG/XjdO24kHww+RPfjQAFOVC0ysfNFB8ymrrIuyq7KhC335VCUhlSUVQ4UHlRRJQ9XYb3zamILGWAomFq4BSw4DlnmH2WoKDKuvMIYWx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:15:27.9557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15948657-e44f-48b8-bfb7-08deef2fb311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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

From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

Introduce DRM_COLOROP_FIXED_MATRIX, a new colorop type representing a
hardware that performs a fixed matrix operation.

Unlike CTM-based colorops, this block does not expose programmable
coefficients. Instead, userspace selects one of the predefined
hardware modes via a new FIXED_MATRIX_TYPE enum property. Supported modes
include common YCbCr->RGB and RGB709->RGB2020 conversions.

v5:
 - Drop YCbCr limited to full and RGB709 to RGB2020 matrices
   until we have non-IGT userspace that shows their use (Robert)

v4:
 - Add limited-range YCbCr-RGB conversion matrix enums (Robert)
 - Document matrix values (Pekka)
 - Clarify RGB709 to RGB2020 is a full-range matrix (Pekka)
 - Fix confusing "CSC preset" doc (Pekka)

v2:
 - Naming changes (Pekka)

v3:
 - Fix NC matrix enum name and string (Melissa)
 - Rebase

Co-developed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Robert Mader <robert.mader@collabora.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---
 drivers/gpu/drm/drm_atomic.c      |   4 +
 drivers/gpu/drm/drm_atomic_uapi.c |   7 ++
 drivers/gpu/drm/drm_colorop.c     | 107 +++++++++++++++++++++++++
 include/drm/drm_colorop.h         | 127 ++++++++++++++++++++++++++++++
 include/uapi/drm/drm_mode.h       |  12 +++
 5 files changed, 257 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index e5c8ef06caed..45df6376f408 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -925,6 +925,10 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 				  drm_get_colorop_lut3d_interpolation_name(state->lut3d_interpolation));
 		drm_printf_indent(p, 1, "data blob id=%d\n", state->data ? state->data->base.id : 0);
 		break;
+	case DRM_COLOROP_FIXED_MATRIX:
+		drm_printf_indent(p, 1, "fixed_matrix_type=%s\n",
+				  drm_get_colorop_fixed_matrix_type_name(state->fixed_matrix_type));
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1050dddadb17..d52504d823bc 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -786,6 +786,11 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
 		return drm_atomic_color_set_data_property(colorop, state,
 							  property, val,
 							  replaced);
+	} else if (property == colorop->fixed_matrix_type_property) {
+		if (state->fixed_matrix_type != val) {
+			state->fixed_matrix_type = val;
+			*replaced = true;
+		}
 	} else {
 		drm_dbg_atomic(colorop->dev,
 			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
@@ -818,6 +823,8 @@ drm_atomic_colorop_get_property(struct drm_colorop *colorop,
 		*val = state->lut3d_interpolation;
 	else if (property == colorop->data_property)
 		*val = (state->data) ? state->data->base.id : 0;
+	else if (property == colorop->fixed_matrix_type_property)
+		*val = state->fixed_matrix_type;
 	else
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 682fcc651525..95da03d6c65c 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -68,6 +68,7 @@ static const struct drm_prop_enum_list drm_colorop_type_enum_list[] = {
 	{ DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
 	{ DRM_COLOROP_MULTIPLIER, "Multiplier"},
 	{ DRM_COLOROP_3D_LUT, "3D LUT"},
+	{ DRM_COLOROP_FIXED_MATRIX, "Fixed Matrix"},
 };
 
 static const char * const colorop_curve_1d_type_names[] = {
@@ -90,6 +91,15 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
 	{ DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
 };
 
+static const char * const colorop_fixed_matrix_type_names[] = {
+	[DRM_COLOROP_FM_YCBCR601_FULL_RGB] = "YCbCr 601 Full to RGB",
+	[DRM_COLOROP_FM_YCBCR601_LIMITED_RGB] = "YCbCr 601 Limited to RGB",
+	[DRM_COLOROP_FM_YCBCR709_FULL_RGB] = "YCbCr 709 Full to RGB",
+	[DRM_COLOROP_FM_YCBCR709_LIMITED_RGB] = "YCbCr 709 Limited to RGB",
+	[DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] = "YCbCr 2020 NC Full to RGB",
+	[DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB] = "YCbCr 2020 NC Limited to RGB",
+};
+
 /* Init Helpers */
 
 static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *colorop,
@@ -453,6 +463,80 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
 }
 EXPORT_SYMBOL(drm_plane_colorop_3dlut_init);
 
+/**
+ * drm_plane_colorop_fixed_matrix_init - Initialize a DRM_COLOROP_FIXED_MATRIX
+ *
+ * @dev: DRM device
+ * @colorop: The drm_colorop object to initialize
+ * @plane: The associated drm_plane
+ * @funcs: control functions for the new colorop
+ * @supported_fm: A bitfield of supported drm_colorop_fixed_matrix_type enum values,
+ *               created using BIT(fixed_matrix_type) and combined with the OR '|'
+ *               operator.
+ * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
+ * @return zero on success, -E value on failure
+ */
+int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct drm_colorop *colorop,
+					struct drm_plane *plane,
+					const struct drm_colorop_funcs *funcs,
+					u64 supported_fm, uint32_t flags)
+{
+	struct drm_prop_enum_list enum_list[DRM_COLOROP_FM_COUNT];
+	int i, len;
+	struct drm_property *prop;
+	int ret;
+
+	if (!supported_fm) {
+		drm_err(dev,
+			"No supported FM type op for new Fixed Matrix colorop on [PLANE:%d:%s]\n",
+			plane->base.id, plane->name);
+		return -EINVAL;
+	}
+
+	if ((supported_fm & -BIT(DRM_COLOROP_FM_COUNT)) != 0) {
+		drm_err(dev, "Unknown Fixed Matrix provided on [PLANE:%d:%s]\n",
+			plane->base.id, plane->name);
+		return -EINVAL;
+	}
+
+	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_FIXED_MATRIX, flags);
+	if (ret)
+		return ret;
+
+	len = 0;
+	for (i = 0; i < DRM_COLOROP_FM_COUNT; i++) {
+		if ((supported_fm & BIT(i)) == 0)
+			continue;
+
+		enum_list[len].type = i;
+		enum_list[len].name = colorop_fixed_matrix_type_names[i];
+		len++;
+	}
+
+	if (WARN_ON(len <= 0))
+		return -EINVAL;
+
+	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC, "FIXED_MATRIX_TYPE",
+					enum_list, len);
+
+	if (!prop)
+		return -ENOMEM;
+
+	colorop->fixed_matrix_type_property = prop;
+	/*
+	 * Default to the first supported CSC mode as provided by the driver.
+	 * Intuitively this should be something that keeps the colorop in pixel bypass
+	 * mode but that is already handled via the standard colorop bypass
+	 * property.
+	 */
+	drm_object_attach_property(&colorop->base, colorop->fixed_matrix_type_property,
+				   enum_list[0].type);
+	drm_colorop_reset(colorop);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_plane_colorop_fixed_matrix_init);
+
 static void __drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop,
 							struct drm_colorop_state *state)
 {
@@ -533,6 +617,13 @@ static void __drm_colorop_state_init(struct drm_colorop_state *colorop_state,
 							   &val))
 			colorop_state->lut3d_interpolation = val;
 	}
+
+	if (colorop->fixed_matrix_type_property) {
+		if (!drm_object_property_get_default_value(&colorop->base,
+							   colorop->fixed_matrix_type_property,
+							   &val))
+			colorop_state->fixed_matrix_type = val;
+	}
 }
 
 /**
@@ -596,6 +687,7 @@ static const char * const colorop_type_name[] = {
 	[DRM_COLOROP_CTM_3X4] = "3x4 Matrix",
 	[DRM_COLOROP_MULTIPLIER] = "Multiplier",
 	[DRM_COLOROP_3D_LUT] = "3D LUT",
+	[DRM_COLOROP_FIXED_MATRIX] = "Fixed Matrix",
 };
 
 static const char * const colorop_lu3d_interpolation_name[] = {
@@ -652,6 +744,21 @@ const char *drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_inte
 	return colorop_lu3d_interpolation_name[type];
 }
 
+/**
+ * drm_get_colorop_fixed_matrix_type_name: return a string for fixed matrix type
+ * @type: fixed matrix type to compute name of
+ *
+ * In contrast to the other drm_get_*_name functions this one here returns a
+ * const pointer and hence is threadsafe.
+ */
+const char *drm_get_colorop_fixed_matrix_type_name(enum drm_colorop_fixed_matrix_type type)
+{
+	if (WARN_ON(type >= ARRAY_SIZE(colorop_fixed_matrix_type_names)))
+		return "unknown";
+
+	return colorop_fixed_matrix_type_names[type];
+}
+
 /**
  * drm_colorop_set_next_property - sets the next pointer
  * @colorop: drm colorop
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 224fae40ed2b..26ef67c835e2 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -134,6 +134,114 @@ enum drm_colorop_curve_1d_type {
 	DRM_COLOROP_1D_CURVE_COUNT
 };
 
+/**
+ * enum drm_colorop_fixed_matrix_type - type of Fixed Matrix
+ *
+ * Describes a Fixed Matrix operation to be applied by the DRM_COLOROP_FIXED_MATRIX
+ */
+enum drm_colorop_fixed_matrix_type {
+	/**
+	 * @DRM_COLOROP_FM_YCBCR601_FULL_RGB:
+	 *
+	 * enum string "YCbCr 601 Full to RGB"
+	 *
+	 * Converts full-range YCbCr into full-range RGB using the BT.601
+	 * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
+	 * at 0 (the nominal 0.5 offset removed) before the matrix::
+	 *
+	 *   | R |   | 1.0   0.000000   1.402000 |   | Y  |
+	 *   | G | = | 1.0  -0.344136  -0.714136 | x | Cb |
+	 *   | B |   | 1.0   1.772000   0.000000 |   | Cr |
+	 */
+	DRM_COLOROP_FM_YCBCR601_FULL_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
+	 *
+	 * enum string "YCbCr 601 Limited to RGB"
+	 *
+	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
+	 * the BT.601 coefficients. Before the matrix Y is offset by 16/255
+	 * and Cb, Cr are centered at 0, following the studio-range
+	 * convention of ITU-R BT.601::
+	 *
+	 *   | R |   | 1.164384   0.000000   1.596027 |   | Y - 16/255 |
+	 *   | G | = | 1.164384  -0.391762  -0.812968 | x | Cb         |
+	 *   | B |   | 1.164384   2.017232   0.000000 |   | Cr         |
+	 */
+	DRM_COLOROP_FM_YCBCR601_LIMITED_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR709_FULL_RGB:
+	 *
+	 * enum string "YCbCr 709 Full to RGB"
+	 *
+	 * Converts full-range YCbCr into full-range RGB using the BT.709
+	 * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
+	 * at 0 (the nominal 0.5 offset removed) before the matrix::
+	 *
+	 *   | R |   | 1.0   0.000000   1.574800 |   | Y  |
+	 *   | G | = | 1.0  -0.187324  -0.468124 | x | Cb |
+	 *   | B |   | 1.0   1.855600   0.000000 |   | Cr |
+	 */
+	DRM_COLOROP_FM_YCBCR709_FULL_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
+	 *
+	 * enum string "YCbCr 709 Limited to RGB"
+	 *
+	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
+	 * the BT.709 coefficients. Before the matrix Y is offset by 16/255
+	 * and Cb, Cr are centered at 0, following the studio-range
+	 * convention of ITU-R BT.709::
+	 *
+	 *   | R |   | 1.164384   0.000000   1.792741 |   | Y - 16/255 |
+	 *   | G | = | 1.164384  -0.213249  -0.532909 | x | Cb         |
+	 *   | B |   | 1.164384   2.112402   0.000000 |   | Cr         |
+	 */
+	DRM_COLOROP_FM_YCBCR709_LIMITED_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
+	 *
+	 * enum string "YCbCr 2020 NC Full to RGB"
+	 *
+	 * Converts full-range YCbCr into full-range RGB using the BT.2020
+	 * non-constant luminance coefficients. Y is normalized to [0, 1]
+	 * and Cb, Cr are centered at 0 (the nominal 0.5 offset removed)
+	 * before the matrix::
+	 *
+	 *   | R |   | 1.0   0.000000   1.474600 |   | Y  |
+	 *   | G | = | 1.0  -0.164553  -0.571353 | x | Cb |
+	 *   | B |   | 1.0   1.881400   0.000000 |   | Cr |
+	 */
+	DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
+	 *
+	 * enum string "YCbCr 2020 NC Limited to RGB"
+	 *
+	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
+	 * the BT.2020 non-constant luminance coefficients. Before the matrix
+	 * Y is offset by 16/255 and Cb, Cr are centered at 0, following the
+	 * studio-range convention of ITU-R BT.2020::
+	 *
+	 *   | R |   | 1.164384   0.000000   1.678674 |   | Y - 16/255 |
+	 *   | G | = | 1.164384  -0.187326  -0.650424 | x | Cb         |
+	 *   | B |   | 1.164384   2.141772   0.000000 |   | Cr         |
+	 */
+	DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_COUNT:
+	 *
+	 * enum value denoting the size of the enum
+	 */
+	DRM_COLOROP_FM_COUNT
+};
+
 /**
  * struct drm_colorop_state - mutable colorop state
  */
@@ -197,6 +305,13 @@ struct drm_colorop_state {
 	 */
 	enum drm_colorop_lut3d_interpolation_type lut3d_interpolation;
 
+	/**
+	 * @fixed_matrix_type:
+	 *
+	 * Type of Fixed Matrix operation.
+	 */
+	enum drm_colorop_fixed_matrix_type fixed_matrix_type;
+
 	/** @state: backpointer to global drm_atomic_commit */
 	struct drm_atomic_commit *state;
 };
@@ -366,6 +481,13 @@ struct drm_colorop {
 	 */
 	struct drm_property *data_property;
 
+	/**
+	 * @fixed_matrix_type_property:
+	 *
+	 * Sub-type for DRM_COLOROP_FIXED_MATRIX type.
+	 */
+	struct drm_property *fixed_matrix_type_property;
+
 	/**
 	 * @next_property:
 	 *
@@ -422,6 +544,10 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
 				 uint32_t lut_size,
 				 enum drm_colorop_lut3d_interpolation_type interpolation,
 				 uint32_t flags);
+int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct drm_colorop *colorop,
+					struct drm_plane *plane,
+					const struct drm_colorop_funcs *funcs,
+					u64 supported_fm, uint32_t flags);
 
 struct drm_colorop_state *
 drm_atomic_helper_colorop_create_state(struct drm_colorop *colorop);
@@ -480,6 +606,7 @@ drm_get_colorop_lut1d_interpolation_name(enum drm_colorop_lut1d_interpolation_ty
 
 const char *
 drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_interpolation_type type);
+const char *drm_get_colorop_fixed_matrix_type_name(enum drm_colorop_fixed_matrix_type type);
 
 void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_colorop *next);
 
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index bd435effdcee..ed1a660a3dfd 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -955,6 +955,18 @@ enum drm_colorop_type {
 	 *         color = lut3d[index]
 	 */
 	DRM_COLOROP_3D_LUT,
+
+	/**
+	 * @DRM_COLOROP_FIXED_MATRIX:
+	 *
+	 * enum string "Fixed Matrix"
+	 *
+	 * A Colorop block that performs a pre-defined matrix operation selected
+	 * via the FIXED_MATRIX_TYPE enum property. The driver advertises the supported
+	 * operations through this property.
+	 */
+	DRM_COLOROP_FIXED_MATRIX,
+
 };
 
 /**
-- 
2.55.0

