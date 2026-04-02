Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E906E7E345
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC4510F421;
	Fri,  3 Apr 2026 08:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="kWr5bTlg";
	dkim-atps=neutral
X-Greylist: delayed 663 seconds by postgrey-1.36 at gabe;
 Thu, 02 Apr 2026 02:02:42 UTC
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5720A10EFE5
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 02:02:41 +0000 (UTC)
X-KPN-MessageId: 7c158a5f-2e36-11f1-bea8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 7c158a5f-2e36-11f1-bea8-005056992ed3;
 Thu, 02 Apr 2026 03:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=mime-version:message-id:date:subject:to:from;
 bh=Upu3hspDUQtPDlHPtVRD7wHM/YoMYhyMfZlDEsMhLIQ=;
 b=kWr5bTlgUBAsYCFVZvEZKISUNJ8aAWb4r6CH1rdr3mDXF6e3cWXgZGeFpiLVXiht3o2mbQoE7K9RM
 jUsRuGOX5zT2x5SgY6oibHmgY+Rc2epyX/p3NOOydgwefv+2f3fdcvKGW4ON6zaZgz7ZsMuP4OPtIm
 UrJIxmgHrw0BRketDnTCBWOpSqKOEu56j8y6K+nQmWm5iUkGgo3LvLsabvTKKEaoeQOnS2iz1PpJm4
 gHq7Pj7/h6lSmkTvVEqPaXaOgxhnoJieKYim+Kczogweh4wtIfzqBKyfHpm1Y0LQUPEMYUa7bemHjJ
 t7m0XwuGt8QNfVQ+RM6sRok+TtBqA4Q==
X-KPN-MID: 33|d0yl7Q98SvCfDXiXT6MNI3+M172r2vhAevaezgnNeMz7hc66nPLLkBqAN87QFmi
 E99pckkSYaE7vMoavjHuq9kgBSZ7B6v7O82uXlivcUDY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|+eor1/XExEcGHdwXtd/w6CzghpLDsdomTA1L9wkEUJS6tTi4SqdF45cNcFGDY9T
 mPNBFmETAlbD/OH8ZPHhbVg==
X-Originating-IP: 188.212.113.114
Received: from DESKTOP-40RM2Q1.localdomain (unknown [188.212.113.114])
 by smtp.xs4all.nl (Halon) with ESMTPSA
 id 77d246e9-2e36-11f1-9c09-00505699d6e5;
 Thu, 02 Apr 2026 03:51:36 +0200 (CEST)
From: Henri Zikken <zikken@xs4all.nl>
To: Emma Anholt <emma@anholt.net>,
	Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Henri Zikken <zikken@xs4all.nl>, root <root@DESKTOP-40RM2Q1.localdomain>
Subject: [PATCH] drm/vc4: Fix NULL pointer dereference in
 vc4_plane_create_additional_planes
Date: Thu,  2 Apr 2026 01:51:01 +0000
Message-Id: <20260402015101.3328-1-zikken@xs4all.nl>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

When a vc4 DRM device has no TXP (Writeback) CRTC, txp_crtc remains
uninitialized after the drm_for_each_crtc loop. Subsequent calls to
drm_crtc_mask(txp_crtc) then dereference a NULL pointer, causing a
kernel panic.

This was observed on Raspberry Pi Zero 2W with a DPI panel connected,
where vc4_dpi_dev_probe triggers vc4_drm_bind which calls
vc4_plane_create_additional_planes without a TXP being present.

Fix by initializing txp_crtc to NULL and guarding all drm_crtc_mask()
calls on txp_crtc with a NULL check.

Fixes: (vc4_plane_create_additional_planes introduction)
Signed-off-by: Henri Zikken<zikken@xs4all.nl>
Signed-off-by: root <root@DESKTOP-40RM2Q1.localdomain>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index fdd6ba310..c43c12c2c 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -2665,7 +2665,7 @@ int vc4_plane_create_additional_planes(struct drm_device *drm)
 	struct drm_plane *cursor_plane;
 	struct drm_crtc *crtc;
 	unsigned int i;
-	struct drm_crtc *txp_crtc;
+	struct drm_crtc *txp_crtc = NULL;
 	uint32_t non_txp_crtc_mask;
 
 	drm_for_each_crtc(crtc, drm) {
@@ -2678,7 +2678,7 @@ int vc4_plane_create_additional_planes(struct drm_device *drm)
 	}
 
 	non_txp_crtc_mask = GENMASK(drm->mode_config.num_crtc - 1, 0) -
-					drm_crtc_mask(txp_crtc);
+					(txp_crtc ? drm_crtc_mask(txp_crtc) : 0);
 
 	/* Set up some arbitrary number of planes.  We're not limited
 	 * by a set number of physical registers, just the space in
@@ -2707,7 +2707,7 @@ int vc4_plane_create_additional_planes(struct drm_device *drm)
 	for (i = 0; i < VC4_NUM_TXP_OVERLAY_PLANES; i++) {
 		struct drm_plane *plane =
 			vc4_plane_init(drm, DRM_PLANE_TYPE_OVERLAY,
-				       drm_crtc_mask(txp_crtc));
+				       (txp_crtc ? drm_crtc_mask(txp_crtc) : 0));
 
 		if (IS_ERR(plane))
 			continue;
-- 
2.39.5

