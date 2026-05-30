Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C2DCD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 14:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C14112B87;
	Sun, 31 May 2026 13:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KDxbcFL8";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD21112742
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 09:44:11 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2bf008a99d4so29388415ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 02:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780134250; x=1780739050; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOGv5iwSngrj41XE+piVh0d8DY2B1AD5Rx86ecpnAxY=;
 b=KDxbcFL8Bkq0qLJ5bcPJBEFPtbdyHOydFLbhNcY/NJJcJK4ySg4s/4wbfUypKrN4XI
 RX6CuEx9+nFWGEPWsuc1bmIXKI3XIsSeqy/i+FdqrFarnMCZmgrWRr10aGhZkaD2w4My
 uPHoEKXQPxM4Q+0T4YT7bwmFukpurbqNW8NlsaYIVTktdSBNw4EVASr2RFiZbxdVJ/L4
 mBertt8/EEjo5lxY6x81jBwUM17h08yo3BHCoYtuJC59dT/DfCkDILZix6Y6yFAMOKvE
 L074E/vtawK6ha5OtZ7PDXMagHckdV+ma7OX8SiYW2PXh/KonNyrC3H3Co+o3yqw8+xK
 uY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780134250; x=1780739050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MOGv5iwSngrj41XE+piVh0d8DY2B1AD5Rx86ecpnAxY=;
 b=VQ/DSr7Cw4Yp/trpyep1QPnj0l9U4Y3cdhrBUMTo6EAwKF4W00hatvnTM0flshqttu
 qtYgGihnN9+vFTmyJDDA3m1/QEiZgWAtmFsl1lrwwG9XITzcESXylnuh5EKX7gNWinkF
 sFuawAVfluV1VBf/8OKGetRRtrh9+ZFvca+JcW0Ys7OEKKBfPcf++BT30SKSm0TUeHC7
 BNbcx15YUOrPQs2xs8Gcm2YHpGqnkhAupzEFLAwsYiW+qkzYDOx/I6K+kaXfvwH6WLfx
 z/5Usynwnl1ezEMx5KR0Paa6s7RZUjCBBeg4XVymC+fXrOMT5DIXfUcA4+BM8DOkwNLK
 KxFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WLvYmmDLEdPEzH5AxbsnYZ2TGWKX2fkNFbWfvRIGZS4JxX7M+m6Uw0yVYMKn10fWOqZUNsExSnEk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzH1Eegq89WJNqC5uU2inbc9yhOF0z4i9htqwFjTBIuLlin1S0K
 McY1flYFq5xihc6cKjNOBe7OcmNRgfg2zue0BJK71f1xGmZiETtmYlZg
X-Gm-Gg: Acq92OE5nyFMVEeZXYgIplp8s3+QE3SXQ9yOTbJZ+Mu++jqACHbSPeSdqUM7Ka0x9ns
 ciUbCJ8tpsDZc1QN3ccSAUeowVNQN9meG8rzPRuL05JUlQSLlgcCBYPnX8aD8vzMMzlMEblF8G4
 kJ+paE+tDJuAeJwHPhAtuZceaotFOk4f9jjxxMzTng1Hn08JC+uHqtTS8+kNAk7Z0uXI5Ut4Qc3
 ZkJhNgi2uryKeXzUSn5nASE2V8IbmwqeKs0Axif5foPg5yJXadPKB8WDxtYwSfvx2lUfF48NbaV
 yNlrg74EZNCmxPz2cJ7yT3k+zns4TjtHcLVGRdVqlPVaX/vBbJEdSBoeK+okap+HC+eDGzP72QP
 7Jwt2tENpMsiMXtFxXf1qz+PFh6hMH3VWmERVaiw/oWYD37BLw4oNCr49EpbqbeU7bQxK6bVUXg
 /2mCTAKtVc/fkVXmfGIapL0dx+K5zYczQ=
X-Received: by 2002:a17:903:a8f:b0:2b0:7531:b61e with SMTP id
 d9443c01a7336-2bf36889991mr42155535ad.41.1780134250482; 
 Sat, 30 May 2026 02:44:10 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e700csm61529945ad.10.2026.05.30.02.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 02:44:09 -0700 (PDT)
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
 Maxime Jourdan <mjourdan@baylibre.com>, Hans Verkuil <hverkuil@kernel.org>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-amlogic@lists.infradead.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC
 support), linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC
 SOCS), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Cc: Anand Moon <linux.amoon@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v6 1/8] media: meson: vdec: Fix memory leaks and lifetime of
 m2m device
Date: Sat, 30 May 2026 15:12:47 +0530
Message-ID: <20260530094326.11892-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260530094326.11892-1-linux.amoon@gmail.com>
References: <20260530094326.11892-1-linux.amoon@gmail.com>
MIME-Version: 1.0
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

The driver was initializing the v4l2 m2m device instance per-session
within vdec_open() and releasing it inside vdec_close(). This approach
is faulty because the m2m device represents the hardware context and
should persist across multiple open sessions.

Fix this design flaw by shifting v4l2_m2m_init() to vdec_probe() and
v4l2_m2m_release() to vdec_remove(). Correspondingly, move the m2m_dev
pointer from struct amvdec_session to struct amvdec_core.

Additionally, this patch addresses two critical resource leaks:
1. Adds a missing v4l2_ctrl_handler_free() in vdec_close() to clean up
   allocated control handlers upon session closure.
2. Introduces proper unwinding logic via a new 'err_fh_del' label in
   vdec_open() to ensure that file handles (v4l2_fh) are fully deregistered
   if subsequent session resource allocations fail.

This was identified via kmemleak:
unreferenced object 0xffff0000205d6878 (size 8):
  comm "v4l_id", pid 5289, jiffies 4294938580
  hex dump (first 8 bytes):
    40 d2 49 18 00 00 ff ff                          @.I.....
  backtrace (crc d3204599):
    kmemleak_alloc+0xc8/0xf0
    __kvmalloc_node_noprof+0x60c/0x850
    v4l2_ctrl_handler_init_class+0x1b4/0x2e8 [videodev]
    vdec_open+0x1f4/0x788 [meson_vdec]
    v4l2_open+0x144/0x460 [videodev]
    chrdev_open+0x1ac/0x500
    do_dentry_open+0x3f0/0xfe8
    vfs_open+0x68/0x320
    do_open+0x2d8/0x9a8
    path_openat+0x1d0/0x4f0
    do_filp_open+0x190/0x380
    do_sys_openat2+0xf8/0x1b0
    __arm64_sys_openat+0x13c/0x1e8
    invoke_syscall+0xdc/0x268
    el0_svc_common.constprop.0+0x178/0x258
    do_el0_svc+0x4c/0x70

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260520045905.6ACBA1F000E9@smtp.kernel.org/#t
Fixes: 3e7f51bd9607 ("media: meson: add v4l2 m2m video decoder driver")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 33 ++++++++++++++-----------
 drivers/staging/media/meson/vdec/vdec.h |  4 +--
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 4b77ec1af5a7..4ffebba2341d 100644
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
+		goto err_fh_del;
 	}
 
 	ret = vdec_init_ctrls(sess);
 	if (ret)
-		goto err_m2m_release;
+		goto err_free_sess;
 
 	sess->pixfmt_cap = formats[0].pixfmts_cap[0];
 	sess->fmt_out = &formats[0];
@@ -913,8 +906,8 @@ static int vdec_open(struct file *file)
 
 	return 0;
 
-err_m2m_release:
-	v4l2_m2m_release(sess->m2m_dev);
+err_fh_del:
+	v4l2_fh_exit(&sess->fh);
 err_free_sess:
 	kfree(sess);
 	return ret;
@@ -925,9 +918,9 @@ static int vdec_close(struct file *file)
 	struct amvdec_session *sess = file_to_amvdec_session(file);
 
 	v4l2_m2m_ctx_release(sess->m2m_ctx);
-	v4l2_m2m_release(sess->m2m_dev);
 	v4l2_fh_del(&sess->fh, file);
 	v4l2_fh_exit(&sess->fh);
+	v4l2_ctrl_handler_free(&sess->ctrl_handler);
 
 	mutex_destroy(&sess->lock);
 	mutex_destroy(&sess->bufs_recycle_lock);
@@ -1057,10 +1050,17 @@ static int vdec_probe(struct platform_device *pdev)
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
@@ -1095,6 +1095,8 @@ static int vdec_probe(struct platform_device *pdev)
 err_vdev_release:
 	video_device_release(vdev);
 	v4l2_device_unregister(&core->v4l2_dev);
+err_m2m_release:
+	v4l2_m2m_release(core->m2m_dev);
 	return ret;
 }
 
@@ -1104,6 +1106,7 @@ static void vdec_remove(struct platform_device *pdev)
 
 	video_unregister_device(core->vdev_dec);
 	v4l2_device_unregister(&core->v4l2_dev);
+	v4l2_m2m_release(core->m2m_dev);
 }
 
 static struct platform_driver meson_vdec_driver = {
diff --git a/drivers/staging/media/meson/vdec/vdec.h b/drivers/staging/media/meson/vdec/vdec.h
index 7a5d8e871d70..cc0cfafb8a95 100644
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

