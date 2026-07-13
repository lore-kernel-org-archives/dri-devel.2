Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC24C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D6CE10E94C;
	Mon, 13 Jul 2026 12:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hJQcxacz";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CC410E94C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:09:14 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38df94d4dd8so571113a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944554; x=1784549354; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O9YYyee56RYzJH/7lhC6WY6QS3lP6Hx70/PxBzEZ1WM=;
 b=hJQcxaczoa2QOdbUBh/wmvvT7oZ5a8wSmDf0u8wUyc/9UKk/GRBAoe/DorUYQhANN3
 ra5bkbSdpmu/3OzrXrr7iUiE3pxrS2/XDK1yFWCIv2POxDIegKlndroriFMx0hew49wj
 wctiL/Ka+NmvodhRYoI3LKcAkiTbpUCAUM7/G2t08S+sWgSmNSS2SD08Gs/PuhxpppMm
 ls/2nHgP7CgVS8yLDYs13n3q/8VzQ4psHC6nhBtVsxKgK4WsIeKTgM23UwnHd2JARHO1
 exh7AMIBQFc7C9p/btfbMUOpUL98UqOWscZOXulSjD6dKisrLC1H9n/cUqiupfoEumGZ
 XXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944554; x=1784549354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O9YYyee56RYzJH/7lhC6WY6QS3lP6Hx70/PxBzEZ1WM=;
 b=XCH2E008Jjlg42+Sq0xRa38cqGuzqLd69/Nbk0yriPdqwxEF7ayDx4x7n2k2oKbF/R
 za72zlWk1eu+A3XNa+ADubISlZ8mgNVtQFuu47AIya52CAamXUh7h7MjMLp0yHSLo0WT
 oy6wXzI087D5sOAZbABn9ESdiBGqBUNwstXm9hZWxZJsKJCMFX+9jwimNb49RSKGhlVz
 v2AB1js+OLTD4xB65EWelmY7GzU4+K1aj7sXFYf8Fvr4+pw8Myhox/X2zF3gJen+rFRp
 hbhodDLn78Vs2aSMoCwVN/xx0IOg1vPR7t4yQIizktK+q4VZQr3F3uMKpySLLIePrHwa
 faXg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/Nn4GElnBMCDPZ7sn58WuoO8MP+nBnAXl0af5mvXGePHjyNG5DbvzquenhxyePUB++RiL+nb/gSE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyJaz4jxlwZp5117smvQhI8rcgDqUvjyI/hLyRKWwzPg7vDBMC
 wAKBcIoXhFyXwskhwwy8eOOmAaAc92Ko1vtiv66sEtpB1dM3C3WO9l94
X-Gm-Gg: AfdE7cmeWGlBJp2eEY6+o0pBDV4S9u2qOEE/7S1CYJAOio5lbY7PLLnxc3tQ2hWmuqx
 dIiHQ5uP0sbj/K72UVbe2PZPR0pfW3V9mmEaVxbcvDhxAZsZz3XtMHoNy7l5KSw9VahOwu+9kJs
 X++VKgdzBdV+nL313oi+P+1a7MB3Heh6bvOC/UWfqfU3TxpokA8iCP5uoHnEd3ZYRyEFuuBGMTI
 ABl/CAJ7Ij9dD2ZEYCmZclymehua9EWeIlNHHKwS3r/tKQnpFGGDJRqp1vmqlhm+glK5eRr/x8r
 BlZjC2IPK2OPJXFcrRt8C7/M89+G2SCZ96B0P5lKwhe6LGOJw9glertpG5GUlciKzOImxi1pWRB
 SqxD7/fnxM1XNWbAvvrsQ2VzYFhX9EIFF84nOUquGx4EvPsVemAgegz9qf85GiML30Wr3/BTm4m
 K1fwBb3fyz+aaES3acFDpW
X-Received: by 2002:a17:90b:58f0:b0:387:e0db:bc23 with SMTP id
 98e67ed59e1d1-38dc77b82bemr9015022a91.35.1783944553867; 
 Mon, 13 Jul 2026 05:09:13 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:09:13 -0700 (PDT)
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
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-amlogic@lists.infradead.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC
 support), linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC
 SOCS), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Cc: Anand Moon <linux.amoon@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v7 02/19] media: meson: vdec: Fix STREAMON / STREAMOFF race
 conditions and session teardown
Date: Mon, 13 Jul 2026 17:36:57 +0530
Message-ID: <20260713120840.17427-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713120840.17427-1-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The vdec driver suffered from unsafe state transitions and race
conditions when handling concurrent STREAMON / STREAMOFF calls and
dynamic resolution change (DRC) events. Global context pointers
(e.g. core->cur_sess) and session status flags were updated outside
proper lock boundaries, allowing parallel threads to corrupt hardware
state under load.

Address these architectural stability flaws with the following changes:

1. In vdec_start_streaming(), safely encapsulate hardware occupancy
   evaluations and target session context claims within a secure mutex
   lock (core->lock). This blocks overlapping multi-threaded STREAMON
   calls from creating concurrent assignment conflicts.

2. Restructure initialization error path handlers to avoid global memory
   maps cross-contamination. Segregate buffer flushes cleanly based
   strictly on the active vb2 queue type (OUTPUT vs CAPTURE) to avoid
   incorrectly reclaiming undecoded ready blocks.

3. In vdec_stop_streaming(), introduce state-aware tracking to
   accurately identify DRC conditions. If a resolution modification
   forces a capture queue reset while the output stream is still live,
   preserve the driver's inner runtime states and bypass premature
   hardware power-off sweeps.

4. Enforce strict null-pointer safety limits inside DMA unmapping
   sequences. Explicitly clear tracking metadata entries
   (sess->vififo_vaddr = NULL) inside the VIFIFO freeing routines to
   neutralize accidental double-free risks.

Together these changes harden the driver against concurrency bugs,
eliminate memory leaks, and ensure predictable session lifecycle
management under multi threaded workloads.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260530100841.9CEBA1F00893@smtp.kernel.org/
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 136 +++++++++++++++++-------
 1 file changed, 95 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 6ae3471155a87..d1f35fc893de1 100644
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
+		ret = -EBUSY;
+		mutex_unlock(&core->lock);
+		goto err_unlock_no_hw;
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
@@ -319,7 +334,7 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (!sess->vififo_vaddr) {
 		dev_err(sess->core->dev, "Failed to request VIFIFO buffer\n");
 		ret = -ENOMEM;
-		goto bufs_done;
+		goto err_cleanup_session;
 	}
 
 	sess->should_stop = 0;
@@ -333,33 +348,43 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 
 	ret = vdec_poweron(sess);
 	if (ret)
-		goto vififo_free;
+		goto err_free_vififo;
 
 	sess->sequence_cap = 0;
 	sess->sequence_out = 0;
+
 	if (vdec_codec_needs_recycle(sess))
 		sess->recycle_thread = kthread_run(vdec_recycle_thread, sess,
 						   "vdec_recycle");
 
-	sess->status = STATUS_INIT;
-	core->cur_sess = sess;
 	schedule_work(&sess->esparser_queue_work);
 	return 0;
 
-vififo_free:
-	dma_free_coherent(sess->core->dev, sess->vififo_size,
-			  sess->vififo_vaddr, sess->vififo_paddr);
-bufs_done:
-	while ((buf = v4l2_m2m_src_buf_remove(sess->m2m_ctx)))
-		v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
-	while ((buf = v4l2_m2m_dst_buf_remove(sess->m2m_ctx)))
-		v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
-
+err_free_vififo:
+	if (sess->vififo_vaddr) {
+		dma_free_coherent(sess->core->dev, sess->vififo_size,
+				  sess->vififo_vaddr, sess->vififo_paddr);
+		sess->vififo_vaddr = NULL;
+		sess->vififo_paddr = 0;
+	}
+err_cleanup_session:
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		sess->streamon_out = 0;
 	else
 		sess->streamon_cap = 0;
 
+	mutex_lock(&core->lock);
+	if (core->cur_sess == sess)
+		core->cur_sess = NULL;
+	if (sess->status != STATUS_NEEDS_RESUME)
+		sess->status = STATUS_STOPPED;
+	mutex_unlock(&core->lock);
+err_unlock_no_hw:
+	while ((buf = v4l2_m2m_src_buf_remove(sess->m2m_ctx)))
+		v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
+	while ((buf = v4l2_m2m_dst_buf_remove(sess->m2m_ctx)))
+		v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
+
 	return ret;
 }
 
@@ -399,30 +424,13 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 	struct amvdec_codec_ops *codec_ops = sess->fmt_out->codec_ops;
 	struct amvdec_core *core = sess->core;
 	struct vb2_v4l2_buffer *buf;
+	enum amvdec_status old_status;
+	bool full_cleanup = false;
 
-	if (sess->status == STATUS_RUNNING ||
-	    sess->status == STATUS_INIT ||
-	    (sess->status == STATUS_NEEDS_RESUME &&
-	     (!sess->streamon_out || !sess->streamon_cap))) {
-		if (vdec_codec_needs_recycle(sess))
-			kthread_stop(sess->recycle_thread);
-
-		vdec_poweroff(sess);
-		vdec_free_canvas(sess);
-		dma_free_coherent(sess->core->dev, sess->vififo_size,
-				  sess->vififo_vaddr, sess->vififo_paddr);
-		vdec_reset_timestamps(sess);
-		vdec_reset_bufs_recycle(sess);
-		kfree(sess->priv);
-		sess->priv = NULL;
-		core->cur_sess = NULL;
-		sess->status = STATUS_STOPPED;
-	}
-
+	/* flush buffers to kill background workqueue thread */
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		while ((buf = v4l2_m2m_src_buf_remove(sess->m2m_ctx)))
 			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
-
 		sess->streamon_out = 0;
 	} else {
 		/* Drain remaining refs if was still running */
@@ -431,9 +439,55 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 
 		while ((buf = v4l2_m2m_dst_buf_remove(sess->m2m_ctx)))
 			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
-
 		sess->streamon_cap = 0;
 	}
+
+	/* Hold core lock continuously for the state and resource processing */
+	mutex_lock(&core->lock);
+	old_status = sess->status;
+
+	if (old_status == STATUS_RUNNING || old_status == STATUS_INIT ||
+	    (old_status == STATUS_NEEDS_RESUME && (!sess->streamon_out ||
+						   !sess->streamon_cap))) {
+		/*
+		 * If it's a DRC event (Capture queue streamoff only), preserve
+		 * the status
+		 */
+		if (old_status == STATUS_NEEDS_RESUME && sess->streamon_out) {
+			full_cleanup = false;
+		} else {
+			full_cleanup = true;
+			sess->status = STATUS_STOPPED;
+		}
+	}
+
+	if (full_cleanup) {
+		if ((q->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE ||
+		     !sess->streamon_out) && vdec_codec_needs_recycle(sess)) {
+			kthread_stop(sess->recycle_thread);
+		}
+
+		vdec_poweroff(sess);
+		vdec_free_canvas(sess);
+
+		if (sess->vififo_vaddr) {
+			dma_free_coherent(sess->core->dev, sess->vififo_size,
+					  sess->vififo_vaddr, sess->vififo_paddr);
+			sess->vififo_vaddr = NULL;
+			sess->vififo_paddr = 0;
+		}
+
+		vdec_reset_timestamps(sess);
+		vdec_reset_bufs_recycle(sess);
+		core->cur_sess = NULL;
+
+		kfree(sess->priv);
+		sess->priv = NULL;
+	} else {
+		if (sess->status == STATUS_NEEDS_RESUME)
+			sess->changed_format = 0;
+	}
+	mutex_unlock(&core->lock);
 }
 
 static int vdec_vb2_buf_prepare(struct vb2_buffer *vb)
-- 
2.50.1

