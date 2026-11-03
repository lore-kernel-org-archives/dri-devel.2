Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82239606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0RC48vnF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8152E10F888;
	Tue,  3 Nov 2026 21:38:18 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA24A10E1D6;
 Tue,  3 Nov 2026 21:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxfEK4w2l3oXdG5DqAcCPEjA8X/d03wYx8RmBUqUXq5CSOhPtGyFaikwKJ8CLZQLdo1D/Zsp72j0qlqT8a7BZH5+t3ZKtC5O7CIQRbp0lENNWsLUNaCxGVG2dX1AAIrmrE7Zink0qtZAJ/nFVl036OWMi1xdtiwBrEjjQlbnJCxAkeDjOspDxyjGGCVinSjgigjtDCzPmnsycgjFSQPF4JRJzmC090jbytirVgrwtG1iLGOw0HgrU0FW+6YT0nkp/BK6gdJSl+IBnpZ5Jqg/EEn1177L+F9793oZv7YpdPwwWlCkyTWKsS8tOXkHno9sii1+7FjbDg6x8jrPiU/VPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EktGL478O+j6wqelcjKywhAp72r+FXa+gSJBudCmzoQ=;
 b=mmabZUwt2AnS+yEgLhjaRdZjTRB2W1RV5q9kCVVxLISERbaaBTgqZfQxp+79IYMw4rrs9w1rK1AGPGqCnnKz7kP8Kx63oKdWSbkJwtYXPSa3iXYpGO9TU1mBv3xG1s28hPQsqfZQBiRigD1mL1ifcLUIdDfYgXTsYOp1AxfRTPYRumJTfXqqPwU0PvP6Ec99XLihZw4zPskYOtI7/GOhKGiXdenClTDHeCDpkXC8wnMrS8s+mEe+TtI+0GRau13yPClEywvKffPplcGkgVtPgWQHseY1pZgKVtmWqaKC40NHWNIzXT6M+HJwKC63l6KsQU8q01asNUAYJO18+R8oSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EktGL478O+j6wqelcjKywhAp72r+FXa+gSJBudCmzoQ=;
 b=0RC48vnFDH7juFTiNdTLdOEQvFPtDs5km34iMwZJXDEToRkBRTqWzX5s7o+23P2Zeoc2OJAfUpKZGNGQJOiisYh7aRfKFh0WggLXAff+9BtPMYd8n9zTsR9Yi/9BosF7HS+DOOFqmFQw8WGUPgWRiLVN3nEBhzkN5PcPT/Qw/Nk=
Received: from BLAPR03CA0133.namprd03.prod.outlook.com (2603:10b6:208:32e::18)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 21:38:07 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::51) by BLAPR03CA0133.outlook.office365.com
 (2603:10b6:208:32e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:38:07 +0000
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
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:04 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:04 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 02/13] drm/colorop: add DRM_COLOROP_3D_LUT_DMA object and
 state
Date: Tue, 3 Nov 2026 16:37:45 -0500
Message-ID: <20261103213756.618024-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df8b84a-0224-4fdf-4b66-08df39f2bfd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|261102130727099003|56012099006|261022105027099003|261022075727099003|261009221227099003|261021121427099003|261026121527099003|261009223027099003|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: UZmMp4JY7+NlB48WPJ0unnVDyWLfOdPOmc+qsdLQx5cr46wxE5GKZQkTCbFs9wCP/XCoprEtrKHMt8lhdMZkb/Fd/CKwGSn3shUVOR10AyHc2koxE83sNtgBU0CNQCg+2WBuiocPlZ9+kz76sz/y+/xT/+UobwCnYLy4NfDVqGpx6SUGpfG2NJHBl/LlUV9+ju2R9KODSp+otyZkeiQkF9sq4KQfExyzOM/sLPcViR7v5/dyfw3M1g954EdUzhAAr0NlNREGgfHuY+Oi06fyx6xGAqCDXvttq97wNlhzoijnCxP3f8jVWQsOsHGyvF8nmfsWrzZzRplECdl540h/J2BgiPkvyAY39lUAQGmsh0lm3+QpJ795i6F+YRwjJm9JNhrwfJ7wASuDV4G3ff7fmb7Xl0iCXyy+eYvcympG6NtdvDSpDeoETiO8gFVwjNCsCeVbY4YYtA57qM31vEIB7UFPmlKTlIjseHp9Gccoz7UjMy8B9+sGgaTgf8akNHPfILOTW53vi0mukthF6qpXCvW60+HPhE7l5QEQpyZHX+JlQmBtrz47H6hlChswfVhfL5Q6C20FSH0bXaKJLPeR8y2J+N4ZEF1US5A41JnPsXvokSjQA5aOGDZy0qIHen3UufvZciSFYzL69NLcLwaWvYc7qn0tuk52LylTqhdquEe2xbcW8Ha2uP+wydEAQ5wrvtDUkfiqfA+XpiMu86PPqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(261102130727099003)(56012099006)(261022105027099003)(261022075727099003)(261009221227099003)(261021121427099003)(261026121527099003)(261009223027099003)(11063799006)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8+ebl2grNpzfbb57HAZ5CIDPs5UpiLTwpU+m5o1T95D6OvSvfCdrQqKKyffwvaKN0W2Ce9gWR8lw/FzOkfDab8x9lmsFVqbJ2i3sh0qYzYgNUQxULCKRDYYE3jZ/QZGdIDECL6QBJzYwSdm+H6kduIwz8u67sO1eC6oXYfuvsouuO9wDeaO3/NY2g5oNnGaNxNEe68ZK8MSqR5nwxuOKDvWzfzRSdGqDigyYb/4iCoGlC6glmKSrn+CxEGy6xwZeN2t1/f/iU9RuIfiaaI8xONQOoLgsAo+kViJ3dondnzj00EeRXqbdiZrz72RhnmXgAsKjss/S81jFVefLSJS3Pwl5cv+fPJ16m2/TvlOQ+isYSBwbKIGQLuXkFrucXIie7hT/aJUo3ASTD+2a1Qi52ifExC1iSmVKr3gvengMp17O0J0qAWQjmIDw9qqnTsLC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:07.2701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df8b84a-0224-4fdf-4b66-08df39f2bfd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

Introduce the core object and state for the fast-loading (DMA) 3D LUT
colorop. Add drm_plane_colorop_3dlut_dma_init(), which creates the
read-only LUT_3D_FORMATS blob (advertising the driver's accepted struct
drm_mode_3dlut_mode entries), the LUT_3D_FORMAT selection range, and the
FB_ID object property. The colorop must allow bypass, since removing
the LUT framebuffer bypasses it.

The colorop state gains a selected-format index and a reference-counted
framebuffer pointer; the state duplicate/destroy helpers take and drop
the framebuffer reference so an in-flight LUT buffer stays pinned for the
lifetime of the state.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_colorop.c | 86 +++++++++++++++++++++++++++++++++++
 include/drm/drm_colorop.h     | 56 +++++++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index b30413ad797b..3fc7884befbf 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -28,6 +28,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_plane.h>
+#include <drm/drm_framebuffer.h>
 
 #include "drm_crtc_internal.h"
 
@@ -464,6 +465,87 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
 }
 EXPORT_SYMBOL(drm_plane_colorop_3dlut_init);
 
+/**
+ * drm_plane_colorop_3dlut_dma_init - Initialize a DRM_COLOROP_3D_LUT_DMA
+ *
+ * @dev: DRM device
+ * @colorop: The drm_colorop object to initialize
+ * @plane: The associated drm_plane
+ * @funcs: control functions for the new colorop
+ * @formats: array of accepted buffer formats advertised to userspace
+ * @num_formats: number of entries in @formats
+ * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines. Must include
+ *         DRM_COLOROP_FLAG_ALLOW_BYPASS, since removing the LUT framebuffer
+ *         bypasses the colorop.
+ *
+ * Initializes a fast-loading (DMA) 3D LUT colorop. The colorop advertises
+ * the accepted buffer formats via a read-only LUT_3D_FORMATS blob, lets
+ * userspace select one via LUT_3D_FORMAT, and points FB_ID at the
+ * framebuffer holding the LUT data.
+ *
+ * @return zero on success, -E value on failure
+ */
+int drm_plane_colorop_3dlut_dma_init(struct drm_device *dev, struct drm_colorop *colorop,
+				     struct drm_plane *plane,
+				     const struct drm_colorop_funcs *funcs,
+				     const struct drm_mode_3dlut_mode *formats,
+				     size_t num_formats, uint32_t flags)
+{
+	struct drm_property_blob *blob;
+	struct drm_property *prop;
+	int ret;
+
+	if (!formats || !num_formats)
+		return -EINVAL;
+
+	/* Removing the LUT framebuffer bypasses the colorop. */
+	if (drm_WARN_ON(dev, !(flags & DRM_COLOROP_FLAG_ALLOW_BYPASS)))
+		return -EINVAL;
+
+	ret = drm_plane_colorop_init(dev, colorop, plane, funcs,
+				     DRM_COLOROP_3D_LUT_DMA, flags);
+	if (ret)
+		return ret;
+
+	/* LUT_3D_FORMATS: immutable blob listing the accepted buffer formats */
+	blob = drm_property_create_blob(dev,
+					num_formats * sizeof(*formats),
+					formats);
+	if (IS_ERR(blob))
+		return PTR_ERR(blob);
+
+	prop = drm_property_create(dev, DRM_MODE_PROP_IMMUTABLE | DRM_MODE_PROP_BLOB,
+				   "LUT_3D_FORMATS", 0);
+	if (!prop) {
+		drm_property_blob_put(blob);
+		return -ENOMEM;
+	}
+	colorop->lut_3d_formats_property = prop;
+	colorop->lut_3d_formats_blob = blob;
+	drm_object_attach_property(&colorop->base, prop, blob->base.id);
+
+	/* LUT_3D_FORMAT: selected index into the LUT_3D_FORMATS array */
+	prop = drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC, "LUT_3D_FORMAT",
+					 0, num_formats - 1);
+	if (!prop)
+		return -ENOMEM;
+	colorop->lut_3d_format_property = prop;
+	drm_object_attach_property(&colorop->base, prop, 0);
+
+	/* FB_ID: framebuffer holding the LUT data */
+	prop = drm_property_create_object(dev, DRM_MODE_PROP_ATOMIC, "FB_ID",
+					  DRM_MODE_OBJECT_FB);
+	if (!prop)
+		return -ENOMEM;
+	colorop->fb_property = prop;
+	drm_object_attach_property(&colorop->base, prop, 0);
+
+	drm_colorop_reset(colorop);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_plane_colorop_3dlut_dma_init);
+
 /**
  * drm_plane_colorop_fixed_matrix_init - Initialize a DRM_COLOROP_FIXED_MATRIX
  *
@@ -545,6 +627,8 @@ static void __drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colo
 
 	if (state->data)
 		drm_property_blob_get(state->data);
+	if (state->fb)
+		drm_framebuffer_get(state->fb);
 }
 
 struct drm_colorop_state *
@@ -573,6 +657,8 @@ drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop)
 static void __drm_atomic_helper_colorop_destroy_state(struct drm_colorop_state *state)
 {
 	drm_property_blob_put(state->data);
+	if (state->fb)
+		drm_framebuffer_put(state->fb);
 }
 
 void drm_colorop_atomic_destroy_state(struct drm_colorop *colorop,
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 26ef67c835e2..95922eb1044c 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -31,6 +31,8 @@
 #include <drm/drm_mode.h>
 #include <drm/drm_property.h>
 
+struct drm_framebuffer;
+
 /* DRM colorop flags */
 #define DRM_COLOROP_FLAG_ALLOW_BYPASS	(1<<0)	/* Allow bypass on the drm_colorop */
 
@@ -312,6 +314,22 @@ struct drm_colorop_state {
 	 */
 	enum drm_colorop_fixed_matrix_type fixed_matrix_type;
 
+	/**
+	 * @lut_3d_format:
+	 *
+	 * Index into the LUT_3D_FORMATS blob selecting the buffer format for
+	 * a DRM_COLOROP_3D_LUT_DMA colorop.
+	 */
+	uint32_t lut_3d_format;
+
+	/**
+	 * @fb:
+	 *
+	 * Reference-counted framebuffer holding the LUT data for a
+	 * DRM_COLOROP_3D_LUT_DMA colorop.
+	 */
+	struct drm_framebuffer *fb;
+
 	/** @state: backpointer to global drm_atomic_commit */
 	struct drm_atomic_commit *state;
 };
@@ -488,6 +506,39 @@ struct drm_colorop {
 	 */
 	struct drm_property *fixed_matrix_type_property;
 
+	/**
+	 * @lut_3d_formats_property:
+	 *
+	 * Immutable blob property listing the accepted buffer formats (an
+	 * array of struct drm_mode_3dlut_mode) for a DRM_COLOROP_3D_LUT_DMA
+	 * colorop.
+	 */
+	struct drm_property *lut_3d_formats_property;
+
+	/**
+	 * @lut_3d_format_property:
+	 *
+	 * Range property selecting an entry, by index, of the
+	 * @lut_3d_formats_blob array.
+	 */
+	struct drm_property *lut_3d_format_property;
+
+	/**
+	 * @fb_property:
+	 *
+	 * Object property (DRM_MODE_OBJECT_FB) pointing at the framebuffer
+	 * that holds the LUT data for a DRM_COLOROP_3D_LUT_DMA colorop.
+	 */
+	struct drm_property *fb_property;
+
+	/**
+	 * @lut_3d_formats_blob:
+	 *
+	 * The advertised list backing @lut_3d_formats_property, retained for
+	 * validation during atomic check.
+	 */
+	struct drm_property_blob *lut_3d_formats_blob;
+
 	/**
 	 * @next_property:
 	 *
@@ -544,6 +595,11 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
 				 uint32_t lut_size,
 				 enum drm_colorop_lut3d_interpolation_type interpolation,
 				 uint32_t flags);
+int drm_plane_colorop_3dlut_dma_init(struct drm_device *dev, struct drm_colorop *colorop,
+				     struct drm_plane *plane,
+				     const struct drm_colorop_funcs *funcs,
+				     const struct drm_mode_3dlut_mode *formats,
+				     size_t num_formats, uint32_t flags);
 int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct drm_colorop *colorop,
 					struct drm_plane *plane,
 					const struct drm_colorop_funcs *funcs,
-- 
2.56.0

