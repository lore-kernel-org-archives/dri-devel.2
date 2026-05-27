Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B516ECD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 14:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1699E10E81F;
	Wed, 27 May 2026 14:51:39 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2714710E83C
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 14:51:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E03F467282;
 Wed, 27 May 2026 14:51:24 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 651315A8AA;
 Wed, 27 May 2026 14:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0K5pF+wEF2qsegAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 14:51:24 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mripard@kernel.org, maarten.lankhorst@linux.intel.com, airlied@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, admin@kodeit.net,
 gargaditya08@proton.me, paul@crapouillou.net, jani.nikula@linux.intel.com,
 mhklinux@outlook.com, zack.rusin@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 10/10] drm/vmwgfx: Remove unused field struct
 vmwgfx_du_update_plane.old_state
Date: Wed, 27 May 2026 16:46:29 +0200
Message-ID: <20260527145113.241595-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527145113.241595-1-tzimmermann@suse.de>
References: <20260527145113.241595-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: E03F467282
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
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

