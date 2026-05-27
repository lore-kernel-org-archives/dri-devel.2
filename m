Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB145CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 13:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E91A10E7E2;
	Wed, 27 May 2026 13:39:31 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4E110E7E7
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:39:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A9B6A676DD;
 Wed, 27 May 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42D495A861;
 Wed, 27 May 2026 13:39:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +EXgDgz0FmrpMQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 13:39:24 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch, airlied@gmail.com, mdaenzer@redhat.com,
 pekka.paalanen@collabora.com, jadahl@gmail.com, contact@emersion.fr,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mhklinux@outlook.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/9] drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
Date: Wed, 27 May 2026 15:32:43 +0200
Message-ID: <20260527133917.207150-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527133917.207150-1-tzimmermann@suse.de>
References: <20260527133917.207150-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: A9B6A676DD
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

Add DRM_VBLANK_FLAG_SIMULATED for CRTCs that do not have a hardware
vblank interrupt. Setting the flag tells DRM to not report vblank
capabilities from the WAIT_VBLANK ioctl.

DRM_IOCTL_WAIT_VBLANK queries timestamps from a vblank event or waits
for the next vblank event to occur. DRM clients use this functionality
to synchronize their output with the display's vblank phase. Hence this
is only supported for hardware implementations.

Software implementations are not synchronized to the display and merely
act as a rate limiter for page-flip events. The WAIT_VBLANK ioctl thus
should fail with an error.

v2:
- add filter in CRTC_GET_SEQUENCE and CRTC_QUEUE_SEQUENCE ioctls (Michel)

Suggested-by: Simona Vetter <simona@ffwll.ch>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c | 10 ++++++++++
 include/drm/drm_vblank.h     |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 21ca91b4c014..3ef4ed08e7f6 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1794,6 +1794,9 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
 
 	vblank = drm_vblank_crtc(dev, pipe);
 
+	if (vblank->flags & DRM_VBLANK_FLAG_SIMULATED)
+		return -EOPNOTSUPP;
+
 	/* If the counter is currently enabled and accurate, short-circuit
 	 * queries to return the cached timestamp of the last vblank.
 	 */
@@ -2035,6 +2038,10 @@ int drm_crtc_get_sequence_ioctl(struct drm_device *dev, void *data,
 	pipe = drm_crtc_index(crtc);
 
 	vblank = drm_crtc_vblank_crtc(crtc);
+
+	if (vblank->flags & DRM_VBLANK_FLAG_SIMULATED)
+		return -EOPNOTSUPP;
+
 	vblank_enabled = READ_ONCE(vblank->config.disable_immediate) &&
 		READ_ONCE(vblank->enabled);
 
@@ -2102,6 +2109,9 @@ int drm_crtc_queue_sequence_ioctl(struct drm_device *dev, void *data,
 
 	vblank = drm_crtc_vblank_crtc(crtc);
 
+	if (vblank->flags & DRM_VBLANK_FLAG_SIMULATED)
+		return -EOPNOTSUPP;
+
 	e = kzalloc_obj(*e);
 	if (e == NULL)
 		return -ENOMEM;
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 39a201b83781..03fa7259b6ac 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -37,6 +37,11 @@ struct drm_device;
 struct drm_crtc;
 struct drm_vblank_work;
 
+/**
+ * DRM_VBLANK_FLAG_SIMULATED - vblank uses a software timer
+ */
+#define DRM_VBLANK_FLAG_SIMULATED	BIT(1)
+
 /**
  * struct drm_pending_vblank_event - pending vblank event tracking
  */
-- 
2.54.0

