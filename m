Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0260C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6DE10E94A;
	Mon, 13 Jul 2026 12:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CuthlRgA";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8D610E94A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:09:03 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-381ed661712so3562281a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944543; x=1784549343; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ARrER7TwdRrsnOsOCnXp0K3Qc6DycIa1Bph8QCPIN4s=;
 b=CuthlRgARDBSGleJIn7gybwUdgJp3q17KIXU7igmHiR6M+WvoOMD4VEYmgqVUW9kS4
 ej7LtJPr0wBKt3nt+BSeqRjWty+2DsDgarjGn67IquBbvyQS3XWWjgfca/1VSEtPPwPE
 PCgfJuGpJWIVMu383rYp0OeKx/4Xb0XT0aQ80vwVPPMRAAZxTBMOAMuxndajyj2shBoU
 fhaRHkkf5U3XJb2pqrbhhcldPugFjaUy3Mi91ipSIj9l7g4CXlBcGBtSmyAlR+wuJLBU
 7U7f2zFlqC7oRrSeApRfKYsSKXuZ2w9zi4Wrm+UBJVianP9xWWMZU3QAZn6e0YtGP8kJ
 4RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944543; x=1784549343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ARrER7TwdRrsnOsOCnXp0K3Qc6DycIa1Bph8QCPIN4s=;
 b=ELZOipo7SD25G9YibYRZDn8XlFV0OngdGDUCJV3WvO6IXaCoM/kHNU4eUmkqtlTO8n
 FuHZduFuGodQfJDNQWObDsbFWYxoL3CuNwviwKdnMfSQWyixcpQu0gCxEuqEi3B7UDwd
 TVKX0+DPKo4LNLd1zQPokViogKJJDLjLY0YXhcPx7U6ZVd1u9jK8Yohx/RZIo8aWXLmZ
 taFfkidFrFS6KgV/T8Ukkx4+f6NVqwEptwtM60SUl36Dw7kdkk9TPkSWkaeeAdmDXAUf
 upJ6uFg67R9GDBKAGJ/J21MYG1kdLMu357Vr8Agd82AXEMe3mB22mOmn2IPgLPHXA7J/
 PBzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqADgjrevVTWx6Ip9QVVJWvRs4iwENQlqnyZz/Ztc2K1LRpuHNnd3Ldqjs0Ka348smlIn4P5M9F2P4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYj7Vba3HjHlpU+HzUuYcd+QSkk9010LG1OAbsHoQg7XT/Qj+b
 uJhhwMT5JY+hog7Xc9uS4XfQBtfmm0Fgi5EhWlOWPTcE6uxOlL6oEBVF
X-Gm-Gg: AfdE7cn5mkDXcIDBjNjQtfr5xyX0BTzw3K6PWiD8INuHHTorA9U3u5ZpBBNCB5sSL8z
 EbsmiwjkkQbYKDZuX9AuWerylalkXWCNW8lNHXUMQAeL2uzxlubaDh5KxNZQoa9wmdUAkvtjSUz
 DkXMhtn91mnWs/O6b2S6tuLWfwToRi+MwqU/y1rv0IABeGYp/7uYYV/AsklL/5N2grETVE5oU0M
 NZxuwNK6NpyxmVNcUptnlDXrrIBxMxAZZVy6x3OrgGsqiIKC7vpG2YO05M7VybZjBnLI+7aKSBK
 Eck648toKJip9fODQaN2ZBJwSP13CP2RyetMD/++jHM1FTivFkv8lUEW9i6jeQX8AxX+4UMz/+2
 RExFXoalg/tIoAiNzjscqbrTHUpMp/K4u1p76yaNQZed3Kta0aI7nWLL5u3wz2cuolmXXs/t2ES
 32ORDccwq9fg==
X-Received: by 2002:a17:90b:2750:b0:37c:18e0:90dc with SMTP id
 98e67ed59e1d1-38dc75ebea3mr8633908a91.16.1783944542617; 
 Mon, 13 Jul 2026 05:09:02 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:09:01 -0700 (PDT)
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
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v7 01/19] media: meson: vdec: Fix m2m device lifetime and
 cleanup path
Date: Mon, 13 Jul 2026 17:36:56 +0530
Message-ID: <20260713120840.17427-2-linux.amoon@gmail.com>
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

The vdec driver was incorrectly initializing a new v4l2_m2m device
instance per session inside vdec_open() and releasing it in vdec_close().
This design is faulty because the m2m device models the core hardware
engine and must persist across multiple sessions.

Fix the lifetime by moving v4l2_m2m_init() into vdec_probe() and
releasing it in vdec_remove() which resolves passing the global
core->m2m_dev down to session contexts so all sessions share the
same hardware instance.

This change aligns the driver with proper v4l2_m2m usage, ensuring
the hardware device lifetime is tied to the platform driver core,
not individual sessions, and making teardown safe and predictable.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260520045905.6ACBA1F000E9@smtp.kernel.org/#t
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 36 +++++++++++++------------
 drivers/staging/media/meson/vdec/vdec.h |  4 +--
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index a039d925c0fe5..6ae3471155a87 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -153,7 +153,7 @@ static void vdec_m2m_job_abort(void *priv)
 {
 	struct amvdec_session *sess = priv;
 
-	v4l2_m2m_job_finish(sess->m2m_dev, sess->m2m_ctx);
+	v4l2_m2m_job_finish(sess->core->m2m_dev, sess->m2m_ctx);
 }
 
 static const struct v4l2_m2m_ops vdec_m2m_ops = {
@@ -873,23 +873,16 @@ static int vdec_open(struct file *file)
 
 	sess->core = core;
 
-	sess->m2m_dev = v4l2_m2m_init(&vdec_m2m_ops);
-	if (IS_ERR(sess->m2m_dev)) {
-		dev_err(dev, "Fail to v4l2_m2m_init\n");
-		ret = PTR_ERR(sess->m2m_dev);
-		goto err_free_sess;
-	}
-
-	sess->m2m_ctx = v4l2_m2m_ctx_init(sess->m2m_dev, sess, m2m_queue_init);
+	sess->m2m_ctx = v4l2_m2m_ctx_init(core->m2m_dev, sess, m2m_queue_init);
 	if (IS_ERR(sess->m2m_ctx)) {
 		dev_err(dev, "Fail to v4l2_m2m_ctx_init\n");
 		ret = PTR_ERR(sess->m2m_ctx);
-		goto err_m2m_release;
+		goto err_free_sess;
 	}
 
 	ret = vdec_init_ctrls(sess);
 	if (ret)
-		goto err_m2m_ctx_release;
+		goto err_release_ctx;
 
 	sess->pixfmt_cap = formats[0].pixfmts_cap[0];
 	sess->fmt_out = &formats[0];
@@ -913,10 +906,8 @@ static int vdec_open(struct file *file)
 
 	return 0;
 
-err_m2m_ctx_release:
+err_release_ctx:
 	v4l2_m2m_ctx_release(sess->m2m_ctx);
-err_m2m_release:
-	v4l2_m2m_release(sess->m2m_dev);
 err_free_sess:
 	kfree(sess);
 	return ret;
@@ -927,9 +918,9 @@ static int vdec_close(struct file *file)
 	struct amvdec_session *sess = file_to_amvdec_session(file);
 
 	v4l2_m2m_ctx_release(sess->m2m_ctx);
-	v4l2_m2m_release(sess->m2m_dev);
 	v4l2_fh_del(&sess->fh, file);
 	v4l2_fh_exit(&sess->fh);
+	v4l2_ctrl_handler_free(&sess->ctrl_handler);
 
 	mutex_destroy(&sess->lock);
 	mutex_destroy(&sess->bufs_recycle_lock);
@@ -1059,16 +1050,23 @@ static int vdec_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	core->m2m_dev = v4l2_m2m_init(&vdec_m2m_ops);
+	if (IS_ERR(core->m2m_dev)) {
+		dev_err(dev, "Failed to initialize v4l2 m2m device\n");
+		return PTR_ERR(core->m2m_dev);
+	}
+
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
 	if (ret) {
 		dev_err(dev, "Couldn't register v4l2 device\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_m2m_release;
 	}
 
 	vdev = video_device_alloc();
 	if (!vdev) {
 		ret = -ENOMEM;
-		goto err_vdev_release;
+		goto err_v4l2_unregister;
 	}
 
 	core->vdev_dec = vdev;
@@ -1096,7 +1094,10 @@ static int vdec_probe(struct platform_device *pdev)
 
 err_vdev_release:
 	video_device_release(vdev);
+err_v4l2_unregister:
 	v4l2_device_unregister(&core->v4l2_dev);
+err_m2m_release:
+	v4l2_m2m_release(core->m2m_dev);
 	return ret;
 }
 
@@ -1105,6 +1106,7 @@ static void vdec_remove(struct platform_device *pdev)
 	struct amvdec_core *core = platform_get_drvdata(pdev);
 
 	video_unregister_device(core->vdev_dec);
+	v4l2_m2m_release(core->m2m_dev);
 	v4l2_device_unregister(&core->v4l2_dev);
 }
 
diff --git a/drivers/staging/media/meson/vdec/vdec.h b/drivers/staging/media/meson/vdec/vdec.h
index 7a5d8e871d708..cc0cfafb8a951 100644
--- a/drivers/staging/media/meson/vdec/vdec.h
+++ b/drivers/staging/media/meson/vdec/vdec.h
@@ -63,6 +63,7 @@ struct amvdec_session;
  * @vdec_hevcf_clk: VDEC_HEVCF clock
  * @esparser_reset: RESET for the PARSER
  * @vdev_dec: video device for the decoder
+ * @m2m_dev: v4l2 m2m device
  * @v4l2_dev: v4l2 device
  * @cur_sess: current decoding session
  * @lock: video device lock
@@ -87,6 +88,7 @@ struct amvdec_core {
 	struct reset_control *esparser_reset;
 
 	struct video_device *vdev_dec;
+	struct v4l2_m2m_dev *m2m_dev;
 	struct v4l2_device v4l2_dev;
 
 	struct amvdec_session *cur_sess;
@@ -183,7 +185,6 @@ enum amvdec_status {
  *
  * @core: reference to the vdec core struct
  * @fh: v4l2 file handle
- * @m2m_dev: v4l2 m2m device
  * @m2m_ctx: v4l2 m2m context
  * @ctrl_handler: V4L2 control handler
  * @ctrl_min_buf_capture: V4L2 control V4L2_CID_MIN_BUFFERS_FOR_CAPTURE
@@ -230,7 +231,6 @@ struct amvdec_session {
 	struct amvdec_core *core;
 
 	struct v4l2_fh fh;
-	struct v4l2_m2m_dev *m2m_dev;
 	struct v4l2_m2m_ctx *m2m_ctx;
 	struct v4l2_ctrl_handler ctrl_handler;
 	struct v4l2_ctrl *ctrl_min_buf_capture;
-- 
2.50.1

