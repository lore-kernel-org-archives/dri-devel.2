Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A42CD6E55
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 00:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CE410EAAE;
	Tue,  2 Jun 2026 00:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="fQ0zu/r1";
	dkim-atps=neutral
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com
 [209.85.160.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE89410EAAD
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 00:38:57 +0000 (UTC)
Received: by mail-qt1-f227.google.com with SMTP id
 d75a77b69052e-516d634956fso124624171cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780360737; x=1780965537;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dPsFqQz7h6W1OHlMi/rkwVkmhB+py6dtji4+zYayJYY=;
 b=renIX3xArWkehZhtsX4UGkBM6ITy+DPXgx8U7TErVXrBVvOGqZoWbduA343EI41oJI
 8MMi2s8M3ZeIw+ri5zZJX7Rnj+gV7DbqT4dUhQuARz6oU3fuiGd8YL34+i2OTIeCfqN3
 56otOUFE2QbXcdA9ON7RH8BhLs2OgrFNlnJj951GkjBNbEIo3lpV1Sj+h9QbOC+H4yVE
 qXkZdF4gVGDpslFYHLMr0h0a1NqtJnsmMp/t+VsZlsHCkXkVc48PaDm7mDHRsKz7Zure
 8zOUlnf5ctwx9G7YWUIqKdDEkTymkx+pxMvliNjfodkSw2XAAdIslo+JZBLsIAnK1PGM
 1yNw==
X-Gm-Message-State: AOJu0YzbRNjxZhY58zLeNLnqlR73J4XLw2YuFHvBW2xq+7Ba3/XSrnrd
 mGS+2ntoS6aHfgj2Pd0DMrnr7aEFzr+ZRJJ6wXR8rUPuwjpIW23Biot0M90nCr96PuMYdNEPWRQ
 HEq8NwS32jxlPekRgWL3pAWrCppsGnmyVsZXk3D429eMWlitD4w+0DuFn9ClQwi4z85z/IfNKxH
 4otmUx/amVG4My/StSPDzWEoVxwH+DV3GTvmHGtv9wC1ndfz6VWPDDk/lrWxSG37MuzlUtAh0lX
 eLQoT7fU/8OgMQ5B3FhoEAb99L6
X-Gm-Gg: Acq92OEcrWUS+eCDtHh67Kc2zPKWAsQFyPKbQMw9U5rnAyrk4VoSkQpFBFiTiT4Qm7q
 z6p7NxW2DIAj7XtjrNSvO6mvUO/JLY+5m8kMxS0YgENvbjpfGwU7I/00XLhS4+b3Tatf3CYhD9s
 fgkJVvq4yHQmW7PYE7ZtNhyrS7BtbUv0PL9rOLe2lV1be5GVcS0yEgyQx9D6cOizl9MbVnO8dsN
 ddpM1j3W5yKSyFGZSYZDN3deOae1bc7WYqQe0htCj7vLcMrfBRKmonKHPpKuldZUMT/2GAa9o4D
 vGwTSEk3oO7+80QUEEktlExrO3G5qidPL2Y9ofoQ4LtExWmooOWblRrWtf16AmyoYsKN4+PK2SH
 5b4n443ptHF9vJD+FtQqvrxJGc/Q+v/RCWxjiCUBnplyABtQDDL9PPvdvjMTafHMf0kMwc+GKIw
 hQwGRRbb2JpVSdjhtIE7tLEdOCJMg9NKJJ3XMkA0YapEI0+aNvI/snJ/EW9xz59ZJRKWG8n1v7
X-Received: by 2002:a05:622a:15c2:b0:517:5b79:c109 with SMTP id
 d75a77b69052e-5175b79c15emr65693071cf.56.1780360736403; 
 Mon, 01 Jun 2026 17:38:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-5175c635d57sm1677031cf.23.2026.06.01.17.38.56
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2026 17:38:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ccf0174d1cso68539426d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780360736; x=1780965536;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dPsFqQz7h6W1OHlMi/rkwVkmhB+py6dtji4+zYayJYY=;
 b=fQ0zu/r1PN84F9/H1lpb6VRna1qvTrGeq3F18HD7e/BK8fd5B/RDHeKqDLdpqGGHi+
 FoliufFjfQ9882fKhiNP+s1moPYBzi3XxAizt6ZIE8plQvWV9/mrZ55HdhNRznzNFGUu
 Ih3XlR0PUmpgWhwzj3C0KMHNZc3Ll7wZTdl3I=
X-Received: by 2002:a05:6214:c6b:b0:8cc:ea2c:f2b5 with SMTP id
 6a1803df08f44-8ccefd92d4dmr235578716d6.23.1780360735734; 
 Mon, 01 Jun 2026 17:38:55 -0700 (PDT)
X-Received: by 2002:a05:6214:c6b:b0:8cc:ea2c:f2b5 with SMTP id
 6a1803df08f44-8ccefd92d4dmr235578426d6.23.1780360735192; 
 Mon, 01 Jun 2026 17:38:55 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([216.221.25.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea1cadd2sm108125616d6.24.2026.06.01.17.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 17:38:54 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v5 1/4] drm/vmwgfx: Add some checks to
 vmw_cursor_plane_atomic_update
Date: Mon,  1 Jun 2026 17:42:00 -0700
Message-ID: <20260602004203.102901-2-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602004203.102901-1-maaz.mombasawala@broadcom.com>
References: <20260602004203.102901-1-maaz.mombasawala@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

In cases where old_state may not be present we hit a null dereference.
Get display unit from cursor plane instead to fix this and also do an
early return if there is no new_state since there is nothing to do in
that case.
This fixes igt test kms_cursor_legacy@torture-bo.

Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Cc: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index b010fc7ca68e..35e3fd2bbdad 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -22,6 +22,9 @@
 #define VMW_CURSOR_SNOOP_WIDTH 64
 #define VMW_CURSOR_SNOOP_HEIGHT 64
 
+#define vmw_cursor_to_du(cursor_plane) \
+	container_of(cursor_plane, struct vmw_display_unit, cursor.base)
+
 struct vmw_svga_fifo_cmd_define_cursor {
 	u32 cmd;
 	SVGAFifoCmdDefineAlphaCursor cursor;
@@ -742,13 +745,14 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 			       struct drm_atomic_commit *state)
 {
 	struct vmw_bo *bo;
-	struct drm_plane_state *new_state =
-		drm_atomic_get_new_plane_state(state, plane);
-	struct drm_plane_state *old_state =
-		drm_atomic_get_old_plane_state(state, plane);
-	struct drm_crtc *crtc = new_state->crtc ?: old_state->crtc;
+	struct drm_plane_state *new_state;
+
+	new_state = drm_atomic_get_new_plane_state(state, plane);
+	if (!new_state)
+		return;
+
 	struct vmw_private *dev_priv = vmw_priv(plane->dev);
-	struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
+	struct vmw_display_unit *du = vmw_cursor_to_du(plane);
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(new_state);
 	s32 hotspot_x, hotspot_y, cursor_x, cursor_y;
 
-- 
2.54.0

