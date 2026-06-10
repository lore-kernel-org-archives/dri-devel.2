Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831C9CD98DE
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B4C10EAA2;
	Wed, 10 Jun 2026 15:25:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="LErn801m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/gj2oqwe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LErn801m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/gj2oqwe";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B492410EAB6
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:25:45 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 344C76AED7;
 Wed, 10 Jun 2026 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781105125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5UtJ6eV6iOSreVQ99DfSSH13XZuuKC0qy/3UHtKhSU=;
 b=LErn801mgf0Wj2MbLzMjH9WR8A2GfoXtHgvC4Kgg5XcqnGRLO4WucHIqSMIrl9LtfjaeJ3
 f9JoFG9cSP6BSKsvEq7MmOxOs7hVOJR9ECVZZWlTUHvYhFHKBFiIKfdSB3QFi9ZzPTIQis
 ulr4+xns++2oB5B/UpyPg9/sEjHHbIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781105125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5UtJ6eV6iOSreVQ99DfSSH13XZuuKC0qy/3UHtKhSU=;
 b=/gj2oqweTBBHd8ryXjO4cluY8v9LaZrF9oBqMR+EgAOTTCUNVGdHRhxkxrt1O82U3YVqhq
 Wx/f6dDn0M5okzCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781105125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5UtJ6eV6iOSreVQ99DfSSH13XZuuKC0qy/3UHtKhSU=;
 b=LErn801mgf0Wj2MbLzMjH9WR8A2GfoXtHgvC4Kgg5XcqnGRLO4WucHIqSMIrl9LtfjaeJ3
 f9JoFG9cSP6BSKsvEq7MmOxOs7hVOJR9ECVZZWlTUHvYhFHKBFiIKfdSB3QFi9ZzPTIQis
 ulr4+xns++2oB5B/UpyPg9/sEjHHbIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781105125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5UtJ6eV6iOSreVQ99DfSSH13XZuuKC0qy/3UHtKhSU=;
 b=/gj2oqweTBBHd8ryXjO4cluY8v9LaZrF9oBqMR+EgAOTTCUNVGdHRhxkxrt1O82U3YVqhq
 Wx/f6dDn0M5okzCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6098A779A9;
 Wed, 10 Jun 2026 15:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +JMmFuSBKWr3HwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:24 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mripard@kernel.org, maarten.lankhorst@linux.intel.com, airlied@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, admin@kodeit.net,
 gargaditya08@proton.me, paul@crapouillou.net, jani.nikula@linux.intel.com,
 mhklkml@zohomail.com, zack.rusin@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, javierm@redhat.com, dmitry.osipenko@collabora.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v5 15/15] drm/vmwgfx: Remove unused field struct
 vmwgfx_du_update_plane.old_state
Date: Wed, 10 Jun 2026 17:18:31 +0200
Message-ID: <20260610152505.260172-16-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610152505.260172-1-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.79 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.19)[-0.942]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCPT_COUNT_TWELVE(0.00)[31]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,zohomail.com,broadcom.com,amd.com,igalia.com,intel.com,ursulin.net,collabora.com,chromium.org];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLq3cifbxyhc6qbbynzfc6amns)];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Plane updates no longer require the old plane state. Remove the field
from struct vmwgfx_du_update_plane and fix all callers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  2 --
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c | 12 ++----------
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 11 ++---------
 3 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 2224d7d91d1b..8c2072b82062 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -19,7 +19,6 @@
 /**
  * struct vmw_du_update_plane - Closure structure for vmw_du_helper_plane_update
  * @plane: Plane which is being updated.
- * @old_state: Old state of plane.
  * @dev_priv: Device private.
  * @du: Display unit on which to update the plane.
  * @vfb: Framebuffer which is blitted to display unit.
@@ -102,7 +101,6 @@ struct vmw_du_update_plane {
 				    struct drm_rect *bb);
 
 	struct drm_plane *plane;
-	struct drm_plane_state *old_state;
 	struct vmw_private *dev_priv;
 	struct vmw_display_unit *du;
 	struct vmw_framebuffer *vfb;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index c83061cf7455..fa84bc7ab5bb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -530,7 +530,6 @@ static uint32_t vmw_stud_bo_post_clip(struct vmw_du_update_plane  *update,
  */
 static int vmw_sou_plane_update_bo(struct vmw_private *dev_priv,
 				   struct drm_plane *plane,
-				   struct drm_plane_state *old_state,
 				   struct vmw_framebuffer *vfb,
 				   struct vmw_fence_obj **out_fence)
 {
@@ -538,7 +537,6 @@ static int vmw_sou_plane_update_bo(struct vmw_private *dev_priv,
 
 	memset(&bo_update, 0, sizeof(struct vmw_du_update_plane_buffer));
 	bo_update.base.plane = plane;
-	bo_update.base.old_state = old_state;
 	bo_update.base.dev_priv = dev_priv;
 	bo_update.base.du = vmw_crtc_to_du(plane->state->crtc);
 	bo_update.base.vfb = vfb;
@@ -692,7 +690,6 @@ static uint32_t vmw_sou_surface_post_clip(struct vmw_du_update_plane *update,
  */
 static int vmw_sou_plane_update_surface(struct vmw_private *dev_priv,
 					struct drm_plane *plane,
-					struct drm_plane_state *old_state,
 					struct vmw_framebuffer *vfb,
 					struct vmw_fence_obj **out_fence)
 {
@@ -700,7 +697,6 @@ static int vmw_sou_plane_update_surface(struct vmw_private *dev_priv,
 
 	memset(&srf_update, 0, sizeof(struct vmw_du_update_plane_surface));
 	srf_update.base.plane = plane;
-	srf_update.base.old_state = old_state;
 	srf_update.base.dev_priv = dev_priv;
 	srf_update.base.du = vmw_crtc_to_du(plane->state->crtc);
 	srf_update.base.vfb = vfb;
@@ -721,7 +717,6 @@ static void
 vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
 				    struct drm_atomic_commit *state)
 {
-	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_crtc *crtc = new_state->crtc;
 	struct vmw_fence_obj *fence = NULL;
@@ -734,12 +729,9 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
 			vmw_framebuffer_to_vfb(new_state->fb);
 
 		if (vfb->bo)
-			ret = vmw_sou_plane_update_bo(dev_priv, plane,
-						      old_state, vfb, &fence);
+			ret = vmw_sou_plane_update_bo(dev_priv, plane, vfb, &fence);
 		else
-			ret = vmw_sou_plane_update_surface(dev_priv, plane,
-							   old_state, vfb,
-							   &fence);
+			ret = vmw_sou_plane_update_surface(dev_priv, plane, vfb, &fence);
 		if (ret != 0)
 			DRM_ERROR("Failed to update screen.\n");
 	} else {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index f0df2b1c8465..474e3badb80f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1240,7 +1240,6 @@ vmw_stdu_bo_populate_update_cpu(struct vmw_du_update_plane  *update, void *cmd,
  */
 static int vmw_stdu_plane_update_bo(struct vmw_private *dev_priv,
 				    struct drm_plane *plane,
-				    struct drm_plane_state *old_state,
 				    struct vmw_framebuffer *vfb,
 				    struct vmw_fence_obj **out_fence)
 {
@@ -1248,7 +1247,6 @@ static int vmw_stdu_plane_update_bo(struct vmw_private *dev_priv,
 
 	memset(&bo_update, 0, sizeof(struct vmw_du_update_plane_buffer));
 	bo_update.base.plane = plane;
-	bo_update.base.old_state = old_state;
 	bo_update.base.dev_priv = dev_priv;
 	bo_update.base.du = vmw_crtc_to_du(plane->state->crtc);
 	bo_update.base.vfb = vfb;
@@ -1350,7 +1348,6 @@ vmw_stdu_surface_populate_update(struct vmw_du_update_plane  *update, void *cmd,
  */
 static int vmw_stdu_plane_update_surface(struct vmw_private *dev_priv,
 					 struct drm_plane *plane,
-					 struct drm_plane_state *old_state,
 					 struct vmw_framebuffer *vfb,
 					 struct vmw_fence_obj **out_fence)
 {
@@ -1363,7 +1360,6 @@ static int vmw_stdu_plane_update_surface(struct vmw_private *dev_priv,
 
 	memset(&srf_update, 0, sizeof(struct vmw_du_update_plane));
 	srf_update.plane = plane;
-	srf_update.old_state = old_state;
 	srf_update.dev_priv = dev_priv;
 	srf_update.du = vmw_crtc_to_du(plane->state->crtc);
 	srf_update.vfb = vfb;
@@ -1424,12 +1420,9 @@ vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
 			DRM_ERROR("Failed to bind surface to STDU.\n");
 
 		if (vfb->bo)
-			ret = vmw_stdu_plane_update_bo(dev_priv, plane,
-						       old_state, vfb, &fence);
+			ret = vmw_stdu_plane_update_bo(dev_priv, plane, vfb, &fence);
 		else
-			ret = vmw_stdu_plane_update_surface(dev_priv, plane,
-							    old_state, vfb,
-							    &fence);
+			ret = vmw_stdu_plane_update_surface(dev_priv, plane, vfb, &fence);
 		if (ret)
 			DRM_ERROR("Failed to update STDU.\n");
 	} else {
-- 
2.54.0

