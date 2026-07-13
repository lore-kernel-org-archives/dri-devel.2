Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43023C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 963CC10E959;
	Mon, 13 Jul 2026 12:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SYGIYIer";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF3810E959
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:11:11 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-381018b9375so3450828a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944671; x=1784549471; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vnt3ypfWeNL23UY1KrHNZewux6mQtgVXM5HeMULrIrY=;
 b=SYGIYIer3hnvUzdwLVMFDCImeq1K6e14ncHipVGBENzmRL+eD6sdO4gc+cLyWlcYkW
 qQ2WrXdD2OyrhKJ4qyo0LEuO4KTeyVDPwZQbyowzy2WDoVZhU911FkPDidAKSBmRrODM
 il74mmPlDMxoC7VjtX2rtSbAZ9T9GfbVr0W1bJ7bdjzBEzKVqG71tAnp489PdC3dp0BD
 ORl+OxaGMLPzah3WThU84kxJizIpOSQ7CkPgBmn1AMHXCgYnmVN6dxeLekQpJmoCYLbz
 jZh75SfxEikurCJV0ArZvsZOXB1tjeqO6NUrJdr3Y8AaFTwZ0y6VSMd81YYXPxD5BdpY
 W+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944671; x=1784549471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vnt3ypfWeNL23UY1KrHNZewux6mQtgVXM5HeMULrIrY=;
 b=hP2m7HD7QpRqTOn2fHDb07AnbzFurLO9IjKQ92argoDwGPMoljaUnTMNrBzpXWh6IA
 SSLwTgrcZVTfo/qi4lYT7mvAhuoKIt6y0CcCfv8e5ZWwaO7JxhEPOXrXev1g7tJi0t3w
 ZLXxMfl6sp09uVumySiJZS/dhdoUZt0xoZo9/MeSJ+x3DDlLyQMVYC5v4nbSJ8vbuwq/
 PdLxD/bS2w+W75NDPmVRE+qnUUffVOXA9Gsk769UfynpAzZIGT8RniErChfqqEbIQGT5
 h6dw5r+ubwgJduo5+MBHdfKbzDce0p2KMv+xE7imCQX5f/4CA8wjXosNnTdG5KOgjNoK
 zmxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJX1rpaPyiia/gvFP1lW8Xjai9QF8B0U2TMqsCqzE8Nr8rWg9oTfFShDFMfcww1fa5lBG+IOFtwZg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaDADSH2oY1UI3SLI+zYcPOqOopMiU5TaFmkhOIdSOkDAss3tl
 VTxpZMavK6hQaF0jjmAZf4x8iHj3yf102qzM4DiHpG01i41Zp8W6N3jv
X-Gm-Gg: AfdE7cmJpg+wyzy7LZoGjhyhhtutv1RvXViyD2ib0ZPsxp+fj4w4ljz3uD8fs8yU+Q/
 BAGZAee31afQQV5MKf600NzdkQgivs0Skq0GHcmm75j9Gcel9DkksZBxMLlt1ybxFfd6/44NFDt
 aCWyPVRkrwhib0sCP34yUYAfFQkX4JbUCcL4sD/uOL/y6iCUwD5fZ+UnIkqp07UduL4TVrIMbNa
 edb2BLmie5sCunObOE8XgFZjylyg8PPdMvf+8k3JYOpMVdz26rrGROg4bQS7nlqzbipiqbewpjL
 TcIm5CtF8l+rLh0oMK4MLQT/AkpAmVBDljqqoOHz4gTmSk+Y/DnaGLic96sIQT934NFld21PdYm
 yOrzxWFpNotLPsrasapq2HtJK6KuV/hqBFqDEFSkS6ZM//mURSOwBH1quOXSXKBpjtCZtqryxY5
 aNCrEBiybseJMlPGj49hd/
X-Received: by 2002:a17:90b:4990:b0:36a:a16b:5f6d with SMTP id
 98e67ed59e1d1-38dc74c4c2cmr9218450a91.7.1783944671501; 
 Mon, 13 Jul 2026 05:11:11 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:11:10 -0700 (PDT)
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
Subject: [PATCH v7 13/19] media: meson: vdec: Fix race conditions in job abort
 sequence
Date: Mon, 13 Jul 2026 17:37:08 +0530
Message-ID: <20260713120840.17427-14-linux.amoon@gmail.com>
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

Implement proper cleanup inside vdec_m2m_job_abort to safely stop
the hardware job sequence during a streaming abort or teardown.

Without this, if a job is aborted right after being triggered, the
deferred work item (esparser_queue_work) scheduled by device_run
could continue running concurrently. This leads to unexpected behavior
and potential use-after-free bugs if session structures are cleared.

Fix this by flagging the session to stop via WRITE_ONCE, synchronously
canceling any pending parser work, and safely clearing the active core
session pointer under the core lock protection.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index b3e1d99e8889f..ac86a9c4febff 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -167,6 +167,17 @@ static void vdec_m2m_device_run(void *priv)
 static void vdec_m2m_job_abort(void *priv)
 {
 	struct amvdec_session *sess = priv;
+	struct amvdec_core *core = sess->core;
+
+	WRITE_ONCE(sess->should_stop, 1);
+
+	cancel_work_sync(&sess->esparser_queue_work);
+
+	mutex_lock(&core->lock);
+	if (core->cur_sess == sess)
+		/* Safely clear hardware ownership since we were confirmed as the owner */
+		smp_store_release(&core->cur_sess, NULL);
+	mutex_unlock(&core->lock);
 
 	v4l2_m2m_job_finish(sess->core->m2m_dev, sess->m2m_ctx);
 }
-- 
2.50.1

