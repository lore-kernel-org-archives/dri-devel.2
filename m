Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BDCCD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7057E10E866;
	Tue, 16 Jun 2026 07:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="hzL08NIH";
	dkim-atps=neutral
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A70310E87F;
 Tue, 16 Jun 2026 07:13:11 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781593989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/n5ClynN9wECcpRwRUUOPxrDcmCBQxKZrrm5x/CS1ZE=;
 b=hzL08NIHwOLXET4LriCS3jha/l1h+tfnJXHRFF5PimyEs96MvmK5yzxHmm3eCx+NSquRx7
 96INU4Tj8riZJ3BaJ6nwzMPnj+rV16l3jsldze2JOlt8qS6BJedNizu0u35dyXi/WldTF2
 EoScnkPyfLkGEwT4LUiX08EFbW/tM/Y=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 christian.koenig@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 natalie.vock@gmx.de
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [RFC PATCH] drm/amd/display: Pin native scanout to VRAM on
 large-carveout APUs
Date: Tue, 16 Jun 2026 00:10:37 -0700
Message-ID: <20260616071037.26718-1-matthew.schwartz@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Native scanout buffers on APUs are pinned with the VRAM|GTT domain, so
under VRAM carveout pressure a swapchain can end up split across VRAM and
GTT. The scanout buffer's memory type then changes from one flip to the
next, and amdgpu_dm_crtc_mem_type_changed() rejects an async page flip
across the change. The result is repeated async page flip failures,
observed as choppy updates under carveout pressure, until the buffers
reconverge to a single domain.

Pin native scanout buffers in VRAM only so the swapchain stays in one
memory domain. Restrict this to APUs whose carveout is larger than
AMDGPU_SG_THRESHOLD, so small-carveout parts keep their existing VRAM|GTT
placement, and fall back to GTT when the buffer does not fit in VRAM, so
the flip still succeeds and the swapchain stays in one domain. Imported
buffers may only be pinnable in GTT, so leave those on the default
domains.

Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
Hi,

This came up while testing my kernel patch to fix mem_type detection for
async flips here: https://lore.kernel.org/amd-gfx/20260611154438.571685-1-matthew.schwartz@linux.dev/

I found a new issue where splitting a swapchain between VRAM and GTT
causes a noticeable stutter in gameplay if gamescope is using direct
scanout and tearing is enabled while a game is already running.

Once a swapchain is split across the VRAM carveout and GTT, the scanout
buffer's mem_type changes from one flip to the next, so
amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Under direct
scanout with tearing that rejection recurs every time the displayed buffer
crosses domains, which is what surfaces as the choppiness. 

With this patch, I can enable tearing on top of an already-disabled frame
limit mid-game and no longer reproduce the choppiness.

amdgpu_gem_info confirms the swapchain converges to a single domain
instead of splitting across VRAM and GTT.

Before:
0x00000f81:      3981312 byte GTT exported as ino:275 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC     write fence:drm_sched gfx_0.0.0 seq 88248 signalled
0x00000f82:      3981312 byte GTT exported as ino:276 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC     write fence:drm_sched gfx_0.0.0 seq 88224 signalled
0x00000f83:      3981312 byte VRAM VISIBLE pin count 1 exported as ino:277 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC        write fence:drm_sched gfx_0.0.0 seq 88236 signalled

After:
0x00000f82:      3981312 byte VRAM VISIBLE pin count 1 exported as ino:548 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC        write fence:drm_sched gfx_0.0.0 seq 822258 signalled
0x00000f83:      3981312 byte VRAM VISIBLE exported as ino:549 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC    write fence:drm_sched gfx_0.0.0 seq 822255 signalled
0x00000f84:      3981312 byte VRAM VISIBLE exported as ino:550 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC    write fence:drm_sched gfx_0.0.0 seq 822261 signalled

Does this seem like the correct approach to take for fixing the observed
issue? I wanted to start with an RFC to make sure I didn't overlook
anything obvious or miss any better methods of fixing this.

Thanks,
Matt
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 23a9faa2ea89..b99f938e58ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -932,6 +932,7 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	struct amdgpu_bo *rbo;
 	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
 	uint32_t domain;
+	bool pin_vram_only;
 	int r;
 
 	if (!new_state->fb) {
@@ -958,13 +959,35 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	if (r)
 		goto error_unlock;
 
-	if (plane->type != DRM_PLANE_TYPE_CURSOR)
-		domain = amdgpu_display_supported_domains(adev, rbo->flags);
-	else
+	/*
+	 * Pin native scanout in VRAM on APUs so a swapchain stays in one
+	 * memory domain. A VRAM/GTT split changes its mem_type between flips
+	 * and amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Skip
+	 * small carveouts that may not fit, and imported buffers.
+	 */
+	pin_vram_only = plane->type != DRM_PLANE_TYPE_CURSOR &&
+			(adev->flags & AMD_IS_APU) &&
+			!rbo->tbo.base.import_attach &&
+			adev->gmc.real_vram_size > AMDGPU_SG_THRESHOLD;
+
+	if (plane->type == DRM_PLANE_TYPE_CURSOR || pin_vram_only)
 		domain = AMDGPU_GEM_DOMAIN_VRAM;
+	else
+		domain = amdgpu_display_supported_domains(adev, rbo->flags);
 
 	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	r = amdgpu_bo_pin(rbo, domain);
+	if (r == -ENOMEM && pin_vram_only) {
+		/*
+		 * VRAM could not fit the buffer. Fall back to GTT where
+		 * allowed so the swapchain stays in one domain.
+		 */
+		domain = amdgpu_display_supported_domains(adev, rbo->flags);
+		if (domain & AMDGPU_GEM_DOMAIN_GTT) {
+			domain = AMDGPU_GEM_DOMAIN_GTT;
+			r = amdgpu_bo_pin(rbo, domain);
+		}
+	}
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
 			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
-- 
2.54.0

