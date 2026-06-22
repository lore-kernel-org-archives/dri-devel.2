Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04973CDE002
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FFF10E9DB;
	Tue, 23 Jun 2026 08:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="bLSwW2Kt";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QIce19w4";
	dkim-atps=neutral
X-Greylist: delayed 347 seconds by postgrey-1.36 at gabe;
 Mon, 22 Jun 2026 07:51:08 UTC
Received: from flow-a2-smtp.messagingengine.com
 (flow-a2-smtp.messagingengine.com [103.168.172.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 906C810E498
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:51:08 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.phl.internal (Postfix) with ESMTP id 10BA71380C0A;
 Mon, 22 Jun 2026 03:45:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 03:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
 cc:content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
 t=1782114321; x=1782117921; bh=fXbF0Kh4GrsPiW1DTDWekoSj6fsW84xB
 4tIxD7/4/60=; b=bLSwW2KtuAzyuETlYQJmomZslJmo0M3bKtaL9M+aPkncIJe4
 19J50qHAn307U2cFivB+XIWVl3BsBvvxX6NqwUcdUQS+7jhcjW1l8Hg5/yHOuWHq
 tZ4xDTKvrgkPIjyZZSjffhneOYyDKHviYzLC7oqDnDEvDBE7GIhQPcmEXbkKuPGu
 0zJSGIbCYGO7s/9fqc79EnakAu5qr6gMfZT1LhrXDOGluzd2nMwWUkL1RtX/TJTr
 DUzGKMlcjb0au06fSNkA8jGM7E9XzZFeUFHodcWWTuVVO7j1Ggxa+QE61TquCqSI
 W9YpZbIeju2+4sytj0PaaOaTYn/AGWVF5/F4GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782114321; x=
 1782117921; bh=fXbF0Kh4GrsPiW1DTDWekoSj6fsW84xB4tIxD7/4/60=; b=Q
 Ice19w4LLDvju0DM4bWpWhOHTc4zExeW/lf5DiW3vAjw38E06V4R/qOiuUtfu/+u
 x8rke2nh0XHvmU0UalTdHTs66PzrnjmnnicsOzEi5n1shO8LB+vCoLmkk6+zSjKc
 QZzNXT5FmU62vRjoyBODw4HFxnirMwB3jRu2+sYAfG1DH2qIWtbOdutJo45Gb3Jl
 xXJhn3Bpe2+tIxoaCte6isF6gBi7xkHN6+8Y3ON8Efsnmv74/qeksqcI/H/h85TY
 Y0D13sbrOwdOhH2PjRheqkIPK5YAhPV00JSWgEPo/SXi58mznqd3UYDAwiTPb4rI
 DWO/2egfZNICV1NtD+alg==
X-ME-Sender: <xms:EOg4aueAyyX4mHM6xXbPc9l6lHeNrn9MUkCGe8zdfr5HLmDdSv6Viw>
 <xme:EOg4ahLGZRjlpVMMQku72jT-yn5LHERNttlm8LCWNK8KOA_d-aO-w-l-gqXeF1ePS
 EYyrC96v_x-6k-zX_gItVSqf5ds-ujoFXwi_nPCAMYBkDrISBx8xx6U>
X-ME-Received: <xmr:EOg4arHJGl6kiN5od6CLjAdPVMytaCVoUGF3wscm9WvZ3RzJB9tRzSfsS7g>
X-ME-Proxy-Cause: dmFkZTFk1jJ522U3G5zJeCXZeJfZvdUVtNySz0zBj+ppH4R/k3aBNwduw6UgPJzjoQJ+Jg
 b5p4Oa1QCGE38BA/lTfoW3impkEq7FuA8yGQ8j70PA5jIC8l8dlpO6FcVG1UvawiB83SMT
 9tN0I5czCkoo8d0Z72/hJQsISQssKbG7tCOS9w5wJkIPZPFpiUZbQcKASw0vQJTa2U8xGo
 k6qfzoLKK38xWHNAfiXPVKnffxFPvR80cXGXOl/pbYB96Css4YhkVHdK5MnFUEWBuRrUm+
 NlF2BRnZETfYP8Pb6cM9M6/vFVCVzENCCblWB8iokQUjMRSmWUPgzG9gf3LZIn5687H3tq
 B+3+mjsznvep4/C7QwCVFM+WsfZPVV2XPEYcAmysTEo4eyUqfcVEa3vSQBcKGFwrcyVRSH
 d5p9Sz/FUc2yquV1qjPN03uXD4oSk5Zl3RAK/jIDYk5qDqa2XLozmiDADWKR/fRxjh5dP/
 bRgF2gn0USDSP0WvdujDXBGch1xnCk9yvW3DqB3PRhgL8CfBVX+MVmrQ8WvmAcQFnR8wCE
 +H0WrlrHS+SQx3ex/bPZw6tNZzUknZL0KqGfnAokHgO94f4Pltf2yHLTSiqoDP1DOy0rym
 mpRLUO1MV14VLNePfoCuSbWDahZRZ1ty/4lZewFrwDjupfjgkeeSgCUmhZFQ
X-ME-Proxy: <xmx:EOg4asAnOoeMLp9aQb89PEvUTDAU8rjXkl8qCAO2REDAT3IOWUbi9A>
 <xmx:EOg4am_HPEGadwJnKqoLTDkHJnXZFJBJ4PZzXn_v3g4HR5Cx_9BmQA>
 <xmx:EOg4agAUUGLlBUef_BjJ3fa6O0rYgJMc4huzMlatKY6GmTzRZ6ramA>
 <xmx:EOg4ajRThqTt6yS3zEjFTHJ7cIfgWmj05V-HUyn34quKdbFiiBh5zA>
 <xmx:EOg4aglC7ORuEbZP46QOZVOkclSndq1ht-J-CikbSEKtX87pTAbnww7c>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 03:45:20 -0400 (EDT)
Date: Mon, 22 Jun 2026 02:45:18 -0500
From: Ian Bridges <icb@fastmail.org>
To: Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: fix use-after-free of fb_display[i].mode in
 store_modes()
Message-ID: <ajjoDhAi2y4ArSlz@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:06:53 +0000
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

store_modes() replaces a framebuffer's modelist and frees the old entries
with fb_destroy_modelist(). fb_display[i].mode is a back-pointer into a
modelist entry, and it is not cleared when a console is detached from the
framebuffer (unbinding fbcon clears con2fb_map[] but leaves
fb_display[i].mode set).

store_modes() relies on fb_new_modelist() -> fbcon_new_modelist() to move
the back-pointers to the new list, but that only re-points consoles still
mapped to the framebuffer. A console that is no longer mapped to it is
skipped, so once fb_destroy_modelist() frees the old list that console's
fb_display[i].mode dangles. A later FBIOPUT_VSCREENINFO with
FB_ACTIVATE_INV_MODE makes fbcon_mode_deleted() read it through
fb_mode_is_equal(), a use-after-free.

Commit a1f305893074 ("fbcon: Set fb_display[i]->mode to NULL when the
mode is released") fixed the same use-after-free for the framebuffer
unregister path. Do the same in store_modes() by clearing the stale
pointers with fbcon_delete_modelist() before freeing the old list.

Reported-by: syzbot+81c7c6b52649fd07299d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=81c7c6b52649fd07299d
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
This patch contains a proposed fix for a crash reported by syzbot in
fb_mode_is_equal().

The file names and offsets in this description are from commit
8cd9520d35a6c38db6567e97dd93b1f11f185dc6 on the for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git

I also have a deterministic reproducer that triggers the crash under virtme-ng
with a KASAN kernel and two framebuffers (vfb as fb0, bochs-drm as fb1). It
performs six ioctl/sysfs operations, listed at the end of "The Bug". The free
is driven by a write to /sys/class/graphics/fb0/modes, which needs write access
to that file. The reproducer was written with the help of a coding agent
(Claude Code).

This crash has the same KASAN signature as the one fixed by commit
a1f305893074 ("fbcon: Set fb_display[i]->mode to NULL when the mode is
released"), but reaches it through a different free path. It is still reported
on kernels that contain that commit.

The Bug

fb_display[i].mode is a back-pointer into a struct fb_modelist entry on
info->modelist. var_to_display() (fbcon.c:989) sets it when a console is
attached to a framebuffer. fbcon_mode_deleted() reads it through
fb_mode_is_equal() (fbcon.c:2750, modedb.c:931).

store_modes() is the .store handler for /sys/class/graphics/fbN/modes
(fbsysfs.c:94). It splices the current modelist into a local old_list, builds
the new list, and on success frees old_list with fb_destroy_modelist()
(fbsysfs.c:115). To keep the back-pointers valid it relies on
fb_new_modelist() -> fbcon_new_modelist() (fbmem.c:737), but that only re-points
consoles still mapped to this framebuffer (fbcon_info_from_console(i) != info,
fbcon.c:3038).

fb_display[i].mode is not cleared when a console is detached. Unbinding fbcon
runs fbcon_release_all() (fbcon.c:1248), which sets con2fb_map[i] = -1 but
leaves fb_display[i].mode pointing into the former framebuffer's modelist. Such
a console is skipped by fbcon_new_modelist(), so once fb_destroy_modelist()
frees old_list its fb_display[i].mode dangles.

The minimal reproduction is six operations on two framebuffers (fb0, fb1). All
six are required (verified against source and by removing each in turn). fbcon
starts bound with the consoles mapped to fb0. The operations all act on one
unused console i (no allocated vc_data). An allocated console would be
re-initialised, and its fb_display[i].mode reset, by the takeover in step 5.
Pre-allocating all consoles does not reproduce.

  1. FBIOPUT_CON2FBMAP, the console -> fb1
     set_con2fb_map() reaches var_to_display(), which points fb_display[i].mode
     at an fb1 modelist entry (var_to_display() uses the console index, so it
     runs even though the console has no vc_data)
  2. FBIOPUT_CON2FBMAP, the console -> fb0
     fb_display[i].mode now points at an fb0 modelist entry M
  3. echo 0 > /sys/class/vtconsole/vtcon1/bind
     fbcon_release_all() sets con2fb_map[i] = -1 and leaves fb_display[i].mode
     pointing at M
  4. write a videomode array to /sys/class/graphics/fb0/modes
     The buffer holds raw struct fb_videomode entries. At least one must be
     valid so fb_new_modelist() keeps it and store_modes() takes the success
     path that frees old_list (an empty or invalid set takes the failure path
     that restores it, and nothing is freed). fbcon_new_modelist() skips the
     console (con2fb_map[i] == -1), then fb_destroy_modelist() frees M, so
     fb_display[i].mode now dangles
  5. FBIOPUT_CON2FBMAP, the console -> fb1
     fbcon is unbound, so set_con2fb_map() takes the do_fbcon_takeover() branch
     (fbcon.c:931). do_fbcon_takeover() sets con2fb_map[] = info_idx for the
     whole range (fbcon.c:619), so the console is now mapped to fb1. The mode is
     reset only via fbcon_init() during the takeover, which runs for allocated
     consoles only, so this unused console keeps its dangling fb_display[i].mode
  6. FBIOPUT_VSCREENINFO on fb1 with FB_ACTIVATE_INV_MODE and a mode different
     from fb1's current var (otherwise fb_set_var() returns early without
     calling fbcon_mode_deleted(), to avoid deleting the current var's
     videomode)
     fb_set_var() (fbmem.c:240,248) -> fbcon_mode_deleted() walks fb1's consoles
     and reads the dangling fb_display[i].mode via fb_mode_is_equal(), a
     use-after-free

The free is in store_modes() on fb0, and the read in fbcon_mode_deleted() on
fb1.

The Proposed Fix

A framebuffer's modelist is freed in two places, do_unregister_framebuffer()
(fbmem.c:548) and store_modes() (fbsysfs.c:115). Commit a1f305893074 added the
helper fbcon_delete_modelist() to clear the stale fb_display[i].mode pointers,
but called it from the first site only (fbmem.c:547). The store_modes() site
was raised as a potential issue during review of that commit [1] but
assumed safe.

Fix store_modes() the same way by clearing the stale pointers with
fbcon_delete_modelist() before freeing old_list.

The fix was verified with the reproducer. The unpatched kernel reports the
slab-use-after-free read, freed by fb_destroy_modelist() from store_modes().
The patched kernel produces no use-after-free.

The bug predates git history. Both the fb_display[i].mode back-pointer and the
store_modes() swap-and-free are present in the initial 2.6.12-rc2 import
(1da177e4c3f4), so there is no Fixes tag, matching a1f305893074. The fix calls
fbcon_delete_modelist(), which a1f305893074 added, so a stable backport needs
that commit first.

[1] https://lkml.org/lkml/2025/9/23/786

 drivers/video/fbdev/core/fbsysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index baa2bae0fb5b..c761dcf21daf 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -111,8 +111,10 @@ static ssize_t store_modes(struct device *device,
 	if (fb_new_modelist(fb_info)) {
 		fb_destroy_modelist(&fb_info->modelist);
 		list_splice(&old_list, &fb_info->modelist);
-	} else
+	} else {
+		fbcon_delete_modelist(&old_list);
 		fb_destroy_modelist(&old_list);
+	}
 
 	unlock_fb_info(fb_info);
 	console_unlock();
-- 
2.47.3

