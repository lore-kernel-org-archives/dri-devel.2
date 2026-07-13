Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09795C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A4DB10E94D;
	Mon, 13 Jul 2026 12:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U57QQULB";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7847910E94D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:09:25 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so533617a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944565; x=1784549365; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Pn+IHk1Sk762XTDH7lvSm6CZZGNFHunM58OnD0jYLk=;
 b=U57QQULBYCgcTrkOj6vnJd3ShQVteXbtf+i+kUhAVO+SCezBrktlOncOL55u8x3YbC
 sSLK2731193kmY9ZQp3w5izwsZQRvFv5wZOBtz6slJ1PI9ED+heN8pVANeimhb1j7+ol
 wR8H4h6suR1opO5m2p2/hIDMm9IGirtkN6L2zdNEOklf7sd1rrx3zkYJDoHMGqY09YbU
 u4RUv7rOrXxllxJ0i2nzin36wNT80ZRiwuM1zFKsGmjeZLp3phbjIMuleZkaBTdCQC7H
 g6wUcqv/KVga4TOp2jeXENfdLgp2lIr1EQoPl44i5lvjJnTVs4a+MjYMnHISy34UOugH
 iwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944565; x=1784549365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1Pn+IHk1Sk762XTDH7lvSm6CZZGNFHunM58OnD0jYLk=;
 b=UvoMhGbWY3YI78UQ5ZtdH/xHLr4hgycX1Tj+xUKU7JXv3z9AkqsQQJpn+RdCxtpham
 DTCUGzkoQmn2smZyKePJLcSov3wcOzNUVgFJR7H7jaqI25OvwFlRTsnl74bQYR9aNfRP
 1rrP3svssRy95wgdo6tWbnGWuyYXIl3w0mN0GjhTV4Cu70A/v+8VbIWuJ1zRm5KdUxFv
 nSlGwRfkSk18ISQDpIkvGlD07sOAdY1o4DS3IVcihgORXBA7D9utUsS2beDtRfvrC6yR
 10ZHc1oZoZvyiSCyIWT62OkRVR6ZlBXQtmeGtn+xDVC9o2nStVeIE1cqhObuoiFyBohN
 y1Dg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQRyLFCQSc2L6IfDK/0sNZF1mCKnnG1BumojEN9CyFcVnP4oLjGZZLhedkqx2eb8Q401G3nt+5TIE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0WtvtHp/+9xA/5Ag/2bm3+/n4sAns2lgwovP6vg1qHMm95XsP
 KKLWwobz9i3vY0slk5znXzcZrLHNRycQNnG6qkpqmGZ9UR+UFpn4Uewg
X-Gm-Gg: AfdE7cn1dEtMfq34hXy6A40ahcw6a43oOJzBvqbS22Bh6x5IsECYaF7x04gou7ortXe
 m35DhZXVNLpyLzVGBw+VTPh66Hps2ndcGc5lveEcIKRrBk7UPD4+j8OTUzzJ+QVl3LkJPAj0E+1
 6TRXSYauXQcGb+hR+jGuPatCizGYaPvaZDy/d4M078BDNWNyc69UQ3p02EubVhiBrX4kmB2oWjy
 IjPUhXq/kMO+7KdCEc+m7ZVU69zbc6eRyfC3ggzN3vB/RA3BD8uU7Sk1u6HqNsj2O8lA9UjeS7M
 zdTZQwtTnLJgzbrGoYxLc//3MpK7t0iwHrgto5kI4X31DYCSAm8ZKDVYAH4jvzAzLZ/2elSbEPL
 s68/KwvFvfcUuku6s6KT7Q9oJLTdWN72RWV6okoPB8TXO683FPuQUhqwlJ8brdp+DwgIIeiLr+/
 aKiHb4kJP66I33lGbniXuS
X-Received: by 2002:a17:90b:2884:b0:387:e0db:bc22 with SMTP id
 98e67ed59e1d1-38dc77b3846mr9100073a91.34.1783944564932; 
 Mon, 13 Jul 2026 05:09:24 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:09:24 -0700 (PDT)
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
Subject: [PATCH v7 03/19] media: meson: vdec: Fix lifecycle leaks and race
 conditions in recycle_thread
Date: Mon, 13 Jul 2026 17:36:58 +0530
Message-ID: <20260713120840.17427-4-linux.amoon@gmail.com>
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

Validate the return status of kthread_run() during decoder recycling
thread initialization to prevent memory leaks, and enforce robust state
checking before invoking kthread_stop() to prevent kernel panics.

If the system operates under severe memory constraints, the previous
implementation silently accepted error pointers returned by a failed
kthread_run() operation. Attempting to pass these invalid error pointers
downstream to kthread_stop() during streaming stop or application
teardown routines triggered instant kernel panics.

Furthermore, when thread initialization failed, the lack of an explicit
unwinding path leaked the session's private context (sess->priv) and its
associated firmware memory block allocations. Because sess->status was
never transitioned to STATUS_INIT, any subsequent call to stop streaming
or close the driver file node failed its state validation checks,
permanently orphaning active platform DMA assets and codec parameters.

Fix these thread lifetime and memory leak bugs via the following:

1. In vdec_start_streaming(), add an explicit IS_ERR() verification
   barrier immediately following the recycling kthread launch. If thread
   creation fails, capture the error code via PTR_ERR(), clear the
   dangling pointer tracking entry to NULL, and jump to a newly added
   'err_poweroff' label to unwind hardware settings and clear out
   allocated structural components cleanly.

2. In vdec_stop_streaming(), protect the teardown execution track by
   wrapping the kthread_stop() invocation inside a safe !IS_ERR_OR_NULL()
   conditional block to ensure the target thread structure actually exists
   in system memory before stopping it.

3. In vdec_close(), cleanly wind down and terminate any lingering
   recycling threads at the absolute entry boundary of the routine
   before flushing data framework contexts and releasing the file
   descriptor matrices to user space.

Together, these changes ensure predictable driver behavior, prevent
kernel panics during low-memory conditions, and guarantee that memory
and DMA assets are fully reclaimed during teardown.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel.org/
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 48 +++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index d1f35fc893de1..7fc73d5cdebbf 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -32,6 +32,10 @@ struct dummy_buf {
 /* 16 MiB for parsed bitstream swap exchange */
 #define SIZE_VIFIFO SZ_16M
 
+static void vdec_free_canvas(struct amvdec_session *sess);
+static void vdec_reset_timestamps(struct amvdec_session *sess);
+static void vdec_reset_bufs_recycle(struct amvdec_session *sess);
+
 static u32 get_output_size(u32 width, u32 height)
 {
 	return ALIGN(width * height, SZ_64K);
@@ -353,13 +357,23 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 	sess->sequence_cap = 0;
 	sess->sequence_out = 0;
 
-	if (vdec_codec_needs_recycle(sess))
+	if (vdec_codec_needs_recycle(sess) && !sess->recycle_thread) {
 		sess->recycle_thread = kthread_run(vdec_recycle_thread, sess,
 						   "vdec_recycle");
-
+		if (IS_ERR(sess->recycle_thread)) {
+			ret = PTR_ERR(sess->recycle_thread);
+			sess->recycle_thread = NULL;
+			goto err_poweroff;
+		}
+	}
 	schedule_work(&sess->esparser_queue_work);
 	return 0;
 
+err_poweroff:
+	vdec_poweroff(sess);
+	vdec_free_canvas(sess);
+	vdec_reset_timestamps(sess);
+	vdec_reset_bufs_recycle(sess);
 err_free_vififo:
 	if (sess->vififo_vaddr) {
 		dma_free_coherent(sess->core->dev, sess->vififo_size,
@@ -464,7 +478,10 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 	if (full_cleanup) {
 		if ((q->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE ||
 		     !sess->streamon_out) && vdec_codec_needs_recycle(sess)) {
-			kthread_stop(sess->recycle_thread);
+			if (!IS_ERR_OR_NULL(sess->recycle_thread)) {
+				kthread_stop(sess->recycle_thread);
+				sess->recycle_thread = NULL;
+			}
 		}
 
 		vdec_poweroff(sess);
@@ -970,6 +987,31 @@ static int vdec_open(struct file *file)
 static int vdec_close(struct file *file)
 {
 	struct amvdec_session *sess = file_to_amvdec_session(file);
+	struct amvdec_core *core = sess->core;
+
+	if (!IS_ERR_OR_NULL(sess->recycle_thread)) {
+		kthread_stop(sess->recycle_thread);
+		sess->recycle_thread = NULL;
+	}
+
+	mutex_lock(&core->lock);
+
+	vdec_poweroff(sess);
+	vdec_free_canvas(sess);
+	core->cur_sess = NULL;
+
+	if (sess->vififo_vaddr) {
+		dma_free_coherent(core->dev, sess->vififo_size,
+				  sess->vififo_vaddr, sess->vififo_paddr);
+		sess->vififo_vaddr = NULL;
+		sess->vififo_paddr = 0;
+	}
+	vdec_reset_timestamps(sess);
+	vdec_reset_bufs_recycle(sess);
+	kfree(sess->priv);
+	sess->priv = NULL;
+
+	mutex_unlock(&core->lock);
 
 	v4l2_m2m_ctx_release(sess->m2m_ctx);
 	v4l2_fh_del(&sess->fh, file);
-- 
2.50.1

