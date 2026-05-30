Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCCCCD6E5F
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 14:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E54112B75;
	Sun, 31 May 2026 13:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kFqlRt7e";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CBC4112750
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 09:45:16 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2be1dd4af34so132902355ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780134316; x=1780739116; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5aJiRofz4S8JTYcjNZpyXHhE2VKKeRqZ24DGJJ/QHU=;
 b=kFqlRt7eXI+bx+s37r3IBNNBb8B2qPxwhMV+nLHPxPnOG4fl7x9CAG9DcadGxnpd8a
 yGqOTE81rKGziOvYaSOzhm0D6UmUJy7a38Y3RBKl2ah2Bg2tvLVwHOchoePO4BMrNUmf
 gbetm68bOdjcMmAxlFMUCdxoM5yb8iCzQlem2dh9iQEpRE5umqgS4e//14GI0wIrg0Zj
 Lh/jiOFNdHePDmDJ8fBQVoFuWosEBd499dYnMEG11l1BuoYG7uCQZF/xhFZDHw/sXwJO
 baMIGliAC/1fI3aHZQHJw0CLPRNs6qcoQewE9InX5lV1oxEly8hp4MPuJO2EAGFGw0/d
 9Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780134316; x=1780739116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N5aJiRofz4S8JTYcjNZpyXHhE2VKKeRqZ24DGJJ/QHU=;
 b=pyxro0QMInGJswHx3SiSbXksd4ZCsG6vbe9uBLCGJEM/qRy8GqjS+1P3/3Sp98xceB
 WliSnwZWvgqlYa+TpeMK41alA+R4xy0nKi83q4l4o7P//Yd1T2rmbCSi65eQGYJpymaM
 okAQ/sO9v0SWolfWjfzo2iMrt/kl5lweDZVPgrC1QWQ91msLrVyewlwGVbxLnx+k1d2W
 a+vJC3ovRiLzvUrCxFN2srVR+qrGI5GKjp/nJabeuEo4NxIDrrruTnMCYTebkbqyavGt
 Ji8kzP78+ZC5hAtpBT4LSJ9Ara3L6LaR0OkdmaA/CgjqB+7Gruq1qR/V6EzpEQKRrJys
 h4zA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eRoYhNkGU3xBiBakNJ6i+ozlR89uJKqAjH8UMlb7pcLAA1+SevqFcjQob9/i63ZMWDPZ1f7Bd88s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfDVqHYIgLq9B2Q6E7PP7hOr7nA1ekYWhPsL/2pWrcnKBHjmyk
 zsdyq6pi7aJDX3TNGceqMYcHzrcvvc5UvbOEDWrydBsXibQm82IT7ZHs
X-Gm-Gg: Acq92OGqMdv3h1WUSgf4xB2n5va31d0RbX2PSGOD6su5KVaO8YCs/OK+7beCxC/Wiv0
 oTwrbMuziYe64lV/RmWJ9QOZ+RjqHDRt4ChKU/QEi0PEOvyz/vXX2E5heFp15uQbPwexLlbjzeZ
 FUWV5JNe1ZuTxj/ZNtkcCIduBGZK3XbYxqhNl6cyGdWQmff6wfMcKYbW1Ve1Ieo3iHB4dBEkF/r
 wzIgdlpYax98zBE7QJASJJN1TfS6lkIQ0N8xzTnzClFy/o/2lrD1LEmURstPv1hsHjgH0uKEpQU
 0toqpfuiNI/883gNLGKldEgwD9t/RNlIi8hrMv8LrzYgl4jQGJTwimZRAYW6fgZ90zSw1PZp5+l
 1rqUkNK/AmYp2T9oDoyuaZw6mVBIFhFBaxC/OI2aFpI0b4PfxwePsLCB6KBuB71dkuR1VyHHPA/
 MiWSaGXtGKU8jBLj1OI0hDDe8SSoA6acQ=
X-Received: by 2002:a17:902:e88e:b0:2c0:a3dd:4e6c with SMTP id
 d9443c01a7336-2c0a3dd4f17mr23090205ad.38.1780134315999; 
 Sat, 30 May 2026 02:45:15 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e700csm61529945ad.10.2026.05.30.02.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 02:45:15 -0700 (PDT)
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
Subject: [PATCH v6 7/8] media: meson: vdec: Fix NULL pointer dereference in
 ISR handlers
Date: Sat, 30 May 2026 15:12:53 +0530
Message-ID: <20260530094326.11892-8-linux.amoon@gmail.com>
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

The hard interrupt handler (vdec_isr) and the threaded interrupt handler
(vdec_threaded_isr) directly read core->cur_sess without synchronization
or validation. If a streaming teardown concurrently clears core->cur_sess
to NULL while an interrupt is being processed, a NULL pointer dereference
occurs when accessing the session fields or codec operations.

Fix this race condition by using READ_ONCE() to obtain a stable, atomic
snapshot of core->cur_sess. Check if the returned session pointer is NULL,
and return IRQ_NONE immediately if the session has already been torn down.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel.org/
Fixes: 3e7f51bd9607 ("media: meson: add v4l2 m2m video decoder driver")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index f99335effe17..3897c75b19c8 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -996,17 +996,36 @@ static const struct v4l2_file_operations vdec_fops = {
 static irqreturn_t vdec_isr(int irq, void *data)
 {
 	struct amvdec_core *core = data;
-	struct amvdec_session *sess = core->cur_sess;
+	struct amvdec_session *sess;
+	irqreturn_t ret = IRQ_HANDLED;
+
+	/*
+	 * Use READ_ONCE to secure an atomic snapshot of the pointer,
+	 * protecting against concurrent clearing during streaming
+	 * teardowns.
+	 */
+	sess = READ_ONCE(core->cur_sess);
+	if (!sess)
+		return IRQ_NONE;
 
 	sess->last_irq_jiffies = get_jiffies_64();
+	ret = sess->fmt_out->codec_ops->isr(sess);
 
-	return sess->fmt_out->codec_ops->isr(sess);
+	return ret;
 }
 
 static irqreturn_t vdec_threaded_isr(int irq, void *data)
 {
 	struct amvdec_core *core = data;
-	struct amvdec_session *sess = core->cur_sess;
+	struct amvdec_session *sess;
+
+	/*
+	 * Prevent late-stage threaded interrupts from dereferencing a NULL
+	 * session.
+	 */
+	sess = READ_ONCE(core->cur_sess);
+	if (!sess)
+		return IRQ_NONE;
 
 	return sess->fmt_out->codec_ops->threaded_isr(sess);
 }
-- 
2.50.1

