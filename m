Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90399CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 12:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB4110E418;
	Fri, 15 May 2026 12:09:23 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0830E10E623
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:09:22 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD2DC66D05;
 Fri, 15 May 2026 12:09:20 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73584593AA;
 Fri, 15 May 2026 12:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OCv1GvAMB2rQFwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 15 May 2026 12:09:20 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch, airlied@gmail.com, mdaenzer@redhat.com,
 pekka.paalanen@collabora.com, jadahl@gmail.com, contact@emersion.fr,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/9] drm/vblank: Add drmm_vblank_init() to indicate managed
 cleanup
Date: Fri, 15 May 2026 13:55:06 +0200
Message-ID: <20260515120916.333614-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515120916.333614-1-tzimmermann@suse.de>
References: <20260515120916.333614-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CD2DC66D05
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

Rename drm_vblank_init() to drmm_vblank_init(). As the initializer
function sets up managed cleanup, it should use the drmm prefix. Keep
the old name around until all callers have been converted.

Also add a flags argument to the function. The first use of the flags
will be to distinguish between hardware vblank interrupts and simulated
vblank timeouts.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c        | 16 +++++++++-------
 drivers/gpu/drm/drm_vblank_helper.c |  2 +-
 include/drm/drm_crtc.h              |  2 +-
 include/drm/drm_device.h            |  2 +-
 include/drm/drm_vblank.h            | 10 +++++++++-
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e42..21ca91b4c014 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -117,7 +117,7 @@
  * optionally provide a hardware vertical blanking counter.
  *
  * Drivers must initialize the vertical blanking handling core with a call to
- * drm_vblank_init(). Minimally, a driver needs to implement
+ * drmm_vblank_init(). Minimally, a driver needs to implement
  * &drm_crtc_funcs.enable_vblank and &drm_crtc_funcs.disable_vblank plus call
  * drm_crtc_handle_vblank() in its vblank interrupt handler for working vblank
  * support.
@@ -146,7 +146,7 @@
  * See also DRM vblank helpers for more information.
  *
  * Drivers without support for vertical-blanking interrupts nor timers must
- * not call drm_vblank_init(). For these drivers, atomic helpers will
+ * not call drmm_vblank_init(). For these drivers, atomic helpers will
  * automatically generate fake vblank events as part of the display update.
  * This functionality also can be controlled by the driver by enabling and
  * disabling struct drm_crtc_state.no_vblank.
@@ -519,7 +519,7 @@ static void vblank_disable_fn(struct timer_list *t)
 	spin_unlock_irqrestore(&dev->vbl_lock, irqflags);
 }
 
-static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
+static void drmm_vblank_init_release(struct drm_device *dev, void *ptr)
 {
 	struct drm_vblank_crtc *vblank = ptr;
 
@@ -534,9 +534,10 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 }
 
 /**
- * drm_vblank_init - initialize vblank support
+ * drmm_vblank_init - initialize vblank support
  * @dev: DRM device
  * @num_crtcs: number of CRTCs supported by @dev
+ * @flags: flags for vblank handling
  *
  * This function initializes vblank support for @num_crtcs display pipelines.
  * Cleanup is handled automatically through a cleanup function added with
@@ -545,7 +546,7 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
  * Returns:
  * Zero on success or a negative error code on failure.
  */
-int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
+int drmm_vblank_init(struct drm_device *dev, unsigned int num_crtcs, unsigned int flags)
 {
 	int ret;
 	unsigned int i;
@@ -564,11 +565,12 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 
 		vblank->dev = dev;
 		vblank->pipe = i;
+		vblank->flags = flags;
 		init_waitqueue_head(&vblank->queue);
 		timer_setup(&vblank->disable_timer, vblank_disable_fn, 0);
 		seqlock_init(&vblank->seqlock);
 
-		ret = drmm_add_action_or_reset(dev, drm_vblank_init_release,
+		ret = drmm_add_action_or_reset(dev, drmm_vblank_init_release,
 					       vblank);
 		if (ret)
 			return ret;
@@ -580,7 +582,7 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 
 	return 0;
 }
-EXPORT_SYMBOL(drm_vblank_init);
+EXPORT_SYMBOL(drmm_vblank_init);
 
 /**
  * drm_dev_has_vblank - test if vblanking has been initialized for
diff --git a/drivers/gpu/drm/drm_vblank_helper.c b/drivers/gpu/drm/drm_vblank_helper.c
index d3f8147ecdc1..5b05ab72e133 100644
--- a/drivers/gpu/drm/drm_vblank_helper.c
+++ b/drivers/gpu/drm/drm_vblank_helper.c
@@ -25,7 +25,7 @@
  * for drivers without further requirements. The initializer macro
  * DRM_CRTC_HELPER_VBLANK_FUNCS sets them coveniently.
  *
- * Once the driver enables vblank support with drm_vblank_init(), each
+ * Once the driver enables vblank support with drmm_vblank_init(), each
  * CRTC's vblank timer fires according to the programmed display mode. By
  * default, the vblank timer invokes drm_crtc_handle_vblank(). Drivers with
  * more specific requirements can set their own handler function in
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index c6dbe8b7db9e..f981468d9a00 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -163,7 +163,7 @@ struct drm_crtc_state {
 	 *
 	 * One usage is for drivers and/or hardware without support for VBLANK
 	 * interrupts. Such drivers typically do not initialize vblanking
-	 * (i.e., call drm_vblank_init() with the number of CRTCs). For CRTCs
+	 * (i.e., call drmm_vblank_init() with the number of CRTCs). For CRTCs
 	 * without initialized vblanking, this field is set to true in
 	 * drm_atomic_helper_check_modeset(), and a fake VBLANK event will be
 	 * send out on each update of the display pipeline by
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index bc78fb77cc27..381417c6b6f5 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -283,7 +283,7 @@ struct drm_device {
 	 * Array of vblank tracking structures, one per &struct drm_crtc. For
 	 * historical reasons (vblank support predates kernel modesetting) this
 	 * is free-standing and not part of &struct drm_crtc itself. It must be
-	 * initialized explicitly by calling drm_vblank_init().
+	 * initialized explicitly by calling drmm_vblank_init().
 	 */
 	struct drm_vblank_crtc *vblank;
 
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 2fcef9c0f5b1..39a201b83781 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -282,10 +282,12 @@ struct drm_vblank_crtc {
 	 * @vblank_timer: Holds the state of the vblank timer
 	 */
 	struct drm_vblank_crtc_timer vblank_timer;
+
+	unsigned int flags;
 };
 
 struct drm_vblank_crtc *drm_crtc_vblank_crtc(struct drm_crtc *crtc);
-int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
+int drmm_vblank_init(struct drm_device *dev, unsigned int num_crtcs, unsigned int flags);
 bool drm_dev_has_vblank(const struct drm_device *dev);
 u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
 u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
@@ -321,6 +323,12 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc);
 void drm_crtc_vblank_cancel_timer(struct drm_crtc *crtc);
 void drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_time);
 
+/* deprecated; use drmm_vblank_init() instead */
+static inline int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
+{
+	return drmm_vblank_init(dev, num_crtcs, 0);
+}
+
 /*
  * Helpers for struct drm_crtc_funcs
  */
-- 
2.54.0

