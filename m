Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28EFC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717AF10F497;
	Fri,  7 Aug 2026 11:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="q7ma/2wY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030BA10F48F;
 Fri,  7 Aug 2026 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=VyzaDBTNvUR9/B1sqINXHvb+oFPBhizMhgR5f230gNQ=; b=
 q7ma/2wYEIFq5GfvNK337yny/O3GThxl3rndF9lTVEePh5UyliT/zojX/5DLQP5aMBPfDpjRNCaSh
 p6kOy/oWdrR8kk8rOo5krkKYQ4KgmdUEKs7fko78SbJBd+LdlIg//qp/utfH8t5UO+HpUSdGAT/MI
 hIWmABdHfuWRueLEHjOrGMobh6XBAM2ffOeVcyJyNrvN2+c5BgIjb1KuMArSX0/i0A1YS0s7TA1a/
 h9aVoRPCZY01eUR6K30MoS22ZcIWuz5LSyjF6mQsLbXNfYNOql4Ldgc7Ve5q2ddKTehAy7bvfc7dL
 QJizZZW7c6QoN9WAIJkTPexeas4/+MDnvQ==;
Received: from 84.125.127.96.dyn.user.ono.com ([84.125.127.96]
 helo=killbill.home) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wsJCT-00FPeE-UV; Fri, 07 Aug 2026 13:57:22 +0200
From: Melissa Wen <mwen@igalia.com>
To: Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: use plane color_mgmt_changed to track
 colorop changes
Date: Fri,  7 Aug 2026 13:56:21 +0200
Message-ID: <20260807115712.22423-1-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is a resubmission of d79716401a95 ("drm/amd/display: use plane
color_mgmt_changed to track colorop changes") whose change was reverted
by 0461ba9a7994 ("Merge tag 'amd-drm-next-7.3-2026-07-02' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next") during a
merge conflict resolution.

Original commit message:

```
Ensure the driver tracks changes in any colorop property of a plane
color pipeline by using the same mechanism of CRTC color management and
update plane color blocks when any colorop property changes. It fixes an
issue observed on gamescope settings for night mode which is done via
shaper/3D-LUT updates.
```

Fixes: 0461ba9a7994 ("Merge tag 'amd-drm-next-7.3-2026-07-02' of https://gitlab.freedesktop.org/agd5f/linux into drm-next")
Signed-off-by: Melissa Wen <mwen@igalia.com>

---

Hey,

I noticed this problem in the resolution of a merge conflict after
testing drm-misc-next on SteamDeck with KMS colorop API support and
verifying the issue of missing updates in nightlight-mode was back.

Let me know what are the right steps to address it.

Thanks,

Melissa

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 67b825cbb88f..d0e612371c8f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4202,7 +4202,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			continue;
 
 		bundle->surface_updates[planes_count].surface = dc_plane;
-		if (new_pcrtc_state->color_mgmt_changed) {
+		if (new_pcrtc_state->color_mgmt_changed || new_plane_state->color_mgmt_changed) {
 			bundle->surface_updates[planes_count].gamma = &dc_plane->gamma_correction;
 			bundle->surface_updates[planes_count].in_transfer_func = &dc_plane->in_transfer_func;
 			bundle->surface_updates[planes_count].gamut_remap_matrix = &dc_plane->gamut_remap_matrix;
@@ -6012,6 +6012,10 @@ static bool should_reset_plane(struct drm_atomic_commit *state,
 	if (new_crtc_state->color_mgmt_changed)
 		return true;
 
+	/* Plane color pipeline or its colorop changes. */
+	if (new_plane_state->color_mgmt_changed)
+		return true;
+
 	/*
 	 * On zpos change, planes need to be reordered by removing and re-adding
 	 * them one by one to the dc state, in order of descending zpos.
-- 
2.53.0

