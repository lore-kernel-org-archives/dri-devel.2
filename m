Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA68C79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC6610F534;
	Fri, 11 Sep 2026 07:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mgn+WKrm";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870E010E29D
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 19:25:32 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfb6so118707a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 12:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789068332; x=1789673132; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+PeYuTXLJN0HyhAFocaxbl7I4I0JEiUHMhHC88VArJc=;
 b=Mgn+WKrmbl+VNunwLIGCVCnlkKeO1P04zADYdrJ03rf/W4jx2MRBrdCwo5haElVPI7
 Gdzl8rI4P09eJW7oUv/e3nTFUA3SnukTp28GAGl1/lYiFOGSLF9L2ZTQCcfRdBEmxDbu
 65uQMa+ZOWFNAmwvgC5CNVBTmuFin8Vtv7lzjvKAkh8ghTgR18zWfuhtXuSwV5YWCyOe
 ECGoGg+Tx6gKGBqeGjHnJXL9llpSJbvQrZbKjHW1aLFVdygHS8AHgMbaMMNC+D5sQdAg
 VvuWlwvwyMqGzHrscBof8fCEqax7hl1FPSBITZVbdJJAuJg8Dd0vO3mJgAoodqZD57ke
 resg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789068332; x=1789673132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+PeYuTXLJN0HyhAFocaxbl7I4I0JEiUHMhHC88VArJc=;
 b=pPRyYrH4lcPWOArs0suiJvExkXy81Igp0+WnxLARFRjf2MhTQHZtOZe6rEHSh/Fw0U
 vOUHBDzSx74Vxil46rNOQPLLqz1pwh5ugU64Vna+CQvu1TOvUS5/KZ9l+PzEtH+NpEj/
 Fe/dJleQsARlNLDhwH/sGSe2MseoD0TdaCq7HvrvGGEA2W6d8M6sH8S29rCG/f9hCDst
 MS0ttbSuBGS88019Tm8Rsqn1leOf99tK2l6SjZafl3C2G2v5KUbL9ylduEnApbAD8suz
 opp271aqr0wb3Z1oUuz3DPYCtfQQ9Zkcv2GwyKf26lz4of/m/D+ySTuS/zGWU7GmtqzS
 QDOg==
X-Forwarded-Encrypted: i=1;
 AKwUvByy3m2T2Fv8C5D8+iE6y37NhgLq6m/x1wwYVOJW7vQh/LT8FsGwNiSfpPzoKq8SQ32I/aO6ss6HRSw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lBKkTrWA6jTj70p6abteWiEtCPr26PzdsjeYtOeZYCQvUlBx8D
 3f+7llJH59o3nNxrHCtc5Q6b8h4FjTqXCjxgAWnOMhGjagwkbYW6tHiGa9fLqyrM
X-Gm-Gg: AYBFou3/yLKC9T4dfabZkQCUh4v8XiwDvhdzthrVWQLuz+y0mwLTsEqAEaJpCoMkLpj
 m3EWb9wwYbugHbloVtKA2fCxkS/mIyBk25FmmrTsUMfteGzALKK/ddqSA6FM89hoJS5t/4KBRWl
 aGusUjJUD67DBzvfMrWKlvIwDkfLnl3FNjz9YI/sq5juEw3BVQvGnwbSPi+CKKQdA0+ArxQv+tq
 j7hAyggy3tdsK9QrP1zS3jB1y08XhJFsuLCrH2Vykh4XK7mRq+H3AC393YBbu6tecQjwAgBjIis
 fgaxag5YZb6Hw1g16lRDuPGNd/psrgOvbzZACOuGHQzszhJb1YeegyEwu8xAQeFlTU96TwM6yQT
 zGiS7rty5Fjsm9YDuPbTzVB6UIWXiBOnwn9OLJJ8FcAYUpbqOxzBjqLSD02/wRpZrJRHGzaaf85
 LKxVdFuIO+KoqFKe2XbSTFRtP26LPsL7n1hCut6GkPPbPZh9yiRj+j6UWXT5YLQWstxG5JB9IR
X-Received: by 2002:a05:6a20:3c8d:b0:3d0:8cbb:8c2d with SMTP id
 adf61e73a8af0-3daed2183cemr810896637.4.1789068331771; 
 Thu, 10 Sep 2026 12:25:31 -0700 (PDT)
Received: from fox.. ([43.242.224.196]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f1e434sm228408eec.22.2026.09.10.12.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 12:25:31 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: linusw@kernel.org,
	dri-devel@lists.freedesktop.org
Cc: leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, pimyn@google.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/pl111: drop alpha formats the hardware cannot scan out
Date: Fri, 11 Sep 2026 00:55:26 +0530
Message-ID: <20260910192526.137057-1-roshaen09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825105427.686619-1-roshaen09@gmail.com>
References: <20260825105427.686619-1-roshaen09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

The PL110/PL111 controller scans out a single framebuffer and never
blends its alpha channel with anything. In every pixel-format table
each alpha-carrying entry (ARGB/ABGR in 8888, 1555 and 4444) maps to
exactly the same register configuration as its XRGB/XBGR counterpart,
so the alpha byte was never used by the hardware.

Commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
with alpha exposed") added validation that warns when a plane exposes
alpha formats without a pixel blend mode property, and PL111 does exactly
that. With panic_on_warn enabled the warning prevents the syzkaller
vexpress-a15 manager from booting.

Drivers should not report formats they do not support, so remove the
alpha formats from all variant tables: the generic PL110, PL111 and
Nomadik tables in pl111_drv.c and the board-specific Integrator, IM-PD1,
Versatile and RealView/Versatile-Express tables in pl111_versatile.c,
plus the now dead case labels in the display setup and the Versatile
syscon connector switch, instead of advertising a blend mode property.
Behavior is unchanged for userspace that picks an XRGB/XBGR/RGB format;
alpha-picking clients fall back to the identical X variant.

Link: https://github.com/google/syzkaller/issues/7805
Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Roshan Kumar <roshaen09@gmail.com>

Changes in v2: drop the alpha formats entirely instead of advertising a
DRM_MODE_BLEND_PIXEL_NONE property, per review feedback from Thomas
Zimmermann. Leandro's Reviewed-by from v1 is not carried as the
approach changed.

Changes in v3: v2 missed the board-specific variant tables in
pl111_versatile.c (Integrator, IM-PD1, Versatile, RealView and
Versatile Express), which still exposed alpha formats and would fall
through to the WARN_ONCE default in pl111_display_enable() on those
boards. Pointed out by the sashiko AI reviewer.
---
 drivers/gpu/drm/pl111/pl111_display.c   |  6 ------
 drivers/gpu/drm/pl111/pl111_drv.c       | 16 ----------------
 drivers/gpu/drm/pl111/pl111_versatile.c | 18 ------------------
 3 files changed, 40 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 5d10bc5fdf1f..e1b513d36c27 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -267,14 +267,12 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		if (priv->variant->st_bitmux_control)
 			cntl |= CNTL_ST_LCDBPP24_PACKED;
 		break;
-	case DRM_FORMAT_ABGR8888:
 	case DRM_FORMAT_XBGR8888:
 		if (priv->variant->st_bitmux_control)
 			cntl |= CNTL_LCDBPP24 | CNTL_BGR;
 		else
 			cntl |= CNTL_LCDBPP24;
 		break;
-	case DRM_FORMAT_ARGB8888:
 	case DRM_FORMAT_XRGB8888:
 		if (priv->variant->st_bitmux_control)
 			cntl |= CNTL_LCDBPP24;
@@ -297,13 +295,11 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		else
 			cntl |= CNTL_LCDBPP16_565 | CNTL_BGR;
 		break;
-	case DRM_FORMAT_ABGR1555:
 	case DRM_FORMAT_XBGR1555:
 		cntl |= CNTL_LCDBPP16;
 		if (priv->variant->st_bitmux_control)
 			cntl |= CNTL_ST_1XBPP_5551 | CNTL_BGR;
 		break;
-	case DRM_FORMAT_ARGB1555:
 	case DRM_FORMAT_XRGB1555:
 		cntl |= CNTL_LCDBPP16;
 		if (priv->variant->st_bitmux_control)
@@ -311,13 +307,11 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		else
 			cntl |= CNTL_BGR;
 		break;
-	case DRM_FORMAT_ABGR4444:
 	case DRM_FORMAT_XBGR4444:
 		cntl |= CNTL_LCDBPP16_444;
 		if (priv->variant->st_bitmux_control)
 			cntl |= CNTL_ST_1XBPP_444 | CNTL_BGR;
 		break;
-	case DRM_FORMAT_ARGB4444:
 	case DRM_FORMAT_XRGB4444:
 		cntl |= CNTL_LCDBPP16_444;
 		if (priv->variant->st_bitmux_control)
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index ac7b1d12a0f5..2175ac953795 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -341,13 +341,9 @@ static void pl111_amba_shutdown(struct amba_device *amba_dev)
  * This early variant lacks the 565 and 444 pixel formats.
  */
 static const u32 pl110_pixel_formats[] = {
-	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ABGR1555,
 	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_XRGB1555,
 };
 
@@ -361,19 +357,13 @@ static const struct pl111_variant_data pl110_variant = {
 
 /* RealView, Versatile Express etc use this modern variant */
 static const u32 pl111_pixel_formats[] = {
-	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_BGR565,
 	DRM_FORMAT_RGB565,
-	DRM_FORMAT_ABGR1555,
 	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_ABGR4444,
 	DRM_FORMAT_XBGR4444,
-	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_XRGB4444,
 };
 
@@ -387,19 +377,13 @@ static const struct pl111_variant_data pl111_variant = {
 static const u32 pl110_nomadik_pixel_formats[] = {
 	DRM_FORMAT_RGB888,
 	DRM_FORMAT_BGR888,
-	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_BGR565,
 	DRM_FORMAT_RGB565,
-	DRM_FORMAT_ABGR1555,
 	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_ABGR4444,
 	DRM_FORMAT_XBGR4444,
-	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_XRGB4444,
 };
 
diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index 0d8331a3909f..9a60f10231b1 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -209,9 +209,7 @@ static void pl111_versatile_enable(struct drm_device *drm, u32 format)
 	drm_info(drm, "enable Versatile CLCD connectors\n");
 
 	switch (format) {
-	case DRM_FORMAT_ABGR8888:
 	case DRM_FORMAT_XBGR8888:
-	case DRM_FORMAT_ARGB8888:
 	case DRM_FORMAT_XRGB8888:
 		val |= SYS_CLCD_MODE_888;
 		break;
@@ -221,9 +219,7 @@ static void pl111_versatile_enable(struct drm_device *drm, u32 format)
 	case DRM_FORMAT_RGB565:
 		val |= SYS_CLCD_MODE_565_B_LSB;
 		break;
-	case DRM_FORMAT_ABGR1555:
 	case DRM_FORMAT_XBGR1555:
-	case DRM_FORMAT_ARGB1555:
 	case DRM_FORMAT_XRGB1555:
 		val |= SYS_CLCD_MODE_5551;
 		break;
@@ -266,44 +262,30 @@ static void pl111_realview_clcd_enable(struct drm_device *drm, u32 format)
 
 /* PL110 pixel formats for Integrator, vanilla PL110 */
 static const u32 pl110_integrator_pixel_formats[] = {
-	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ABGR1555,
 	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_XRGB1555,
 };
 
 /* Extended PL110 pixel formats for Integrator and Versatile */
 static const u32 pl110_versatile_pixel_formats[] = {
-	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_BGR565, /* Uses external PLD */
 	DRM_FORMAT_RGB565, /* Uses external PLD */
-	DRM_FORMAT_ABGR1555,
 	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_XRGB1555,
 };
 
 static const u32 pl111_realview_pixel_formats[] = {
-	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_BGR565,
 	DRM_FORMAT_RGB565,
-	DRM_FORMAT_ABGR1555,
 	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_ABGR4444,
 	DRM_FORMAT_XBGR4444,
-	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_XRGB4444,
 };
 
-- 
2.43.0

