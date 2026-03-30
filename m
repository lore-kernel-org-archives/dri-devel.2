Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F1D1061B0F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ECD310E60D;
	Mon, 30 Mar 2026 15:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X6ouF/Lc";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D5310E235;
 Mon, 30 Mar 2026 15:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAB2vgkUbFa2k5dGAYrTACkYHtxztmuhc6sYMrD/3s39bXQXuw26WO5j1yYivJH83t/jaXRH/0z4ZoTZydWh/70U8IA2UuTTm1gA678MuRIzDLDSdr6qND6wIF3VNirJxMU+BMgK9SkuDpwsTyFQnLZJIJRoRTZlqAbgMKvHA8gdCArOLL81ff7K2FQZMSSgA25adsQ6ywkv3h1gebOxZ7/w1TW+/LjCQ/B1vbz5jpc5f872xqAF8u2gT0AIhnI0E2WTpcpBlS01pDkg/q8Ll6SXZcp84VAWaA29wBR1yoBku6BCFlbBdnZeTz1o83uMsc5RFeJeKZPxvJ05blXiTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJVv/J1buQ16VGhOYGVFh3bnSiRXhmTb8ocgDtTWEow=;
 b=SnADVWTGMHVAadjU7F4H7IZ1HjEtbkgWiS+T2EJcE7n7z19XtVD8pAAqqPeudHrTP6YoK6xIpRbXbSxSGDsiDpise3e7SaTAFAh9KB0r6ZU0hGDcex1amGEGfYFUpen91VlS1MUWK1c/eVzLdYZiXYBWpv4gUHQ6X1wZt+nSeeFt1bjHIo1bwpA5AHSdMipnE371Fm9Wxzs9QXnkQlH0hs1fFbyvMbFzRbZxd9q7SuxlmmoOciGOJ8IVvUZbmGPuMR98kFUbsJ8YkRJG+a4/aXuybVGGXrFefkpdAGM8GvDHdx6NPUneIRJclWv967A2YtD7k6Xpc2vSvMf0SWzBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJVv/J1buQ16VGhOYGVFh3bnSiRXhmTb8ocgDtTWEow=;
 b=X6ouF/Lc9hSUYFgkW/rlMyE6Yszy1asf5/pBoMQDwFzHvN5itamRf9lniqt4tze8fww8cNP5d0uO15elrudb7mFjf+zIGN44xvy+rI7hW4z4p+Aqa7x5972yPQNdjS+Mbvo5ylEAH0fHjbznKaEU6s1LlOX4HnOi3C48EIzeTpA=
Received: from BY3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:254::12)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 15:34:57 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::5) by BY3PR05CA0007.outlook.office365.com
 (2603:10b6:a03:254::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 15:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 15:34:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 10:34:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 10:34:55 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 10:34:55 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: [RFC PATCH v2 1/9] drm/colorop: Add DRM_COLOROP_CSC_FF
Date: Mon, 30 Mar 2026 11:34:43 -0400
Message-ID: <20260330153451.99472-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330153451.99472-1-harry.wentland@amd.com>
References: <20260330153451.99472-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 861cea9f-a48b-4fd8-ef68-08de8e71e5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: P5DG+UBIF6P19O0i4KGHb1/AFytQdWeHFrmuNcWR81avHoNxzWIIfSh4w6qKkfwKEW916fJKl0nCCZP1Mf0vr2E8zEY2Dog/ChsT/eE2Acmn4G38rBkHl8VKui8r1K6BYCJYvTNpqe0BaPfxjSR3QRh8FbHteY/Dz5UvVaiUKm0UyomUDjIT8cojKLS5Bet9bdupJ2FOBi6EI8YNYv2iQblv3UX/WfK5ivTnu9JEqPV+JVyCa0iB3ic487CO8/ddMpBXIwPA14RbggsFOyEEO5T9BhjTC1TwA27QdDPKoEtjVSwzSUA+M0n7uHRSL1uOH+GbAE/kV0b1Vy4LWTM5y/F1V8tiOCKRt6BbDcDiJmCcGn3XcB3gvtcJYiRnxL4r6e3DMiiz3dX4hIkiTsY7rTqL8OMjgAzENJk0OeCne4yyC5OmTlZeLU5dtFiymbSYZQ6K0l750s6j0iaJL0fxUuaO3+HOExs2cMyEMwUVMS1ohcpNxdvmkfCu5gSShh7BSkLpbdDp8+X80Dug24OqX7jdMdNEf+k1O6dJooT1DOPEOcr3n5KqSHUQIExj6+jPSJ+MU1lJ/+k0DSkmemdSuhzY7bh8eOc2C1bBGPQXBkamgdM0R4wZllxnJLCCtQ8F9NdykYAzZh88Hja3q3sOe+etcv492yF6Kvztdt4YerPGQm0ax/aebBQel0TMHofAX/MuFBlgQ2R+YcrlAMbtiY65DG8ibi7srlShagM42hJyW9s5/ZJAGkykoQXFAeUTk6oV1MdYLGkmiL9NNXqVCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j1d8hmClLz94iIoqiOCClGdQwjh9nNcA/yUO61ygZSvlwlD5+QHR/TcRfjA4eZTLm08YphKlTVXrFZSIfuKrTWeKyWIujO21E5F+ftcJHdgWes8TMCWNMQobHPdZBbvzVUYY/y/JDXc7c4HyVyus12n+XNg/0ZDnUmk6sqzrLfwvgz5DbpShBe4HqcvhOdmzKczkgjQ2s1XUwmFG5ojIW+vGnOamGevLrAlAYkCi0EXmBc4J7qywOFGJrIUnP1Xw/EmrfXXFoNahA72O8A1hFExLGD6txtbSXDHBybHp+gnOlX/3c3jM/b97CHhyoT8uRtcuZAB+kiS2Mz1QdTvD9gpmqOlsVJ29R5vxjL9MU1v8NlgAsQ+AkIy2O/Z0tyFzEyt0D3N5m+1/p5B/DRjArJGSmVMQMJcSXmH/GEJoI9k7evKRHTB0ZocYAVofY2aC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:34:56.8039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 861cea9f-a48b-4fd8-ef68-08de8e71e5ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
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

Introduce DRM_COLOROP_CSC_FF, a new colorop type representing a
fixed-function Color Space Conversion (CSC) block.

Unlike CTM-based colorops, this block does not expose programmable
coefficients. Instead, userspace selects one of the predefined
hardware modes via a new CSC_FF_TYPE enum property. Supported modes
include common YUV->RGB and RGB709->RGB2020 conversions.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/drm_atomic.c      |   4 ++
 drivers/gpu/drm/drm_atomic_uapi.c |   4 ++
 drivers/gpu/drm/drm_colorop.c     | 105 ++++++++++++++++++++++++++++++
 include/drm/drm_colorop.h         |  72 ++++++++++++++++++++
 include/uapi/drm/drm_mode.h       |  13 ++++
 5 files changed, 198 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 41c57063f3b4..5bff85576e6b 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -845,6 +845,10 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 			   drm_get_colorop_lut3d_interpolation_name(colorop->lut3d_interpolation));
 		drm_printf(p, "\tdata blob id=%d\n", state->data ? state->data->base.id : 0);
 		break;
+	case DRM_COLOROP_CSC_FF:
+		drm_printf(p, "\tcsc_ff_type=%s\n",
+			   drm_get_colorop_csc_ff_type_name(state->csc_ff_type));
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 5bd5bf6661df..39b0dd1ec348 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -761,6 +761,8 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
 	} else if (property == colorop->data_property) {
 		return drm_atomic_color_set_data_property(colorop, state,
 							  property, val);
+	} else if (property == colorop->csc_ff_type_property) {
+		state->csc_ff_type = val;
 	} else {
 		drm_dbg_atomic(colorop->dev,
 			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
@@ -793,6 +795,8 @@ drm_atomic_colorop_get_property(struct drm_colorop *colorop,
 		*val = colorop->lut3d_interpolation;
 	else if (property == colorop->data_property)
 		*val = (state->data) ? state->data->base.id : 0;
+	else if (property == colorop->csc_ff_type_property)
+		*val = state->csc_ff_type;
 	else
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 566816e3c6f0..6a345e2e8b15 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -68,6 +68,7 @@ static const struct drm_prop_enum_list drm_colorop_type_enum_list[] = {
 	{ DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
 	{ DRM_COLOROP_MULTIPLIER, "Multiplier"},
 	{ DRM_COLOROP_3D_LUT, "3D LUT"},
+	{ DRM_COLOROP_CSC_FF, "CSC Fixed-Function"},
 };
 
 static const char * const colorop_curve_1d_type_names[] = {
@@ -90,6 +91,13 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
 	{ DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
 };
 
+static const char * const colorop_csc_ff_type_names[] = {
+	[DRM_COLOROP_CSC_FF_YUV601_RGB601]   = "YUV601 to RGB601",
+	[DRM_COLOROP_CSC_FF_YUV709_RGB709]   = "YUV709 to RGB709",
+	[DRM_COLOROP_CSC_FF_YUV2020_RGB2020] = "YUV2020 to RGB2020",
+	[DRM_COLOROP_CSC_FF_RGB709_RGB2020]  = "RGB709 to RGB2020",
+};
+
 /* Init Helpers */
 
 static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *colorop,
@@ -455,6 +463,80 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
 }
 EXPORT_SYMBOL(drm_plane_colorop_3dlut_init);
 
+/**
+ * drm_plane_colorop_csc_ff_init - Initialize a DRM_COLOROP_CSC_FF
+ *
+ * @dev: DRM device
+ * @colorop: The drm_colorop object to initialize
+ * @plane: The associated drm_plane
+ * @funcs: control functions for the new colorop
+ * @supported_csc_ff: A bitfield of supported drm_plane_colorop_csc_ff_type enum values,
+ *                    created using BIT(csc_ff_type) and combined with the OR '|'
+ *                    operator.
+ * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
+ * @return zero on success, -E value on failure
+ */
+int drm_plane_colorop_csc_ff_init(struct drm_device *dev, struct drm_colorop *colorop,
+				  struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
+				  u64 supported_csc_ff, uint32_t flags)
+{
+	struct drm_prop_enum_list enum_list[DRM_COLOROP_CSC_FF_COUNT];
+	int i, len;
+
+	struct drm_property *prop;
+	int ret;
+
+	if (!supported_csc_ff) {
+		drm_err(dev,
+			"No supported CSC op for new CSC FF colorop on [PLANE:%d:%s]\n",
+			plane->base.id, plane->name);
+		return -EINVAL;
+	}
+
+	if ((supported_csc_ff & -BIT(DRM_COLOROP_CSC_FF_COUNT)) != 0) {
+		drm_err(dev, "Unknown CSC provided on [PLANE:%d:%s]\n",
+			plane->base.id, plane->name);
+		return -EINVAL;
+	}
+
+	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_CSC_FF, flags);
+	if (ret)
+		return ret;
+
+	len = 0;
+	for (i = 0; i < DRM_COLOROP_CSC_FF_COUNT; i++) {
+		if ((supported_csc_ff & BIT(i)) == 0)
+			continue;
+
+		enum_list[len].type = i;
+		enum_list[len].name = colorop_csc_ff_type_names[i];
+		len++;
+	}
+
+	if (WARN_ON(len <= 0))
+		return -EINVAL;
+
+	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC, "CSC_FF_TYPE",
+					enum_list, len);
+
+	if (!prop)
+		return -ENOMEM;
+
+	colorop->csc_ff_type_property = prop;
+	/*
+	 * Default to the first supported CSC mode as provided by the driver.
+	 * Intuitively this should be something that keeps the colorop in pixel bypass
+	 * mode but that is already handled via the standard colorop bypass
+	 * property.
+	 */
+	drm_object_attach_property(&colorop->base, colorop->csc_ff_type_property,
+				   enum_list[0].type);
+	drm_colorop_reset(colorop);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_plane_colorop_csc_ff_init);
+
 static void __drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop,
 							struct drm_colorop_state *state)
 {
@@ -521,6 +603,13 @@ static void __drm_colorop_state_reset(struct drm_colorop_state *colorop_state,
 						      &val);
 		colorop_state->curve_1d_type = val;
 	}
+
+	if (colorop->csc_ff_type_property) {
+		drm_object_property_get_default_value(&colorop->base,
+						      colorop->csc_ff_type_property,
+						      &val);
+		colorop_state->csc_ff_type = val;
+	}
 }
 
 /**
@@ -561,6 +650,7 @@ static const char * const colorop_type_name[] = {
 	[DRM_COLOROP_CTM_3X4] = "3x4 Matrix",
 	[DRM_COLOROP_MULTIPLIER] = "Multiplier",
 	[DRM_COLOROP_3D_LUT] = "3D LUT",
+	[DRM_COLOROP_CSC_FF] = "CSC Fixed-Function",
 };
 
 static const char * const colorop_lu3d_interpolation_name[] = {
@@ -617,6 +707,21 @@ const char *drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_inte
 	return colorop_lu3d_interpolation_name[type];
 }
 
+/**
+ * drm_get_colorop_csc_ff_type_name: return a string for interpolation type
+ * @type: csc ff type to compute name of
+ *
+ * In contrast to the other drm_get_*_name functions this one here returns a
+ * const pointer and hence is threadsafe.
+ */
+const char *drm_get_colorop_csc_ff_type_name(enum drm_colorop_csc_ff_type type)
+{
+	if (WARN_ON(type >= ARRAY_SIZE(colorop_csc_ff_type_names)))
+		return "unknown";
+
+	return colorop_csc_ff_type_names[type];
+}
+
 /**
  * drm_colorop_set_next_property - sets the next pointer
  * @colorop: drm colorop
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index bd082854ca74..2cd8e0779c2a 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -134,6 +134,60 @@ enum drm_colorop_curve_1d_type {
 	DRM_COLOROP_1D_CURVE_COUNT
 };
 
+/**
+ * enum drm_colorop_csc_ff_type - type of CSC Fixed-Function
+ *
+ * Describes a CSC operation to be applied by the DRM_COLOROP_CSC_FF colorop.
+ */
+enum drm_colorop_csc_ff_type {
+	/**
+	 * @DRM_COLOROP_CSC_FF_YUV601_RGB601
+	 *
+	 * enum string "YUV601 to RGB601"
+	 *
+	 * Selects the fixed-function CSC preset that converts YUV
+	 * (BT.601) colorimetry to RGB (BT.601).
+	 */
+	DRM_COLOROP_CSC_FF_YUV601_RGB601,
+
+	/**
+	 * @DRM_COLOROP_CSC_FF_YUV709_RGB709:
+	 *
+	 * enum string "YUV709 to RGB709"
+	 *
+	 * Selects the fixed-function CSC preset that converts YUV
+	 * (BT.709) colorimetry to RGB (BT.709).
+	 */
+	DRM_COLOROP_CSC_FF_YUV709_RGB709,
+
+	/**
+	 * @DRM_COLOROP_CSC_FF_YUV2020_RGB2020:
+	 *
+	 * enum string "YUV2020 to RGB2020"
+	 *
+	 * Selects the fixed-function CSC preset that converts YUV
+	 * (BT.2020) colorimetry to RGB (BT.2020).
+	 */
+	DRM_COLOROP_CSC_FF_YUV2020_RGB2020,
+
+	/**
+	 * @DRM_COLOROP_CSC_FF_RGB709_RGB2020:
+	 *
+	 * enum string "RGB709 to RGB2020"
+	 *
+	 * Selects the fixed-function CSC preset that converts RGB
+	 * (BT.709) colorimetry to RGB (BT.2020).
+	 */
+	DRM_COLOROP_CSC_FF_RGB709_RGB2020,
+
+	/**
+	 * @DRM_COLOROP_CSC_FF_COUNT:
+	 *
+	 * enum value denoting the size of the enum
+	 */
+	DRM_COLOROP_CSC_FF_COUNT
+};
+
 /**
  * struct drm_colorop_state - mutable colorop state
  */
@@ -183,6 +237,13 @@ struct drm_colorop_state {
 	 */
 	struct drm_property_blob *data;
 
+	/**
+	 * @csc_ff_type:
+	 *
+	 * Type of Fixed function CSC.
+	 */
+	enum drm_colorop_csc_ff_type csc_ff_type;
+
 	/** @state: backpointer to global drm_atomic_state */
 	struct drm_atomic_state *state;
 };
@@ -368,6 +429,13 @@ struct drm_colorop {
 	 */
 	struct drm_property *data_property;
 
+	/**
+	 * @csc_ff_type_property:
+	 *
+	 * Sub-type for DRM_COLOROP_CSC_FF type.
+	 */
+	struct drm_property *csc_ff_type_property;
+
 	/**
 	 * @next_property:
 	 *
@@ -424,6 +492,9 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
 				 uint32_t lut_size,
 				 enum drm_colorop_lut3d_interpolation_type interpolation,
 				 uint32_t flags);
+int drm_plane_colorop_csc_ff_init(struct drm_device *dev, struct drm_colorop *colorop,
+				  struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
+				  u64 supported_csc_ff, uint32_t flags);
 
 struct drm_colorop_state *
 drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop);
@@ -480,6 +551,7 @@ drm_get_colorop_lut1d_interpolation_name(enum drm_colorop_lut1d_interpolation_ty
 
 const char *
 drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_interpolation_type type);
+const char *drm_get_colorop_csc_ff_type_name(enum drm_colorop_csc_ff_type type);
 
 void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_colorop *next);
 
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index a4bdc4bd11bc..5d21f73c3d76 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -971,6 +971,19 @@ enum drm_colorop_type {
 	 *         color = lut3d[index]
 	 */
 	DRM_COLOROP_3D_LUT,
+
+	/**
+	 * @DRM_COLOROP_CSC_FF:
+	 *
+	 * enum string "CSC Fixed-Function"
+	 *
+	 * A fixed-function Color Space Conversion block where the coefficients
+	 * are not programmable but selected from predefined hardware modes via
+	 * the CSC_FF_TYPE enum property. The driver advertises the supported
+	 * CSC modes through this property.
+	 */
+	DRM_COLOROP_CSC_FF,
+
 };
 
 /**
-- 
2.53.0

