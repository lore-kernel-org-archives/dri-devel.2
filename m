Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CCCCD6E5F
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9AB112B6B;
	Sun, 31 May 2026 13:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SPl0cNt4";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC29112747
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 09:44:33 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-36b9b15af73so2370117a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 02:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780134273; x=1780739073; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrXJFZmxeXg5CYXAWJIPwYaWF/wPAlGFj3atI5I4qIQ=;
 b=SPl0cNt40DkfTq2cbiPl5vG31ng0JXxCB+v00kDs5Yqwnlduj7ATi3mUd0KDuyZX6q
 Sze5jlpmTOY46BLON40khANVGT2M7uFnBQV/v116k3T0HR+EAYg9Rw9+2Thz0SgE2TI7
 wX1sbQ9XX95mxltQTvx/iQpWqNaLqQwtNYuIDjnafIObGJ9XfQ8ka7O+RXLg9JUSte/2
 r2EmdqAqzp33lhKmK+RkmIrk18bZHMmu41J5NSuVxIoX/bSmshAs6/TDE0Ao2jsq6k6m
 E1IAOJyy7YkMrnEXCSXraf6nKtV0pLqsSzOGVQv3QkESIqOe9zMyWoVFnAEkZlXMF1bc
 tOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780134273; x=1780739073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BrXJFZmxeXg5CYXAWJIPwYaWF/wPAlGFj3atI5I4qIQ=;
 b=XxY7pEQbRbtrPpoeu22yHrqzAQxZG8q+qBoHdJbAHFLAip1WVIk4nT7OFc5R/xtVxP
 UcJodla7WqKVND6K2LjhN7BZMdHptnhrmfDjy2/M+NWYjRUsaaSoS/pPVy3WSzjFQC9N
 Qf/EyWxzHNV4a4p6cL7oUc+jpPkoM2ZhMOlybHdzZvw1mw1ZXQrHcxjxR12DzkLmi27N
 Fg1fgj17scf0Ua7doSzptXXfLrLycHZh40NeeMJlVJHqbkCZO79ROmE0JgzBkZa1H5P3
 e4H3rJfJbTzSbac7tmORPpqRGIcUXuZeyg9oPUTmHZk3fPknrBb68OJmPtIfXbu8HDYM
 cklw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BwW5rWBnx6xZ+xfPT3mwED4SdYi28+WaA5De0YKd45gdPJXaC4pQJKIbGpgLb8wRg7PU2HsOF8yw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQqO/RCHtMI4+jTCR4h17pCfAY9GZaRYvbi4fJlft0MdnkBoP3
 UzhxNHA6NVYe/xZ+t/ADmXZfsuOkX13d8NF2AVMhVYo4rcTu/NiT+tK4
X-Gm-Gg: Acq92OExVuYsy516AjHEc601sMg9/8XZQh/QSqfI3MjzK4Fc4PsQZQv7g4KLpCr3/I+
 KAx/KtmNAEdNsA1+p/+ypBPlayRiH2Y3iuj3z4P1D/0vHJrvAPf8OIMQjNyFdJEGgwqsb5hLIEh
 owRwF3KDGobQWGnfvw/ALNnbuBDuinEIOBuS8sXBukk80/VzPqNnT/bTe5sNbh4v4AEqqoEmFXg
 JlK+QnqLlfftGyB+lrbwq4Hfh0us/g1+8wC9mD0+Mc03GofP3N7IeVUHVwL/LZs+xH6R6kbcMZo
 fmyEY+GiIaAwLPLEnufYikhvb2Jp9ZHlx2HT7Wm23vlljfHxQwO7duD0i9GdnmAFfeOaYd/9URw
 gVplzcgyTYk8ehJkdEddQ7ICzxGtLhDIvUYTaMXUwT25sx3hdnli2wfgtXGq/i3YquxhbCjRCUF
 uZC03v4/hBqUMzu+GSVNlkilzdzriCRr4=
X-Received: by 2002:a17:902:da8e:b0:2bf:356f:4e0c with SMTP id
 d9443c01a7336-2bf36793916mr38435335ad.1.1780134272635; 
 Sat, 30 May 2026 02:44:32 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e700csm61529945ad.10.2026.05.30.02.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 02:44:31 -0700 (PDT)
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
Subject: [PATCH v6 3/8] media: meson: vdec: Handle kthread failure and free
 codec state
Date: Sat, 30 May 2026 15:12:49 +0530
Message-ID: <20260530094326.11892-4-linux.amoon@gmail.com>
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

vdec_start_streaming() launches a recycle thread when required by the
codec. If kthread_run() fails, the previous error path only powered off
the hardware, leaving sess->priv and codec state allocated. This caused
a permanent leak of the codec context and associated DMA buffers.

Fix this by introducing a dedicated err_cleanup path:

- Call codec_ops->stop() to release the codec context and clear sess->priv.
- Power off the hardware before freeing buffers to avoid DMA faults.
- Free canvas IDs explicitly and set sess->vififo_vaddr = NULL after
  dma_free_coherent() to guard against double‑free in fallback stop paths.
- Reset core->cur_sess and sess->status to prevent stale references.

Following change closes the memory leak on kthread_run() failure and ensures
robust cleanup of codec resources in both error and stop paths.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel.org/
Fixes: 3e7f51bd9607 ("media: meson: add v4l2 m2m video decoder driver")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 26 ++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 7233000e2232..8a5bf1a96830 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -32,6 +32,8 @@ struct dummy_buf {
 /* 16 MiB for parsed bitstream swap exchange */
 #define SIZE_VIFIFO SZ_16M
 
+static void vdec_free_canvas(struct amvdec_session *sess);
+
 static u32 get_output_size(u32 width, u32 height)
 {
 	return ALIGN(width * height, SZ_64K);
@@ -352,16 +354,31 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 
 	sess->sequence_cap = 0;
 	sess->sequence_out = 0;
-	if (vdec_codec_needs_recycle(sess))
+	if (vdec_codec_needs_recycle(sess)) {
 		sess->recycle_thread = kthread_run(vdec_recycle_thread, sess,
 						   "vdec_recycle");
+		if (IS_ERR(sess->recycle_thread)) {
+			ret = PTR_ERR(sess->recycle_thread);
+			sess->recycle_thread = NULL;
+			goto err_cleanup;
+		}
+	}
 
 	schedule_work(&sess->esparser_queue_work);
 	return 0;
 
+err_cleanup:
+	vdec_free_canvas(sess);
+	vdec_poweroff(sess);
+	if (codec_ops && codec_ops->stop && sess->priv) {
+		codec_ops->stop(sess);
+		kfree(sess->priv);
+		sess->priv = NULL;
+	}
 vififo_free:
 	dma_free_coherent(sess->core->dev, sess->vififo_size,
 			  sess->vififo_vaddr, sess->vififo_paddr);
+	sess->vififo_vaddr = NULL;
 bufs_done:
 	mutex_lock(&core->lock);
 	if (core->cur_sess == sess)
@@ -441,8 +458,11 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 
 		vdec_poweroff(sess);
 		vdec_free_canvas(sess);
-		dma_free_coherent(sess->core->dev, sess->vififo_size,
-				  sess->vififo_vaddr, sess->vififo_paddr);
+		if (sess->vififo_vaddr) {
+			dma_free_coherent(sess->core->dev, sess->vififo_size,
+					  sess->vififo_vaddr,
+					  sess->vififo_paddr);
+		}
 		vdec_reset_timestamps(sess);
 		vdec_reset_bufs_recycle(sess);
 		kfree(sess->priv);
-- 
2.50.1

