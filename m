Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F29CC88E48
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB63B10F41C;
	Thu, 10 Sep 2026 10:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ei4KBstk";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBEA10E1F0
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 19:10:43 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2db22383fe8so6168365ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788981043; x=1789585843; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TyPxplOOHI2AEPRdVqrOjZibnjH3OGUmINX0gnTrLb8=;
 b=ei4KBstkmPNlveTuyjTdbka7R+o3NNUuPSVeMOzMXytKqet9wot+0hhoyPM7Vvc44h
 1BI90o9qq6/6d3d54jOoDA5APeW+q5LeYbscvJqMgrGF73ie1PQYPkrHOsUK000ildbA
 T8c2TKgnV4u14jtxCXWMHff1r1iqsqferh5QoZ7eD4vnYl8bYG8WMihZSzPegFysLdoc
 poHq8tGCYJV33J9I45vwAD1NaITZWIefh9zPPiH2TaHsVphDwZQet41KGc2azS/n0ILw
 W4uY/+92+tnyWzIE5H9J0/9KUUfdZ1FTORVBOD1NL6a1vo+tKVlLU62x3f2M6gQQMZ2q
 ss8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788981043; x=1789585843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TyPxplOOHI2AEPRdVqrOjZibnjH3OGUmINX0gnTrLb8=;
 b=jFgLuDC0jsDkGHKSbWfbnXNY9WzYON7kXZG9N8iyEGtSnGU3tda65PJq9RvCNhyU6Y
 GbMJg5N1edPI/zgzuIstzC5rHhZijr851QvvDhSgg38ANcmj7NVXUO8ggoyKLOUPBaDB
 +vQ9u/fGhA5A+aJnj4yLE08se6PEhfuLzliuT4oPBQFBFVh8OLMgPS3jts80WMSoQ4Uh
 SJJgzImeGeyX3bceVHIrcVoLhzbPZeW+Mwi7fa0U1yI9XyJcAeIxGQBJjDHX3mX9qKbM
 02GpDcBOEw8SHWmgm1/rSqx3CsV+1FAO/I3HZZr+EXoe/4+lb/Fcwb1JU6Sg3SaKHzWG
 PvUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzs27FT/NQxh5xOklw+dbDkGOAdr5MqNJJvHM2y2MiE386CtT6t85NGE4nqr2L3tMJeMDCb+OVtsJM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mUEB5UXwkm1/DIjMq+TdG3pt/9apr+CXrgHGP/LIgc0O8QT4hE
 gk1hwdlQCjFPSJ+DVq/gDwHSCYvR+4emn784MX4YLyMXuQgkShQ/W9Ad
X-Gm-Gg: AYBFou1Kd47CrN1Megbtx4+6ife8j3BaNY0b/ztFInFTHPDvyMksImB4m8yZ4DyitiG
 rUutnY1tg3tBs/d3G0CghTe8lBD71Z2fJsykR+eUNCQOvJkNICTXii47KG12BqxmRleP2OCdikt
 N3fnLONUr7WHTLfLxEy6UfMxIvs/OUrsxMmTRGyDOLx/k8ChFbWFWWtkvow9cbrSzrsLW9KpLuD
 HvfIZ1UiYmZnzKnPExo9C3GopIicuhZOPQF6avGV4ZjspMBj4uQKaGfMohwUwoDWlwZXwueuT+6
 DAW8wcg+l6RyuMF5ZYUI35YT5wlWHHlFKG6yky7eXKb0A9HNqyYL+9t4WLV6xcB1QbqZ8KxKHrA
 9feKorq5XhzQJvUZwsc+qd2BOUiC3XfjhdTQ0CmaLy1d/CG+qKbmFyVdQ8JudHHt0H7oLO//JMP
 KD6JJwOSAzbfwCBWJ3UJvVLYrj3JjDR5fN0OSLS9kQ3Oqy+1f9Rv/U7qPbMV4gx57HN7knOjFKe
 nkOhhDzHNc8E57SNksOY3r+veAcREfz
X-Received: by 2002:a17:902:ec89:b0:2d6:df31:5bd0 with SMTP id
 d9443c01a7336-2dd07b9d3c0mr43860775ad.10.1788981042709; 
 Wed, 09 Sep 2026 12:10:42 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db18a1eb47sm77198285ad.48.2026.09.09.12.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 12:10:41 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, co+c25629c98ba36ebe@bugs.sh,
 Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] fbdev: vfb: defer cleanup until the last reference
Date: Thu, 10 Sep 2026 03:10:23 +0800
Message-ID: <20260909191022.847295-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

FBIOGETCMAP takes a shallow snapshot of info->cmap and performs the
usercopy after dropping info->lock. vfb_remove() frees the colormap
immediately after unregistering the framebuffer, even when an open file
still holds a reference to fb_info. A concurrent driver unbind can
therefore free the colormap while the ioctl copies it to userspace.

KASAN reports:

  BUG: KASAN: slab-use-after-free in _copy_to_user
  Read of size 512 by task poc/125

   _copy_to_user (./include/linux/instrumented.h:129 ./include/linux/uaccess.h:201 lib/usercopy.c:24)
   fb_cmap_to_user (./include/linux/uaccess.h:230 drivers/video/fbdev/core/fbcmap.c:211)
   do_fb_ioctl (drivers/video/fbdev/core/fb_chrdev.c:114)

   Allocated by task 1:
   fb_alloc_cmap_gfp (./include/linux/slab.h:973 ./include/linux/slab.h:1290 drivers/video/fbdev/core/fbcmap.c:108)
   vfb_probe (drivers/video/fbdev/vfb.c:459)

   Freed by task 124:
   fb_dealloc_cmap (drivers/video/fbdev/core/fbcmap.c:151)
   vfb_remove (drivers/video/fbdev/vfb.c:489)

unregister_framebuffer() drops the registration reference, and fbdev calls
fb_destroy after the last put_fb_info(). Move the registered framebuffer's
cleanup into an fb_destroy callback so its colormap and screen buffer stay
alive until all file references have been released.

Fixes: 5e266e2e0e19 ("vfb: fix memory leaks in removal path")
Reported-by: co+c25629c98ba36ebe@bugs.sh
Closes: https://lore.kernel.org/linux-fbdev/f2Kf9GYn1lKR5S1dbvGVtykMxK1RlgP5z8sW@bugs.sh/
Assisted-by: Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/video/fbdev/vfb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index 5b7965f36c5ed..de137b2bdaedc 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -78,6 +78,13 @@ static int vfb_pan_display(struct fb_var_screeninfo *var,
 static int vfb_mmap(struct fb_info *info,
 		    struct vm_area_struct *vma);
 
+static void vfb_destroy(struct fb_info *info)
+{
+	vfree(info->screen_buffer);
+	fb_dealloc_cmap(&info->cmap);
+	framebuffer_release(info);
+}
+
 static const struct fb_ops vfb_ops = {
 	.owner		= THIS_MODULE,
 	__FB_DEFAULT_SYSMEM_OPS_RDWR,
@@ -87,6 +94,7 @@ static const struct fb_ops vfb_ops = {
 	.fb_pan_display	= vfb_pan_display,
 	__FB_DEFAULT_SYSMEM_OPS_DRAW,
 	.fb_mmap	= vfb_mmap,
+	.fb_destroy	= vfb_destroy,
 };
 
     /*
@@ -485,9 +493,6 @@ static void vfb_remove(struct platform_device *dev)
 
 	if (info) {
 		unregister_framebuffer(info);
-		vfree(videomemory);
-		fb_dealloc_cmap(&info->cmap);
-		framebuffer_release(info);
 	}
 }
 
-- 
2.55.0

