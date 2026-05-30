Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB8DCD6E5E
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C9A112B4B;
	Sun, 31 May 2026 13:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iYjjPh13";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B423E112758
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 09:44:53 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2bd80b3aa13so96582855ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780134293; x=1780739093; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eg9ggvkEkoQKR+hIDJPnP9lc/gF7VRqufBdsoqX52Vc=;
 b=iYjjPh13Uj/zvZr3HSAG8m1f3mbuK7d28mlNGuG4HhY+lYUvc3YT8dMziRVf4g3XFI
 qNOenKrf8bzKzpWeT+SRjdIws0IRIY1MyOP6uz8NXgWi73NobjrHjGEfwTHFg6v97s50
 qpNl/TyfnGGYTrQhlqB8SSX4xCa5Quh5Ll63nrEi5NxT2gLLLHbh7t0Kz84nzB3LxwO9
 f1MQOoD9iMDobsnyUvICq0wYfTJzbzQld0Y85+sZbivC9AnNMWaaYiAoDKKdety4SCsJ
 tPq/H1okr8EI5fc1ypig1QMNeHTiEIH07PPfwqgp6ya1kWSRM0MtVZbNQ3a+5k6UUegR
 1Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780134293; x=1780739093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Eg9ggvkEkoQKR+hIDJPnP9lc/gF7VRqufBdsoqX52Vc=;
 b=HsA9rSQxa1e2ZU8oY/FnwnGZ3KrtDYQxPqvwiZKyc5Zu5LTXcyr88IQmM8YSYMyD/J
 0FbYJO4lfhqHbTWk6Q1ObEjBis0jhRpW9z2iWieDOMld5krScjz+B1ykpj1oxR9MaCVE
 cGO8S1O/Vob3a+TDPaIemgYiAK9KCDXkHlOnKDre4OtEj7qTpoW7WrEB9jtX8kc0QicR
 OzkNXuYAFQZvJRjIEy3/EKQpzhLqk6v87nJnblePRbzQihKxeLjWcSuh689Yyg2xqpGB
 xr3URgwI81oPwLYFdXTNHlVHayGA3liDnbxZ9/fsRHm+VdNNMIMNn+sGMUWp/ZJ3e3Bd
 1A6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oH5W7pyIFHppCwf9p1ue8oWQYf8YYZnmC7KbY8q5brpkHs2WINnzaZwMmDhQUSEQtsoEpBmkYQeE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwL03y9hooHfEy0TzY8b0F9ZbZXW0yorN6C7TDw4pwSLwvsbYCF
 IifcDSBQNW/l7uWtap+diYDFMZ3/j7iAb28I3Db5U79wn29X1zZj/zXL
X-Gm-Gg: Acq92OEP/cTnZOJkjuaEoWJZNpoDTwyNUEDvd1xwGf6TnhvVkv34v+58CawW5he4kVo
 xDD+iM4u4bgskLAgYiqYwpwVCSyTdV36l/MLsbltMRNlsRz8DPFSxnC1iNq/ITmS3Z/ZUMugQcw
 JZGAhoyNsC09akR6SV6DDx8/j7600jIMFWR/t8SC81ZZAW9NLLXWIAUedSniSaq73OlfMe1Gvcm
 vfWgOzQHKTWojoZrObK6tjJALaiN1PABI7xKgGek40svsKx2jFmiYBxKz3r60TcQ9aPE+NlYKu2
 2fFiUsP107mLsarM6whsAsnrSh5zebEAENMD9w5ZQI2VSaWFs/B+hkq30Ik1i1ZLguedCtCvh+G
 iA36oXQh9D5RRjMKfq8IWpxYnlCC70UNfjMNXe8bVZH8+iXjBvR+4h/EaWjjSx7ml7FyryrW4vV
 kYNL7rzDSPPKVHKYcoq2b8Uzt6zKUEHRw=
X-Received: by 2002:a17:902:c94c:b0:2b2:be01:5532 with SMTP id
 d9443c01a7336-2bf3686d1dcmr41074635ad.35.1780134293228; 
 Sat, 30 May 2026 02:44:53 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e700csm61529945ad.10.2026.05.30.02.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 02:44:52 -0700 (PDT)
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
Subject: [PATCH v6 5/8] media: meson: vdec: Cancel esparser work during
 teardown
Date: Sat, 30 May 2026 15:12:51 +0530
Message-ID: <20260530094326.11892-6-linux.amoon@gmail.com>
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

The esparser workqueue could remain active during error unwind,
streaming stop, or device close, leading to use‑after‑free when
work items accessed freed session memory.

Fix this by explicitly cancelling the work in all teardown paths:

- Call cancel_work_sync(&sess->esparser_queue_work) in
  vdec_start_streaming() error unwind, vdec_stop_streaming(),
  and vdec_close().
- Ensure the workqueue is drained before releasing session
  state and buffers.
- Move codec_ops->drain() evaluation earlier in stop_streaming()
  using the status snapshot, so draining occurs before buffer
  cleanup.

Following change prevents dangling work execution, eliminates
use‑after‑free hazards, and ensures orderly teardown of decoder
resources.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel.org/
Fixes: 3e7f51bd9607 ("media: meson: add v4l2 m2m video decoder driver")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 698a95566ad2..4884ee04b352 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -380,6 +380,8 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 			  sess->vififo_vaddr, sess->vififo_paddr);
 	sess->vififo_vaddr = NULL;
 bufs_done:
+	cancel_work_sync(&sess->esparser_queue_work);
+
 	mutex_lock(&core->lock);
 	if (core->cur_sess == sess)
 		core->cur_sess = NULL;
@@ -437,6 +439,8 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 	struct vb2_v4l2_buffer *buf;
 	enum amvdec_status old_status;
 
+	cancel_work_sync(&sess->esparser_queue_work);
+
 	/*
 	 * Safely snapshot the status and clear the hardware owner inside
 	 * the mutex to prevent data races with concurrent STREAMON requests.
@@ -448,7 +452,11 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 	sess->status = STATUS_STOPPED;
 	mutex_unlock(&core->lock);
 
-	/* Evaluate the hardware state using our snapshot */
+	if (q->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		if (old_status >= STATUS_RUNNING && codec_ops->drain)
+			codec_ops->drain(sess);
+	}
+
 	if (old_status == STATUS_RUNNING ||
 	    old_status == STATUS_INIT ||
 	    (old_status == STATUS_NEEDS_RESUME &&
@@ -472,16 +480,10 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		while ((buf = v4l2_m2m_src_buf_remove(sess->m2m_ctx)))
 			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
-
 		sess->streamon_out = 0;
 	} else {
-		/* Drain remaining refs if was still running using the snapshot */
-		if (old_status >= STATUS_RUNNING && codec_ops->drain)
-			codec_ops->drain(sess);
-
 		while ((buf = v4l2_m2m_dst_buf_remove(sess->m2m_ctx)))
 			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
-
 		sess->streamon_cap = 0;
 	}
 }
@@ -967,6 +969,8 @@ static int vdec_close(struct file *file)
 {
 	struct amvdec_session *sess = file_to_amvdec_session(file);
 
+	cancel_work_sync(&sess->esparser_queue_work);
+
 	v4l2_m2m_ctx_release(sess->m2m_ctx);
 	v4l2_fh_del(&sess->fh, file);
 	v4l2_fh_exit(&sess->fh);
-- 
2.50.1

