Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0A0C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E3010E953;
	Mon, 13 Jul 2026 12:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hvM0zl47";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D0C310E953
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:10:08 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c89636920a3so1583924a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944608; x=1784549408; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cz2FSgCZR0hsmFPhKS7OSCHd3SyOY5Jhxrt1826LFDI=;
 b=hvM0zl47wRfPjJBy8HChtTDgysfMKarF2cEBjlAgM9sQ1HBsq82llTrYrdP4J8fMYN
 Ogp2jrupNw0pcOkQlDdma7xfcvQ8OcjjsMXHEVCRUlfgZwr1bgGJVbQMsr7NjF8IV1UH
 JYP7TDcHJ8WUfHtZSoPzJoYc/gcFAg7JImpx6g6gc+4pGbrIohO+MNIZTfcSmozdWWGa
 gDUuh5Q1MVfX+1ZxlWWams5kT8D7m5Qc/kr+UtpFu8K84IBzoMdJrDDyqjtqk/XE5swa
 5/KFlUovH2wOpqxgEt5Znkymk1tmYQlwIomqDblNlbQ9CZuN+mXYbVLi0vnrimJMwtWi
 Acwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944608; x=1784549408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cz2FSgCZR0hsmFPhKS7OSCHd3SyOY5Jhxrt1826LFDI=;
 b=O3ZWygWOTekzDrLTlP8tKx4TRDsDb29Y4xot9NTFnCnF0Tbc3nu/sqks2lcIIbgZN3
 Da71Bxa07CXfiZGwOxq0CrCoEG5f2mq4A//3xqfSSfnxd/o3DcJqmdlHLSGAjPtafL0Z
 tVLqGjjzi0Y+yfUVDnKcVOcXK+zJx+1c5PyisDBHryrWVWeat42fv26fl8yXdgiEZfvN
 KNmAgEaFNof2UbYXKE0rba9aZU1kbb/9tn3uHTOTfZIxgUneWzP6pui300DpC+QRJV/1
 DRowb1A+lnyA1J9zQ3S+/NJGD4th5MTqZQc+TDMV/f4FucxubqNjchLWTxWU8yshLuQn
 vnSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfyfxRLnVjmy9xSamNvoh8y/C3fwpi4q3Om3lAuJADY8aXjV0tw5k3fY0H3ZYCVTV9B9UuE7dQSrI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPJNjMV9h4zc+4hFoZcitgHPyc8O12dxp30cRXqhFghIU55vcv
 k02NUUwEEddz4xZB8WWQYtbUJgkm3l2aK+O3F9L9TScYBdRPjCm1a3C7
X-Gm-Gg: AfdE7ckuqHnN24CeOdhdhtt6CUMfumGLWGvq7hHab8vXAqSOklVfsyLsycB6kkwol2L
 fLbtoilXZFMzORrcV0lOGnTcTALbaPQOXfZTubVbiYNbYIytGcBzMP9gv41saaj+EQZxKX4jVo5
 LtuIIdcLqLNPS/hRKUbaQ5LVoG78COecajHq/A7OIo2oilFkaUTVBDRgqFlQoyKdQc97aFkosZq
 pfh0qZE2dyUrkWcE/jpVH/OR61HmK2bKk7Anfx6GTsHmTQQ5VDHarcBKRsErZap+CBph6A1CuwT
 NckxnowPE7OUSqvoMo/cYVYyGj7BzwMMTIHynLODX2LyXge2nZsl8GbW1r8BHPr9GaR75n7hrjF
 cYyHYvCA3rmWdeILGtQ3X5OcQBOQiTSo0vzOFtYFhBNQv535skNIGeAWqkaM06FDXFPUX+J4U4i
 6kwKx857TepA==
X-Received: by 2002:a05:6a21:140a:b0:3c0:9c19:b27d with SMTP id
 adf61e73a8af0-3c110cfefa5mr9580843637.75.1783944607855; 
 Mon, 13 Jul 2026 05:10:07 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:10:07 -0700 (PDT)
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
 Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: [PATCH v7 07/19] media: meson: vdec: Refactor esparser work queue and
 fix teardown race
Date: Mon, 13 Jul 2026 17:37:02 +0530
Message-ID: <20260713120840.17427-8-linux.amoon@gmail.com>
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

Rework the esparser work queue logic to prevent concurrent queue mutations
and fix a race condition during streaming teardown.

The previous implementation relied on v4l2_m2m_for_each_src_buf_safe(),
which held the session mutex across the entire queue traversal. This
blocked concurrent operations, caused inaccurate buffer mapping, and
triggered 100+ second watchdog freezes due to an unyielding polling loop.
Additionally, the low-level parser handled buffer ownership adjustments
and completion callbacks directly, leading to inconsistent error paths and
races between streamon and streamoff.

Fix this by utilizing the modern scoped_guard(mutex) mechanism inside the
main worker loop. This allows the session lock to be automatically
dropped on any conditional breakout path, preventing voluntary scheduling
bugs while invoking cond_resched(). De-couple buffer lifecycles from the
hardware parser routine by leveraging safe, linear fetches via
v4l2_m2m_next_src_buf() and v4l2_m2m_src_buf_remove(), ensuring orderly
frame transactions. Refactor esparser_queue() to return explicit error
codes (such as -EBADMSG, -EIO, and -EAGAIN) to safely handle buffer states.

Clean up teardown paths: Execute cancel_work_sync() inside
vdec_stop_streaming() and vdec_close() immediately after
synchronize_irq(). This ensures any pending scheduled queue work is fully
flushed and canceled before the driver destroys hardware instances.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/esparser.c | 69 +++++++++++++++------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index 37749ede308c6..e5d3d817b9b2b 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -328,15 +328,11 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 		return -EAGAIN;
 	}
 
-	v4l2_m2m_src_buf_remove_by_buf(sess->m2m_ctx, vbuf);
-
 	offset = esparser_get_offset(sess);
 
 	ret = amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
-	if (ret) {
-		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+	if (ret)
 		return ret;
-	}
 
 	dev_dbg(core->dev, "esparser: ts = %llu pld_size = %u offset = %08X flags = %08X\n",
 		vb->timestamp, payload_size, offset, vbuf->flags);
@@ -348,12 +344,10 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 	if (sess->fmt_out->pixfmt == V4L2_PIX_FMT_VP9) {
 		payload_size = vp9_update_header(core, vb);
 
-		/* If unable to alter buffer to add headers */
 		if (payload_size == 0) {
+			dev_err(core->dev, "esparser: VP9 header update failed\n");
 			amvdec_remove_ts(sess, vb->timestamp);
-			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
-
-			return 0;
+			return -EBADMSG;
 		}
 	}
 
@@ -363,33 +357,68 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 	if (ret <= 0) {
 		dev_warn(core->dev, "esparser: input parsing error\n");
 		amvdec_remove_ts(sess, vb->timestamp);
-		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
 		amvdec_write_parser(core, PARSER_FETCH_CMD, 0);
-
-		return 0;
+		return -EIO;
 	}
 
 	atomic_inc(&sess->esparser_queued_bufs);
-	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
 
 	return 0;
 }
 
 void esparser_queue_all_src(struct work_struct *work)
 {
-	struct v4l2_m2m_buffer *buf, *n;
 	struct amvdec_session *sess =
 		container_of(work, struct amvdec_session, esparser_queue_work);
+	struct device *dev = sess->core->dev_dec;
+	int ret;
 
-	mutex_lock(&sess->lock);
-	v4l2_m2m_for_each_src_buf_safe(sess->m2m_ctx, buf, n) {
-		if (sess->should_stop)
-			break;
+	while (1) {
+		struct vb2_v4l2_buffer *vbuf = NULL;
+		bool processed_frame = false;
+
+		scoped_guard(mutex, &sess->lock) {
+			/* Safe atomic tracking check: exit loop if session is shutting down */
+			if (sess->should_stop)
+				return;
+
+			/* Queue completely empty: exit work loop cleanly */
+			vbuf = v4l2_m2m_next_src_buf(sess->m2m_ctx);
+			if (!vbuf)
+				break;
+
+			/* Stop processing if we hit the end-of-stream drain buffer */
+			if (vbuf->flags & V4L2_BUF_FLAG_LAST)
+				break;
+
+			/* Check hardware FIFO limits safely inside the locks */
+			ret = esparser_queue(sess, vbuf);
+			if (ret == -EAGAIN)
+				break;
+
+			/* Pop the buffer from the source queue since it is now processed */
+			vbuf = v4l2_m2m_src_buf_remove(sess->m2m_ctx);
+			if (!vbuf) {
+				dev_dbg(dev, "Buffer missing during queue removal\n");
+				break;
+			}
+
+			/* Complete the buffer transaction based on parser results */
+			if (ret < 0)
+				v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+			else
+				v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
 
-		if (esparser_queue(sess, &buf->vb) < 0)
+			/* Set tracking flag indicating transaction completion */
+			processed_frame = true;
+		}
+
+		if (processed_frame)
 			break;
+
+		/* Give other threads and IRQ routines a window to execute while unlocked */
+		cond_resched();
 	}
-	mutex_unlock(&sess->lock);
 }
 
 int esparser_power_up(struct amvdec_session *sess)
-- 
2.50.1

