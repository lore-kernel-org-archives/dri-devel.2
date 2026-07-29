Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035A4C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6525F10E037;
	Wed, 29 Jul 2026 11:20:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LCjOB2Ee";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B7610E037
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:20:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58A4560A5E;
 Wed, 29 Jul 2026 11:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8468C1F000E9;
 Wed, 29 Jul 2026 11:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1785324038;
 bh=AzcR5oOyTETIKSOZ7+ejnKAWTvpCplTpPFXoWFhpb0Y=;
 h=Subject:To:Cc:From:Date;
 b=LCjOB2EemCG3hKMzcI+E1VhwD5U/2yshISvpyY7oviwYxHUUliey6U5sZ2/uCnyeb
 gkY5blhC8FNCpqmxygz+x4yP+M0CuuoFYomVktarl0pQOp4HgmJQY9myR1x4c3EHWP
 OhjQlC1xp8FLHzXPNdKvCpWg5t8M63KiGr+vCtRg=
Subject: Patch "drm/amd/display: Handle struct
 drm_plane_state.ignore_damage_clips" has been added to the 7.1-stable tree
To: alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, harry.wentland@amd.com, javierm@redhat.com,
 tzimmermann@suse.de, zackr@vmware.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:19:38 +0200
Message-ID: <2026072938-sprain-irritate-78fe@gregkh>
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

    drm/amd/display: Handle struct drm_plane_state.ignore_damage_clips

to the 7.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amd-display-handle-struct-drm_plane_state.ignore_damage_clips.patch
and it can be found in the queue-7.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From ac11060c6d4959e2d4ceada037d2e1e1bfcf6645 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 10 Jun 2026 17:18:17 +0200
Subject: drm/amd/display: Handle struct drm_plane_state.ignore_damage_clips

From: Thomas Zimmermann <tzimmermann@suse.de>

commit ac11060c6d4959e2d4ceada037d2e1e1bfcf6645 upstream.

The mode-setting pipeline can disabled damage clippings for a commit
by setting ignore_damage_clips in struct drm_plane_state. The commit
will then do a full display update.

Test the flag in DCN code and do a full update in DCN code if it has
been set.

Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
to ignore damage clips") introduced ignore_damage_clips to selectively
ignore damage clipping in certain framebuffer changes. This driver does
not do that, but DRM's damage iterator will soon rely on the flag.
Therefore supporting it here as well make sense for consistency.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zack Rusin <zackr@vmware.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a24019f6480fad5c077b5956eed942c8960323d6)
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6440,8 +6440,8 @@ static void fill_dc_dirty_rects(struct d
 {
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
 	struct rect *dirty_rects = flip_addrs->dirty_rects;
-	u32 num_clips;
-	struct drm_mode_rect *clips;
+	u32 num_clips = 0;
+	struct drm_mode_rect *clips = NULL;
 	bool bb_changed;
 	bool fb_changed;
 	u32 i = 0;
@@ -6457,8 +6457,10 @@ static void fill_dc_dirty_rects(struct d
 	if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
 		goto ffu;
 
-	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
-	clips = drm_plane_get_damage_clips(new_plane_state);
+	if (!new_plane_state->ignore_damage_clips) {
+		num_clips = drm_plane_get_damage_clips_count(new_plane_state);
+		clips = drm_plane_get_damage_clips(new_plane_state);
+	}
 
 	if (num_clips && (!amdgpu_damage_clips || (amdgpu_damage_clips < 0 &&
 						   is_psr_su)))


Patches currently in stable-queue which might be from tzimmermann@suse.de are

queue-7.1/drm-tests-shmem-set-dma-mask-to-64-bit-in-drm_gem_sh.patch
queue-7.1/drm-exynos-fbdev-remove-offset-into-screen_buffer.patch
queue-7.1/drm-sysfb-avoid-possible-truncation-with-calculating-visible-size.patch
queue-7.1/drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
queue-7.1/drm-sysfb-do-not-page-align-visible-size-of-the-framebuffer.patch
queue-7.1/drm-sysfb-return-errno-code-from-drm_sysfb_get_visible_size.patch
queue-7.1/drm-sysfb-avoid-truncating-maximum-stride.patch
queue-7.1/drm-amd-display-handle-struct-drm_plane_state.ignore_damage_clips.patch
