Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE766C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B97710E958;
	Mon, 13 Jul 2026 12:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bxH6PHcH";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08EEB10E959
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:11:01 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so1786416a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944660; x=1784549460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=or8zdD24QFos1ceTDAq+AN9AMfFHPT46CUnsHlWUgzA=;
 b=bxH6PHcHUOok8KWBC6A74YRBUSOPAtZoHsxEpE2z2UArkUiX7XPbXJilpqS1CnDiq3
 n9bZuIE6V7gc7lELFBCl0svZra6qhSX+pL/LHkQWViE2DPMPo1fJVugl5eovMRO40FzK
 9xTccAWfT71vxSsKywX9jHMRcNFlUok7MMg2tlHR5M1dvTMfNkWEP9ChaF+tC3jE2G8g
 k+AFaS1eMGcreSlfjNYaXq43AR/QfGSn4qHbvXTrTCpbzERNWnBcSRQXwV9c+DtDR5L3
 hPmHYUHM4gMAHWphg3FTQaNm/OxGYsvsU3OKKURU19QZjSup1lIlyz7QmL98dcmKea1d
 pO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944660; x=1784549460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=or8zdD24QFos1ceTDAq+AN9AMfFHPT46CUnsHlWUgzA=;
 b=cey+s8LqNun+H4v4ABR9BloTJZZ/AG57eotM68su66KJNoaR6EErcD8Di6z8kDb4xz
 jh5vT7kMoGgjyYD1lv3GgvVdflmmLznWPBtiC4kpqCPskVpw89qA+/mzHNEwxjM9Gcbk
 sCsuRqZlCdYMDJ3NO0fxz0VO3EIQ1qZIXivWXSR2lfn53EijaHr5tA8pgaB9UOKvjcLb
 yYLA8cyWlAFSyRB0/uirDP7qaAr1wZl27UjcQA8mUw9jHY+crzrLOV8XvLaI+A7/yTXC
 Tqjj8CxoLl04YSSEDXzOCZMSSWV+xx4QkbXYVEMSR0z7OwRleeAihHYQVvxmUTsxd4PT
 xB3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7sq4uZuDZhbiG/I8hQLlCylhnWHzdYDuXzsQ7H0sXj7bzpv0c04I7KV+cari8P/GVdb8sD14QNvQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/w3nKn5P6hp7fAKAUeaJetMySDliiovQ+v27uJI0XA1g7L1tC
 me/2nIA6aqnAHVQ3BxVLxHWjZvPcgflYwgHGhgPSR6VdtMvzLtEi0t+H
X-Gm-Gg: AfdE7cmEcRYFZKNpnpo40PQQxy+oVl+Y7VfpBNCz7reCa7CjZE6U4zkJz/o2kLUjO06
 ZSS8deRTm2sgFmDmwQNdP19bImbyrrRnxBrgkGS8ghNfoGeGcJO/bxGFaCRPybOrO5ZRRQ8uSCK
 K7TFJoJUv4aH5EBoXCGWQwTZBMtIKglTe3F0i67c6w3mPbveO8qwCYoo33ZCJrSra9Ux7BQApkI
 +BdOwgjpW5pEiSlgd5KM8a8d7yp/CgHi65j06gxkQWdILk2mZaq0IrEJbWxpdambPhscVZzHKsn
 WHbuM++7EMn2RiOL1+b+CimQuyXbgdHk3vGqq4adElIYyvHjs21hcQbMaHd+Sk4XXitnSU9+0nt
 JomJsATK2I//uQtcyUZtp55XQLn8KXGJzT6X4XMeAVrrbusPZ6nUAilzlWFpkirCdaWQ+QPFYFx
 tv+6iER2zLXWkPhfRg6FoB
X-Received: by 2002:a17:90b:3c43:b0:37f:9ce3:ca97 with SMTP id
 98e67ed59e1d1-38dc777b8a2mr8266584a91.32.1783944660581; 
 Mon, 13 Jul 2026 05:11:00 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:10:59 -0700 (PDT)
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
Subject: [PATCH v7 12/19] media: meson: vdec: Coordinate m2m task execution
 inside async loop
Date: Mon, 13 Jul 2026 17:37:07 +0530
Message-ID: <20260713120840.17427-13-linux.amoon@gmail.com>
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

Introduce proper V4L2 Memory-to-Memory (m2m) scheduler pipeline tracking
by handling job finalisation inside the asynchronous esparser workqueue.

Because the meson video decoder offloads raw hardware register processing
and bitstream feeding to an internal workqueue engine, calling the helper
v4l2_m2m_job_finish() prematurely within the primary device execution
trigger context (vdec_m2m_device_run) drops the active task transaction
state too early. This timing gap creates a state mismatch in user-space
multimedia layers like GStreamer, resulting in a fatal "poll error 1"
event abort that breaks streaming setup sequences during pipeline preroll.

Resolve this architectural loop collision by deferring the scheduling call
to v4l2_m2m_job_finish() to execute exclusively within the worker routine
esparser_queue_all_src() at the precise microsecond after an input buffer
payload is fully validated, cleared, and returned via v4l2_m2m_buf_done().
Additionally, protect hardware session context mappings with core mutex
locks and implement volatile early exit gates within vdec_m2m_device_run()
to ensure stable teardowns.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/esparser.c |  4 ++++
 drivers/staging/media/meson/vdec/vdec.c     | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index b9f36fef4be12..939b239c2af47 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -399,6 +399,7 @@ void esparser_queue_all_src(struct work_struct *work)
 	struct amvdec_session *sess =
 		container_of(work, struct amvdec_session, esparser_queue_work);
 	struct device *dev = sess->core->dev_dec;
+	struct amvdec_core *core = sess->core;
 	int ret;
 
 	while (1) {
@@ -437,6 +438,9 @@ void esparser_queue_all_src(struct work_struct *work)
 			else
 				v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
 
+			/* Safely notify the V4L2 core sub-framework */
+			v4l2_m2m_job_finish(core->m2m_dev, sess->m2m_ctx);
+
 			/* Set tracking flag indicating transaction completion */
 			processed_frame = true;
 		}
diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 0eb39aa6014ee..b3e1d99e8889f 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -149,6 +149,17 @@ vdec_queue_recycle(struct amvdec_session *sess, struct vb2_buffer *vb)
 static void vdec_m2m_device_run(void *priv)
 {
 	struct amvdec_session *sess = priv;
+	struct amvdec_core *core = sess->core;
+
+	if (READ_ONCE(sess->should_stop)) {
+		v4l2_m2m_job_finish(core->m2m_dev, sess->m2m_ctx);
+		return;
+	}
+
+	mutex_lock(&core->lock);
+	if (!core->cur_sess)
+		core->cur_sess = sess;
+	mutex_unlock(&core->lock);
 
 	schedule_work(&sess->esparser_queue_work);
 }
-- 
2.50.1

