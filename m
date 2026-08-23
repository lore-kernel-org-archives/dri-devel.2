Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE03C5DF9B
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE5410E49F;
	Sun, 23 Aug 2026 09:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DXYEY300";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D933A10E02F
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 08:32:21 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso1452831a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 01:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787473941; x=1788078741; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gQjZACrYdNbBdH+jtlaQgBXai3RCK9BnyKOFi8yya1Q=;
 b=DXYEY300SrhNasZ+i+YOcXHwKjG/bmj6wH69sFykOHn/iHE0ZYUCK7VU32XUoXaaU7
 e8pASSZn/AlQ0LsgnsJ/wXVq1HwV1eqDcVrtopbNA6J7U50++4imWywMHVDosk5sNb1a
 onFPCHxI6OC3I8Ckw/BkWgLRexqwhzhuG2M3Cmv0FVSe0vj6/AXzlnNI2oBAvJeD7LDM
 ABSyd23phkgU6nL/mN2XgHxtaGvjmzMSxVg3md79P9/G3zoSpe0/RaGumIzPPsPjj2ns
 Qb+KwFbPYGqhnTEi4hW0kZ0IQkaY5L+hNqOCRE+s3nTjY8RYyq4SlCpNEEqOBsQlK13E
 x/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787473941; x=1788078741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gQjZACrYdNbBdH+jtlaQgBXai3RCK9BnyKOFi8yya1Q=;
 b=r+5gK46Gf2OXJC8uL6RewMgQD4fkROzv98cJOhZ2ScrRytddBII/1JOqieZbGj1Klh
 QRMJPVfCdgHcStqVy4OnFDfz2yZOK6/PdCzuIFJqTZBXDSVkoRSWuxbFzLwA0WuzkXHe
 010juEpr60PM44Gg8RvEyvlA8tfUXec52Jc0omV6zybIuX3p6407iBLtMqHoim1z6mmD
 7T1YX9/GaDNprMozv/Y5bxLMpBcizpBuG2BzvMIHQqDwm6nTt1cDku0VjoDBDpa2POy4
 eR1poi5wSRQxZsCjikJGIMtHF2a5UVcF4nDRzA+f+jWQqw4QjeVbPHLdKIyIE0tuZiSg
 /1aQ==
X-Gm-Message-State: AFuF++k3guAhhnaXDTznn+S+vRJaxRlygnKMgVXYMpkFPPYwGGO0jjhf
 jPr8gMqah5Pcy/LLS61idWxa0wBtp9liNew9Oy+KCxGievYibdRFplQgXIVDaVWs5qbXGA==
X-Gm-Gg: AR+sD10tyeIKeVMbCY+xOpmufIbkgb/xGVs+rMPZgMka/x5WscSjJtb7ABVfG8Zb90c
 CcUfzjORIkV9penNdCYebpoRTnRuGxke3N0A9b7iYB7bWPhBV3fwG8dI74jq68AoXu9dSOcBejk
 LZ14TmjvCUm0bfAM4MMuPeZis5e43D1yPs7LN/VG1Zdk8XVn0h8XbNZY/JKdnIr0STX6LSn8dnF
 VCsFwe0qENstmPqQvDLbjrJqF3WpVCHEnlhmm0xWPZtec+vizq9YKt4sxId3v7XbrTpfxAqPUZz
 dswTBR7kB3FP6l+hfCJ7VFvZNCmZJST8AYFiTUfcjdQZVKXANxqFSN+wXBhv6g4RR6Zn8HGrJ2H
 is/F0y6gqzGDpnEJP3FYYtm1/VG20rtqlaEZGv9tWpus+/K2/bnB1DOTT+CNOf5Qwz9Stq+DbAn
 7KTQfqoXneDHdK+WXoP7wj/eflDMWnnmvgpspuHsAV8I6Sw63N5dr7Pvl/keANYvWrHZyUno7KD
 WVpdOA=
X-Received: by 2002:a17:90b:2785:b0:38f:23d6:b4ad with SMTP id
 98e67ed59e1d1-395c3594cf5mr34224184a91.8.1787473941256; 
 Sun, 23 Aug 2026 01:32:21 -0700 (PDT)
Received: from 138.101.136.61.ha.cnc ([61.136.101.138])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4a15829sm5378703a91.14.2026.08.23.01.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 01:32:20 -0700 (PDT)
From: fausten <yunfeng.li.nb@gmail.com>
X-Google-Original-From: fausten <yunfeng.li.nb@email.com>
To: dri-devel@lists.freedesktop.org,
	zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org,
 fausten <yunfeng.li.nb@email.com>
Subject: [PATCH] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION as unset
Date: Sun, 23 Aug 2026 16:32:11 +0800
Message-Id: <20260823083211.2654733-1-yunfeng.li.nb@email.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

The cursor plane code validates cursor dimensions against
SVGA_REG_CURSOR_MAX_DIMENSION before every cursor update, and
rejects the update with -EINVAL if the cursor is larger than the
reported maximum.

However, some SVGA implementations do not implement this register
and return 0 for it. In that case every cursor update is rejected,
and the log is spammed with:

  [drm] Cursor dimensions (64, 64) exceed device max 0

The visible symptom is that the hardware cursor never appears at
all on VMware Fusion guests (SVGA version 2), making the mouse
pointer invisible even though the input devices work fine.

Treat a reported maximum of 0 as "not implemented" and skip the
dimension check in that case, restoring the pre-existing behaviour
of accepting the cursor.

Tested on VMware Fusion with an SVGA version 2 device where the
cursor previously did not show up.

Fixes: d5ed8749168a ("drm/vmwgfx: enforce cursor size limits for MOB cursors")
Signed-off-by: fausten <yunfeng.li.nb@email.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index d1e7df500..fbdd23ecb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -237,8 +237,10 @@ static int vmw_cursor_mob_get(struct vmw_cursor_plane *vcp,
 	mob_max_size = vmw_read(dev_priv, SVGA_REG_MOB_MAX_SIZE);
 	cursor_max_dim = vmw_read(dev_priv, SVGA_REG_CURSOR_MAX_DIMENSION);
 
-	if (size > mob_max_size || vps->base.crtc_w > cursor_max_dim ||
-	    vps->base.crtc_h > cursor_max_dim)
+	/* Some SVGA implementations (e.g. VMware Fusion) report 0 here. */
+	if (cursor_max_dim &&
+	    (size > mob_max_size || vps->base.crtc_w > cursor_max_dim ||
+	     vps->base.crtc_h > cursor_max_dim))
 		return -EINVAL;
 
 	if (vps->cursor.mob) {
@@ -748,8 +750,10 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 		u32 cursor_max_dim =
 			vmw_read(vmw, SVGA_REG_CURSOR_MAX_DIMENSION);
 
-		if (new_state->crtc_w > cursor_max_dim ||
-		    new_state->crtc_h > cursor_max_dim) {
+		/* Some SVGA implementations (e.g. VMware Fusion) report 0 here. */
+		if (cursor_max_dim &&
+		    (new_state->crtc_w > cursor_max_dim ||
+		    new_state->crtc_h > cursor_max_dim)) {
 			drm_warn(&vmw->drm,
 				 "Cursor dimensions (%d, %d) exceed device max %u\n",
 				 new_state->crtc_w, new_state->crtc_h,
-- 
2.33.0

