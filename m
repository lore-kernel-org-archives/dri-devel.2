Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62187C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 21:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BADF610F766;
	Fri, 14 Aug 2026 21:18:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lMZerUje";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D51C10F75E;
 Fri, 14 Aug 2026 21:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOwEyDyDMbclKqiOU/3AO0/ZaPJ6BdLcgDtng3ZwSD5hxoedEfoEYvo99kQd34/0lAUXjksCu6GNubBkZyZZDa+R7+UCiND1qZ5PL27+ulq+6hJ5mUfsnBkoq6/q68jTcgeLJQ0dpWFkBwtZrMt/A2pdUTRmov10vMGNhBZj29jN9j6FUNwuftDddswfjM+NIz8dvK7lVCqQuEaz1Uje+vYBYanEmXtYpsX9uJ3Ag4Ovtgl4hBdWPPdyUZuyuuNo24L+uvZIYaNSPXqktmfzrXCkrNU0LhaDooaS5aWqbOVW/0Rw4ZQZhB+6n6BbhSatx3M5qrM6q2HSFMjrcDnP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dXwXGxs0XoNeCV6kj6eyhsV/3jB2tgJnWk7rl1DXjM=;
 b=RHuja0EeM5tmnSEx0ObKQIP69o6xgOMq48wQ123TLfECxJVdq4Awxr8GaVucO+EHIe2de5jvC/Lf3kA3nPDzwjxGMTwcpIkefXFSmXO3dcj3DoARYeM1JqqnShJLifTpIhnVpFqfgggCJirfdDTQ+rr8OWVidq8By9l/L1su1sn/b9OTIyv9gGDBz3MydxW/Oo3rB7z0U7Z9G8wNQ/UXAqLq8vnIyFLs7SO8oRVdUwo/eJpWl9tWHR1fOWzdfwUFjP1P+2iO0KGXZsokuZ1ReNbDjCJ2nKfgvpxb/HUBNL8esA8Q3eemGVKz+i7SutFs1k8uImOC2dMU/DpRnGhkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dXwXGxs0XoNeCV6kj6eyhsV/3jB2tgJnWk7rl1DXjM=;
 b=lMZerUjetY2t/uyVVXjD9N8wqMhoTeQW+xWCO0uemu11XGDnh6K30k7rwHk3XPRjQpWtwV/H+OlL39alKJ9CVCEZwFAn6QgYLs4Gn4UnBF8mhahF5n3x3eoUwnr02LRsr8EGO8/ts0LhXBnKwAnl39bagAgukaEFZ7nRQS+zqtU=
Received: from SJ0PR03CA0251.namprd03.prod.outlook.com (2603:10b6:a03:3a0::16)
 by LV8PR12MB9692.namprd12.prod.outlook.com (2603:10b6:408:295::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:18:22 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::75) by SJ0PR03CA0251.outlook.office365.com
 (2603:10b6:a03:3a0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:18:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:19 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:18:18 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>, Harry Wentland
 <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>, Robert Mader
 <robert.mader@collabora.com>, Alex Hung <alex.hung@amd.com>, Pekka Paalanen
 <pekka.paalanen@collabora.com>
Subject: [PATCH v6 01/10] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
Date: Fri, 14 Aug 2026 17:18:07 -0400
Message-ID: <20260814211816.1219597-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814211816.1219597-1-harry.wentland@amd.com>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|LV8PR12MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e0b485-36d2-44da-a62e-08defa4991f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3+WGtp3ghBhXUx6IjjMCHcF+ZJah8uNWM8XuQCJfiRUdiHR9CQUQRzh2WNfdmSUQRcRze8mpK0vFiwtXjmLWYJ/3mYnj5wi/yobmM5Qut7Zrl9n0Og/lo6vIjhbS85b4qcKPOsPbNUXF5VXFVJho1e44nXV6fDUxd+vR+NrG4H0sAwwCLrB/f+T90IZQPCD89uobbrztT3VhNuuZdbGsYDCcmSHsVsi6IT00ZVMEap8y5+tMkjjB/VHkPg376trXEmYYEBZe/Mg5u4IIyaiwNklHqnGT2UMhw2gf1d/gJdkNX97hlMd5FflceSm5VY2abGR4BIaQKFtwOFcvIIjgakNSXl9NO7HEkAMO1+e3fXayjnLZsbDC2vnrxKOpeN89bZ8LUGp614AY03xasoCOwl1PnZeYaxSi/w17ZrdQbpca23cRVC2P+9+lICD2BczbeCw8xg0S0W5lhAxld7944ZvE0g7RxwtskWOLr7oFwXDPsPHEumieJeMzYnYDPNOn9ZjpUrcNiaGvBLwNp1KDxsBZ99TsWUhCwzQYC/hW54I1xV9weHqvcIHIi6sISknKHDDEx6DwGJfIQOB3jv4SAjGVVJ++0cIt9Zbw/icL9f0SF3TuK7ExFP+C6lz4YxDjGBZiMlUuJRWAZVWD8s58GKykrvDJRt5q/EfBGl1Y7iZaibSUIhZ/HI0JRTxeDxp4+EQ7qp0VL+sI3Suan1de0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: INTxykVWsc0LsV7NWxW3OcJWlm1/zlImvH9epKk/GTm+lh8ZzSNeBcuZGtEFTqMUhWM51FcIxjVRG+TntC8CpckqiKqVbfj+0QjMnK3rkUd7HpP3ruOZeTzM7b3dGCYx6XLbNSArt448uf6uqoEZcEAJB2sitZscSHO6XYhm+hfQa0TReyMRd4DPPUZ5b8XyovBFW43wX5UyNQJPjOe+g+OLFopa/NwtXbSMTSPVFUbPBucwqnNb/PDBJbX6bv8UDZPMofCrwnrR4Ns4d8/jLm5s1ny3YGyf4dNJGlK8lafJBRk/9tYof96EOq7V/zFDuvtjBx3MsW0OV0o74XFAxXr93kHqQQquggL+Fl1N5IBxoZTVxhTtrSy7RWgz6ZOMdQ+UKBX889vFgiNk7bywvzlwkizdYpq+50AIB1drWZd81U1hU9mZGtORetxhm5h6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:22.0054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e0b485-36d2-44da-a62e-08defa4991f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9692
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

