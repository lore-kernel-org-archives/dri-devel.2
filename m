Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1525C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC4D10E950;
	Mon, 13 Jul 2026 12:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b9gO6Ok6";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D1D10E950
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:09:46 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso2902021a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944586; x=1784549386; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Krigkeb0EY7ngMYX+Y7ADjdq0pOv6Fpp5Q1fhmmedpo=;
 b=b9gO6Ok6PmPJuwYJeNUJvQwFo/J3ZuAoY5WOdNRZg4U9sHsNMoXBXyKPMSEYePHvm2
 UGw0HqjJXkJtFk018YBrsHsitciMIi6ZmolmUI0JaLhmKJcKOgh++MQzQ+O8d/5hZMwH
 StIVFHA76nYeIVKL6FWRT1eEvsE3nrWOgcB3Hsft4Ktkt2rHErD3aBB4r77cwU6fCBL3
 om78t5z2TFJCGRnMt+hJFAoM74cWOJQJt7dM9nFu+6el4JSxDlCg3pnOhczMDleqHKyf
 981zOJJOcTGpPDh6xAMbP8WILG6DyDdNkgzLXnj/T5ywEq1gKy8qRNOTXh/m0uFBaooH
 iWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944586; x=1784549386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Krigkeb0EY7ngMYX+Y7ADjdq0pOv6Fpp5Q1fhmmedpo=;
 b=iON6W4UkkloBsZAfyoxb0z2zVQOdOSeUdf4+7o0ayZ4sb/WlDLDUP+0pm+bVDfF7CY
 pjtVbao1+4t0zHxawn5XlceUq5Qy5atuaA5F2r8S323CdTqWMFGiNH9OSzNXKs18kYSQ
 mPDFPDARuIy2VEnsf/7VXp0fhCKp8UocIQJWM+DavcDEUaoHnO6AgByd1ppXr+Px7er1
 TNIU0cDrKlXWHujyJxoxjUyPvr8dP2o5o4vu6HYpKOo0/pCslytksCRKxzFi16ZpphCL
 wPn1CNG7z+vXuzTVKu2jOOtZuadNohzYooCpIjGumh8UPPE9Jfqmg0VvzXMrer8trV/b
 Kp/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUHaIebwOBlNR9/72e7Y6ZU5PWMtuANgXOdoH3VMilLEakb/TV+pllzN7OO6ceODqkle95MBj/9HY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVTiGkICXbtnr0IFoyr9cFe/Q+QawJCqIF0Xdu0qA65Wzn8XR9
 +2GfqDl995h8ib73kc3zhBcGGkOB8ZLOGjkWcjBeUejEGBxYwQxolfrt
X-Gm-Gg: AfdE7cm4r5HbQHj5tVlMsLfyeckq5kjfiy1FDgaxwf92zx0mEdztpCbPmAWNKGXVo8b
 FV9ooQvOV0EbhBruybOXq82JXWFp0JOJcknFGVhJcH58lWrGqB/oWZCyaoAkRRerzbODdKa8eFK
 gbGBwBXZn67KfKFl/I4KB+LQGbd3YWQsUYwisDEe2BY1odyIlQGEeIuJwygj+WYAkh/KAaz2Bto
 C7RWSs1M3QgwM/OoEAV5Q2oNDyHjsZfloaDPvhWooCrIZBbU47g0u03QxJq3LtRCuC73NiXfQyb
 qovFWQmZ9ppQEnnMdiRBg8JV6S7jq69U7FfpQyKvYxIT+VE2+4gs54CxOY1UZrAfWccyUHFt3tv
 46s2nGVrCIZnE8ToyhFxka7P/AaXTKRM7ugQVtIzDsWKnH73vnvatnuXQhhxv7CZxNthjSLOCZ+
 iw01cEHmhRAEj4MNvnhoE/
X-Received: by 2002:a17:90b:4ac1:b0:38d:e0c4:c955 with SMTP id
 98e67ed59e1d1-38de0c4ca49mr5634290a91.15.1783944586225; 
 Mon, 13 Jul 2026 05:09:46 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:09:45 -0700 (PDT)
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
Subject: [PATCH v7 05/19] media: meson: vdec: Fix race condition and
 synchronize esparser IRQ
Date: Mon, 13 Jul 2026 17:37:00 +0530
Message-ID: <20260713120840.17427-6-linux.amoon@gmail.com>
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

During session teardown sequences in vdec_stop_streaming() and
vdec_close(), the 'esparser' hardware interrupt handler can still be
actively triggered or executing on another CPU core. This creates a
transient race condition where the ISR attempts to handle stream data and
allocate internal tracking state structures after session contexts have
been modified or freed.

Update esparser_isr() to read the current session context utilizing an
smp_load_acquire() barrier snapshot. If the pointer resolves to NULL,
terminate processing early with IRQ_HANDLED to protect against
concurrent dismantling.

Suggested-by: Doruk Tan Ozturk <doruk@0sec.ai>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel.org/
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/esparser.c | 8 ++++++++
 drivers/staging/media/meson/vdec/vdec.c     | 4 ++++
 drivers/staging/media/meson/vdec/vdec.h     | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index 4632346f04a9e..37749ede308c6 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -60,6 +60,12 @@ static irqreturn_t esparser_isr(int irq, void *dev)
 {
 	int int_status;
 	struct amvdec_core *core = dev;
+	struct amvdec_session *sess;
+
+	/* Secure an atomic snapshot to protect against concurrent teardown */
+	sess = smp_load_acquire(&core->cur_sess);
+	if (!sess)
+		return IRQ_HANDLED;
 
 	int_status = amvdec_read_parser(core, PARSER_INT_STATUS);
 	amvdec_write_parser(core, PARSER_INT_STATUS, int_status);
@@ -439,6 +445,8 @@ int esparser_init(struct platform_device *pdev, struct amvdec_core *core)
 	if (irq < 0)
 		return irq;
 
+	core->esparser_irq = irq;
+
 	ret = devm_request_irq(dev, irq, esparser_isr, IRQF_SHARED,
 			       "esparserirq", core);
 	if (ret) {
diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 7ae3d5a9dd6ab..7689ffdb2e500 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -486,6 +486,8 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 
 		/* Synchronize and flush pending hardware interrupt service routines */
 		synchronize_irq(core->vdec_irq);
+		/* Ensure esparser ISR finishes executing */
+		synchronize_irq(core->esparser_irq);
 
 		vdec_poweroff(sess);
 		vdec_free_canvas(sess);
@@ -994,6 +996,8 @@ static int vdec_close(struct file *file)
 
 	/* Synchronize and flush pending hardware interrupt service routines */
 	synchronize_irq(core->vdec_irq);
+	/* Ensure esparser ISR finishes executing */
+	synchronize_irq(core->esparser_irq);
 
 	if (!IS_ERR_OR_NULL(sess->recycle_thread)) {
 		kthread_stop(sess->recycle_thread);
diff --git a/drivers/staging/media/meson/vdec/vdec.h b/drivers/staging/media/meson/vdec/vdec.h
index d165c343fd022..c4639cf33e73e 100644
--- a/drivers/staging/media/meson/vdec/vdec.h
+++ b/drivers/staging/media/meson/vdec/vdec.h
@@ -68,6 +68,7 @@ struct amvdec_session;
  * @cur_sess: current decoding session
  * @lock: video device lock
  * @vdec_irq: irq for video decoding
+ * @esparser_irq: irq for elementary stream parsing
  */
 struct amvdec_core {
 	void __iomem *dos_base;
@@ -95,6 +96,7 @@ struct amvdec_core {
 	struct amvdec_session *cur_sess;
 	struct mutex lock;
 	int vdec_irq;
+	int esparser_irq;
 };
 
 /**
-- 
2.50.1

