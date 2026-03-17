Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C83EFED9E7
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A0FC10E5A4;
	Tue, 17 Mar 2026 16:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q2kHU3bD";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB2110E5A4;
 Tue, 17 Mar 2026 16:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD4UkV2mQ7KNFNVGuBguqTQBSQ6W8RWjDceQvpRIYAkLnwOLF6y41zhp5lgEmnsx1yvAs9s/E7j4kQ4UJA5Sa11j7JHXiful4ZDCqY1iwK9mXHW8cXzA/ArwKJvcNUwVfzFeJcD2fwtk938ub0ZA8R0sN4AZqFsTUQC4ZaE1/fc/F9Qf26vQPyZLglRUwEz0JYWc6yuhoaJqSADh0RkcayqHBcHHUn1ln+KZsK/JxYkcEHkU5tQ4/7f9vR9OomyVhXe2j0Y1GpzRDiIvVbFyP5wYK1AcTxpP9BLoSIW0yMAIuukDhoRUn4WXgb3MkqXiQDeIvlQcBzYlh7EK8h6vcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDPh7tQQX4HMDEd05x+7LRQqDfmKR6oXLj/ebylJ6xM=;
 b=qw4ZZEJW3P1OokqaanPF2GzBw87bCEL+FSxIrghRfANUGbnVH2ggGfqg5a7cFRxqGgf2qOkQUZy5ue4JihQCSKjYgZtPuyV6kWrX0Cpc54oN697afuVWzx7G1GMoaJuc7zOULlWgHJhKaGWP51MU+fDMuo45SHV4knceTi0SlfNteoAZlCh+pteOs7bOW0T37l/x7H39rqAvQBY0gJv/9xwWPBiqW8M4hjQqagrlDGVNDJkfkINifoccv1SsbXmDYRB3eJXE0sMuMYZqZ6dC3CDUEes4NAZlyt+ngkRWTmIj4NMvZkGIS8I0EuRKitWt97M7+4YMXMokGXY7bHSMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDPh7tQQX4HMDEd05x+7LRQqDfmKR6oXLj/ebylJ6xM=;
 b=q2kHU3bDtg8Pm1AB+02h5S/9HeD8glbQaKyoXV77pMY8objmkQOpvGsR1rS6T6OgWZ50vA8376wKCP8Xb0L0fsW0UDJv6/uqu9D+YmT2gDIw43Txc1OtV3ZigNomWB7Ud47Y+tBddJpKTeUbzoNTP1/BCmFde7Fl7DJ6NAYZRuw=
Received: from SJ0PR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:334::13)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 16:04:02 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::5b) by SJ0PR05CA0098.outlook.office365.com
 (2603:10b6:a03:334::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Tue,
 17 Mar 2026 16:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:04:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 11:04:01 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 11:04:01 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH 02/10] drm/colorop: Add CSC colorop initialization helper
Date: Tue, 17 Mar 2026 12:03:42 -0400
Message-ID: <20260317160350.229028-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317160350.229028-1-harry.wentland@amd.com>
References: <20260317160350.229028-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: eecc7c6c-769d-4626-8143-08de843ece98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: bdAyijlKu5FF+Rtrhsm4TLfoAvCdBbZa5b7DSKwIb4B03YDs/a44mLsooS9Bw+V2QxgoGF8AWSeMUM9prDuZ6lT6TeoW8ynhsy09hCs9KwSrWxJEas6m2Q/VYsViCwK+p1oInTj/g2S1nRY1IrWNBLEBsOB8vOOhKJ0wDFiIX/PJIh6zM85wF73gzXShH7SuyMFYqpvOQAz8mVRl3lg6YB4ILTvnKrWmVPo2VLxXpGvR68P1ya7ymNw46gAgk4tLAjbhtWDqgusjbp2m5eiixy1vTFT20vJxvSrd28am88V5s6TEEzexDPtif1xJK1ZPfmUnxxHaDfpYfrjZAv25Aqx6Go51Nsm7xXdpEjdFcBq6+tGOoAVea69YY28MMh87s5b/2nnWaPHKPm63SA9NdB/3n+WqcFdqkGJTKDO8JWZkOVu1m6Bsl9NqpbfOnOuZOQl4nvZNgiSln2ne7JHWKfmd5w8OwYQBIIr2hsvhMnBDJbzS4XzSz+LVfsGlFbvvN06BgF4JE2rOLXM/QS5rnGlq6cowW9lgkVfI/XURaCzJtfLJGXGDITlfG0+5aFU7/bqSS9PRKTIxvQy0dsHH6Tz1tDXBw29uvL3Yvi1V0Pq4FPnx3889YWPYD4LPQwkniL4QmMckZBGAXsHd/L//QqIGhABHKTq1jvKhidkQYyFYF6L0wreWpGZ7cPzStijALQURwiDTNL1XsraQuLoh1MzFPt8Tp7+yjmJHHuiumVMhnJhaHWI+Wsd7dKvuG82Vxn0E4eE02Nwmg4BT96Dcyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YPHxY9USVDc+jgwpcBRaM+MoOLN37WEcQ87QMryNZUyENl5fbgAVJTvu9e2M81nBVq18PzL8rFhaTQwaF6/LtxOrJa6WfenRwcyXD0XY5Dam/A/vK9qxGbEvUIL7hzQMSIQ239/3KT4eYS9roSx8zsl9Lj7kIU1IGCGaLF1bzSIfZbvuqFUYN0VdjXjsYGPI6aidclvu2KjNL2s002q9WncZjZxIV2+jJh2nKMJczXJOr/mOO1aJztQPAdf33uKR8ndQQe7GX1X/3cZl2HL6qJuJlv7LJ+JJw+aMhZKhP2ZbK16jJkYLKfYCiY9t0sWH1x3n8nSTYAK5JDDRj9QE4WtS8+aScdJdhNGx4Kf5bn1PAqik7DNdj5C8xFUxUOvdPfwEVrKU7neaH3fkSt8YIK1fn7E1fukq24UfJTntX3l9y8YNUZawZuIdvLrW2OFC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:04:02.1356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eecc7c6c-769d-4626-8143-08de843ece98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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

Add drm_plane_colorop_csc_init() helper function to initialize a CSC
(Color Space Conversion) colorop with COLOR_ENCODING and COLOR_RANGE
properties.

This function allows drivers to create CSC colorops with configurable
YUV encoding standards (BT.601, BT.709, BT.2020) and range types
(limited/full range), which control the YUV-to-RGB conversion matrix.

The colorop state structure is extended with color_encoding and
color_range fields to hold the current property values.

Co-developed by Claude Sonnet 4.5.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_colorop.c | 89 +++++++++++++++++++++++++++++++++++
 include/drm/drm_colorop.h     | 39 +++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 11b2f11db874..5329eeb0ae1b 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -621,6 +621,95 @@ const char *drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_inte
 	return colorop_lu3d_interpolation_name[type];
 }
 
+/**
+ * drm_plane_colorop_csc_init - Initialize a CSC colorop
+ * @dev: DRM device
+ * @colorop: the color operation to initialize
+ * @plane: plane object that this colorop will belong to
+ * @supported_encodings: Bitmask of supported encodings (BIT(DRM_COLOR_YCBCR_*))
+ * @supported_ranges: Bitmask of supported ranges (BIT(DRM_COLOR_YCBCR_*_RANGE))
+ * @default_encoding: Default COLOR_ENCODING value
+ * @default_range: Default COLOR_RANGE value
+ * @flags: Flags for this colorop (DRM_COLOROP_FLAG_*)
+ *
+ * Initializes a CSC (Color Space Conversion) colorop suitable for YUV to RGB
+ * conversion. Creates COLOR_ENCODING and COLOR_RANGE properties that control
+ * which conversion matrix is used.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_plane_colorop_csc_init(struct drm_device *dev, struct drm_colorop *colorop,
+			       struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
+			       u32 supported_encodings, u32 supported_ranges,
+			       enum drm_color_encoding default_encoding,
+			       enum drm_color_range default_range,
+			       uint32_t flags)
+{
+	struct drm_property *prop;
+	struct drm_prop_enum_list enum_list[max_t(int, DRM_COLOR_ENCODING_MAX,
+						       DRM_COLOR_RANGE_MAX)];
+	int i, len, ret;
+
+	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_CSC, flags);
+	if (ret)
+		return ret;
+
+
+	if (WARN_ON(supported_encodings == 0 ||
+		    (supported_encodings & -BIT(DRM_COLOR_ENCODING_MAX)) != 0 ||
+		    (supported_encodings & BIT(default_encoding)) == 0))
+		return -EINVAL;
+
+	if (WARN_ON(supported_ranges == 0 ||
+		    (supported_ranges & -BIT(DRM_COLOR_RANGE_MAX)) != 0 ||
+		    (supported_ranges & BIT(default_range)) == 0))
+		return -EINVAL;
+
+	len = 0;
+	for (i = 0; i < DRM_COLOR_ENCODING_MAX; i++) {
+		if ((supported_encodings & BIT(i)) == 0)
+			continue;
+
+		enum_list[len].type = i;
+		enum_list[len].name = drm_get_color_encoding_name(i);
+		len++;
+	}
+
+	prop = drm_property_create_enum(dev, 0, "COLOR_ENCODING",
+					enum_list, len);
+	if (!prop)
+		return -ENOMEM;
+	colorop->color_encoding_property = prop;
+	drm_object_attach_property(&colorop->base, prop, default_encoding);
+	if (colorop->state)
+		colorop->state->color_encoding = default_encoding;
+
+	len = 0;
+	for (i = 0; i < DRM_COLOR_RANGE_MAX; i++) {
+		if ((supported_ranges & BIT(i)) == 0)
+			continue;
+
+		enum_list[len].type = i;
+		enum_list[len].name = drm_get_color_range_name(i);
+		len++;
+	}
+
+	prop = drm_property_create_enum(dev, 0, "COLOR_RANGE",
+					enum_list, len);
+	if (!prop)
+		return -ENOMEM;
+	colorop->color_range_property = prop;
+	drm_object_attach_property(&colorop->base, prop, default_range);
+	if (colorop->state)
+		colorop->state->color_range = default_range;
+
+	drm_colorop_reset(colorop);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_plane_colorop_csc_init);
+
 /**
  * drm_colorop_set_next_property - sets the next pointer
  * @colorop: drm colorop
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index bd082854ca74..09844e8885e2 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -30,6 +30,8 @@
 #include <drm/drm_mode_object.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_property.h>
+#include <drm/drm_color_mgmt.h>
+
 
 /* DRM colorop flags */
 #define DRM_COLOROP_FLAG_ALLOW_BYPASS	(1<<0)	/* Allow bypass on the drm_colorop */
@@ -183,6 +185,20 @@ struct drm_colorop_state {
 	 */
 	struct drm_property_blob *data;
 
+	/**
+	 * @color_encoding:
+	 *
+	 * Color encoding for YUV-to-RGB conversion
+	 */
+	enum drm_color_encoding color_encoding;
+
+	/**
+	 * @color_range:
+	 *
+	 * Color range
+	 */
+	enum drm_color_range color_range;
+
 	/** @state: backpointer to global drm_atomic_state */
 	struct drm_atomic_state *state;
 };
@@ -357,6 +373,23 @@ struct drm_colorop {
 	 */
 	struct drm_property *lut3d_interpolation_property;
 
+	/**
+	 * @color_encoding_property:
+	 *
+	 * "COLOR_ENCODING" enum property for specifying the YUV-to-RGB
+	 * conversion matrix on a DRM_COLOROP_CSC.
+	 */
+
+	struct drm_property *color_encoding_property;
+
+	/**
+	 * @color_range_property:
+	 *
+	 * "COLOR_RANGE" enum property for specifying color range
+	 * for a YUV-to-RGB conversion matrix on DRM_COLOROP_CSC.
+	 */
+	struct drm_property *color_range_property;
+
 	/**
 	 * @data_property:
 	 *
@@ -424,6 +457,12 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
 				 uint32_t lut_size,
 				 enum drm_colorop_lut3d_interpolation_type interpolation,
 				 uint32_t flags);
+int drm_plane_colorop_csc_init(struct drm_device *dev, struct drm_colorop *colorop,
+			       struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
+			       u32 supported_encodings, u32 supported_ranges,
+			       enum drm_color_encoding default_encoding,
+			       enum drm_color_range default_range,
+			       uint32_t flags);
 
 struct drm_colorop_state *
 drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop);
-- 
2.53.0

