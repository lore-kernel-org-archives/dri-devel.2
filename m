Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE16C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6867710E957;
	Mon, 13 Jul 2026 12:10:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kdFb0mGP";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8533010E957
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:10:50 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38101f85591so2893123a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944650; x=1784549450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OBddtjFYWhyXG/z7saOr360Gpb3JLBOtzUiY/pJ38ko=;
 b=kdFb0mGPB8lXdGfqOzaToKCm4DF9CvWm4sPJUoCoH756P6n4v2xqy677PAXpQiVQ01
 y2vA6/S4YkmJA4d4/R1E4ZFkEtTYQIWBU35QVGm+KDwg/Duc94LqnfcxrWLyEFnWDz5G
 SsarpK7IJpfBT2K1UyQiYl7omnLzH97arBBhJI+YF8jug2+zjqR/Q8TYEBRP7jyl6zEY
 RoGQNxoelqLh2DOUa6KEkED0kbUGvR43v6r7V2y1htULypVvf35LYmZETfuzQGfFfRgi
 XGx91uyLvOUqnRZR7N5YuWRZJIIoqVtEN7YM9bWd+Y1O6F9vowhLQSZqWZ1hNIHB7Ufs
 VAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944650; x=1784549450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OBddtjFYWhyXG/z7saOr360Gpb3JLBOtzUiY/pJ38ko=;
 b=rW1i6dRPu+fgvFbiQxs6RkyuU8pn51ppB2ZjhD0zXeyOH8u+pq7UgWD5cIERKRmb+m
 RsulS3NdfCw4TaZP1RUoid2sgHUr7JGklJanWWD7OZVcmrAzMH3WB1XpLLgrN3EHA95o
 LJZSHQW9wC7TtWOELliBUNwzYYmxI57dqChTYdk79n73JzJZlkv+WIOFsAXyqJbvqAds
 AoM2Vo2jm5laZutl+rr11/jsQoXc9X/0KId/cKMugnhGjWd+0cG64AFxkGo+aGxh6YyB
 LUWqNMH8TIT1XQdXv1eEKQS17IyID9pHE79DciScZ7Cki5FJD42ZYU9ONjL+rPZtS8Fi
 9N1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTxlfCeL4qyoj9Uzuuv94rQOz+Ic/xEofzZtaa2ZVFH+MTqnE/UN8u8aADqgCAys9wW9NxI1a2wMg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzK9+8gxnxCqcX76uaMWgAzxVEsLRvrC0qPElepgjG59BTdR4jz
 FQ5nKnOHt/Lq/TMXxUMxharjuZJvJzXWWjxoCOrq20yZr9/hwrjyu74u
X-Gm-Gg: AfdE7clj7iZjwbf8PkPdN/6mLkzKJHI21Nf5txAxRoVpsA7qqcyHgHCwZOO5cjCFm9C
 HnOh7Nr/q6K7KPeYeX9eSjgjm/OFC2nq6uhbkbIGWk8vOifwVumyg0jnufHe/m3i3/yYdRYlIMU
 TO6XiIrGy8adCWNBoY+fvMnjnxzrJnbrubej9qZhmvHHjsQ7ImCu8j+RyE3JaPATUgtwRecU4cR
 EF5CTNzXJe5ULP5YLfzBccjlsXk1N09fzDMAFgeNoN3I35HJtPJ65BRzcSwpvazTN/BIsDSY7lM
 EUDp4s8CMJgGBdamiHQzy69Y0qdDODEn0aCKTQWd6eUAfzOsdDrJwJCL8lmbkVT74UMz+dV6RyX
 O37wYIZfQtr5y4urgM6jAZYw6cGWBM0Qu91K2W9CycZ7Qiaq6ygPJLQsqgEc577bHm1sU2p9S+h
 9fWQ2t7h2H0kp4cyIAmJxa
X-Received: by 2002:a17:90b:4cc7:b0:36b:b903:994 with SMTP id
 98e67ed59e1d1-38d13768de2mr15327432a91.4.1783944650044; 
 Mon, 13 Jul 2026 05:10:50 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:10:49 -0700 (PDT)
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
Subject: [PATCH v7 11/19] media: meson: vdec: Update core m2m stream state
 during transitions
Date: Mon, 13 Jul 2026 17:37:06 +0530
Message-ID: <20260713120840.17427-12-linux.amoon@gmail.com>
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

Explicitly update the V4L2 core Memory-to-Memory (m2m) framework's
internal streaming states when initiating or terminating streaming on
the device queues.

Without invoking these core framework helpers, the m2m engine's
bookkeeping of active source and destination queues drifts out of
alignment with the driver's local 'streamon_out' and 'streamon_cap'
tracking variables. This misalignment causes state validation stalls
and incorrect polling outcomes when the device is subjected to quick
runtime cycles or strict testing setups (such as v4l2-compliance).

Fix this by integrating v4l2_m2m_update_start_streaming_state() right
after a queue is marked active in vdec_start_streaming(), and pairing
it cleanly with v4l2_m2m_update_stop_streaming_state() at the end of
vdec_stop_streaming() before the session core mutex is released.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 83a9b1238972a..0eb39aa6014ee 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -299,6 +299,8 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 	else
 		sess->streamon_cap = 1;
 
+	v4l2_m2m_update_start_streaming_state(sess->m2m_ctx, q);
+
 	if (!sess->streamon_out)
 		return 0;
 
@@ -529,6 +531,8 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 			sess->changed_format = 0;
 	}
 
+	v4l2_m2m_update_stop_streaming_state(sess->m2m_ctx, q);
+
 	mutex_unlock(&core->lock);
 }
 
-- 
2.50.1

