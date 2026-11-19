Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5FB606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iccpJ0Vo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A731123FF;
	Thu, 19 Nov 2026 13:36:39 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198BF1123EC
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:36:34 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-490d59c3f0aso1044125f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 05:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095392; x=1795700192; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4LNJl1KvBRoHPGDthD6nMoONkH1GEfbZ05kasQLsnCI=;
 b=iccpJ0Vofk4ATCMwz8lnXZuuEZoe/80QDAOStRpLDF7tCUmB46DO/lKwHvUXlAnJOe
 x4R6xpQlXBPTEPzi+Fm6yYywo8McVqTT+jS6xqzWzx3keaQhm3Mdnqz0zeMgWWB+7qU6
 zFe3iIs+SDLFhLFu1G+7opSdZIj96/e63qDkZJ+1kX/K/9tGqARJvXtDvN34vhkPFdvZ
 53tBe8Q0GkCXCsZgf4MIsVPYb7Wr+B3nQOG4pYx0+ljjWyj14c/urPx7eFzbIu+X6vxy
 X0Aa/50iJa7QrVO+TIEoG8lZ2zbdzsei0hVisJsymn9rXq1JNZcqodrMcxYo1icUf0Qv
 bI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095392; x=1795700192;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4LNJl1KvBRoHPGDthD6nMoONkH1GEfbZ05kasQLsnCI=;
 b=TP+4foQYXezTo8e7XzrZ93HAw3xGfeHszX9lfwNB7nueozX1OhAPAXy/S6qAsnFYWu
 LG0DIcYEyQgI+MYNMnlDoQ9x3d5Gv8xcDXV4OYx7s1inHujyM91m/lRs274qbRzdECbp
 NZZzGLuwPY+05QSSy20UT7gUU5EQTQJKDV4Ap1nZsL5BwAhVGv49eBUcet2kkw/vGZw7
 aHpIxKQKX9i0N6BLP1SFzKxeP3PBMbIww8xlr7Jm5L+l/GlAre0a+OuAM3zJQ9F7Ohao
 /7OIlGg4GyVeuMYb8JTM9D7wqul5ZlmXvI1ZSA8UEkJ0VdB2/JHI9X5SJ1Hg3vu6ydWy
 F71w==
X-Gm-Message-State: APuU4Z/DbGHjCgxPSA+6B34LwF+ahA9xYvI3SkuGIsjDjcb4ZJTq67tp
 WG686ZMsP+vUDO0GT2ADxfMtuC1lYzgpEyD/FqeDpEYyPYizrQHsYN5ngmyJEU/o
X-Gm-Gg: AZFdTZd1Lduh+nyjpLKg8g74HTbAO9CdQ33e1l7wx7ijRMkUThfob5l+rOA60ZswW6Z
 YA4PIVNtrFX537UdfxbNaF+FhdchX2fejumsBU1HVsgyOYzPEg/zThQKhFXrLYdu/kNgX4a7oQD
 6TBEx92q2PmXHa0/N73NYCwx6at3sX6a7351bYCH0gXoa043mZTfh/qflfWo4F+pif5+hh61e6u
 UIAUkmLd8uUlsUkv8sktSDvUEmBFKEj8IKFob89j1kJeUD2Rh4i8x+U+7/R6r4Ox+pY//5pcBVl
 eeeYYgkBym8G4fUvli2B65RzHFHQhLbpZFBLbanjp8UpXua6NCbiIEH8DUAb9UFO9poX7ePxOsO
 uzyniEAzeJl4z6pKFUPY9isH6cqB76dW4Ag+ErMBfR5ZdN3Tnc71RqcgfYZNy7p7cvQ2Uonb/QG
 eoOtf4Tp5y4UZrM7E9va2U4rdAy84ZWldu+gWrLPxpkYTsrZS86fy5IWM0Sf/41OViM1Mj1KRTQ
 +l2h211PJ9HcDS32Rj9zBBou3XXGcW1TaCag3N3fJvqu5/NyEJf/lpgAp+OZtBaGSfYL/od98Ft
 PH8vJRDd9h5bvoEPCUm1XkeIwRSnPaU56zMtcR4hwA==
X-Received: by 2002:a5d:5d81:0:b0:48d:fd4d:7fbe with SMTP id
 ffacd0b85a97d-4a6346da919mr13526484f8f.2.1795095392379; 
 Thu, 19 Nov 2026 05:36:32 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6573ba95csm11547911f8f.56.2026.11.19.05.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 05:36:31 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Thu, 19 Nov 2026 14:36:03 +0100
Subject: [PATCH v3 1/2] drm/vkms: count the composer users
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-composer-v3-1-dd470a820303@gmail.com>
References: <20261119-composer-v3-0-dd470a820303@gmail.com>
In-Reply-To: <20261119-composer-v3-0-dd470a820303@gmail.com>
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
writeback jobs, so either of them can turn it off for the other.  Replace
the switch with a count of users:

  - the CRC source takes and drops one reference per open()/release(),
    which the core always pairs;
  - a writeback job keeps the value returned by vkms_composer_get() and
    only drops a reference it actually took, because a job can be cleaned
    up after a commit that never reached the composer.

vkms_set_composer() becomes vkms_composer_get() and vkms_composer_put().

Fixes: dbd9d80c1b2e ("drm/vkms: Add support for writeback")
Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 Documentation/gpu/vkms.rst            |  5 -----
 drivers/gpu/drm/vkms/vkms_composer.c  | 33 +++++++++++++++++++++++++--------
 drivers/gpu/drm/vkms/vkms_crtc.c      |  2 +-
 drivers/gpu/drm/vkms/vkms_drv.h       | 29 +++++++++++++++++++++++++----
 drivers/gpu/drm/vkms/vkms_writeback.c |  7 ++++---
 5 files changed, 55 insertions(+), 21 deletions(-)

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
index 0fc915a954ba..96c40eeeb61b 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -711,19 +711,33 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *src_name,
 	return 0;
 }
 
-void vkms_set_composer(struct vkms_output *out, bool enabled)
+bool vkms_composer_get(struct vkms_output *out)
 {
-	bool old_enabled;
+	unsigned int users;
 
-	if (enabled)
-		drm_crtc_vblank_get(&out->crtc);
+	if (drm_crtc_vblank_get(&out->crtc))
+		return false;
+
+	spin_lock_irq(&out->lock);
+	users = out->composer_users++;
+	spin_unlock_irq(&out->lock);
+
+	/* All users share a single vblank reference. */
+	if (users)
+		drm_crtc_vblank_put(&out->crtc);
+
+	return true;
+}
+
+void vkms_composer_put(struct vkms_output *out)
+{
+	unsigned int users;
 
 	spin_lock_irq(&out->lock);
-	old_enabled = out->composer_enabled;
-	out->composer_enabled = enabled;
+	users = --out->composer_users;
 	spin_unlock_irq(&out->lock);
 
-	if (old_enabled)
+	if (!users)
 		drm_crtc_vblank_put(&out->crtc);
 }
 
@@ -735,7 +749,10 @@ int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 	ret = vkms_crc_parse_source(src_name, &enabled);
 
-	vkms_set_composer(out, enabled);
+	if (enabled)
+		vkms_composer_get(out);
+	else
+		vkms_composer_put(out);
 
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
index dea6cad3f1b9..f245b64f8726 100644
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
@@ -210,8 +212,9 @@ struct vkms_crtc_state {
  *	       vblank timestamps
  * @composer_workq: Ordered workqueue for @composer_state.composer_work.
  * @lock: Lock used to protect concurrent access to the composer
- * @composer_enabled: Protected by @lock, true when the VKMS composer is active (crc needed or
- *		      writeback)
+ * @composer_users: Number of users that currently hold a composer reference; the composer
+ *		    is active only while it is non-zero. Updated under @lock and read with
+ *		    READ_ONCE() from the vblank timeout.
  * @composer_state: Protected by @lock, current state of this VKMS output
  * @composer_lock: Lock used internally to protect @composer_state members
  */
@@ -222,7 +225,7 @@ struct vkms_output {
 	struct workqueue_struct *composer_workq;
 	spinlock_t lock;
 
-	bool composer_enabled;
+	unsigned int composer_users;
 	struct vkms_crtc_state *composer_state;
 
 	spinlock_t composer_lock;
@@ -317,7 +320,25 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 
 /* Composer Support */
 void vkms_composer_worker(struct work_struct *work);
-void vkms_set_composer(struct vkms_output *out, bool enabled);
+
+/**
+ * vkms_composer_get() - Take a composer reference
+ * @out: VKMS output
+ *
+ * The composer stays active while at least one reference is held.  Users
+ * whose get() and put() calls are not guaranteed to pair have to keep the
+ * return value and only call vkms_composer_put() for a reference they took.
+ *
+ * Returns: false if no reference was taken.
+ */
+bool vkms_composer_get(struct vkms_output *out);
+
+/**
+ * vkms_composer_put() - Drop a composer reference
+ * @out: VKMS output
+ */
+void vkms_composer_put(struct vkms_output *out);
+
 void vkms_writeback_row(struct vkms_writeback_job *wb, const struct line_buffer *src_buffer, int y);
 
 /* Writeback */
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 858df1f89f66..8ebeb8ceeaaf 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -118,7 +118,8 @@ static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
 
 	drm_framebuffer_put(vkmsjob->wb_frame_info.fb);
 
-	vkms_set_composer(vkms_output, false);
+	if (vkmsjob->composer_wb_holds)
+		vkms_composer_put(vkms_output);
 	kfree(vkmsjob);
 }
 
@@ -141,11 +142,11 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	if (!conn_state)
 		return;
 
-	vkms_set_composer(output, true);
-
 	active_wb = conn_state->writeback_job->priv;
 	wb_frame_info = &active_wb->wb_frame_info;
 
+	active_wb->composer_wb_holds = vkms_composer_get(output);
+
 	spin_lock_irq(&output->composer_lock);
 	crtc_state->active_writeback = active_wb;
 	crtc_state->wb_pending = true;

-- 
2.56.1

