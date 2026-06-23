Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2B4CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F2310EC18;
	Tue, 23 Jun 2026 16:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NJQgVefv";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D70210EC0F;
 Tue, 23 Jun 2026 16:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzTDYfQlv9LLgKTLkHebHPFOvdDFw/MzNZYxWZZOPJhyo2woqW1Hb3syBgCW8O4leGoBA3koY0uPfK1bBbBQMq1SNO2cHqxyg/HEdb+pynAb0RNbAGtJUz2r9X6AtnPzERX/j34GLEgsFSD7w02XqnWRJcCJilKAopP2sPe7dX4r508pAjMqNexlneZJyhuioxNx0VfraRyYGHcHOy3E96b75rFeiThFYVwTi6bH8c04KxEJ6WmOE7G8jG66fKkyKSowPdUH19u7GyAL1qfXf5FWTa6eyhdqqM4yE/f0U7CcUx4OXnvM3K7P+UTVA20dUCV3VUaXnO4T8Hg/xzvYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03j/yCtNlLepPzUgWl+iJ+GbqFW4ybchtlEdkKMUcxU=;
 b=KdRvniXEl1EusV3M/3hK0zJ2gLuwgzQ/PqKNcwrnhJr0BnJ0gNOihClsGGMwDU2HBK+1fKQIq3lsq1pz44zB/tK/gSO6p3sfjSkJxpu2AyDsvtfAww+3xEQRTJ7kn0HIInaGihrJ5efptk2ZM55QXvWkUNiShJuIqVV+YvQbbaI7Mwn4sLvOAa+wKeJchQAq0Nh6YankW/hy/5doRGtWtapPWabu1dRm5zzv//AjtW4V5NiymyWuSi/UH8Duh+i/VWjav8AyNTFEc5qQaS6KIKx5igukhcAJYrk/A/94n1b76pVCE7yVE2fJrvA0SwnuinpRfsBAphFhvNDH7JnzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03j/yCtNlLepPzUgWl+iJ+GbqFW4ybchtlEdkKMUcxU=;
 b=NJQgVefvLh2wqHLGVtfVRotPGy9RnWPNiMfBYQ5y14n/wFQok6X0P51CIjarMiL1jcYbB88vsSNR4xT7QaEgufZRkNnW7Hb0AyvsOaIVDfrQkageXr6liVUZE91OpqWAqwFM5314i7aekGwIyX7b9R9pITmJUZhWUEDGZYNFkmE=
Received: from BY3PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:39b::32)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Tue, 23 Jun 2026 16:48:24 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::59) by BY3PR05CA0057.outlook.office365.com
 (2603:10b6:a03:39b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 16:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 16:48:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:16 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 11:48:16 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>, Melissa Wen
 <mwen@igalia.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v3 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
Date: Tue, 23 Jun 2026 12:48:02 -0400
Message-ID: <20260623164812.81110-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db39586-7d19-4ed1-97c8-08ded1473d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: a/U4C+a5qAU6eycalmxOJkiaZ1AkFW1KU3lpQbA8nDRtO8b2OdDfi+oewG+l6c7lc51o3FmxOx6YHvbZ/iUuOW34ONBkbXQw7D6QonWJRWcb0PU/pRXrR1wXh0x9m8BCG+Rn8CP5elUoQ51MGlqXUKe+2UAmCHCMspVt1XQ78MgAqdZL9gq/sYOtY4SWwGyrTjXlQLFumhpL/FvGt40F913nLjkMPbxEvvWuGCG+1YoUQIbS51esO6eQWsVyg9XXpzL+4mtWy3Ujonvffkc07PG1bJNUrAC1pUP3BdXpBiRV36Y+o2zwUUtYhM5FyfJSKMTh4CbsVCxnz9V7i2s31QTAFbxwn2u84YUSLo52bZvjd/s0ooVrQDmL66sah61RJHXScnsHb5DWsXr/4/UQ1mhrNIgFGClaaacgLDQl7Kl+A0Vtmz5quf6mf5XcNCBeLsy+AcJdaGu+/7RnGyK6ZpVsV5wg81bK6GD+n1WK3wRyo5rJjyuLy6n/Bs8pv5GY93YZWx5hoIt5SZEwpWLfEeGpUxAvK/8Q/xo0UhsnkusjeOt/JCuxw5GSqEO2HhDMmromhqhTId9gHdpBvNUWSc7AfhmVbFVzCv3xAkTA3Kyld6vwd3s7C3UcOXe4pGX93mHU2nspVdoUsfvfCm0jHZNRomwVMhqgrXnXeUMgn0g1/AZvHfs8V6cYhoyMQJf4O8wLAh3kZtbkR5M9W34kBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mdDbZ7dRn6umYD8PEZf2avQXKLy7lincjVPbfwJ/YHIgCw+Tw/RXXt/a6FkVlALLtSq5naEX2bOwEvfq4sZE/IdhvLgKeMlqUBh5CAHuHTbeXqjPyj441GlPs3/D53W4SoZrL6HsMEkzUzcgL/reBBfUnXfSwwT8jZmu2iS/t+El58oDD5X+O83QZ1miw4aqFwBvZ9n944BaBiDoLMg9g7L/ynfbunW/XDHjl+q8oqJ2EngzsS7u/+OzYlR6Y95+rehuazmRhMDRmD2qHk0CCEMivS+uoPn+Jo9x2wUpOGu8c2ZYPohpB5pslwHZSTQOks8Cat2Rhi8ePyl8ha/jd42j9+Yfv/lk3XYEHak2Tt7XNMI7UNFrLPokHeljKVy+dR+u1hRFFDdv0CVdLfQPUpdcwfy3SKJBYcNswIW1EIEbym/vrE950o3cBU1RbeDN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:48:23.5458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db39586-7d19-4ed1-97c8-08ded1473d6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
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

v2:
 - Naming changes (Pekka)

v3:
 - Fix NC matrix enum name and string (Melissa)
 - Rebase

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_atomic.c      |   4 ++
 drivers/gpu/drm/drm_atomic_uapi.c |   4 ++
 drivers/gpu/drm/drm_colorop.c     | 106 ++++++++++++++++++++++++++++++
 include/drm/drm_colorop.h         |  84 +++++++++++++++++++++++
 include/uapi/drm/drm_mode.h       |  12 ++++
 5 files changed, 210 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 3af1b9cc9a06..ced591c4a0bd 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -925,6 +925,10 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 				  drm_get_colorop_lut3d_interpolation_name(colorop->lut3d_interpolation));
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
index c7f80d90794c..cee4550ffdbd 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -761,6 +761,8 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
 	} else if (property == colorop->data_property) {
 		return drm_atomic_color_set_data_property(colorop, state,
 							  property, val);
+	} else if (property == colorop->fixed_matrix_type_property) {
+		state->fixed_matrix_type = val;
 	} else {
 		drm_dbg_atomic(colorop->dev,
 			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
@@ -793,6 +795,8 @@ drm_atomic_colorop_get_property(struct drm_colorop *colorop,
 		*val = colorop->lut3d_interpolation;
 	else if (property == colorop->data_property)
 		*val = (state->data) ? state->data->base.id : 0;
+	else if (property == colorop->fixed_matrix_type_property)
+		*val = state->fixed_matrix_type;
 	else
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index c0eecde8c176..c11c3012fcc5 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -68,6 +68,7 @@ static const struct drm_prop_enum_list drm_colorop_type_enum_list[] = {
 	{ DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
 	{ DRM_COLOROP_MULTIPLIER, "Multiplier"},
 	{ DRM_COLOROP_3D_LUT, "3D LUT"},
+	{ DRM_COLOROP_FIXED_MATRIX, "Fixed Matrix"},
 };
 
 static const char * const colorop_curve_1d_type_names[] = {
@@ -90,6 +91,14 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
 	{ DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
 };
 
+static const char * const colorop_fixed_matrix_type_names[] = {
+	[DRM_COLOROP_FM_YCBCR601_FULL_RGB] = "YCbCr 601 Full to RGB",
+	[DRM_COLOROP_FM_YCBCR709_FULL_RGB] = "YCbCr 709 Full to RGB",
+	[DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] = "YCbCr 2020 NC Full to RGB",
+	[DRM_COLOROP_FM_YCBCR_LIMITED_FULL] = "YCbCr limited to full",
+	[DRM_COLOROP_FM_RGB709_RGB2020] = "RGB709 to RGB2020",
+};
+
 /* Init Helpers */
 
 static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *colorop,
@@ -455,6 +464,80 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
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
@@ -521,6 +604,13 @@ static void __drm_colorop_state_init(struct drm_colorop_state *colorop_state,
 							   &val))
 			colorop_state->curve_1d_type = val;
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
@@ -584,6 +674,7 @@ static const char * const colorop_type_name[] = {
 	[DRM_COLOROP_CTM_3X4] = "3x4 Matrix",
 	[DRM_COLOROP_MULTIPLIER] = "Multiplier",
 	[DRM_COLOROP_3D_LUT] = "3D LUT",
+	[DRM_COLOROP_FIXED_MATRIX] = "Fixed Matrix",
 };
 
 static const char * const colorop_lu3d_interpolation_name[] = {
@@ -640,6 +731,21 @@ const char *drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_inte
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
index b4b9e4f558ab..88933d5b4d8b 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -134,6 +134,71 @@ enum drm_colorop_curve_1d_type {
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
+	 * This selects the matrix that converts full range YCbCr into RGB
+	 * according to the BT.601 coefficients.
+	 */
+	DRM_COLOROP_FM_YCBCR601_FULL_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR709_FULL_RGB:
+	 *
+	 * enum string "YCbCr 709 Full to RGB"
+	 *
+	 * This selects the matrix that converts full range YCbCr into RGB
+	 * according to the BT.709 coefficients.
+	 */
+	DRM_COLOROP_FM_YCBCR709_FULL_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
+	 *
+	 * enum string "YCbCr 2020 NC Full to RGB"
+	 *
+	 * This selects the matrix that converts full range YCbCr into RGB
+	 * according to the BT.2020 non-constant luminance coefficients.
+	 */
+	DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR_LIMITED_FULL:
+	 *
+	 * enum string "YCbCr limited to full"
+	 *
+	 * This selects the matrix that converts limited range YCbCr into
+	 * full range YCbCr. Though not strictly a matrix operation but
+	 * can be represented as one.
+	 */
+	DRM_COLOROP_FM_YCBCR_LIMITED_FULL,
+
+	/**
+	 * @DRM_COLOROP_FM_RGB709_RGB2020:
+	 *
+	 * enum string "RGB709 to RGB2020"
+	 *
+	 * Selects the fixed-function CSC preset that converts RGB
+	 * (BT.709) colorimetry to RGB (BT.2020).
+	 */
+	DRM_COLOROP_FM_RGB709_RGB2020,
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
@@ -183,6 +248,13 @@ struct drm_colorop_state {
 	 */
 	struct drm_property_blob *data;
 
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
@@ -368,6 +440,13 @@ struct drm_colorop {
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
@@ -424,6 +503,10 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
 				 uint32_t lut_size,
 				 enum drm_colorop_lut3d_interpolation_type interpolation,
 				 uint32_t flags);
+int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct drm_colorop *colorop,
+					struct drm_plane *plane,
+					const struct drm_colorop_funcs *funcs,
+					u64 supported_fm, uint32_t flags);
 
 struct drm_colorop_state *
 drm_atomic_helper_colorop_create_state(struct drm_colorop *colorop);
@@ -482,6 +565,7 @@ drm_get_colorop_lut1d_interpolation_name(enum drm_colorop_lut1d_interpolation_ty
 
 const char *
 drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_interpolation_type type);
+const char *drm_get_colorop_fixed_matrix_type_name(enum drm_colorop_fixed_matrix_type type);
 
 void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_colorop *next);
 
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 381a3e857d4e..bff6dba08d50 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -954,6 +954,18 @@ enum drm_colorop_type {
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
2.54.0

