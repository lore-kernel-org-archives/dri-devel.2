Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA695C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9F210E3B5;
	Mon, 21 Sep 2026 07:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6dVz1gv";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A6710E1E3
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 17:39:44 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so909026f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789839583; x=1790444383; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4EHMIGahq49+RZLtM+Kl+epi4IOt/noj9kfBGnfIJZY=;
 b=V6dVz1gvgNIwA/ZmKCIQeZjEXoGSBCzvNlBD8qHXgO3xb4dFKK/5AovMttbHjri6aO
 eDA4mwANfBpBctS8hue9yhjk9tn+/SnC30Wb2W3N+TNxiUq2gomOJ8HeOgr8mFTnPgMM
 fKIlL1UdylGKV9aI+iKRUbXumjxr8m/lgy12lbmrZW0OHR+xkIxZWh53z4loadRWY/+8
 9PJJNX+zGb5INpjwFyFWsY5pvg4qm2iftEuzCfntvJYC/c3aiQNfM3V5FSxy4vdn7yaz
 s30SYze8r5A1xZGMfL2l6C34hPPmnDjtqpdqk50Rehfbw/hvAOxajcF2YToFKfJ7tGUf
 r96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789839583; x=1790444383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4EHMIGahq49+RZLtM+Kl+epi4IOt/noj9kfBGnfIJZY=;
 b=bZzut8CDknBz3+FLvVvxYU2GRg6uQGMjGzYSvjnv2pdj0eKWxu/8fR8WQveWU1p1Gb
 gCRIc1v5koUPC6LN2pXaBUfRIDhwUJbp2S5WNKxZI3jJs8906EzG8CqMk0bS9RxX7fI6
 SlV3j0jB5Sm/nFxaDSuk1iwmG+vQOdEwAwNRCGwM2f8hJ5iXHJtK7F5VZqizZVtXIaho
 YyUR+c929OHHVMKH8hmHZJhteEa/IH4nx0bm8UvHYmF+9JpDMlwkhMXig1Nc7ZTcAucz
 zhxR3XfKRNPS6uKvP9DaK/Cln8MtYO4hIBX7ssKMVGdcN7UkkN5P0fJYwCFhQoqeUOCF
 v7aw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRd4U1Dru2Z0+7aTRgzufUL+vXBmcuRHTd0H1n5uGih+iprW0XM3LpFnim9QdfviiTUv9qz7LZy68=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kxu4i6tWXhahurODQ9rxFM81Q088oU9YG/iu2ZLR4sf7i+TZ11
 zlyXgLlxEaBoryPo11DjAvpoSyhDtQYW8pwaKlMvhZXuq75muwIhKLEy
X-Gm-Gg: AYBFou10rxG1/YoK6OGDKEQrp1LP2BqWrnSUKM+ELB/m98QYKZGOL7AwKpklYen6uxy
 e0MhTwf6UQa/e71JCZXJ7Jke7DhIsNGoSgRgiFqok17Pb0WksYg88/vTDtFlYoY59s9nK61Tef3
 NhpgFqdmpOPGqui5qsHrnJ6iRFoQE1AsDvFIe9r0AbDpPyRWjwXjD3oT3gfuAE6TR+S8TjquMBK
 MMqmo04olsh9o39JRNzj2rc54rfSp/1QBLuibc97hVRWpOvrvRi7MRiVLWf2ZnD6zTgZeDomnrU
 KYtfG+IxoVUUL83qo7yDHY7apmbzuRw3T4PSbWpCgY65NCVt+ndGBrqW0KmUck5lmZqU+n+vxWe
 qHPlxh0FHtVg3GeYZd60Rc0Q3A809QwM5x9G2BFda6jtSHvukw9CAewL59aZf1v61PWVuoBlIZe
 aKzYjDhfpnw8eTHVUvqNnsjyGBD/WGzsb7KU3hsHbh5RJR1KJLo50aRibCDKKP
X-Received: by 2002:a05:6000:2081:b0:487:936:7ce0 with SMTP id
 ffacd0b85a97d-4871e268810mr7891242f8f.28.1789839582833; 
 Sat, 19 Sep 2026 10:39:42 -0700 (PDT)
Received: from fedora ([2a02:587:200a:7d00:31a7:37b6:ee54:4eca])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724562bcbsm9173384f8f.16.2026.09.19.10.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 10:39:42 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, George Karagounis <mail@taterr.org>
Subject: [PATCH] drm/i915/display: Split i845 and i9xx cursor updates into
 arm/noarm
Date: Sat, 19 Sep 2026 20:39:14 +0300
Message-ID: <20260919173914.111150-1-mail@taterr.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

There was a problem with the i845 and i9xx cursor update functions
they handled both position updates and control/base/size updates in
a single armed sequence. This prevented the cursor position from
being updated asynchronously, which can make the cursor feel laggy

To fix this i split the updates into two phases
1. noarm Calculates and writes the CURPOS register immediately.
2. arm Calculates and writes CURCNTR, CURBASE, and CURSIZE to
   latch the control and memory updates at vblank

Also handled a hardware quirk on i9xx platforms where CURPOS requires
a CURBASE write to arm the update. The arm phase now writes CURBASE
even if only the position changed

This resolves two inline TODOs and improves cursor responsiveness

Signed-off-by: George Karagounis <mail@taterr.org>
---
 drivers/gpu/drm/i915/display/intel_cursor.c | 44 +++++++++++++++------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index 0673f16f6fd0..c12a7222f2f6 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -270,14 +270,27 @@ static int i845_check_cursor(struct intel_crtc_state *crtc_state,
 	return 0;
 }
 
-/* TODO: split into noarm+arm pair */
+static void i845_cursor_update_noarm(struct intel_dsb *dsb,
+				     struct intel_plane *plane,
+				     const struct intel_crtc_state *crtc_state,
+				     const struct intel_plane_state *plane_state)
+{
+	struct intel_display *display = to_intel_display(plane);
+	u32 pos = 0;
+
+	if (plane_state && plane_state->uapi.visible)
+		pos = intel_cursor_position(crtc_state, plane_state, false);
+
+	intel_de_write_fw(display, CURPOS(display, PIPE_A), pos);
+}
+
 static void i845_cursor_update_arm(struct intel_dsb *dsb,
 				   struct intel_plane *plane,
 				   const struct intel_crtc_state *crtc_state,
 				   const struct intel_plane_state *plane_state)
 {
 	struct intel_display *display = to_intel_display(plane);
-	u32 cntl = 0, base = 0, pos = 0, size = 0;
+	u32 cntl = 0, base = 0, size = 0;
 
 	if (plane_state && plane_state->uapi.visible) {
 		unsigned int width = drm_rect_width(&plane_state->uapi.dst);
@@ -289,7 +302,6 @@ static void i845_cursor_update_arm(struct intel_dsb *dsb,
 		size = CURSOR_HEIGHT(height) | CURSOR_WIDTH(width);
 
 		base = plane_state->surf;
-		pos = intel_cursor_position(crtc_state, plane_state, false);
 	}
 
 	/* On these chipsets we can only modify the base/size/stride
@@ -301,14 +313,11 @@ static void i845_cursor_update_arm(struct intel_dsb *dsb,
 		intel_de_write_fw(display, CURCNTR(display, PIPE_A), 0);
 		intel_de_write_fw(display, CURBASE(display, PIPE_A), base);
 		intel_de_write_fw(display, CURSIZE(display, PIPE_A), size);
-		intel_de_write_fw(display, CURPOS(display, PIPE_A), pos);
 		intel_de_write_fw(display, CURCNTR(display, PIPE_A), cntl);
 
 		plane->cursor.base = base;
 		plane->cursor.size = size;
 		plane->cursor.cntl = cntl;
-	} else {
-		intel_de_write_fw(display, CURPOS(display, PIPE_A), pos);
 	}
 }
 
@@ -645,7 +654,21 @@ static void skl_write_cursor_wm(struct intel_dsb *dsb,
 			   skl_cursor_ddb_reg_val(ddb));
 }
 
-/* TODO: split into noarm+arm pair */
+static void i9xx_cursor_update_noarm(struct intel_dsb *dsb,
+				     struct intel_plane *plane,
+				     const struct intel_crtc_state *crtc_state,
+				     const struct intel_plane_state *plane_state)
+{
+	struct intel_display *display = to_intel_display(plane);
+	enum pipe pipe = plane->pipe;
+	u32 pos = 0;
+
+	if (plane_state && plane_state->uapi.visible)
+		pos = intel_cursor_position(crtc_state, plane_state, false);
+
+	intel_de_write_dsb(display, dsb, CURPOS(display, pipe), pos);
+}
+
 static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
 				   struct intel_plane *plane,
 				   const struct intel_crtc_state *crtc_state,
@@ -653,7 +676,7 @@ static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
 {
 	struct intel_display *display = to_intel_display(plane);
 	enum pipe pipe = plane->pipe;
-	u32 cntl = 0, base = 0, pos = 0, fbc_ctl = 0;
+	u32 cntl = 0, base = 0, fbc_ctl = 0;
 
 	if (plane_state && plane_state->uapi.visible) {
 		int width = drm_rect_width(&plane_state->uapi.dst);
@@ -666,7 +689,6 @@ static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
 			fbc_ctl = CUR_FBC_EN | CUR_FBC_HEIGHT(height - 1);
 
 		base = plane_state->surf;
-		pos = intel_cursor_position(crtc_state, plane_state, false);
 	}
 
 	/*
@@ -703,14 +725,12 @@ static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
 		if (HAS_CUR_FBC(display))
 			intel_de_write_dsb(display, dsb, CUR_FBC_CTL(display, pipe), fbc_ctl);
 		intel_de_write_dsb(display, dsb, CURCNTR(display, pipe), cntl);
-		intel_de_write_dsb(display, dsb, CURPOS(display, pipe), pos);
 		intel_de_write_dsb(display, dsb, CURBASE(display, pipe), base);
 
 		plane->cursor.base = base;
 		plane->cursor.size = fbc_ctl;
 		plane->cursor.cntl = cntl;
 	} else {
-		intel_de_write_dsb(display, dsb, CURPOS(display, pipe), pos);
 		intel_de_write_dsb(display, dsb, CURBASE(display, pipe), base);
 	}
 }
@@ -1019,6 +1039,7 @@ intel_cursor_plane_create(struct intel_display *display,
 	if (display->platform.i845g || display->platform.i865g) {
 		cursor->max_stride = i845_cursor_max_stride;
 		cursor->min_alignment = i845_cursor_min_alignment;
+		cursor->update_noarm = i845_cursor_update_noarm;
 		cursor->update_arm = i845_cursor_update_arm;
 		cursor->disable_arm = i845_cursor_disable_arm;
 		cursor->get_hw_state = i845_cursor_get_hw_state;
@@ -1036,6 +1057,7 @@ intel_cursor_plane_create(struct intel_display *display,
 		if (intel_scanout_needs_vtd_wa(display))
 			cursor->vtd_guard = 2;
 
+		cursor->update_noarm = i9xx_cursor_update_noarm;
 		cursor->update_arm = i9xx_cursor_update_arm;
 		cursor->disable_arm = i9xx_cursor_disable_arm;
 		cursor->get_hw_state = i9xx_cursor_get_hw_state;
-- 
2.55.0

