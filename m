Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4539AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC46A10E94B;
	Mon, 13 Jul 2026 12:09:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AzlVSHFO";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC6510E94F
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:09:36 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-381b831d535so3503112a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944576; x=1784549376; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K3WTyPeomnpShciKNumkAzLHLjjvlL0zze6H3PBXARM=;
 b=AzlVSHFOTg0xACtaKyXtNR5UCQf2RhXfxO48me4MCniHglYtVF24EpQp9ayL1vGVoc
 4Zt2n29RqudHYvWEKZxZ5CfR91kwuOrNAuD3h/LyhEE+FfxRBP/fXAuXBob/aYsJhe+m
 1POYGfBuT6WyT2UuVoh6whCfhQusUvD6nVhqTXTx5G7mphajow3X+sbDrqlPPb5WghND
 VTrlEDsgMDyvJJEABEUO5XCnrngBKpN8MnryQwrayEO+vzdWZXnRVRjFKP0oZpsi7aQ7
 uPBymIpGmh3U+QIIHSKpVmPgpoeZXqQ/W+XjTWNfsK4+qxy/N6Gnd/V0mXjWDOE2w/cF
 QsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944576; x=1784549376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K3WTyPeomnpShciKNumkAzLHLjjvlL0zze6H3PBXARM=;
 b=BMk4F38/yRIA5fM17ZSaTF998kiqH4gSYJk7ft71buowpzMPALGzns84bDyT3wsqh0
 Pc6Pt9+/89euEdGxCnv0CK9egHjcW8RO3o1NdrYUrzdbY0KD1jhGJ6TBgyhTfns9ZXBF
 enAYI1lEEeBYI7TpFp6ppfI5vbKkIFbbwugCS8kzmxK2MLgBqljSusAGgb2tcRrFXnZP
 WHe7Fm20SiumUKnZFusN7/E9XD8i64CIRdFHXIt76aJlaoV1A77prXLOsBkykFhKk1mE
 1xq0LepK5P4rVBc7EdQ+D5fDnBEhNZucNg67C5PAPBqCnxSRn5Nf754er+vZBZrOTcCv
 mQ2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpipKXoNprlNzOBqpOyZnOW8XFedtyxLATfb56WEQe/Wuh/KzOUf7PPeyawGOyk6Ifm04WVD3PRJU4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAciDHQUxsHDC0rblIBLURX89ZuJqmd8a3N9jole0olnyMm0YR
 3MLatWHybQZ3tqC07x+lSWkGmNzzBTKjF4YSrCxoRjynjqdQmCa2FVSO
X-Gm-Gg: AfdE7ckw1CRGHjlJpWqZYpkBU2i2qXkLZoWp1Pk5IILI3RSYpIZPSScnqgviuZZrWlg
 eCi3q0jaOXk5oT0pTEXKX8dxniNlNHHLBF52R1UDj5XDsQkI9ZzhKgawBhSbG1Tow238zLAX598
 Nx0vNe54F/Z5fHHpVgXemnjiQ4p5ZW1h0HlggCL1fMsjJWTwQDDUlDJaI+3liXIjmhw1ruj84+S
 FZJtZQC30t3J7LHLaqynDr+sIDuBEYwrL/PIa0zVkmXURQ/Z+gJ0oCiVl/mljiDgx5zFpsHFWkh
 k73k6wzUAkfpIJtvv2Kxj/N0N06L6jnDhNbrpDnQJ0tAerbRPEWeM0P/H1Pol8rxhNS27NSHCCx
 MwPqjgNUumcSbW5y8zCA1n0is8+xw11WbD3pioUj+zzwQOaGpl17wzmZysIPbd+vL5xSJIo3EaB
 NG/5AorhIQPw==
X-Received: by 2002:a17:90b:2248:b0:387:e0db:3fae with SMTP id
 98e67ed59e1d1-38dc7779d32mr8371305a91.39.1783944575701; 
 Mon, 13 Jul 2026 05:09:35 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:09:34 -0700 (PDT)
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
Subject: [PATCH v7 04/19] media: meson: vdec: Fix use-after-free race between
 teardown and ISR routines
Date: Mon, 13 Jul 2026 17:36:59 +0530
Message-ID: <20260713120840.17427-5-linux.amoon@gmail.com>
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

Prevent critical race conditions and null pointer dereferences inside
the Amlogic video decoder driver by synchronizing the interrupt service
routines during session teardown and file descriptor release phases.

The hardware interrupt handler (vdec_isr) and threaded handler
(vdec_threaded_isr) read 'core->cur_sess' without proper synchronization.
During a streaming teardown sequence via vdec_stop_streaming() or session
release inside vdec_close(), the underlying session structures can be
modified or freed concurrently. This creates a transient window where a
late-stage hardware interrupt can wake up, read 'core->cur_sess', and
dereference an invalid or NULL session pointer, causing a kernel panic.

Update both the hard and threaded interrupt service routines to capture
the current session reference using an smp_load_acquire() barrier snapshot.
If the snapshot resolves to NULL, terminate immediately with IRQ_HANDLED
to guarantee execution contexts do not process stale structures.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Suggested-by: Druk Tan Ozturk <doruk@0sec.ai>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel.org/
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 22 ++++++++++++++++++++--
 drivers/staging/media/meson/vdec/vdec.h |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 7fc73d5cdebbf..7ae3d5a9dd6ab 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -484,6 +484,9 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 			}
 		}
 
+		/* Synchronize and flush pending hardware interrupt service routines */
+		synchronize_irq(core->vdec_irq);
+
 		vdec_poweroff(sess);
 		vdec_free_canvas(sess);
 
@@ -989,6 +992,9 @@ static int vdec_close(struct file *file)
 	struct amvdec_session *sess = file_to_amvdec_session(file);
 	struct amvdec_core *core = sess->core;
 
+	/* Synchronize and flush pending hardware interrupt service routines */
+	synchronize_irq(core->vdec_irq);
+
 	if (!IS_ERR_OR_NULL(sess->recycle_thread)) {
 		kthread_stop(sess->recycle_thread);
 		sess->recycle_thread = NULL;
@@ -1038,7 +1044,12 @@ static const struct v4l2_file_operations vdec_fops = {
 static irqreturn_t vdec_isr(int irq, void *data)
 {
 	struct amvdec_core *core = data;
-	struct amvdec_session *sess = core->cur_sess;
+	struct amvdec_session *sess;
+
+	/* Secure an atomic acquire snapshot to protect against concurrent teardown */
+	sess = smp_load_acquire(&core->cur_sess);
+	if (!sess)
+		return IRQ_HANDLED;
 
 	sess->last_irq_jiffies = get_jiffies_64();
 
@@ -1048,7 +1059,12 @@ static irqreturn_t vdec_isr(int irq, void *data)
 static irqreturn_t vdec_threaded_isr(int irq, void *data)
 {
 	struct amvdec_core *core = data;
-	struct amvdec_session *sess = core->cur_sess;
+	struct amvdec_session *sess;
+
+	/* Prevent late-stage threaded interrupts from dereferencing a NULL session */
+	sess = smp_load_acquire(&core->cur_sess);
+	if (!sess)
+		return IRQ_HANDLED;
 
 	return sess->fmt_out->codec_ops->threaded_isr(sess);
 }
@@ -1136,6 +1152,8 @@ static int vdec_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	core->vdec_irq = irq;
+
 	ret = devm_request_threaded_irq(core->dev, irq, vdec_isr,
 					vdec_threaded_isr, IRQF_ONESHOT,
 					"vdec", core);
diff --git a/drivers/staging/media/meson/vdec/vdec.h b/drivers/staging/media/meson/vdec/vdec.h
index cc0cfafb8a951..d165c343fd022 100644
--- a/drivers/staging/media/meson/vdec/vdec.h
+++ b/drivers/staging/media/meson/vdec/vdec.h
@@ -67,6 +67,7 @@ struct amvdec_session;
  * @v4l2_dev: v4l2 device
  * @cur_sess: current decoding session
  * @lock: video device lock
+ * @vdec_irq: irq for video decoding
  */
 struct amvdec_core {
 	void __iomem *dos_base;
@@ -93,6 +94,7 @@ struct amvdec_core {
 
 	struct amvdec_session *cur_sess;
 	struct mutex lock;
+	int vdec_irq;
 };
 
 /**
-- 
2.50.1

