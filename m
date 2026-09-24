Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEECC98326
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB9F10F918;
	Fri, 25 Sep 2026 07:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="clmtSsbj";
	dkim-atps=neutral
Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com
 [74.125.230.234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A94410E198
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 02:53:53 +0000 (UTC)
Received: by mail-qk2-f42.google.com with SMTP id
 d75a77b69052e-52fb76bcb1eso15924981cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790218432; x=1790823232; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wvc7ihS48CMwaqQEEFS304xLksjJ1u/xnvvm0QQvd88=;
 b=clmtSsbj9d3G2AKEqJZY07ksY7IA5uwCITRTEV9TftKxTkvTogiLh/QER3pBg6pGA6
 MBIfwnLOsO3rCDuZR3mbLIoVMuO4VXHOYktoog9wt1799C0TaylDFT0nOXc4xfXkx6r6
 2SPuZnf+oXaqQM3S00leNxXAAm5gUNtEOIUAToT+P/mQKnL2Ah6xD2mwUNgkUlihSa7G
 I0ELCcU48tE83z9QOULyM2xRTdg9aK6i3QwY7LFK5MgdS8FHHbbY7rlCsUiBzJjTHSlF
 u8Ox9W/zVHAbd0toYS091oEGIu83sG0cp350SubnbGOLmqvH7gskdojueGPSt/pRVHP7
 zAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790218432; x=1790823232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wvc7ihS48CMwaqQEEFS304xLksjJ1u/xnvvm0QQvd88=;
 b=C19VCYqgIphIuPqXMZixx73f7+YKC/CxxVJ5nFEokHexEmXXSDyx65TU/WXdQlPZVS
 FXk2AEDDjGvf0NMfLRUIgOElAmTlG7OXX+TTYOQwRokjZ9vgfV29Y2xxIfnao2SsIRsR
 yQdch6dOM4Djt85zItQraDw4xrb1rJOVhomGyfaun4K25zKQF8umTBrt2YOpPEol/lXB
 00IXYaFHxT1R1D9/FY9pcsNnc8TfpXYETGkLcdXB+wKc9iruY2RFljNyUqP9c75EBKvH
 2SDCDstO/t1a9p3HDzew1ZvvVst7SnskNnPV1p2/gpDlVutwUgwvF4muHvZhHWmkQcIL
 UVxQ==
X-Gm-Message-State: AFuF++la04uwDWzZcxZYexRqavrdEATb4DCylcbLiC+DnmYxfcW5OaVg
 D53IZ0OjebNzSJUftFk/K2YAaO2ZhS9of/Hk3NenMva3T63vHcWTcwrGdhcPGctHMRc=
X-Gm-Gg: AYBFou1uZVfqSY92pAfNWcdkfl69JQFN6yRLNUPagG8n+nuybyfzr8XDklMaplQAUmu
 yK/zSZaJruKi18+Vle6Aj8yfdX3JawkKeO/qwRleFLygq3C09PY6FyxBZDTuv9FcY8FNW4CbQ/d
 WULE+YavmrD1Onb45JsbmCISmx7z6Ul+TVR+6DFnlq53v3JTTrTDxX1TSv1AT1MCkYpc3LdxYDw
 0uPCpDhigD3P96bpcm2o0FcFV+MR02VIFAgiHDq8s2QxwolOpYBdKB2+JVbzcjY+PhQF1/HSlqZ
 szeHvJjGk+bbWOCtc6luVdOu+iwqPPKd3VwBSbMTkqXcT5WkwQ8pMw5TvoWTKVTS0cb0eHOVaoE
 oyo0BRID4IHJubT2OY4xesrE1YMMMZwmerrdxYoBfZwvN2SvARSXl+9FTf/GEOkTHjEpBgZKx1h
 gOwg5Q/Qy5/NzToJuB/RUZLQ31t/VPUF5CvVKNUgYMon4h0hRlBbuKQcfekbzvgBGStk/nUpupQ
 cV5y7dYrLBDLr2/JCBHdG+70Hmr8NbAxlrdV9tv5DydPyHERFVQUB5Z9qudCxWnWqY=
X-Received: by 2002:a05:622a:250b:b0:530:e335:58b3 with SMTP id
 d75a77b69052e-532feb571afmr5037371cf.57.1790218431820; 
 Wed, 23 Sep 2026 19:53:51 -0700 (PDT)
Received: from localhost.localdomain
 ([2600:4040:29f7:9600:11c6:662b:adfc:7c99])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532f501100asm18940981cf.24.2026.09.23.19.53.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 19:53:51 -0700 (PDT)
From: Dillon Amburgey <dillona@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com, airlied@gmail.com, kraxel@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/qxl: size packed dumb heads from the plane source
Date: Wed, 23 Sep 2026 22:52:22 -0400
Message-ID: <20260924025222.6077-1-dillona@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

QXL packs per-CRTC dumb buffers into a single primary surface.
qxl_update_dumb_head() recorded each dumb BO allocation (bo->surf)
instead of the plane source rectangle. Scanning 1280x800 from a
2048x1024 dumb framebuffer beside a 1024x768 head therefore created
a 3072x1024 primary and placed head 1 at +2048, rather than 2304x800
with head 1 at +1280.

Use src_w/src_h when building the packed shadow, and copy only that
source rectangle into it.

Fixes: 90adda2ce898 ("drm/qxl: cover all crtcs in shadow bo.")
Assisted-by: LLM sparse
Signed-off-by: Dillon Amburgey <dillona@gmail.com>
---
Tested on torvalds/linux 62f4c998b297. A DRM client (not Xorg, not
SPICE) programmed one QXL device with max_outputs=2. CRTC 0 scans a
1280x800 rectangle from a 2048x1024 dumb framebuffer (the allocation
is larger than the scanout). CRTC 1 scans a separate 1024x768 dumb
framebuffer. Unpatched, qxl_update_dumb_head() sizes packed heads
from bo->surf, so QEMU's qxl_create_guest_primary is 3072x1024
(2048+1024 by max height) and monitors_config places head 1 at +2048.
With this patch, the primary is 2304x800 (1280+1024) and head 1 is at
+1280.

Content outside CRTC 0's 1280x800 source rectangle did not appear in
the packed primary, and both heads' source rectangles did.

checkpatch.pl --strict: 0 errors, 0 warnings, 0 checks. W=1 and Sparse
on drivers/gpu/drm/qxl/qxl_display.c added no warnings.

 drivers/gpu/drm/qxl/qxl_display.c | 39 ++++++++++++++++---------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 0719fc6a52d5..e57aeeb97f84 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -670,13 +670,17 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 	struct qxl_device *qdev = to_qxl(plane->dev);
 	struct qxl_bo *bo = gem_to_qxl_bo(new_state->fb->obj[0]);
 	struct qxl_bo *primary;
-	struct drm_clip_rect norect = {
-	    .x1 = 0,
-	    .y1 = 0,
-	    .x2 = new_state->fb->width,
-	    .y2 = new_state->fb->height
-	};
+	struct drm_clip_rect norect;
 	uint32_t dumb_shadow_offset = 0;
+	u32 src_x = new_state->src_x >> 16;
+	u32 src_y = new_state->src_y >> 16;
+	u32 src_w = new_state->src_w >> 16;
+	u32 src_h = new_state->src_h >> 16;
+
+	norect.x1 = src_x;
+	norect.y1 = src_y;
+	norect.x2 = src_x + src_w;
+	norect.y2 = src_y + src_h;
 
 	primary = bo->shadow ? bo->shadow : bo;
 
@@ -689,7 +693,7 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 
 	if (bo->is_dumb)
 		dumb_shadow_offset =
-			qdev->dumb_heads[new_state->crtc->index].x;
+			qdev->dumb_heads[new_state->crtc->index].x - src_x;
 
 	qxl_draw_dirty_fb(qdev, new_state->fb, bo, 0, 0, &norect, 1, 1,
 			  dumb_shadow_offset);
@@ -764,18 +768,14 @@ static void qxl_cursor_atomic_disable(struct drm_plane *plane,
 	qcrtc->cursor_bo = NULL;
 }
 
-static void qxl_update_dumb_head(struct qxl_device *qdev,
-				 int index, struct qxl_bo *bo)
+static void qxl_update_dumb_head(struct qxl_device *qdev, int index,
+				 struct qxl_bo *bo, uint32_t width,
+				 uint32_t height)
 {
-	uint32_t width, height;
-
 	if (index >= qdev->monitors_config->max_allowed)
 		return;
 
-	if (bo && bo->is_dumb) {
-		width = bo->surf.width;
-		height = bo->surf.height;
-	} else {
+	if (!bo || !bo->is_dumb) {
 		width = 0;
 		height = 0;
 	}
@@ -820,12 +820,11 @@ static void qxl_calc_dumb_shadow(struct qxl_device *qdev,
 }
 
 static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
-			       int crtc_index)
+			       int crtc_index, uint32_t width, uint32_t height)
 {
 	struct qxl_surface surf;
 
-	qxl_update_dumb_head(qdev, crtc_index,
-			     user_bo);
+	qxl_update_dumb_head(qdev, crtc_index, user_bo, width, height);
 	qxl_calc_dumb_shadow(qdev, &surf);
 	if (!qdev->dumb_shadow_bo ||
 	    qdev->dumb_shadow_bo->surf.width  != surf.width ||
@@ -869,7 +868,9 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
 	    user_bo->is_dumb) {
-		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index);
+		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index,
+				   new_state->src_w >> 16,
+				   new_state->src_h >> 16);
 	}
 
 	if (plane->type == DRM_PLANE_TYPE_CURSOR &&

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.43.0

