Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD3BCCF2DF
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D3610E7EC;
	Mon, 19 Oct 2026 07:14:38 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D899810E819
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:14:28 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48de72fc832so1275570f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 00:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792394067; x=1792998867; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TvlgYQm3dB8aOMy4KbGGHq81fZ8P+nSRZxAdejOQGxE=;
 b=jcFH0tBhh3pR9WfbS0mjadYQHBHq7AcLtZhx1d6qE3ZyG/XuWSrCv2IRkaA+jonop4
 oCX2QaDfs2UGeenObgBxGv/f5elmypHord0k+4zc1t0JOH6Z1KJtF4dL38cW2Z3rCEbU
 UOfRakqMqXvoqJ4y9PlffwhwSmcLeF8M0co64XjWGETA8MMmAZvKuy3OIFCj/zu+x4BW
 wqU+J1TkEwjd4nqdrg+LopLka6WzlTI0BpE0h183skd3RPHBOmR7VUMSgrJqjIS+5hWb
 Zt0eNt3iXw2ldSa9VSkYUPQnfby/C7KqrCknHyH8gopNtPcM1J84G8J/Ahay6elPwa9m
 slxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792394067; x=1792998867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TvlgYQm3dB8aOMy4KbGGHq81fZ8P+nSRZxAdejOQGxE=;
 b=YP+1I7504ZoMjaVlm+BPbP3tK1WflcbAYvy7fZMOVxDQiDNeQ/5VG0DtsXBX64mYlF
 4PPtea95QrY74cXirQiMViOAcMHq9JrcQ72+3s0KIE/AslUPL4Vwo1a7MZT5m3XU8c7F
 rscut17XSR2HOG8fnq8JzjEtHYdZfaXePmaza90ggbUuJkB52fSIJ2xdFvghJI/80ZV6
 kFptjuX5+1gXhCWSu7T65VVCjjd0ukTpMNJiQU33I57AtKglX94dwcc5ovWTz26etXCU
 0TpcQILIVRUtzukSBmS8+Ddbr2V/R0UABrVrlCClnAEqEFJdoiG7iKpg1BvorpZaNf0W
 egFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwt1+T+G2o5C1pkvueQ5r5PfzLJwRurVehKT7Cak7u1tDNTnXWQ4In++j5YcMnIaBtGt0Uzeq4u9Ss=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLMDv+tclagZZt//hA8eSRG564Y0udjlHX4ix5c4p5NnxZY5Yk2
 TSJRfI7NE5uMT0XTwpzi3ODssn/p8dcRCKbuOOTTnUWtk9l07w6gZxQC
X-Gm-Gg: AYBFou3wzxo91l+rC5551h52sme9qFKQMkh23a0BcPNse+3UmrawHGeZgws3I5AQW9b
 wTxzqKH88NK1/UzKAnoVlzhxlKYDJe4+XxJWNcvoe23x6n5q8tlih/T2o12FGd36D2xXNg8WEYr
 UTI4roXKUYj+BeTJh2RdMdaumwIiINmmTdOzYQxtkTCvARLcBIyYfpB99ciEME/RdiMx7ylRs68
 pzh14lFYCCrTPybwnxuX19DjeLyKi5VUKPjC7bOQaV7wDHUA9hHoAOMfjp56tdFlKTKYlOEcZOu
 FGnH9uS17mz7W/j3YCpTHtmvS0yeLmTWA4u94FH+eL6BkD1klgFUqdeOt+gxFQ/Ats+/1EMDu3U
 Zj0xetxAj0U1nO++g12f342ex2GnT/AysxilIYB//UmtKJ34AeGGQkeNBMrMO7xLv4fQBQSu747
 L2JPSJi3HLM1jlBD2dMLPlIuACHkZRQpL/NENqsGkFZGAICKlr4eirvJGlIzcm5ZIrYO0oA4Pbp
 Ddn5BTu/wNBcywXLl8ntIkcklKnd6TTI90Y1V8konPHJJuvBNGl3kkzveALElmCjeoWjw3Nn+XF
 DTd0I0BkzZtLeiW2i00LuIxPb7upa1RoDnZnWCoF7lptAY4hi5tyf5FfLCS76ZNFR8qGvcpZ7Yv
 A
X-Received: by 2002:a05:600c:a05:b0:4a1:813f:2a57 with SMTP id
 5b1f17b1804b1-4a1d7608058mr147552565e9.13.1792394067002; 
 Mon, 19 Oct 2026 00:14:27 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a4e0-4601-c43a-536a-04a3-af7d.310.pool.telefonica.de.
 [2a02:3100:a4e0:4601:c43a:536a:4a3:af7d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd540bc4sm21559338f8f.2.2026.10.19.00.14.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Oct 2026 00:14:26 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: linux-media@vger.kernel.org
Cc: Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Tomasz Stanislawski <t.stanislaws@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 4/4] media: vivid: synchronize imported DMA-BUFs for CPU access
Date: Mon, 19 Oct 2026 09:14:11 +0200
Message-Id: <c12681c1d39c45ce554d31eb03e3452ad55b0e43.1792392288.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1792392288.git.kmehltretter@gmail.com>
References: <cover.1792392288.git.kmehltretter@gmail.com>
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

vivid accesses imported DMA-BUFs with the CPU without cache
synchronization, leaving physical RAM stale after capture.

Set uses_cpu_access to bracket the driver's CPU access.

On a Pi 400, stale frames fell from 25/96 to 0/96 with this change.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/media/test-drivers/vivid/vivid-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index 62cfb5feb2cf5..e3aa1fc3bcf75 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -925,6 +925,7 @@ static int vivid_create_queue(struct vivid_dev *dev,
 	q->ops = ops;
 	q->mem_ops = allocators[dev->inst] == 1 ? &vb2_dma_contig_memops :
 						  &vb2_vmalloc_memops;
+	q->uses_cpu_access = true;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->min_reqbufs_allocation = min_reqbufs_allocation;
 	q->lock = &dev->mutex;
-- 
2.47.3

