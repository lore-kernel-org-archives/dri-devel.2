Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5DFC54F52
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E6410E295;
	Wed, 29 Jul 2026 10:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Aq99XCb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A733910E1C4
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:55:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8620141A99;
 Wed, 29 Jul 2026 10:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3F21F000E9;
 Wed, 29 Jul 2026 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1785322521;
 bh=edmZncJd4c+WZD8toiyLbqHplcK/IpDeFNu1CzRPx34=;
 h=Subject:To:Cc:From:Date;
 b=0Aq99XCblKPu8Y1Zf3yWNLo78oyLFeokomhog1KW6Vuholx9sgE8qo6BdO4lJLV5N
 zbO31ZPIjhks05HuzcM5VrY/7u2Fz7FydCDeHKgR9PGjxTuk8dWo+5C0k79eylgHZM
 TtLcZNAEYFG6q7dPXWvtucGUIYeHTFJVcCmhE8P4=
Subject: Patch "drm/sysfb: Avoid truncating maximum stride" has been added to
 the 7.1-stable tree
To: dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 javierm@redhat.com, sashiko-bot@kernel.org, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:54:27 +0200
Message-ID: <2026072927-bash-sandworm-67e1@gregkh>
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

    drm/sysfb: Avoid truncating maximum stride

to the 7.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-sysfb-avoid-truncating-maximum-stride.patch
and it can be found in the queue-7.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 9206b22fb959f4a9cf1921f34aed0df1dcb1ab04 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 18 Jun 2026 10:42:00 +0200
Subject: drm/sysfb: Avoid truncating maximum stride

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 9206b22fb959f4a9cf1921f34aed0df1dcb1ab04 upstream.

Passing a maximum as 64-bit type to drm_sysfb_get_validated_int0()
can truncate the value to 32 bits. Use drm_sysfb_get_validated_size0(),
which uses 64-bit arithmetics. Then test the returned stride against
the limits of int to avoid truncations in the returned value. A valid
stride is in the range of [1, INT_MAX] inclusive.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20260617114016.5A5991F000E9@smtp.kernel.org/
Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patch.msgid.link/20260618084327.46567-5-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
@@ -56,11 +56,17 @@ int drm_sysfb_get_stride_si(struct drm_d
 			    unsigned int width, unsigned int height, u64 size)
 {
 	u64 lfb_linelength = si->lfb_linelength;
+	s64 stride;
 
 	if (!lfb_linelength)
 		lfb_linelength = drm_format_info_min_pitch(format, 0, width);
 
-	return drm_sysfb_get_validated_int0(dev, "stride", lfb_linelength, div64_u64(size, height));
+	stride = drm_sysfb_get_validated_size0(dev, "stride", lfb_linelength,
+					       div64_u64(size, height));
+	if (stride < INT_MIN || stride > INT_MAX)
+		return -EINVAL;
+
+	return (int)stride; /* stride or negative errno code */
 }
 EXPORT_SYMBOL(drm_sysfb_get_stride_si);
 


Patches currently in stable-queue which might be from tzimmermann@suse.de are

queue-7.1/drm-tests-shmem-set-dma-mask-to-64-bit-in-drm_gem_sh.patch
queue-7.1/drm-exynos-fbdev-remove-offset-into-screen_buffer.patch
queue-7.1/drm-sysfb-avoid-possible-truncation-with-calculating-visible-size.patch
queue-7.1/drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
queue-7.1/drm-sysfb-do-not-page-align-visible-size-of-the-framebuffer.patch
queue-7.1/drm-sysfb-return-errno-code-from-drm_sysfb_get_visible_size.patch
queue-7.1/drm-sysfb-avoid-truncating-maximum-stride.patch
