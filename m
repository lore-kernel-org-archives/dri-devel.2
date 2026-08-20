Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DDFC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EACE210F057;
	Thu, 20 Aug 2026 14:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijVuZpLJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E8010F057
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:36:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A6EF760A5D;
 Thu, 20 Aug 2026 14:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AE81F000E9;
 Thu, 20 Aug 2026 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1787236602;
 bh=/K73UpbFqspENqOvtwecuFwCm+ozDxCXHR2h+RT9C28=;
 h=Subject:To:Cc:From:Date;
 b=ijVuZpLJfGNf3KxVUHHUYuVygGdx8FAXEo80FZc1QxJpb4tApcFXnFlMcMk3LVSA6
 XB3rmRlHKRU8ILGyTalpR9w2uA2Mrus3Wk1WwkE4IguWgqsE9+ZhmbkAn4uXpq+wlg
 pArNaW9cgR47OuZtUqYIGWPtRMfjZTqsvc3GcKfs=
Subject: Patch "drm/vmwgfx: Set surface-framebuffer GEM objects" has been
 added to the 6.18-stable tree
To: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, ian.forbes@broadcom.com, jfalempe@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, zack.rusin@broadcom.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 16:36:37 +0200
Message-ID: <2026082037-dig-poppy-40df@gregkh>
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

    drm/vmwgfx: Set surface-framebuffer GEM objects

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-vmwgfx-set-surface-framebuffer-gem-objects.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 9942d36a73c2d46c52fdd6f37cf698f3cb09ce5c Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 4 Nov 2025 11:36:04 +0100
Subject: drm/vmwgfx: Set surface-framebuffer GEM objects

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 9942d36a73c2d46c52fdd6f37cf698f3cb09ce5c upstream.

Set struct drm_framebuffer.obj[0] to the allocated GEM buffer object
for surface framebuffers. Avoids a NULL-pointer deref in the client's
vmap helpers.

[   22.640191] Console: switching to colour frame buffer device 160x50
[   22.641788] Oops: general protection fault, probably for
  non-canonical address 0xdffffc000000001f: 0000 [#1] SMP KASAN NOPTI
[   22.641795] KASAN: null-ptr-deref in range
[0x00000000000000f8-0x00000000000000ff]
[...]
[   22.641809] Hardware name: VMware, Inc. VMware20,1/440BX Desktop
  Reference Platform, BIOS VMW201.00V.24928539.B64.2508260915 08/26/2025
[   22.641812] Workqueue: events drm_fb_helper_damage_work
[   22.641824] RIP: 0010:drm_gem_lock+0x25/0x50
[   22.641831] Code: 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 b8
  00 00 00 00 00 fc ff df 53 48 89 fb 48 81 c7 f8 00 00 00 48 89 fa 48
  c1 ea 03 <80> 3c 02 00 75 0f 48 8b bb f8 00 00 00 31 f6 5b e9 16 2e 15
  01 e8
[...]
[   22.641889] Call Trace:
[   22.641891]  <TASK>
[   22.641894]  drm_client_buffer_vmap_local+0x78/0x140
[   22.641903]  drm_fbdev_ttm_helper_fb_dirty+0x20c/0x510 [drm_ttm_helper]
[   22.641913]  ? __pfx_drm_fbdev_ttm_helper_fb_dirty+0x10/0x10 [drm_ttm_helper]
[   22.641918]  ? __raw_spin_lock_irqsave+0x8c/0xf0
[   22.641924]  ? __pfx___raw_spin_lock_irqsave+0x10/0x10
[   22.641928]  ? __pfx_mutex_lock+0x10/0x10
[   22.641936]  drm_fb_helper_fb_dirty+0x29a/0x5e0
[   22.641942]  ? __pfx_drm_fb_helper_fb_dirty+0x10/0x10
[...]

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: ea39f2e66e61 ("drm/client: Deprecate struct drm_client_buffer.gem")
Reported-by: Ian Forbes <ian.forbes@broadcom.com>
Closes: https://lore.kernel.org/dri-devel/CAO6MGtjg8PiRiSLomJQRBduTBSC0WkqX67tEZwA9qwOgRzchpw@mail.gmail.com/
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Tested-by: Ian Forbes <ian.forbes@broadcom.com>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patch.msgid.link/20251104103611.167821-1-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -553,6 +553,9 @@ static int vmw_kms_new_framebuffer_surfa
 	memcpy(&vfbs->uo, uo, sizeof(vfbs->uo));
 	vmw_user_object_ref(&vfbs->uo);
 
+	if (vfbs->uo.buffer)
+		vfbs->base.base.obj[0] = &vfbs->uo.buffer->tbo.base;
+
 	*out = &vfbs->base;
 
 	ret = drm_framebuffer_init(dev, &vfbs->base.base,


Patches currently in stable-queue which might be from tzimmermann@suse.de are

queue-6.18/drm-client-remove-drm_client_framebuffer_delete.patch
queue-6.18/drm-client-remove-pitch-from-struct-drm_client_buffe.patch
queue-6.18/drm-client-move-dumb-buffer-handling-to-drm_client_f.patch
queue-6.18/drm-client-inline-drm_client_buffer_addfb-and-_rmfb.patch
queue-6.18/drm-connector-hdmi-fix-out-of-bounds-memory-read.patch
queue-6.18/drm-vmwgfx-set-surface-framebuffer-gem-objects.patch
queue-6.18/drm-client-deprecate-struct-drm_client_buffer.gem.patch
