Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676060A2628
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GKUXh7P0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D4810E0BA;
	Wed, 11 Nov 2026 14:32:44 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C4A10E0BA
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:32:37 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so28319435e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794407556; x=1795012356; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u2q57S1P8aLiRzndP7EZ4yhSSjdu/KIimRft1ZX+f7s=;
 b=GKUXh7P0EG0sHP3aXjFlbiMq8OPjab4QbDY7rAji3FKqRCYCtqWtio5ZM5B8sADVH5
 ALAN2dzIGzKP+jHloD/mN/YhkSQ+04fLlQjmhe7+mHogNcOfN00C67k5Gv8eXeYZ+/K0
 oB9AlDZa0GDicKaXxbsByDj4R0hBVoj0GG7l6aqn2+lmTuVDLVfG0wWMxcZPt1quGmaO
 U2y5ha4QrJnChHoR2gLgqXNZym612VfKjeDYbT/GM52zxtG1wz54ER8KYJugWrCHbbkt
 blXfeKBnNnw8+CeeNdMDwmjAzNp0RmH2ZpXsuSu5sopyx3l2RMvyO4ZcpkI4mhiQyXR+
 6Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794407556; x=1795012356;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=u2q57S1P8aLiRzndP7EZ4yhSSjdu/KIimRft1ZX+f7s=;
 b=sxH/RJKGY3cXKupS4PPlqEi8yezjYbzjvecvZFcGz6w/kWSI+HSuewdXnu/SvjpacD
 lpg8DDEuR6m1sgQ+X2//K3RyEg7WtCVGrvs+OvNSNtHRNsMMKU+n9fZo+01aUy2ifuXw
 ecCmrBVPZ64iiXsekfrAeabBQa38h2GxBPaa9jmNFZ78jTc7YwdalbKN5RjWWimMImL/
 gB7Q0o+CksURNzlYQytGcp/qV8ed2Spjh4Xjn4J6SyyRtuRXX2HJmbS1eeQEsftQGQeA
 VVpaNsbbX783s3kQ7QAyh+vua1oq2jzQEjoymoJ6f7sdufC/Ew244HO7Kgb/akEWrxId
 SZaQ==
X-Gm-Message-State: APuU4Z8EWVdXUHDiZJSeT5WpDQqDXcPoYR7VjmABHcOb4wYl1p3eFUI8
 R3MzdibCpM2PFRxs3UYswFGj66P87NRPLs0QKhus648MBklzT7vGPomW
X-Gm-Gg: AYBFou2QGqCKBGo9brB1NUQ16E4ODuUZNh5oAhyHcgstn5XnqVs/DLUJif6wiRDawl3
 NykN9qOlypT+ApE1rGNDVTlWxXpwLW9gW3bay0yQxlKvisW/a0xb4mciyHAjvX6tyBER2v5+qyb
 OXlo+XmGukTivSRQ2Cr/69secsJ4PB9C3d9NZ3Dzbp62gBKuTjJU/zZIO2L35pD+I34Dq3ucd3X
 Pxs2ZPix/Vo+wEWvy+Se8Va2LsvioxTE7QQPD/uVFZGqM1+HvAuOy9UgPkvwOGKxoi7f89J/Ysm
 dhtasWd2sekEjAPW01OYnnLGUXejDtU+2KO/OAoRIlvMpIn7pdwZyBgN5PPm1272/YH/R6mly9E
 LK7UA1Q6GFkEfmNlDae68TpT4+/xpN7m1iqqb4dZ/0/u+RsWXV24MdZPyVWFACZICk6RWAs6kj4
 d79m2KlUN9JGHL3UzsL3PdbW9QbJexCvfGiYtc2rtLILXshBOrSEtW2eYkQU1IHVdQiwbUc7uYp
 9RT4PxUHKk6gSFNf5GAeeKNSjkkNdaOcBkOQrM4lyAaK+F76OJjHa0ZWrRVauQxtYpIpTNpg8ll
 SpakuSyQuAulFA9zNawTfaw1ihrqcEWDl5hWJGBkFWu5lLUeuLB/RnMGH4r0Emo=
X-Received: by 2002:a05:600c:1d1d:b0:4ab:cc03:7f60 with SMTP id
 5b1f17b1804b1-4ba09365d6fmr46922765e9.18.1794407555956; 
 Wed, 11 Nov 2026 06:32:35 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08e423dfsm62256485e9.1.2026.11.11.06.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:32:35 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Wed, 11 Nov 2026 14:32:24 +0000
Subject: [PATCH] drm/vkms: use a bitmask instead of a bool for composer users
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-composer-v1-1-9d5fa94656f8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QpAQBBFf0XzbGt3axW/Ig+MwShWu0hp/93gv
 p2659wQKTBFqLIbAp0c2a8CJs8Ap3YdSXEvDFbbwsgU+mXzIinEsrDaGddhD3LfAg18fam6+Tk
 e3Uy4vz6k9ABvGo/TbAAAAA==
X-Change-ID: 20261111-composer-cc9620515bcd
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Liviu Dudau <liviu.dudau@arm.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Oarora Etimis <oaroraetimis@gmail.com>
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The composer has a single on/off switch, shared by the CRC reader and the
writeback job, and no record of who needs it. Either of them turns it off
for both:

  - with CRC being captured, cleaning up a writeback job stops the CRC
    entries;
  - with a writeback job pending, closing the CRC source leaves the frame
    uncomposed and its out-fence never signalled.

Replace the switch with a bitmask holding one bit per user, so a user only
clears its own bit and the composer stays active while any bit is set. The
vblank reference follows the bitmask: taken when it becomes non-zero and
dropped when it becomes zero again. vkms_set_composer() becomes
vkms_composer_get() and vkms_composer_put().

Fixes: dbd9d80c1b2e ("drm/vkms: Add support for writeback")

Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
- Why not use a refcount? Because there are only a few users, and a bit
  per user shows the working state of each one. A repeated put() from the
  same user does nothing, and it also helps future work that makes the
  vblank timeout synchronous.

- Tested with vng: read crc/data and submitted three writeback jobs with a
  small libdrm helper. The entries kept coming at the full rate of the
  1024x768@60 mode, 235 to 237 of them over the 3.97 s the three jobs
  took, where the current code stops at five.
---
 Documentation/gpu/vkms.rst            |  5 -----
 drivers/gpu/drm/vkms/vkms_composer.c  | 34 ++++++++++++++++++++++++++--------
 drivers/gpu/drm/vkms/vkms_crtc.c      |  2 +-
 drivers/gpu/drm/vkms/vkms_drv.h       | 27 +++++++++++++++++++++++----
 drivers/gpu/drm/vkms/vkms_writeback.c |  4 ++--
 5 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 1e79e62a6bc4..fe7dc8def44a 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -246,11 +246,6 @@ module through configfs. Use/Test-cases:
 Writeback support
 -----------------
 
-- The writeback and CRC capture operations share the use of composer_enabled
-  boolean to ensure vblanks. Probably, when these operations work together,
-  composer_enabled needs to refcounting the composer state to proper work.
-  [Good to get started]
-
 - Add support for cloned writeback outputs and related test cases using a
   cloned output in the IGT kms_writeback.
 
diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 0fc915a954ba..59f1dd50b5bd 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -711,19 +711,34 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *src_name,
 	return 0;
 }
 
-void vkms_set_composer(struct vkms_output *out, bool enabled)
+void vkms_composer_get(struct vkms_output *out, u8 user)
 {
-	bool old_enabled;
+	bool was_enabled;
 
-	if (enabled)
-		drm_crtc_vblank_get(&out->crtc);
+	if (drm_crtc_vblank_get(&out->crtc))
+		return;
+
+	spin_lock_irq(&out->lock);
+	was_enabled = out->composer_users;
+	out->composer_users |= user;
+	spin_unlock_irq(&out->lock);
+
+	/* Another user already holds the reference for the composer. */
+	if (was_enabled)
+		drm_crtc_vblank_put(&out->crtc);
+}
+
+void vkms_composer_put(struct vkms_output *out, u8 user)
+{
+	bool was_set, enabled;
 
 	spin_lock_irq(&out->lock);
-	old_enabled = out->composer_enabled;
-	out->composer_enabled = enabled;
+	was_set = out->composer_users & user;
+	out->composer_users &= ~user;
+	enabled = out->composer_users;
 	spin_unlock_irq(&out->lock);
 
-	if (old_enabled)
+	if (was_set && !enabled)
 		drm_crtc_vblank_put(&out->crtc);
 }
 
@@ -735,7 +750,10 @@ int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 	ret = vkms_crc_parse_source(src_name, &enabled);
 
-	vkms_set_composer(out, enabled);
+	if (enabled)
+		vkms_composer_get(out, VKMS_COMPOSER_CRC);
+	else
+		vkms_composer_put(out, VKMS_COMPOSER_CRC);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index fe17f49305a9..4e15abfd92a0 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -29,7 +29,7 @@ static bool vkms_crtc_handle_vblank_timeout(struct drm_crtc *crtc)
 	state = output->composer_state;
 	spin_unlock(&output->lock);
 
-	if (state && output->composer_enabled) {
+	if (state && READ_ONCE(output->composer_users)) {
 		u64 frame = drm_crtc_accurate_vblank_count(crtc);
 
 		/* update frame_start only if a queued vkms_composer_worker()
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index dea6cad3f1b9..c3bb3cd46863 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -27,6 +27,9 @@
 
 #define VKMS_LUT_SIZE 256
 
+#define VKMS_COMPOSER_CRC  (1U << 0)
+#define VKMS_COMPOSER_WB   (1U << 1)
+
 /**
  * struct vkms_frame_info - Structure to store the state of a frame
  *
@@ -210,8 +213,9 @@ struct vkms_crtc_state {
  *	       vblank timestamps
  * @composer_workq: Ordered workqueue for @composer_state.composer_work.
  * @lock: Lock used to protect concurrent access to the composer
- * @composer_enabled: Protected by @lock, true when the VKMS composer is active (crc needed or
- *		      writeback)
+ * @composer_users: Bitmask of the users that need the VKMS composer; the composer is only
+ *		    active when it is non-zero. Updated under @lock, and read with
+ *		    READ_ONCE() from the vblank timeout.
  * @composer_state: Protected by @lock, current state of this VKMS output
  * @composer_lock: Lock used internally to protect @composer_state members
  */
@@ -222,7 +226,7 @@ struct vkms_output {
 	struct workqueue_struct *composer_workq;
 	spinlock_t lock;
 
-	bool composer_enabled;
+	u8 composer_users;
 	struct vkms_crtc_state *composer_state;
 
 	spinlock_t composer_lock;
@@ -317,7 +321,22 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 
 /* Composer Support */
 void vkms_composer_worker(struct work_struct *work);
-void vkms_set_composer(struct vkms_output *out, bool enabled);
+
+/**
+ * vkms_composer_get() - Enable the composer for a user
+ * @out: VKMS output
+ * @user: bit of the user that needs the composer (VKMS_COMPOSER_CRC or
+ *	  VKMS_COMPOSER_WB)
+ */
+void vkms_composer_get(struct vkms_output *out, u8 user);
+
+/**
+ * vkms_composer_put() - Disable the composer for a user
+ * @out: VKMS output
+ * @user: bit of the user that no longer needs the composer
+ */
+void vkms_composer_put(struct vkms_output *out, u8 user);
+
 void vkms_writeback_row(struct vkms_writeback_job *wb, const struct line_buffer *src_buffer, int y);
 
 /* Writeback */
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 858df1f89f66..7e2f82e44b39 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -118,7 +118,7 @@ static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
 
 	drm_framebuffer_put(vkmsjob->wb_frame_info.fb);
 
-	vkms_set_composer(vkms_output, false);
+	vkms_composer_put(vkms_output, VKMS_COMPOSER_WB);
 	kfree(vkmsjob);
 }
 
@@ -141,7 +141,7 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	if (!conn_state)
 		return;
 
-	vkms_set_composer(output, true);
+	vkms_composer_get(output, VKMS_COMPOSER_WB);
 
 	active_wb = conn_state->writeback_job->priv;
 	wb_frame_info = &active_wb->wb_frame_info;

---
base-commit: 1116f4aee916ca13d3e40ce87e67835f51576fcb
change-id: 20261111-composer-cc9620515bcd

Best regards,
--  
Oarora Etimis <oaroraetimis@gmail.com>

