Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5F606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E024110F958;
	Wed, 11 Nov 2026 08:23:41 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F1B10F88D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 01:37:34 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-8b335ef6441so24462387b3.3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794361054; x=1794965854;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vcp5eI8JJb1RnVVTP7/VW38KUPuSkqgudGy8DfnBQ6o=;
 b=Kv//3K8Bx23kd+1GR6mq7TTa/W6vZlC5On1RUXWa5D+ELFkY4zUglDn20QDc1HaMxq
 LYfhdjcNP62ReXwTW8IR2MHhhCZpxFYkdqRMXIg+27bjWOAa5ChN7eYw6DqXd+LlVLA2
 YCUo10T4Rd19ko6QgoG91LLjsERxf8bhJ1twCBKWzSJZOrlY4hoNtSfdKFeeCi3/seFF
 dxfcEtxX2vtMI7ulq3U5FWfZYWmJR7ldo+yrLCR/Ag4vujP3gcCwIJ+H9FGR0bODKAcg
 SstHBM/F4LuEJ6hA2oN8OJeuxnBgpzK3xyGC6ie4J6e/q9/jYlqc8V/dSVpanE2KgKiJ
 FkjQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG6XxwJWpXtHiOR8QcPT9bM4L+98CwVW42AcFchJAiMceosxLzx/yuYc+SUwXik5mJicppf64QvjMk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+gv8R/WNLP52KCi/P6ExgxGEebixmpK1z9RGgrQ6WvP3QEmPWb
 4HnVc0hIpYizlznZYa6TrAiBk/CPuS3YirOqz94vAjFNerjR6Jas2kma
X-Gm-Gg: AYBFou2HohlWJqXxQH2BrcF2OFzFC/UXqhchv5+s3pXyaiu8GKUfhmA4tHqagg3xogk
 ZI6QP5Oq91bAk6nymxmSPSdgX3GvX8HC96+vB6oNwdCLHy4bFZKd6oNTgzH0xRWX0sPPgzzn3nl
 cvRdzSoNs0OZSQl7kyI9Z5DmqjwGe2kar/yhFGpb8LKXCVqJu2LPIllycx6hhE+Oq3RqKaICOnO
 QXU2B0PY8hrPILCNpRFTvKF6OBV6PsiqYupS8ofaIdi4vWn+mTQxSjNLHMr7H0KKe47LxquaN68
 qi8m9IWv9IzjgV8W3PcmMJL4yA4e9dOZ5xUy3zEjw5TH9+Va10i3uk0DMsHAlqs7MRHyLO2+5cc
 ixEyxvxi4CDQnjzprMqNAYgZ5YbFT5Om7WvhWtpLyHmb+2z9Iae87u6FR0HzKJ+o1TA732icAUU
 p7Ptq+YLPB4q8w0YSxFiVrHVZz3GyO6X4VRcWUaavJx8ugnz0D9NNG/0XoITH7Iwh4LjTVvwcuM
 e9dgxf+i6Zjr94rxsTgVw6HcZQHcIRWAO2XLhBq0iJDX4zTFdiMiC+Lu9sVDMbU0Zq3fE5cManM
 UP02uRi+DuKaQN+trB+n5Qo8v6EkFjbWXB21RKS8+uBVw3WPzLjJc0ruSH9MADEQC9ta0XkqCpr
 19GFfUVp6ZCaDSm2agixCCL6i1zdaPjtesYYazZAtiGlyQvqdijKUBNbcAeUJjuWZOglTOznFqa
 8lxzFxLQ/jfKh2Nhn7t6fZKo+5
X-Received: by 2002:a05:690c:82:b0:8b3:5eaf:29fc with SMTP id
 00721157ae682-8b3a80632fcmr7901627b3.27.1794361053615; 
 Tue, 10 Nov 2026 17:37:33 -0800 (PST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([71.68.170.161]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b39324ba4fsm33625677b3.4.2026.11.10.17.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 17:37:32 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Tue, 10 Nov 2026 20:37:11 -0500
Subject: [PATCH RFC] drm/sysfb: Copy damage outside the DIRTYFB ioctl
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-sysfb-dirtyfb-v1-1-8571d455ccbe@telaak.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0MD3eLK4rQk3ZTMopJKIJ2UmpJoaJCWmGRmYKQE1FNQlJqWWQE2L1o
 pyM1ZKRYiWFyalJWaXAIySam2FgAGuYcydgAAAA==
X-Change-ID: 20261110-sysfb-dirtyfb-beda10fab602
To: Thomas Zimmermann <tzimmermann@suse.de>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The sysfb drivers implement DIRTYFB with drm_atomic_helper_dirtyfb(),
which runs a blocking commit. The commit waits for the framebuffer's
fences, so the ioctl doesn't return until the GPU has finished
rendering into the framebuffer.

Xorg's modesetting driver calls DIRTYFB from its main thread after
every frame. When a separate GPU renders for a sysfb display, X then
blocks for as long as the GPU takes to render the client's frame. With
a game running, X took a median of 1.85 s to answer a pointer query.

Queue the damage instead and copy it from a worker. The worker still
waits for the fences, so nothing unfinished reaches the screen, and
damage that arrives while a copy is pending is merged into it.

With this change, X answers in a median of 23 ms and the game's frame
rate is unchanged.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
This is an RFC because I'm not sure DIRTYFB may return before the copy
is done. The fbdev emulation already defers its damage to a worker,
but userspace might rely on DIRTYFB being synchronous. If the approach
is fine, would you rather have it as a nonblocking mode of
drm_atomic_helper_dirtyfb() for all drivers instead of in sysfb?

I hit this on an Intel Atom CE5300 board, where simpledrm drives the
display and the SoC's PowerVR SGX545 GPU renders with a driver I'm
writing (not upstream yet). I haven't reproduced it with an upstream
GPU driver, but nothing in the stall is specific to the GPU.
---
 drivers/gpu/drm/sysfb/corebootdrm.c       |   3 +
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h  |  15 ++-
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 154 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/sysfb/efidrm.c            |   3 +
 drivers/gpu/drm/sysfb/ofdrm.c             |   3 +
 drivers/gpu/drm/sysfb/simpledrm.c         |   3 +
 drivers/gpu/drm/sysfb/vesadrm.c           |   3 +
 7 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/corebootdrm.c b/drivers/gpu/drm/sysfb/corebootdrm.c
index 853da9a..4ca359b 100644
--- a/drivers/gpu/drm/sysfb/corebootdrm.c
+++ b/drivers/gpu/drm/sysfb/corebootdrm.c
@@ -206,6 +206,9 @@ static int corebootdrm_mode_config_init(struct corebootdrm_device *cdev,
 	int ret;
 
 	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ret;
+	ret = drm_sysfb_damage_init(sysfb);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
index 6dab27b..59c4064 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
@@ -5,6 +5,8 @@
 
 #include <linux/container_of.h>
 #include <linux/iosys-map.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 #include <video/pixel_format.h>
 
@@ -81,6 +83,12 @@ struct drm_sysfb_device {
 
 	/* hardware-framebuffer kernel address */
 	struct iosys_map fb_addr;
+
+	/* damage from DIRTYFB, copied to the hardware framebuffer by damage_work */
+	spinlock_t damage_lock;
+	struct drm_framebuffer *damage_fb;
+	struct drm_rect damage;
+	struct work_struct damage_work;
 };
 
 static inline struct drm_sysfb_device *to_drm_sysfb_device(struct drm_device *dev)
@@ -203,8 +211,13 @@ int drm_sysfb_connector_helper_get_modes(struct drm_connector *connector);
  * Mode config
  */
 
+int drm_sysfb_damage_init(struct drm_sysfb_device *sysfb);
+struct drm_framebuffer *drm_sysfb_fb_create(struct drm_device *dev, struct drm_file *file,
+					    const struct drm_format_info *info,
+					    const struct drm_mode_fb_cmd2 *mode_cmd);
+
 #define DRM_SYSFB_MODE_CONFIG_FUNCS \
-	.fb_create = drm_gem_fb_create_with_dirty, \
+	.fb_create = drm_sysfb_fb_create, \
 	.atomic_check = drm_atomic_helper_check, \
 	.atomic_commit = drm_atomic_helper_commit
 
diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index 13df092..e77f0c0 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -12,6 +12,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_panic.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -612,3 +613,156 @@ int drm_sysfb_connector_helper_get_modes(struct drm_connector *connector)
 	return drm_connector_helper_get_modes_fixed(connector, &sysfb->fb_mode);
 }
 EXPORT_SYMBOL(drm_sysfb_connector_helper_get_modes);
+
+/*
+ * Damage
+ *
+ * DIRTYFB returns at once: the damage is merged into one pending rectangle,
+ * and a worker hands it to drm_atomic_helper_dirtyfb(). That commit waits for
+ * the framebuffer's fences, the GPU work that last rendered into it, before
+ * the CPU copies it to the hardware framebuffer. Done in the ioctl, the wait
+ * blocks the compositor for as long as that rendering takes. Damage that
+ * arrives while the worker runs is merged and copied by the next run, so none
+ * is dropped.
+ */
+
+static void drm_sysfb_damage_work(struct work_struct *work)
+{
+	struct drm_sysfb_device *sysfb = container_of(work, struct drm_sysfb_device,
+						      damage_work);
+	struct drm_framebuffer *fb;
+	struct drm_clip_rect clip;
+	int idx, ret;
+
+	spin_lock(&sysfb->damage_lock);
+	fb = sysfb->damage_fb;
+	sysfb->damage_fb = NULL;
+	clip.x1 = sysfb->damage.x1;
+	clip.y1 = sysfb->damage.y1;
+	clip.x2 = sysfb->damage.x2;
+	clip.y2 = sysfb->damage.y2;
+	spin_unlock(&sysfb->damage_lock);
+	if (!fb)
+		return;
+
+	if (drm_dev_enter(&sysfb->dev, &idx)) {
+		ret = drm_atomic_helper_dirtyfb(fb, NULL, 0, 0, &clip, 1);
+		if (ret)
+			drm_err_ratelimited(&sysfb->dev, "damage update failed: %d\n", ret);
+		drm_dev_exit(idx);
+	}
+	drm_framebuffer_put(fb);
+}
+
+static void drm_sysfb_damage_fini(struct drm_device *dev, void *arg)
+{
+	struct drm_sysfb_device *sysfb = arg;
+
+	cancel_work_sync(&sysfb->damage_work);
+	if (sysfb->damage_fb)
+		drm_framebuffer_put(sysfb->damage_fb);
+	sysfb->damage_fb = NULL;
+}
+
+/**
+ * drm_sysfb_damage_init - Set up deferred damage for a sysfb device
+ * @sysfb: the device
+ *
+ * Call after drmm_mode_config_init(). Framebuffers from drm_sysfb_fb_create()
+ * then copy their damage outside the DIRTYFB ioctl.
+ *
+ * Returns: 0 on success, or a negative errno.
+ */
+int drm_sysfb_damage_init(struct drm_sysfb_device *sysfb)
+{
+	spin_lock_init(&sysfb->damage_lock);
+	INIT_WORK(&sysfb->damage_work, drm_sysfb_damage_work);
+
+	return drmm_add_action_or_reset(&sysfb->dev, drm_sysfb_damage_fini, sysfb);
+}
+EXPORT_SYMBOL(drm_sysfb_damage_init);
+
+static void drm_sysfb_damage_bounds(struct drm_framebuffer *fb, unsigned int flags,
+				    const struct drm_clip_rect *clips, unsigned int num_clips,
+				    struct drm_rect *r)
+{
+	unsigned int inc = 1;
+
+	if (!clips || !num_clips) {
+		drm_rect_init(r, 0, 0, fb->width, fb->height);
+		return;
+	}
+	if (flags & DRM_MODE_FB_DIRTY_ANNOTATE_COPY) {
+		inc = 2;
+		num_clips /= 2;
+	}
+	drm_rect_init(r, clips->x1, clips->y1, clips->x2 - clips->x1, clips->y2 - clips->y1);
+	for (unsigned int i = 1; i < num_clips; i++) {
+		clips += inc;
+		r->x1 = min_t(int, r->x1, clips->x1);
+		r->y1 = min_t(int, r->y1, clips->y1);
+		r->x2 = max_t(int, r->x2, clips->x2);
+		r->y2 = max_t(int, r->y2, clips->y2);
+	}
+}
+
+static int drm_sysfb_fb_dirty(struct drm_framebuffer *fb, struct drm_file *file,
+			      unsigned int flags, unsigned int color,
+			      struct drm_clip_rect *clips, unsigned int num_clips)
+{
+	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(fb->dev);
+	struct drm_rect r;
+	bool queue = false;
+
+	drm_sysfb_damage_bounds(fb, flags, clips, num_clips, &r);
+
+	spin_lock(&sysfb->damage_lock);
+	/* Pending damage of another framebuffer is copied first. */
+	while (sysfb->damage_fb && sysfb->damage_fb != fb) {
+		spin_unlock(&sysfb->damage_lock);
+		flush_work(&sysfb->damage_work);
+		spin_lock(&sysfb->damage_lock);
+	}
+	if (!sysfb->damage_fb) {
+		drm_framebuffer_get(fb);
+		sysfb->damage_fb = fb;
+		sysfb->damage = r;
+		queue = true;
+	} else {
+		sysfb->damage.x1 = min(sysfb->damage.x1, r.x1);
+		sysfb->damage.y1 = min(sysfb->damage.y1, r.y1);
+		sysfb->damage.x2 = max(sysfb->damage.x2, r.x2);
+		sysfb->damage.y2 = max(sysfb->damage.y2, r.y2);
+	}
+	spin_unlock(&sysfb->damage_lock);
+
+	if (queue)
+		queue_work(system_dfl_wq, &sysfb->damage_work);
+	return 0;
+}
+
+static const struct drm_framebuffer_funcs drm_sysfb_fb_funcs = {
+	.destroy = drm_gem_fb_destroy,
+	.create_handle = drm_gem_fb_create_handle,
+	.dirty = drm_sysfb_fb_dirty,
+};
+
+/**
+ * drm_sysfb_fb_create - &drm_mode_config_funcs.fb_create for sysfb devices
+ * @dev: the device
+ * @file: the DRM file of the caller
+ * @info: the pixel format
+ * @mode_cmd: the framebuffer from userspace
+ *
+ * Like drm_gem_fb_create_with_dirty(), but the framebuffer's damage is copied
+ * outside the DIRTYFB ioctl (drm_sysfb_damage_init()).
+ *
+ * Returns: the framebuffer, or an ERR_PTR() on failure.
+ */
+struct drm_framebuffer *drm_sysfb_fb_create(struct drm_device *dev, struct drm_file *file,
+					    const struct drm_format_info *info,
+					    const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	return drm_gem_fb_create_with_funcs(dev, file, info, mode_cmd, &drm_sysfb_fb_funcs);
+}
+EXPORT_SYMBOL(drm_sysfb_fb_create);
diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
index 8b19f43..0ef093a 100644
--- a/drivers/gpu/drm/sysfb/efidrm.c
+++ b/drivers/gpu/drm/sysfb/efidrm.c
@@ -299,6 +299,9 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 	 */
 
 	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ERR_PTR(ret);
+	ret = drm_sysfb_damage_init(sysfb);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
index c412555..4d31bb6 100644
--- a/drivers/gpu/drm/sysfb/ofdrm.c
+++ b/drivers/gpu/drm/sysfb/ofdrm.c
@@ -1021,6 +1021,9 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
 	 */
 
 	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ERR_PTR(ret);
+	ret = drm_sysfb_damage_init(sysfb);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index deaeb7d..c40a6c5 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -813,6 +813,9 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	 */
 
 	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ERR_PTR(ret);
+	ret = drm_sysfb_damage_init(sysfb);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
index 1668aab..812db4a 100644
--- a/drivers/gpu/drm/sysfb/vesadrm.c
+++ b/drivers/gpu/drm/sysfb/vesadrm.c
@@ -539,6 +539,9 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 	 */
 
 	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ERR_PTR(ret);
+	ret = drm_sysfb_damage_init(sysfb);
 	if (ret)
 		return ERR_PTR(ret);
 

---
base-commit: 41b5458595c60143d0ebaa1e032c9cda5d764dff
change-id: 20261110-sysfb-dirtyfb-beda10fab602

Best regards,
--  
Joseph Telaak <joseph@telaak.dev>

