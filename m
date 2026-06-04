Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130C7CD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 06:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 648DF1126F4;
	Thu,  4 Jun 2026 06:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="qB4JrXrC";
	dkim-atps=neutral
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com
 [95.215.58.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9838C1126DE
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 06:45:06 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780555493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mTI2prm2clzWv1IFKwQSUxNjHp3GJWhjQ6YGZew1VGE=;
 b=qB4JrXrC/Jhnp3Q+ZWLXyuhI74JmgrnhViNwN6dZAcs1RKmFD1+S2EV6hNl7S1LHRtKjFw
 lm4uGvjqDH5z7GqzC/po/RcdmO3M7Ydubewk9hlI+IsLo8Gh2iWT7pPCxFFnlTdgX2yUb8
 kt9Goo3DbHszaYU5hi7hBO4Fcg5prgI=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH] drm/amd/display: Fix mem_type change detection for async flips
Date: Wed,  3 Jun 2026 23:44:24 -0700
Message-ID: <20260604064424.3154796-1-matthew.schwartz@linux.dev>
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

[Why]
amdgpu_dm_crtc_mem_type_changed() fetches the "old" and "new" plane state
with two drm_atomic_get_plane_state() calls, which both return the new
state. It compares a state against itself, so it never detects a mem_type
change and never rejects the async flip.

On DCN 3.0.1, this shows up as intermittent corruption when a single DCC
plane is scanned out with immediate flips under gamescope and its buffer
moves between the VRAM carveout and GTT.

[How]
Use drm_atomic_get_old_plane_state() and drm_atomic_get_new_plane_state()
to compare the actual old and new states. These return NULL rather than
an error pointer for a plane that is not part of the commit, so the
IS_ERR() check becomes a NULL check that skips those planes, such as an
unmodified cursor still in the CRTC's plane_mask.

Fixes: 4caacd1671b7a ("drm/amd/display: Do not elevate mem_type change to full update")
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6c1e7e13f0399..711640739179e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12934,13 +12934,11 @@ static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 	struct drm_plane_state *new_plane_state, *old_plane_state;
 
 	drm_for_each_plane_mask(plane, dev, crtc_state->plane_mask) {
-		new_plane_state = drm_atomic_get_plane_state(state, plane);
-		old_plane_state = drm_atomic_get_plane_state(state, plane);
+		new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+		old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 
-		if (IS_ERR(new_plane_state) || IS_ERR(old_plane_state)) {
-			drm_err(dev, "Failed to get plane state for plane %s\n", plane->name);
-			return false;
-		}
+		if (!old_plane_state || !new_plane_state)
+			continue;
 
 		if (old_plane_state->fb && new_plane_state->fb &&
 		    get_mem_type(old_plane_state->fb) != get_mem_type(new_plane_state->fb))
-- 
2.54.0

