Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD26606A324
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WoCOdoQq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA5410EC87;
	Mon, 26 Oct 2026 08:37:25 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F0D310E097
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 19:47:43 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-70bf1671c21so248489eaf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792957662; x=1793562462; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fvXda2ntZpOoAr8wvRdn1LTGflX+1i5bW8ufU/JyDzc=;
 b=WoCOdoQqfuDULz7C/6kTR9uy/ZnXAnuCBI56zZe69RA3Us9CCW1/hhA4BokmQ17/Hx
 4OXkaWqOGGPxfxYbSh1ZmZdzXq8+AWcCx/I7txu0tDJNBdcapIYXLBpDtuyhYMIOOwW+
 bIyoiKRYojhWL4kx91hHgUSvse9tlFP92Z7GdC0GZMLw6fEcsBV57LDh/trjrWpCq8zB
 dSB1WxqrPUGHnyQRt2s2XGzWKN1zG8mJ3acLnmNlqcqVS2iy8LhVDNelYjEDz5uedyt1
 YzrLJ6If9vDQ6Re9mgub9sfvPIwDihQ6/zE7Xw2SuPiFpNIWSVX3kII10LyOfg/YAUn1
 fv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792957662; x=1793562462;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fvXda2ntZpOoAr8wvRdn1LTGflX+1i5bW8ufU/JyDzc=;
 b=GTXqs3MCpTQiQZsBL5BnKKzVcV63q1sAHAa1rGvxPRMCbrj7vnJ7n6IEijbxaDBCVv
 XU6yUnrZVOhNA6TNfUqyaNpDtsTq++M2bYGBoI0reuwE19k4/5Mfc6L0vnVDkcW3Yv/x
 ZDHEOVgAG1AuNebiEkIZk7Jl66a4wilZ2AOxRhkalM5jVorM/tmskZens7ymUcE6WcGn
 W618mAxIjAP92M73ii4PvVxgtGRPyGRYMrnpstCfqs2uSytOX6TUQlELAdwHQc9lg9jX
 GRAXKVMe96EX8RA6QS2ias2VsenG9W5x9z5Mo23xb6+h6c9Rs8fyc3TP4Oe1Jveesr0O
 FZew==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbXzu0K+aoUQSvZVUAkbX9uEG4l76eGGUSLwf2CVphNV9DFU59HSkKxZIWy/Y22vPTlTh8fiesUWc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLfTH7gjbHZz7jopULi9g5P6Kg+Z8e/y/z0RQ3cR6FxhA0HZWl1
 QE+YxdsAFhBa9Zn5DRhmyXvrJXSkluv1EqcU0fjGTq2vAK/dvxuAKj0+
X-Gm-Gg: AYBFou2L9VjFwkbu3O32whyPMWunGlYNLipKutNZbpsV6DDoB2gulrceAJSQ2IoviXX
 iCJ9xzKvgQFppMS4n4VveFg5djr7KGgYePQzIqlJYezIbk1FAej6pIoVrxi52vWfzgXU2kCphbk
 mmaZIEb+vpBmWNNqGeWj2OZgC8w1x0DLE1pmKe4d6P4zAtxLSIDIb+K/oc+2hj8hOr7m//tR2E/
 tqJDkk9os42fXtJMEiAz27CeFaTZuEIVzMABJIkBvHHys0TIPAU/34r4/LkqtusPXKVEyt+JFWn
 uQZDOBX5vL4i8aEINILxHxPSVI3EzbImNjLCTqxX4PBi5HSdE6biUEwXj212n/A0ArQc0R2vgEL
 WfT/HqZzfQ4JoSd2aNPbqXRkKKE+EmOH7f0EqVhC0RWsa2ml5JpCj7Gny7/blUlT63pCzTURaBG
 1dIVxOJposIytIZgfB3MjwqOnyAGQqlBFZV1eZ5Emnh0lI+OzE4s6qxL3Aj7H3RvsCUW2kalRrQ
 WMGInU4EaFfn3RhXBbQo+2iIFgX7g5GKheEVj+kjFGDjCRH15SU1T3Ba4Qi6DoJ0VX4ZKHVH/uX
 GF9NWFBb66a0J5QQvjB51riItSucQSk4N5jS
X-Received: by 2002:a05:6820:a294:20b0:6c9:80d8:a1ea with SMTP id
 006d021491bc7-70ba0e10437mr1759922eaf.39.1792957662485; 
 Sun, 25 Oct 2026 12:47:42 -0700 (PDT)
Received: from localhost.localdomain ([72.12.197.23])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm2991167fac.5.2026.10.25.12.47.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Oct 2026 12:47:41 -0700 (PDT)
From: atipre <tipreaditya@gmail.com>
To: louis.chauvet@bootlin.com
Cc: tipreaditya@gmail.com, dri-devel@lists.freedesktop.org,
 hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: Keep composition enabled for concurrent users
Date: Sun, 25 Oct 2026 15:47:27 -0400
Message-ID: <20261025194727.89093-1-tipreaditya@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CRC capture and writeback share composer_enabled. Cleaning up a writeback
clears this flag even when CRC capture is still active. The composer then
stops producing CRC samples while the CRC data file remains open. Cleanup
of a prepared but uncommitted writeback can also disable composition for
another user.

Replace the shared boolean with a user count protected by the output lock.
Hold one vblank reference for the combined lifetime of all composer users,
refunding redundant references when concurrent first users race. Track
whether each writeback job acquired a composer reference so its cleanup
only releases a reference it owns. Propagate CRC acquisition errors and
signal a failed writeback's own fence before cleaning up the unqueued job.
Read the user count under the output lock in the vblank callback and remove
the resolved documentation TODO.

A local IGT kms_writeback@writeback-preserves-crc regression times out
reading CRCs on the unmodified kernel and passes with this change on ARM64
QEMU with one and two CPUs. All four existing applicable writeback subtests
also pass; two unsupported XRGB2101010 subtests skip on both kernels.

Fixes: dbd9d80c1b2e ("drm/vkms: Add support for writeback")
Signed-off-by: atipre <tipreaditya@gmail.com>
---
IGT regression:
https://gist.github.com/atipre/36a712615c0300d5e09e11a3b5b83f29

Apply the linked patch to igt-gpu-tools, rebuild, then run:
  sudo IGT_FORCE_DRIVER=vkms ./build/tests/kms_writeback \
    --run-subtest writeback-preserves-crc

 Documentation/gpu/vkms.rst            |  5 ---
 drivers/gpu/drm/vkms/vkms_composer.c  | 47 ++++++++++++++++++++++-----
 drivers/gpu/drm/vkms/vkms_crtc.c      |  5 +--
 drivers/gpu/drm/vkms/vkms_drv.h       |  9 ++---
 drivers/gpu/drm/vkms/vkms_writeback.c | 21 ++++++++++--
 5 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 1e79e62a6..fe7dc8def 100644
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
index 0fc915a95..5860e86e6 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -711,19 +711,44 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *src_name,
 	return 0;
 }
 
-void vkms_set_composer(struct vkms_output *out, bool enabled)
+int vkms_composer_get(struct vkms_output *out)
 {
-	bool old_enabled;
+	bool already_enabled;
+	int ret;
 
-	if (enabled)
-		drm_crtc_vblank_get(&out->crtc);
+	spin_lock_irq(&out->lock);
+	if (out->composer_users) {
+		out->composer_users++;
+		spin_unlock_irq(&out->lock);
+		return 0;
+	}
+	spin_unlock_irq(&out->lock);
+
+	ret = drm_crtc_vblank_get(&out->crtc);
+	if (ret)
+		return ret;
 
 	spin_lock_irq(&out->lock);
-	old_enabled = out->composer_enabled;
-	out->composer_enabled = enabled;
+	already_enabled = out->composer_users != 0;
+	out->composer_users++;
 	spin_unlock_irq(&out->lock);
 
-	if (old_enabled)
+	/* Another user may have enabled composition while we got vblank. */
+	if (already_enabled)
+		drm_crtc_vblank_put(&out->crtc);
+
+	return 0;
+}
+
+void vkms_composer_put(struct vkms_output *out)
+{
+	bool last_user;
+
+	spin_lock_irq(&out->lock);
+	last_user = --out->composer_users == 0;
+	spin_unlock_irq(&out->lock);
+
+	if (last_user)
 		drm_crtc_vblank_put(&out->crtc);
 }
 
@@ -734,8 +759,12 @@ int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 	int ret = 0;
 
 	ret = vkms_crc_parse_source(src_name, &enabled);
+	if (ret)
+		return ret;
 
-	vkms_set_composer(out, enabled);
+	if (enabled)
+		return vkms_composer_get(out);
 
-	return ret;
+	vkms_composer_put(out);
+	return 0;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index fe17f4930..69ec6b14a 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -17,7 +17,7 @@ static bool vkms_crtc_handle_vblank_timeout(struct drm_crtc *crtc)
 {
 	struct vkms_output *output = drm_crtc_to_vkms_output(crtc);
 	struct vkms_crtc_state *state;
-	bool ret, fence_cookie;
+	bool ret, fence_cookie, composer_enabled;
 
 	fence_cookie = dma_fence_begin_signalling();
 
@@ -27,9 +27,10 @@ static bool vkms_crtc_handle_vblank_timeout(struct drm_crtc *crtc)
 		DRM_ERROR("vkms failure on handling vblank");
 
 	state = output->composer_state;
+	composer_enabled = output->composer_users != 0;
 	spin_unlock(&output->lock);
 
-	if (state && output->composer_enabled) {
+	if (state && composer_enabled) {
 		u64 frame = drm_crtc_accurate_vblank_count(crtc);
 
 		/* update frame_start only if a queued vkms_composer_worker()
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 381483aa4..4919d8036 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -89,6 +89,7 @@ struct vkms_writeback_job {
 	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
 	struct vkms_frame_info wb_frame_info;
 	pixel_write_t pixel_write;
+	bool composer_ref;
 };
 
 /**
@@ -210,8 +211,7 @@ struct vkms_crtc_state {
  *	       vblank timestamps
  * @composer_workq: Ordered workqueue for @composer_state.composer_work.
  * @lock: Lock used to protect concurrent access to the composer
- * @composer_enabled: Protected by @lock, true when the VKMS composer is active (crc needed or
- *		      writeback)
+ * @composer_users: Protected by @lock, number of CRC capture and writeback users
  * @composer_state: Protected by @lock, current state of this VKMS output
  * @composer_lock: Lock used internally to protect @composer_state members
  */
@@ -222,7 +222,7 @@ struct vkms_output {
 	struct workqueue_struct *composer_workq;
 	spinlock_t lock;
 
-	bool composer_enabled;
+	unsigned int composer_users;
 	struct vkms_crtc_state *composer_state;
 
 	spinlock_t composer_lock;
@@ -317,7 +317,8 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 
 /* Composer Support */
 void vkms_composer_worker(struct work_struct *work);
-void vkms_set_composer(struct vkms_output *out, bool enabled);
+int vkms_composer_get(struct vkms_output *out);
+void vkms_composer_put(struct vkms_output *out);
 void vkms_writeback_row(struct vkms_writeback_job *wb, const struct line_buffer *src_buffer, int y);
 
 /* Writeback */
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index ecf29a2c0..584a71862 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <linux/dma-fence.h>
 #include <linux/iosys-map.h>
 
 #include <drm/drm_atomic.h>
@@ -118,7 +119,9 @@ static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
 
 	drm_framebuffer_put(vkmsjob->wb_frame_info.fb);
 
-	vkms_set_composer(vkms_output, false);
+	/* Prepared jobs can be cleaned up without ever being committed. */
+	if (vkmsjob->composer_ref)
+		vkms_composer_put(vkms_output);
 	kfree(vkmsjob);
 }
 
@@ -137,13 +140,25 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	struct vkms_writeback_job *active_wb;
 	struct vkms_frame_info *wb_frame_info;
 	u32 wb_format = fb->format->format;
+	int ret;
 
 	if (!conn_state)
 		return;
 
-	vkms_set_composer(output, true);
-
 	active_wb = conn_state->writeback_job->priv;
+	ret = vkms_composer_get(output);
+	if (ret) {
+		struct drm_writeback_job *job = conn_state->writeback_job;
+
+		conn_state->writeback_job = NULL;
+		if (job->out_fence) {
+			dma_fence_set_error(job->out_fence, ret);
+			dma_fence_signal(job->out_fence);
+		}
+		drm_writeback_cleanup_job(job);
+		return;
+	}
+	active_wb->composer_ref = true;
 	wb_frame_info = &active_wb->wb_frame_info;
 
 	spin_lock_irq(&output->composer_lock);

base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
-- 
2.50.1 (Apple Git-155)

