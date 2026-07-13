Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52631C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F8310E95A;
	Mon, 13 Jul 2026 12:11:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cQ4KtU6v";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6136110E95A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:11:22 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2caea3f742bso33332195ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944682; x=1784549482; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7nfm5E5YVw8Xk7Gt9ejcJe2nuIHpfZQPsIGFP/AIC7g=;
 b=cQ4KtU6v/NbYAHz18/61RN/u3VEjCbwj+UTWI97AV9KzUtM923i7DqT8zLbF1csz9H
 NSQp9TpnacSDmTNLHnp6q9JqJhFijKBkr/BXHB+zIJX49197G5AGh8YmbefLMBiWbtkx
 M37zrFINxmnpYCD5Py+zn6HUG+Io3d/BhUVob1oRpFYaE7wNQ+1rQKDN+0IydUYXtXnJ
 M/2YMUfZhz0Js4rac+s0p2F/xv3WR+bITw7j3baZ9NVbfqb0KGyO8iu/3O2bFAHbl7Y4
 NRY9TJ1mbTVIZwIwfZbwKPZiuPAyeUaHCFzS89W+275VpdQHLqAdIiLlj9zO08vGTMNL
 5Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944682; x=1784549482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7nfm5E5YVw8Xk7Gt9ejcJe2nuIHpfZQPsIGFP/AIC7g=;
 b=SiWj3UnoV+M38gjP3siyuPSJc1xD5kBl3kSmVJ080IiN6agRBx+ofy4dcfX2GkNkk8
 7LtMwXzyW2+BEmESicm8jYSfB8KDuremHs92toA4XbaZx4pQLc490j03iaRvacZFjMrE
 U64zROO5kwzUDToSXrWuYeWQV+5iCK56bgyrR6NVheOiro59fw2j7XNv4ZIjueN7Hf2j
 wxhPs6FFeWMM9iOL6q/3cpdyLobjp7W6QXf+N1Z0mJzl6TxzN0xhpxJsn/ZDljQo/0zn
 yvjLFsVdx5UAaUrM1UnDjDCeOHmXvQMHgh0YKC+CaExYivRoMp24IeNWjZJXB1/3urgz
 D/zw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYUjxI1MOdE+XCI7X8qNNbMCo1h/ov4KTH1KjY6dAHkqKhJ89jP+oTrxDJ8vS8UZVG1mYnGU7dSt0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yya9obMP/CJLjSbX/Vpa1rFLIIFH+wBZNtH5TMmzpTP2aNxd7gI
 MMfd+et3ch91OUNd1fLiCpDmRskdi3qcOwr6FJLooKXJbh0TriPnDanm
X-Gm-Gg: AfdE7cml6eVH4a0W2+5HMpoP/JT2OHKhEWPEPw8FT+pdVuwjockacuqyLSfiMaaf4UZ
 HwDmdvf8h/P5CiPBzpxnALsOgXKCWVHlZUAv4RczEwu3w1i2I5ZcIU2m5cjrOSFb9x7DmhHsbbG
 b8f3DZvxjPNMc+xKdS5W6e5Ntu5vYWumgOgBH+YgDAzt6sGjl8z3/myLOsuZ/4SzREqQHYvomNs
 xACcoBxTVx+fUwZ/dc4UE+KyA8M/PQ0lJOzWFHCNTbG2KCeVrA4qCRitii+vJ7cPhYHyfKjy4CV
 JonA4kEStjWKZMAyjg6h86KoKYKliRm10oqCwhAKckx/HcLhqVc6oe/G5MKo+bNUUDjaxiKoogm
 TxaBl4PzY95fmE/QeWVcb2ZlFxQhCiNnHukxhVptNGMAtgu7e4GqLJRke5KrNAVnPqoEmQXA7GZ
 K7UNeUerqjtQ==
X-Received: by 2002:a05:6300:220a:b0:3bf:aab1:cc8b with SMTP id
 adf61e73a8af0-3c110b436f6mr8836067637.46.1783944681879; 
 Mon, 13 Jul 2026 05:11:21 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:11:21 -0700 (PDT)
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
Subject: [PATCH v7 14/19] media: meson: vdec: Correct atomic counter placement
 in dst_buf_done
Date: Mon, 13 Jul 2026 17:37:09 +0530
Message-ID: <20260713120840.17427-15-linux.amoon@gmail.com>
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

Fix an end-of-stream (EOS) boundary condition logic flaw in
dst_buf_done() by relocating the atomic decrement helper to execute
after state evaluation.

Previously, decrementing sess->esparser_queued_bufs at the entry point
of the function corrupted the conditional checks for the final video
frame. This premature decrement tricked the driver into flagging the
second-to-last buffer as the final frame (V4L2_BUF_FLAG_LAST) during
teardown sequences, which cut off the true final frame and broke
compliance validation.

Resolve this by moving atomic_dec() to execute immediately after the EOS
conditional tracking block finishes evaluating, right before invoking
v4l2_m2m_buf_done(). This ensures accurate stream termination
signaling.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
index f02c21d5a9c18..303236f0647c0 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.c
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
@@ -314,6 +314,9 @@ static void dst_buf_done(struct amvdec_session *sess,
 	dev_dbg(dev, "Buffer %u done, ts = %llu, flags = %08X\n",
 		vbuf->vb2_buf.index, timestamp, flags);
 	vbuf->field = field;
+
+	atomic_dec(&sess->esparser_queued_bufs);
+
 	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
 
 	/* Buffer done probably means the vififo got freed */
-- 
2.50.1

