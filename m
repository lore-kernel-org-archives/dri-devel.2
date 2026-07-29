Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29844C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A74C10EB8A;
	Wed, 29 Jul 2026 10:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U5FprOVU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2626110EB8A
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:41:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32E86600B1;
 Wed, 29 Jul 2026 10:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF991F000E9;
 Wed, 29 Jul 2026 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1785321703;
 bh=m/tVY747qQcUbCWoM+r9JhmavpQYiLXvZynECqzDeco=;
 h=Subject:To:Cc:From:Date;
 b=U5FprOVUlnP1TM3/fXxzl5Iu/4Vur+YDLVHuTSa9mUH3nWOER9fwzc/+3D41BQlXi
 Kxy+JoVuyKKCeoHLbBBL6tV/Sj+PfkBoxJ4P7wQUB5i5f+xordCPExF1xkzRVoZCWA
 5Qf5sT5ONFUh+amp+4W2aw7ii1Rv56FSmUAoj5rc=
Subject: Patch "drm/exynos: fbdev: Remove offset into screen_buffer" has been
 added to the 7.1-stable tree
To: dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 inki.dae@samsung.com, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:39:59 +0200
Message-ID: <2026072959-cosmic-putt-d5cd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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


This is a note to let you know that I've just added the patch titled

    drm/exynos: fbdev: Remove offset into screen_buffer

to the 7.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-exynos-fbdev-remove-offset-into-screen_buffer.patch
and it can be found in the queue-7.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 760bbc58c2c833dec0ee38dd959f4f2f4084fc57 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 11 May 2026 13:54:31 +0200
Subject: drm/exynos: fbdev: Remove offset into screen_buffer

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 760bbc58c2c833dec0ee38dd959f4f2f4084fc57 upstream.

The screen_buffer field in struct fb_info contains the kernel address
of the first byte of framebuffer memory. Do not add the display offset.
This offset only describes scrolling during scanout.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 19c8b8343d9c ("drm/exynos: fixed overlay data updating.")
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: <stable@vger.kernel.org> # v3.2+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -61,17 +61,13 @@ static int exynos_drm_fbdev_update(struc
 	struct fb_info *fbi = helper->info;
 	struct drm_framebuffer *fb = helper->fb;
 	unsigned int size = fb->width * fb->height * fb->format->cpp[0];
-	unsigned long offset;
 
 	fbi->fbops = &exynos_drm_fb_ops;
 
 	drm_fb_helper_fill_info(fbi, helper, sizes);
 
-	offset = fbi->var.xoffset * fb->format->cpp[0];
-	offset += fbi->var.yoffset * fb->pitches[0];
-
 	fbi->flags |= FBINFO_VIRTFB;
-	fbi->screen_buffer = exynos_gem->kvaddr + offset;
+	fbi->screen_buffer = exynos_gem->kvaddr;
 	fbi->screen_size = size;
 	fbi->fix.smem_len = size;
 


Patches currently in stable-queue which might be from tzimmermann@suse.de are

queue-7.1/drm-tests-shmem-set-dma-mask-to-64-bit-in-drm_gem_sh.patch
queue-7.1/drm-exynos-fbdev-remove-offset-into-screen_buffer.patch
queue-7.1/drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
