Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CBEC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34DA210EA0D;
	Tue,  8 Sep 2026 07:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="SIyfJQtR";
	dkim-atps=neutral
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [185.125.25.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F93410E769
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 10:25:18 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdjRM0FR3zqsr;
 Mon,  7 Sep 2026 12:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
 s=20250113; t=1788775630;
 bh=4usX4hH8MgJcojkyuFvW45gywshubq8uHqF+sudxBMI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SIyfJQtRS8kcnwYDnSvBCygU7rsrFoBYL0aD5+ENdAgegVjgRl2SQsWmfyWLnPaMO
 cpbp0ts8s7U/+m2RgDz1fO+CReDuxXYNT4RQp38hw5T1QBRLF3Pa8VgJlheTou1mki
 egQktbvuJEM0fLJV/OBMkcwhjs8kQhWOmstmdmeanRCG0QoCGP3suRzemR5zmjGOya
 vPbrr+xxFSvNVJw/EJ8JBvaXM0W8OogtL3wL9bgbrvPFWLevvUO/bcdCEDuAv442Ag
 lwxmlNYHY+edGKCxYSbFWKJ6oUHwStkv2q5d4OOuvNPU82Gm9OwcLP4TI+18vXITFY
 upfvcaG/Bfc3g==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hdjRL2MR6zXWX; Mon,  7 Sep 2026 12:07:10 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/amd/display: size frame-packed streams by the doubled
 timing
Date: Mon,  7 Sep 2026 12:06:26 +0200
Message-ID: <20260907100626.54465-4-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907100626.54465-1-adrian.betschart@cinemaone.ch>
References: <20260907100626.54465-1-adrian.betschart@cinemaone.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

A frame-packed 3D mode scans out both views and the active space
between them in one frame, so the CRTC is 2205 lines tall for a
1080p mode. The stream scaling code took the source height from
mode->vdisplay (1080) against the 2205-line addressable destination;
with aspect scaling that keeps 1080 lines and centres them, so the
first view is stretched across both eye windows and the second view
is never shown. The plane viewport check clipped planes to
crtc_vdisplay for the same reason.

Use drm_mode_get_hv_timing(), which returns the doubled height for
stereo modes and the plain display size otherwise, in both places.

Measured on a Radeon RX 7600 with a frame-packed 1920x1080p24 mode:
before, a row-coded 2205-line test frame showed rows of the first
view in both eyes; after, each eye receives its own view.

Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 11 ++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 13 +++++++++----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 7a2beb175..ac9fe2883 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1405,9 +1405,14 @@ void amdgpu_dm_update_stream_scaling_settings(struct drm_device *dev,
 	if (!mode)
 		return;
 
-	/* Full screen scaling by default */
-	src.width = mode->hdisplay;
-	src.height = mode->vdisplay;
+	/*
+	 * Full screen scaling by default. A frame-packed 3D mode scans out the
+	 * doubled timing, so the source size is the CRTC size, not vdisplay:
+	 * with 1080 lines against a 2205-line destination the aspect fit would
+	 * keep 1080 lines and centre them, putting the first view across both
+	 * eye windows and none of the second.
+	 */
+	drm_mode_get_hv_timing(mode, &src.width, &src.height);
 	dst.width = stream->timing.h_addressable;
 	dst.height = stream->timing.v_addressable;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 0a5a73472..8db656ef8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1407,16 +1407,21 @@ int amdgpu_dm_plane_helper_check_state(struct drm_plane_state *state,
 		if (state->plane->type != DRM_PLANE_TYPE_CURSOR) {
 			int viewport_width = state->crtc_w;
 			int viewport_height = state->crtc_h;
+			int mode_hdisplay, mode_vdisplay;
+
+			/* frame-packed 3D scans out the doubled timing */
+			drm_mode_get_hv_timing(&new_crtc_state->mode,
+					       &mode_hdisplay, &mode_vdisplay);
 
 			if (state->crtc_x < 0)
 				viewport_width += state->crtc_x;
-			else if (state->crtc_x + state->crtc_w > new_crtc_state->mode.crtc_hdisplay)
-				viewport_width = new_crtc_state->mode.crtc_hdisplay - state->crtc_x;
+			else if (state->crtc_x + state->crtc_w > mode_hdisplay)
+				viewport_width = mode_hdisplay - state->crtc_x;
 
 			if (state->crtc_y < 0)
 				viewport_height += state->crtc_y;
-			else if (state->crtc_y + state->crtc_h > new_crtc_state->mode.crtc_vdisplay)
-				viewport_height = new_crtc_state->mode.crtc_vdisplay - state->crtc_y;
+			else if (state->crtc_y + state->crtc_h > mode_vdisplay)
+				viewport_height = mode_vdisplay - state->crtc_y;
 
 			if (viewport_width < 0 || viewport_height < 0) {
 				DRM_DEBUG_ATOMIC("Plane completely outside of screen\n");
-- 
2.43.0

