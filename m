Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15103C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F09B10E320;
	Wed, 29 Jul 2026 10:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K9lcG2vz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B0C10E320
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:57:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E97843B17;
 Wed, 29 Jul 2026 10:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E713F1F000E9;
 Wed, 29 Jul 2026 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1785322666;
 bh=WfvqP9ztEVc9cmlE9hhCnSmYYMbUArqWPEy4Ir9jqF0=;
 h=Subject:To:Cc:From:Date;
 b=K9lcG2vzmRbRgoZUZ2x9qL7FHaWSNUmB6vzvAvkOujbfA6e5/n3rKDImH1HDS0VqB
 heqasryXuq9j5CWLOa4ZZAGF6Dge06rdHP8j8Uov8xwzzEPXX4/twl63bcpRT8ojwq
 IvQvcsEDqX8pYlzPvyAgQpMk1MKSRRG1V8NGd9hQ=
Subject: Patch "drm/sysfb: Avoid possible truncation with calculating visible
 size" has been added to the 6.18-stable tree
To: dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 javierm@redhat.com, sashiko-bot@kernel.org, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:56:45 +0200
Message-ID: <2026072945-crock-platonic-7548@gregkh>
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

    drm/sysfb: Avoid possible truncation with calculating visible size

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-sysfb-avoid-possible-truncation-with-calculating-visible-size.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From b771974988ec7ce077a7246fa0fa588c246fe581 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 18 Jun 2026 10:41:58 +0200
Subject: drm/sysfb: Avoid possible truncation with calculating visible size

From: Thomas Zimmermann <tzimmermann@suse.de>

commit b771974988ec7ce077a7246fa0fa588c246fe581 upstream.

Calculating the visible size of the system framebuffer can result in
truncation of the result. The calculation uses 32-bit arithmetics,
which can overflow if the values for height and stride are large. Fix
the issue by multiplying with mul_u32_u32().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20260617114027.1F2A71F000E9@smtp.kernel.org/
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patch.msgid.link/20260618084327.46567-3-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
@@ -2,6 +2,7 @@
 
 #include <linux/export.h>
 #include <linux/limits.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/screen_info.h>
 
@@ -73,7 +74,7 @@ EXPORT_SYMBOL(drm_sysfb_get_stride_si);
 u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
 				  unsigned int height, unsigned int stride, u64 size)
 {
-	u64 vsize = height * stride;
+	u64 vsize = mul_u32_u32(height, stride);
 
 	return drm_sysfb_get_validated_size0(dev, "visible size", vsize, size);
 }


Patches currently in stable-queue which might be from tzimmermann@suse.de are

queue-6.18/drm-tests-shmem-set-dma-mask-to-64-bit-in-drm_gem_sh.patch
queue-6.18/drm-sysfb-avoid-possible-truncation-with-calculating-visible-size.patch
queue-6.18/drm-sysfb-do-not-page-align-visible-size-of-the-framebuffer.patch
queue-6.18/drm-sysfb-return-errno-code-from-drm_sysfb_get_visible_size.patch
queue-6.18/drm-sysfb-avoid-truncating-maximum-stride.patch
