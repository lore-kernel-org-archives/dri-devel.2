Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF4A606A335
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PckfeJdF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C6210FDBD;
	Thu, 19 Nov 2026 12:56:01 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55D310FDBD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:55:55 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so1428501f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 04:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795092954; x=1795697754; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/TmqwLlzq9lcY3l8pvZouPD0/wGxR2mpOzAx8KQEQZw=;
 b=PckfeJdFWSYfax8fKJB35A9TKOtyGGeQO51iuGktenyZs0ZfGPev+rZ5IqDUDABGwI
 UKtb06+CvxtJ3t50yYEQXCG9augjeBVUuDowB5yHLgdgS5Zv3Kto6KbmTv5N9VidqlAZ
 t4M70/xrxVKK2XpL41p29rj+WcJxbnyBW2NUX8Quruzk04COrj2cQicTgPNzNz/6piYa
 F+ofJXoguoDwVUorz0IldEh00L1lBdpA9FM2g60g+9CJH00uqFE8vwV36V9kTrF4TbgD
 B+A87aj9x4HEDd10v0bw/ZF5z4t7YzZj715+Kp92FnARfZu57uz2QYXAaboqQnw2AWAc
 E2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795092954; x=1795697754;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/TmqwLlzq9lcY3l8pvZouPD0/wGxR2mpOzAx8KQEQZw=;
 b=Hro78ZYSbwuNS13VhIFEEhvp2bpnUFo3C5A+nKj5S77ueS0tcyFWRWSLJaG9zy0xIN
 M4dHgfHzGO7LwE8bMn0av23/97OZIW8YHkgF4vwOwtXaPaMQ8+Fo9L2rl2Az5BNgZOpk
 OhelhzG9Ra9WFyu5E9RmdZ96oPOSUo6bkZQz49MFTy0LjUGv2ohKKUyqLMxnlI9N1u6m
 2sHpGj1gM3joj5/5IPf++Roo+BlUflq0k3H+AQZ1pQCT5ylBcl0PrKhTzp7DNA1EhBpS
 Jl3yjnsHqGjimWugmTbcI8vDBUWaHEE6xuqF78R/+jAcJJjnX4+Xic9Lbt2TNv3OkS5o
 nrBQ==
X-Gm-Message-State: APuU4Z+ZaFmGUOgAp6XNGWVSFe6e2THzj+IUyA+/4cB995idJrafF6ku
 DbZVcDc7Ip1t7R7E4Sq6zAtTrgU0bnbNONxsH9PFwHF5N0tRoxWzZdVh
X-Gm-Gg: AZFdTZdhgtYS+R2R+nk78hmKRFENWx3EltYfZSHxRMLNhar0U90C2C8BaRgb8RxH1Xy
 USp+7uELccc2wDGflY61Gotz2Jf2iz/+IerdQqCL1sVDI79E+HzdCg2hjAZL3+8OKUn9jlmWfic
 gJB3BR1gAdEegR5vCWbxVV5FFX7FT+WuM1PavqjWJTb8Gd4xQXh4macFwXp3pXnblQAF4YrQxkM
 JDa2jMwNUsbFGxgBUWJQiO4m/e4rmWdSYUxTNFsQag5Cb1WHSjPv4TLc+Pj1ZEMxclyjzF70SMp
 +MgOoFEVKJRiG8eWjejuERp6z2Hy25zsQBrncsBGtE0D6+eUvaGkgVDDNlNiVPi5W5J0OO6wbA7
 Ek5OmPwPYj+TWSkVb8smboSOv36xB4/0V0FIsZLsMsEQG55lQdF6flePxZHaPE47IubenScP/Om
 M/O7mIDSu2tywbrI0/A5FugxWlMG60sQrudxCf1okm+7nBRBXXLGNV1km7beT8WJd9mdJeiCp61
 fWH3ntmzrqUTSFu6rAjm0qjULPYkcY2zt7zZZJZ6I3jpEC+B6elgFqJIEUzT/l3U8vRFun3oj2c
 v5Gk2LZHQenhEh9gPnf222L6h24Xs1z4aen1oXNGew==
X-Received: by 2002:adf:e191:0:b0:4a4:f86e:d90 with SMTP id
 ffacd0b85a97d-4a63beaa18dmr11375163f8f.52.1795092953786; 
 Thu, 19 Nov 2026 04:55:53 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2e26csm10198193f8f.4.2026.11.19.04.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 04:55:53 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Thu, 19 Nov 2026 13:55:26 +0100
Subject: [PATCH v2 1/2] drm/vkms: count the composer users
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-composer-v2-1-a935e9bae6be@gmail.com>
References: <20261119-composer-v2-0-a935e9bae6be@gmail.com>
In-Reply-To: <20261119-composer-v2-0-a935e9bae6be@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Liviu Dudau <liviu.dudau@arm.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The composer has one on/off switch, shared by the CRC reader and the
writeback jobs, so either of them can turn it off for the other. Replace
it with a count of users plus a per-user record of whether that user holds
a reference: a get() only raises the count for the user that asked, and a
put() can only lower it for the one that took it.

vkms_set_composer() becomes vkms_composer_get() and vkms_composer_put().

Fixes: dbd9d80c1b2e ("drm/vkms: Add support for writeback")
Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 Documentation/gpu/vkms.rst            |  5 -----
 drivers/gpu/drm/vkms/vkms_composer.c  | 39 ++++++++++++++++++++++++++++-------
 drivers/gpu/drm/vkms/vkms_crtc.c      |  2 +-
 drivers/gpu/drm/vkms/vkms_drv.h       | 31 ++++++++++++++++++++++++----
 drivers/gpu/drm/vkms/vkms_writeback.c |  6 +++---
 5 files changed, 62 insertions(+), 21 deletions(-)

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
index 0fc915a954ba..24b8436eaa74 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -711,19 +711,39 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *src_name,
 	return 0;
 }
 
-void vkms_set_composer(struct vkms_output *out, bool enabled)
+void vkms_composer_get(struct vkms_output *out, bool *held)
 {
-	bool old_enabled;
+	unsigned int users;
 
-	if (enabled)
-		drm_crtc_vblank_get(&out->crtc);
+	if (*held)
+		return;
+
+	if (drm_crtc_vblank_get(&out->crtc))
+		return;
+
+	spin_lock_irq(&out->lock);
+	*held = true;
+	users = out->composer_users++;
+	spin_unlock_irq(&out->lock);
+
+	/* All users share a single vblank reference. */
+	if (users)
+		drm_crtc_vblank_put(&out->crtc);
+}
+
+void vkms_composer_put(struct vkms_output *out, bool *held)
+{
+	unsigned int users;
+
+	if (!*held)
+		return;
 
 	spin_lock_irq(&out->lock);
-	old_enabled = out->composer_enabled;
-	out->composer_enabled = enabled;
+	*held = false;
+	users = --out->composer_users;
 	spin_unlock_irq(&out->lock);
 
-	if (old_enabled)
+	if (!users)
 		drm_crtc_vblank_put(&out->crtc);
 }
 
@@ -735,7 +755,10 @@ int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 	ret = vkms_crc_parse_source(src_name, &enabled);
 
-	vkms_set_composer(out, enabled);
+	if (enabled)
+		vkms_composer_get(out, &out->composer_crc_hold);
+	else
+		vkms_composer_put(out, &out->composer_crc_hold);
 
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
index dea6cad3f1b9..20c219a15604 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -89,6 +89,8 @@ struct vkms_writeback_job {
 	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
 	struct vkms_frame_info wb_frame_info;
 	pixel_write_t pixel_write;
+	/* Whether this job holds a reference to the composer. */
+	bool composer_wb_holds;
 };
 
 /**
@@ -210,8 +212,10 @@ struct vkms_crtc_state {
  *	       vblank timestamps
  * @composer_workq: Ordered workqueue for @composer_state.composer_work.
  * @lock: Lock used to protect concurrent access to the composer
- * @composer_enabled: Protected by @lock, true when the VKMS composer is active (crc needed or
- *		      writeback)
+ * @composer_users: Number of users that currently hold a composer reference; the composer
+ *		    is active only while it is non-zero. Updated under @lock and read with
+ *		    READ_ONCE() from the vblank timeout.
+ * @composer_crc_hold: Protected by @lock, true while the CRC source holds a composer reference
  * @composer_state: Protected by @lock, current state of this VKMS output
  * @composer_lock: Lock used internally to protect @composer_state members
  */
@@ -222,7 +226,8 @@ struct vkms_output {
 	struct workqueue_struct *composer_workq;
 	spinlock_t lock;
 
-	bool composer_enabled;
+	unsigned int composer_users;
+	bool composer_crc_hold;
 	struct vkms_crtc_state *composer_state;
 
 	spinlock_t composer_lock;
@@ -317,7 +322,25 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 
 /* Composer Support */
 void vkms_composer_worker(struct work_struct *work);
-void vkms_set_composer(struct vkms_output *out, bool enabled);
+
+/**
+ * vkms_composer_get() - Take a composer reference for one user
+ * @out: VKMS output
+ * @held: the user's own record of whether it holds a reference
+ *
+ * The composer stays active while at least one user holds a reference to it.
+ * @held is owned by a single user and lets a user hold at most one reference,
+ * so that it can only ever drop one it has taken.
+ */
+void vkms_composer_get(struct vkms_output *out, bool *held);
+
+/**
+ * vkms_composer_put() - Drop the composer reference recorded in @held
+ * @out: VKMS output
+ * @held: the user's own record of whether it holds a reference
+ */
+void vkms_composer_put(struct vkms_output *out, bool *held);
+
 void vkms_writeback_row(struct vkms_writeback_job *wb, const struct line_buffer *src_buffer, int y);
 
 /* Writeback */
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 858df1f89f66..dda90eaede3c 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -118,7 +118,7 @@ static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
 
 	drm_framebuffer_put(vkmsjob->wb_frame_info.fb);
 
-	vkms_set_composer(vkms_output, false);
+	vkms_composer_put(vkms_output, &vkmsjob->composer_wb_holds);
 	kfree(vkmsjob);
 }
 
@@ -141,11 +141,11 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	if (!conn_state)
 		return;
 
-	vkms_set_composer(output, true);
-
 	active_wb = conn_state->writeback_job->priv;
 	wb_frame_info = &active_wb->wb_frame_info;
 
+	vkms_composer_get(output, &active_wb->composer_wb_holds);
+
 	spin_lock_irq(&output->composer_lock);
 	crtc_state->active_writeback = active_wb;
 	crtc_state->wb_pending = true;

-- 
2.56.1

