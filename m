Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F13C5DF9C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3647210E215;
	Sun, 23 Aug 2026 09:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l2+kzZTA";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4658110E02F
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 08:59:26 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso3536627a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 01:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787475566; x=1788080366; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q15ldVDxdupMbKGmseyO11WaPsDh9neVNLmDembg4lk=;
 b=l2+kzZTAxNH0ygmekJc/HtYNIGizayozVlT1skW0tLQuEMFvUkG/s8v83ZUyRn40ni
 tmchJv2+r0FixcoHVJC2Yo6+rg02HGJPqWbozKD61HJ8QmfNfIujVePfSUBTErsIUq0d
 5Ts3t9cAwLeyikVSXUtSTxPhIRKCAGuQKSlQBfIlmP6UORITawTg2gAjE3ezFUR3RMvr
 qsHqwsCEiNqsIqgbApOieP3PrUcr+qoJUUwWWJRkqNdEsJDZwJD6C2+kPNdDcI+i54te
 eRgySmACPeWamWTokhuhlbyvhqAE/+tVMBV018Y1GHQZZkdW8IpOb/M/SANZKv0bAVFS
 Rb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787475566; x=1788080366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q15ldVDxdupMbKGmseyO11WaPsDh9neVNLmDembg4lk=;
 b=WUPq4fSKHLm5vcoq5Ta/Sj8VSTLSWxzugC9ev3fvdhjh+eUHVoEycCXIjraIRrId/F
 njxKAfNGdyHxFzrgN3LP7/yP/mSJEHlTN3k61FS9whEOajFiGT7xDYw7buNmlGKb/Gdr
 3xyU89jOWRa38pVzUCMcH0Uye44ZJfVMlIcKftthnA/1+2C8BK/kO0LuC/1roPb5d5sJ
 SRhUGruRP2yC4CaAm9w00tswZb3IHO0rgsa5zVeSR8YnW8IT0oOCTBUmE3sssZ/8z9hc
 ozmOSV8vTqGMsYL8aScrtbOn7GZJJadqyBAiQX11S/xB1gN/QD0BkB+mMuL/wi6sKu8c
 kAHg==
X-Gm-Message-State: AFuF++ntu44VFyV/JY+t/WPzzRs5ceaBZPtHZzPkHlElC+vOqooTZ7oe
 VcCVfv5Rh0gtWIpQHxUllQtOxiZ6RfdykkSjQFOn7iwZ5gWdPaTz+GAsATNfTTLBbZ/vyw==
X-Gm-Gg: AR+sD11LuJZkEWOK8JMW1T0XOLGOt6CZhJewLsq+niLlA9pb9W9bCqIAzFlK8rGK9We
 iD/nAdVyQHVwVdArASYfJZISK7piFzBlScVCjReqmJix2Nf+x1rSEBIuNcK4gt0m+lawcH71LT1
 ZVzXSBw9G8kKcXvqfICL2iZUzzaaZbII9EhaAS1kvlvD8Hx2Kr056AZ9rZUdKCWdNWlQ2ApTTaA
 AeomliV+W2UjAywA2JzqQ0kQ7lnY5rJISRLjmk91PEtV/wwdcacuHJtooqEEzIzFUGcKPTvm0K8
 8fbGAyzHPrMrWa+XLhI+xYX9G1UIjLOlzWEx8Yi3E9Qe3M4KsUo0xo5G8E1PKAhINvxXqrSJ49w
 RMmYvOH4aCfD6230zHDCqLyefN4SOmV49j2FT4e0ykxMDRkWzbMMCRFhxGxnfWsly3ODk4ksTnW
 fTe9cP+DABgor5F15qh6VaxVVnsWUm6ott9lnqMC9+VQI8mCxmUOjVSGvPV0QsBRh8tAWzFeeiP
 JQZ6js=
X-Received: by 2002:a17:90b:4a81:b0:38e:6f90:eabd with SMTP id
 98e67ed59e1d1-395c355c570mr31010607a91.5.1787475565740; 
 Sun, 23 Aug 2026 01:59:25 -0700 (PDT)
Received: from 138.101.136.61.ha.cnc ([61.136.101.138])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e42cc144sm5296045a91.0.2026.08.23.01.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 01:59:25 -0700 (PDT)
From: fausten <yunfeng.li.nb@gmail.com>
To: dri-devel@lists.freedesktop.org,
	zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org,
 fausten <yunfeng.li.nb@gmail.com>
Subject: [PATCH v2] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION as
 unset
Date: Sun, 23 Aug 2026 16:59:16 +0800
Message-Id: <20260823085916.2707488-1-yunfeng.li.nb@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260823083211.2654733-1-yunfeng.li.nb@email.com>
References: <20260823083211.2654733-1-yunfeng.li.nb@email.com>
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
Signed-off-by: fausten <yunfeng.li.nb@gmail.com>
---
Changes in v2:
- Fix author name and email address (v1 was sent with a wrong From).

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

