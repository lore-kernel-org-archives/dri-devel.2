Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1924606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FS574a7U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F58610F855;
	Tue,  3 Nov 2026 21:39:05 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC4210F899;
 Tue,  3 Nov 2026 21:38:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i70OxjA6xunfHxt09fF8qFpuqiIkAd59f30SUV735UvRjC5oj1gi0Fg5l9+IcgQbFiuOCWF9/xxgZd3QFeWTa8eeyAkVARko+Ja2m2JfOF5QuqKBAmowfOdrct7vVOY62zHCF4W0N/eMxnd0c+5dOtZVAqq8DgU46Cs9cex0FNAuuqb/eFzDAXnATxK+Nch5X02+3Qs2weUDzOyDUDz6VKrt/BAPxRUuF4djV/OgbYrTT+qiLKWUxnEsIAra5Za/7uDUyGmPitS0LMwgXq/25R8xXasPjCS5N8NO/GU4LvHAWW+PU6USSxpE3cfYFckMCcPgbBvuSIr4x03+0PMONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXiUsqj9rEYTp31KxuMYqzTfUcZBRA3cxaSYqlBSIbs=;
 b=dubKHjEN/IRProHh7UyIaTIPv8eccxyHRJ4WDV4KQQIox/pwFeLqMGUbfcpc43Ujt9Svq1EM+qUK3VJKmgHzfcHfrO8tdedefhGKJRADCjkADG5iFSHzBMzmN4sJ3rRH/fFoMPooXFY/xXB+AK3xYIiO08SdXHW0IiA/IDtFqcdD2WeyigOLXBjTlwtjddkufcCCixV6HSJYu8r7m0ymXjRpyrCoAMv5Mrw0OzAbgu2V4UiR07q3RezBVrg7yJ45yQo3n3cqtr7JJcLFhwABjvHp8vd5m6nIwdOBm/KYxOlHMg0TuZs3mHJHALbMIW2iw7aKCqUXf6e/vD02n4+BZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXiUsqj9rEYTp31KxuMYqzTfUcZBRA3cxaSYqlBSIbs=;
 b=FS574a7UxDh5rASpj5x99QEQmL2SLCnnNq1RfHUKI78tBdSdaqAmgmooeYTpF7CSKqLxO3ataKOiiRGGT+dlVmqhzSS7g+9WDR/VKxPzBTK3BepEULlJx/8N0tyYcZAW6dmkAjCnTwSz06sreQmYY+q4P6Qud/j6zi+lOWEfO20=
Received: from BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::7)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:38:09 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::57) by BL1P221CA0020.outlook.office365.com
 (2603:10b6:208:2c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:38:08 +0000
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
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:05 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:05 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 03/13] drm/atomic: wire up DMA 3D LUT colorop properties
Date: Tue, 3 Nov 2026 16:37:46 -0500
Message-ID: <20261103213756.618024-4-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: f88da44d-e80d-4289-0127-08df39f2c047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|261009221227099003|261026121527099003|261028144727099003|261009223327099003|261009221727099003|261026140227099003|261009220027099003|261009223027099003|261021123027099003|261022105027099003|261102123227099003|261022075727099003|261021121427099003|56012099006|11063799006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vpBAevFnVrl2JgxN4KX8czMuL2ajSO9uMVdi8AiQVrIZTuokclWC/XSlFiBX5igOS0Ql+aMCmE0twOB7PJFZ5gxb+TeUgxh8P/kLftVsxsPLS36MYOebBmSe8y2nkQYFq6RWq3NPIsoyClDcrhAeeNgwpKxLXgRYyW9oJFcyZ65g17XtNnDbJQZK2xzsuMoWw3VNEJCZ9HyHGXoAN4xGtMgyoSahD9lTggWvd0cAVC4iU/s+fItUf2TFUtSnbbNk1DUfBvUtscZULziuCLUoywSDDYu3Ete1rY9YkzccD6BhZope7YGDen1NNv1/tRMY2zopglMsyhVEqlzN8uaeOdGyz5J+k5dUc52YBkhQrRwCkOrZu12B+00iUkL0VylllOcjWQGaYAaqcW8bwKs/Zb6ou9ecG9Kl381o1vvogqVVWeOK9BZQcHvdZ1rDf2KTJDyyi4yNK3Ti1yTvJjm7cC9tuLOOBLiqzk2eBJd7n06mB3MTgM1FOqE9KjvPGxUcj2IQj5yRLPsPavlZi+MD5K6hnsJa5qKqLWeqpJ1SR61SARyokL0wncQpcRqJPqI8wtxa+elWLaLy5S9axY3+g0Y1eg7SJtEZ36wLLrM7Fxvx8G6t0w+XpaqvpVh38zO/ylEPSIe55FC/VXZwXRXwppUtZczlXNgMqTFmsnfCsw5D0OsTWsQxjQpxErXlogiiSG9DiYGf40aK1qjIjur1Tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(261009221227099003)(261026121527099003)(261028144727099003)(261009223327099003)(261009221727099003)(261026140227099003)(261009220027099003)(261009223027099003)(261021123027099003)(261022105027099003)(261102123227099003)(261022075727099003)(261021121427099003)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DIpU9kFQImDyM67NXLBEP3uG/fA9IERb+/rcf9PpsOz/Nff8VqPfr2OQvG7Kag36EtVrPdSwDVPqv53j0xhcHl2s/vp6Mb3e9PrV9zBElDQuc8ppGp7vHvuoIStTQ+ie94C1Wi1ml2EVB8+XkN9MjkhBWBnD5yCcxJsLukMsohA9xbJWR10mNgMwhZvMAZR5Wi5yI7Z4YK9xGZjtyCv9W+YH/DWoaIIYFSwHMHsn6ZQmZm4HTS3jRGH4WVY/3q34Up6VPMQ9ovZlgd5dru9eZo/625nKJhk1FePID2Lh8pt72H7mRM93J5f+m6PTpCOZl3KlRe3mhRTxm2/LOdxUHSYzyp3zPbqq9hvHfR+0SVZnfvCP7YcWs7rIMdW5b0og1Ob8/2+DduvrMVqIQ+wzam/KWa4gdorDIcIwFAm7mT6LIa2cqN9Bo7M++7JA3as2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:08.0214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88da44d-e80d-4289-0127-08df39f2c047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
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

Handle the FB_ID and LUT_3D_FORMAT properties in the colorop atomic
get/set paths, and report LUT_3D_FORMATS (the immutable formats blob) on
get. Setting FB_ID looks up the framebuffer and swaps the reference into
the colorop state (taking the new reference, dropping the old), mirroring
the plane FB_ID handling.

RMFB, and closing the DRM file that owns a framebuffer, disable the
planes that scan it out. Without further handling a colorop using the
framebuffer would keep it alive and the hardware would keep fetching
from it. Make atomic_remove_fb() also bypass every colorop using the
framebuffer and clear its FB_ID, flagging the plane's color management
as changed. Bypassing keeps the plane visible without the LUT, which is
less disruptive than disabling it. Document this in the RMFB and
CLOSEFB uAPI.

Also print the selected format index and framebuffer id for a
DRM_COLOROP_3D_LUT_DMA colorop in the atomic state dump.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_atomic.c      |  4 +++
 drivers/gpu/drm/drm_atomic_uapi.c | 24 +++++++++++++++++
 drivers/gpu/drm/drm_framebuffer.c | 45 ++++++++++++++++++++++++++++++-
 include/uapi/drm/drm.h            |  7 ++---
 4 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9bb761eda59f..158f41eae76f 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -939,6 +939,10 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 		drm_printf_indent(p, 1, "fixed_matrix_type=%s\n",
 				  drm_get_colorop_fixed_matrix_type_name(state->fixed_matrix_type));
 		break;
+	case DRM_COLOROP_3D_LUT_DMA:
+		drm_printf_indent(p, 1, "lut_3d_format=%u\n", state->lut_3d_format);
+		drm_printf_indent(p, 1, "fb=%u\n", state->fb ? state->fb->base.id : 0);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index aca0edb42a5a..05a2a3b46351 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -791,6 +791,24 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
 			state->fixed_matrix_type = val;
 			*replaced = true;
 		}
+	} else if (property == colorop->lut_3d_format_property) {
+		if (state->lut_3d_format != val) {
+			state->lut_3d_format = val;
+			*replaced = true;
+		}
+	} else if (property == colorop->fb_property) {
+		struct drm_framebuffer *fb = NULL;
+
+		if (val) {
+			fb = drm_framebuffer_lookup(colorop->dev, file_priv, val);
+			if (!fb)
+				return -EINVAL;
+		}
+		if (state->fb != fb)
+			*replaced = true;
+		drm_framebuffer_assign(&state->fb, fb);
+		if (fb)
+			drm_framebuffer_put(fb);
 	} else {
 		drm_dbg_atomic(colorop->dev,
 			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
@@ -825,6 +843,12 @@ drm_atomic_colorop_get_property(struct drm_colorop *colorop,
 		*val = (state->data) ? state->data->base.id : 0;
 	else if (property == colorop->fixed_matrix_type_property)
 		*val = state->fixed_matrix_type;
+	else if (property == colorop->lut_3d_formats_property)
+		*val = colorop->lut_3d_formats_blob ? colorop->lut_3d_formats_blob->base.id : 0;
+	else if (property == colorop->lut_3d_format_property)
+		*val = state->lut_3d_format;
+	else if (property == colorop->fb_property)
+		*val = (state->fb) ? state->fb->base.id : 0;
 	else
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index d32aceb6ca9b..05cce02238bc 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -26,6 +26,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_auth.h>
+#include <drm/drm_colorop.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
@@ -1002,10 +1003,12 @@ static int atomic_remove_fb(struct drm_framebuffer *fb)
 	struct drm_device *dev = fb->dev;
 	struct drm_atomic_commit *state;
 	struct drm_plane *plane;
+	struct drm_colorop *colorop;
 	struct drm_connector *conn __maybe_unused;
 	struct drm_connector_state *conn_state;
 	int i, ret;
 	unsigned plane_mask;
+	bool colorops_changed;
 	bool disable_crtcs = false;
 
 retry_disable:
@@ -1020,6 +1023,7 @@ static int atomic_remove_fb(struct drm_framebuffer *fb)
 
 retry:
 	plane_mask = 0;
+	colorops_changed = false;
 	ret = drm_modeset_lock_all_ctx(dev, &ctx);
 	if (ret)
 		goto unlock;
@@ -1068,6 +1072,45 @@ static int atomic_remove_fb(struct drm_framebuffer *fb)
 		plane_mask |= drm_plane_mask(plane);
 	}
 
+	/*
+	 * Colorops that fetch data from a framebuffer, such as a DMA 3D LUT,
+	 * are bypassed rather than disabling their plane. Such colorops are
+	 * required to support bypass.
+	 */
+	drm_for_each_colorop(colorop, dev) {
+		struct drm_colorop_state *colorop_state;
+		struct drm_plane_state *plane_state;
+
+		if (!colorop->state || colorop->state->fb != fb)
+			continue;
+
+		if (drm_WARN_ON(dev, !colorop->bypass_property)) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+
+		drm_dbg_kms(dev,
+			    "Bypassing [COLOROP:%d] because [FB:%d] is removed\n",
+			    colorop->base.id, fb->base.id);
+
+		colorop_state = drm_atomic_get_colorop_state(state, colorop);
+		if (IS_ERR(colorop_state)) {
+			ret = PTR_ERR(colorop_state);
+			goto unlock;
+		}
+
+		plane_state = drm_atomic_get_plane_state(state, colorop->plane);
+		if (IS_ERR(plane_state)) {
+			ret = PTR_ERR(plane_state);
+			goto unlock;
+		}
+
+		drm_framebuffer_assign(&colorop_state->fb, NULL);
+		colorop_state->bypass = true;
+		plane_state->color_mgmt_changed = true;
+		colorops_changed = true;
+	}
+
 	/* This list is only filled when disable_crtcs is set. */
 	for_each_new_connector_in_state(state, conn, conn_state, i) {
 		ret = drm_atomic_set_crtc_for_connector(conn_state, NULL);
@@ -1076,7 +1119,7 @@ static int atomic_remove_fb(struct drm_framebuffer *fb)
 			goto unlock;
 	}
 
-	if (plane_mask)
+	if (plane_mask || colorops_changed)
 		ret = drm_atomic_commit(state);
 
 unlock:
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index bc7ef7684099..2a06e8e08dbe 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -1217,7 +1217,8 @@ extern "C" {
  *
  * Warning: removing a framebuffer currently in-use on an enabled plane will
  * disable that plane. The CRTC the plane is linked to may also be disabled
- * (depending on driver capabilities).
+ * (depending on driver capabilities). Colorops using the framebuffer, such
+ * as a DMA 3D LUT, are bypassed instead.
  */
 #define DRM_IOCTL_MODE_RMFB		DRM_IOWR(0xAF, unsigned int)
 #define DRM_IOCTL_MODE_PAGE_FLIP	DRM_IOWR(0xB0, struct drm_mode_crtc_page_flip)
@@ -1321,8 +1322,8 @@ extern "C" {
  * argument is a framebuffer object ID.
  *
  * This IOCTL is similar to &DRM_IOCTL_MODE_RMFB, except it doesn't disable
- * planes and CRTCs. As long as the framebuffer is used by a plane, it's kept
- * alive. When the plane no longer uses the framebuffer (because the
+ * planes and CRTCs, or bypass colorops. As long as the framebuffer is used by
+ * a plane or colorop, it's kept alive. When it is no longer used (because the
  * framebuffer is replaced with another one, or the plane is disabled), the
  * framebuffer is cleaned up.
  *
-- 
2.56.0

