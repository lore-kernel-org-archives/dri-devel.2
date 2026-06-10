Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7352BCD98D2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC9610EA60;
	Wed, 10 Jun 2026 15:25:23 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 225DA10EA5F
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:25:21 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 597DD6AE8E;
 Wed, 10 Jun 2026 15:25:16 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82C03779A9;
 Wed, 10 Jun 2026 15:25:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SAmBHtuBKWr3HwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:15 +0000
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
Subject: [PATCH v5 05/15] drm/appletbdrm: Allocate request/response buffers in
 begin_fb_access
Date: Wed, 10 Jun 2026 17:18:21 +0200
Message-ID: <20260610152505.260172-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610152505.260172-1-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 597DD6AE8E
X-Rspamd-Action: no action
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

In atomic_check, damage handling is not fully evaluated. Another
atomic_check helper could trigger a full modeset and thus invalidate
damage clips.

Allocation of the request/response buffers in appletbdrm depends on
correct damage information. Otherwise it might allocate incorrectly
sized buffers. Allocate the buffers in the driver's begin_fb_access
helper. It runs early during the commit when damage clipping has been
fully evaluated.

v5:
- pass plane state as the old damage-iterator state
v2:
- allocate before drm_gem_begin_shadow_fb_access() to avoid leak on error

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Aditya Garg <gargaditya08@proton.me>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/tiny/appletbdrm.c | 53 +++++++++++++++++--------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
index cdd35af49892..ef71b9957961 100644
--- a/drivers/gpu/drm/tiny/appletbdrm.c
+++ b/drivers/gpu/drm/tiny/appletbdrm.c
@@ -315,33 +315,16 @@ static const u32 appletbdrm_primary_plane_formats[] = {
 	DRM_FORMAT_XRGB8888, /* emulated */
 };
 
-static int appletbdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
-						   struct drm_atomic_commit *state)
+static int appletbdrm_primary_plane_helper_begin_fb_access(struct drm_plane *plane,
+							   struct drm_plane_state *new_plane_state)
 {
-	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
-	struct drm_crtc *new_crtc = new_plane_state->crtc;
-	struct drm_crtc_state *new_crtc_state = NULL;
 	struct appletbdrm_plane_state *appletbdrm_state = to_appletbdrm_plane_state(new_plane_state);
+	size_t frames_size = 0;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect damage;
-	size_t frames_size = 0;
 	size_t request_size;
-	int ret;
-
-	if (new_crtc)
-		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_crtc);
 
-	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
-						  DRM_PLANE_NO_SCALING,
-						  DRM_PLANE_NO_SCALING,
-						  false, false);
-	if (ret)
-		return ret;
-	else if (!new_plane_state->visible)
-		return 0;
-
-	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, new_plane_state);
+	drm_atomic_helper_damage_iter_init(&iter, plane->state, new_plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		frames_size += struct_size((struct appletbdrm_frame *)0, buf, rect_size(&damage));
 	}
@@ -366,6 +349,29 @@ static int appletbdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	appletbdrm_state->request_size = request_size;
 	appletbdrm_state->frames_size = frames_size;
 
+	return drm_gem_begin_shadow_fb_access(plane, new_plane_state);
+}
+
+static int appletbdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
+							struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *new_crtc = new_plane_state->crtc;
+	struct drm_crtc_state *new_crtc_state = NULL;
+	int ret;
+
+	if (new_crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_crtc);
+
+	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+	if (ret)
+		return ret;
+	else if (!new_plane_state->visible)
+		return 0;
+
 	return 0;
 }
 
@@ -468,7 +474,7 @@ static int appletbdrm_flush_damage(struct appletbdrm_device *adev,
 }
 
 static void appletbdrm_primary_plane_helper_atomic_update(struct drm_plane *plane,
-						     struct drm_atomic_commit *old_state)
+							  struct drm_atomic_commit *old_state)
 {
 	struct appletbdrm_device *adev = drm_to_adev(plane->dev);
 	struct drm_device *drm = plane->dev;
@@ -552,7 +558,8 @@ static void appletbdrm_primary_plane_destroy_state(struct drm_plane *plane,
 }
 
 static const struct drm_plane_helper_funcs appletbdrm_primary_plane_helper_funcs = {
-	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.begin_fb_access = appletbdrm_primary_plane_helper_begin_fb_access,
+	.end_fb_access = drm_gem_end_shadow_fb_access,
 	.atomic_check = appletbdrm_primary_plane_helper_atomic_check,
 	.atomic_update = appletbdrm_primary_plane_helper_atomic_update,
 	.atomic_disable = appletbdrm_primary_plane_helper_atomic_disable,
-- 
2.54.0

