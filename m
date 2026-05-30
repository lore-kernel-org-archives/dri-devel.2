Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E35CD6E5F
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F0C112B58;
	Sun, 31 May 2026 13:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N9PEeK0q";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE13112742
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 09:44:23 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2bcd3ac3307so84887425ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780134263; x=1780739063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YD6axKKp8wDht90VyqGQ3zjwLyfLDF+g7zoFDStjFGA=;
 b=N9PEeK0qzW5+7/5/LkpM+VIy0Y+oeDaAIHxuGh9aEhHQPO9g9dr1uleQSgLmLrZ1uP
 lY+hyXYyzuV//Ox9TqvSyOKnxxKK4LSeHEhwJ2w4XgRnesJLuIz4b5h9oL4DUk2ZMyE3
 cE/0rRaXBCsT76Pw71sxFh8AEBirzgwLbjw/slPXlP29NcS86U1WREYr/e8ykWbVLVXr
 QOMxW+QBwGP1N6wTsXmdd/EeMAyq/p9ELbFCphAA8NPC4URGpvGfyJU6e1efp/eFsGUW
 9RI+2Ma/6/s8jcsrMERHL2fXKtFn5FDT+LDOUJXX8ZfBf8YmyyJVqnwSZDpGbwnk7wLD
 h5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780134263; x=1780739063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YD6axKKp8wDht90VyqGQ3zjwLyfLDF+g7zoFDStjFGA=;
 b=Yqo3d1Tygugom6pbBpYbbsoYFAcK80yfGbo2/SG2lGHhfKIJrI4syLL9TiPC7eYC6I
 5jW42agHhsoPb5gfIGbTAd8sZhDQPYPebsNuPXNyNrebTYXhpnqt8pROD/Fj0IVjWWoE
 JXP55esrw10YHBSvilm7T7IcRSYICsPPvE6a+dJYvZq+2NbIb6w7eOVC5w/lNXJYqQd3
 tjvYSoSIo/Bep0Loyd7FkyRJMG2QRLfMbSHo3tk0EmxoR+lY/r7l9awM7NJsUwi5io19
 g3y8bcqgdiILoJtb4Kmo5GL7hfW+6cgZ2hR6AeGVnLMZ3zIC2pEkn4VX9m9V3IiJxB+4
 FTRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ//5kBwu4i2A8sAXw8DBiUun1jNe/NXoSq78dQyX/GowprU3rO0DzFjVgibr4YuKICdYSNEHhaEtTw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1b0sh7Ogd4k1VNrfIvLEG8jBVAaNbT88ku3BFkLexovMWw7Rv
 R8bdMqUN2jFtRi1K8HFdaN4qcQL9BduCRPDieC4bbB/FsE81bAVZzLk9
X-Gm-Gg: Acq92OEF/IG3kwu+BZYRtxrutO8Wr7ma+pU8OFBoOEveWirDc0uubbGFNUCrj84E93u
 Cf7tVTXa2Ct6VWxB4QoSZFRQHOnCjOEuwvJVWTkzg6RTZ9xyz4raTRKAhtiGkwmV2cgyw2d/6Gj
 JJ3WnfcVeRUbMKJYHglftHAx9jmjK52KQk03zZCz2VZXZYtO9SyI/zy72OSfJkARKV2f8MSmz7M
 oozjUrTaNtef4+yrXq9sXW1NOUsDw+Guk2GXhMEWB9SY+nh37GVq0gg4tBjMYmFL4wsw1XgXMUH
 8/9M1tR/8jJHbWcwNz7DOr3CholSM5RZxrM1FRj02CH8R4RmqPEDIf8KdMR4xI8tHgCUewcWxYf
 zBwcqoQFz516qz12/yeh3to8cTmQkNky/G3VcrKWZIOI7df36D9iTxJYAmMX2CM9RGqS3FZp4BH
 tJ4UCw98rGFQ94WaIfy+zCowl8eBTintg=
X-Received: by 2002:a17:903:2305:b0:2ba:7881:948d with SMTP id
 d9443c01a7336-2bf367b214fmr38817185ad.1.1780134262731; 
 Sat, 30 May 2026 02:44:22 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e700csm61529945ad.10.2026.05.30.02.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 02:44:22 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil@kernel.org>, Maxime Jourdan <mjourdan@baylibre.com>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-amlogic@lists.infradead.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC
 support), linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC
 SOCS), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Cc: Anand Moon <linux.amoon@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v6 2/8] media: meson: vdec: Fix concurrent STREAMON /
 STREAMOFF race conditions
Date: Sat, 30 May 2026 15:12:48 +0530
Message-ID: <20260530094326.11892-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260530094326.11892-1-linux.amoon@gmail.com>
References: <20260530094326.11892-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:31 +0000
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

The Meson VDEC driver’s start/stop streaming paths previously
updated core->cur_sess and sess->status without synchronization,
leaving a race window between concurrent STREAMON/STREAMOFF calls.

Following change introduces proper locking discipline:

- Hold core->lock when checking or updating core->cur_sess and
  sess->status in vdec_start_streaming().
- Snapshot sess->status under the lock in vdec_stop_streaming()
  to safely evaluate hardware state after releasing the mutex.
- Ensure error unwind paths clear core->cur_sess and reset
  sess->status inside the lock.

This prevents TOCTOU races, avoids data corruption when multiple
sessions contend for the hardware, and ensures consistent session
lifecycle management.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260525104345.C8D501F00A3C@smtp.kernel.org/
Fixes: 3e7f51bd9607 ("media: meson: add v4l2 m2m video decoder driver")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 62 ++++++++++++++++++-------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 4ffebba2341d..7233000e2232 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -286,11 +286,6 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 	struct vb2_v4l2_buffer *buf;
 	int ret;
 
-	if (core->cur_sess && core->cur_sess != sess) {
-		ret = -EBUSY;
-		goto bufs_done;
-	}
-
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		sess->streamon_out = 1;
 	else
@@ -308,9 +303,29 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 	}
 
 	if (sess->status == STATUS_RUNNING ||
-	    sess->status == STATUS_NEEDS_RESUME ||
-	    sess->status == STATUS_INIT)
+	    sess->status == STATUS_NEEDS_RESUME)
+		return 0;
+
+	/*
+	 * Secure the core hardware lock before checking availability
+	 * and updating session states to prevent STREAMON race conditions.
+	 */
+	mutex_lock(&core->lock);
+	if (core->cur_sess && core->cur_sess != sess) {
+		mutex_unlock(&core->lock);
+		ret = -EBUSY;
+		goto bufs_done;
+	}
+
+	/* If already half-initialized, do not re-initialize */
+	if (sess->status == STATUS_INIT) {
+		mutex_unlock(&core->lock);
 		return 0;
+	}
+
+	sess->status = STATUS_INIT;
+	core->cur_sess = sess;
+	mutex_unlock(&core->lock);
 
 	sess->vififo_size = SIZE_VIFIFO;
 	sess->vififo_vaddr =
@@ -341,8 +356,6 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 		sess->recycle_thread = kthread_run(vdec_recycle_thread, sess,
 						   "vdec_recycle");
 
-	sess->status = STATUS_INIT;
-	core->cur_sess = sess;
 	schedule_work(&sess->esparser_queue_work);
 	return 0;
 
@@ -350,6 +363,12 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 	dma_free_coherent(sess->core->dev, sess->vififo_size,
 			  sess->vififo_vaddr, sess->vififo_paddr);
 bufs_done:
+	mutex_lock(&core->lock);
+	if (core->cur_sess == sess)
+		core->cur_sess = NULL;
+	sess->status = STATUS_STOPPED;
+	mutex_unlock(&core->lock);
+
 	while ((buf = v4l2_m2m_src_buf_remove(sess->m2m_ctx)))
 		v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
 	while ((buf = v4l2_m2m_dst_buf_remove(sess->m2m_ctx)))
@@ -399,10 +418,23 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 	struct amvdec_codec_ops *codec_ops = sess->fmt_out->codec_ops;
 	struct amvdec_core *core = sess->core;
 	struct vb2_v4l2_buffer *buf;
+	enum amvdec_status old_status;
 
-	if (sess->status == STATUS_RUNNING ||
-	    sess->status == STATUS_INIT ||
-	    (sess->status == STATUS_NEEDS_RESUME &&
+	/*
+	 * Safely snapshot the status and clear the hardware owner inside
+	 * the mutex to prevent data races with concurrent STREAMON requests.
+	 */
+	mutex_lock(&core->lock);
+	old_status = sess->status;
+	if (core->cur_sess == sess)
+		core->cur_sess = NULL;
+	sess->status = STATUS_STOPPED;
+	mutex_unlock(&core->lock);
+
+	/* Evaluate the hardware state using our snapshot */
+	if (old_status == STATUS_RUNNING ||
+	    old_status == STATUS_INIT ||
+	    (old_status == STATUS_NEEDS_RESUME &&
 	     (!sess->streamon_out || !sess->streamon_cap))) {
 		if (vdec_codec_needs_recycle(sess))
 			kthread_stop(sess->recycle_thread);
@@ -415,8 +447,6 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 		vdec_reset_bufs_recycle(sess);
 		kfree(sess->priv);
 		sess->priv = NULL;
-		core->cur_sess = NULL;
-		sess->status = STATUS_STOPPED;
 	}
 
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
@@ -425,8 +455,8 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 
 		sess->streamon_out = 0;
 	} else {
-		/* Drain remaining refs if was still running */
-		if (sess->status >= STATUS_RUNNING && codec_ops->drain)
+		/* Drain remaining refs if was still running using the snapshot */
+		if (old_status >= STATUS_RUNNING && codec_ops->drain)
 			codec_ops->drain(sess);
 
 		while ((buf = v4l2_m2m_dst_buf_remove(sess->m2m_ctx)))
-- 
2.50.1

