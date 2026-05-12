Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB81CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560F910EA57;
	Tue, 12 May 2026 11:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GzIbnSgG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE9110EA4C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778585866;
 bh=6QHOzxiThV1napBgD2WXGo7jOgBJIud8iecUi32DAPs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=GzIbnSgGMgTiep5zivgzR+X5jFESpkPu20xkKItS9dguCsXlS3xUmFj3nl8IqBEHY
 ysZgqQC8d3jDwHGe3Xuwcq7P9poynS/yNmrq2v3SXPnWiS4w4m8EPbVHNlOARID6DD
 lKXYa8MQwQHiR6PRDpSkvVP6v/4pU9p8Ho0JHzvcmLNxrFsLnVp9zpo3W8Ghv3gAND
 L5lDHkvqOFrTUJ7FF53b7heXh/E9HVxBw+savnE/nKdGh5CkM4wLmHNCFPRJpybejT
 NVoxNJO104u8a1A+ueccUvs//ZdniiGKLLt3yN0KCU5HG6JyqitTDTqoQOXLJh1OKn
 KyPt9Gk2AaYxg==
Received: from [192.168.1.38] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3BA6917E38D0;
 Tue, 12 May 2026 13:37:46 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 12 May 2026 13:37:39 +0200
Subject: [PATCH v2 09/11] drm/panthor: Process FW events in IRQ context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-panthor-signal-from-irq-v2-9-95c614a739cb@collabora.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778585861; l=1970;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=6QHOzxiThV1napBgD2WXGo7jOgBJIud8iecUi32DAPs=;
 b=xFErXu3PXYSnxJtOtOBsAT9YACsqJvddT0SYP6xTmMiSW4k4Q4zPF9PgrHkcYTcrUnrInl69v
 C3EUeAS662hA7ATt0Nu6o311ZXzn1qdDoau+lj23ggMHF8G7IlqAc0m
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

Now that everything is set to allow processing FW events in IRQ context,
go for it. This should reduce the dma_fence signaling latency.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index f5e0ceca4130..8cfebf180de7 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1087,9 +1087,29 @@ static void panthor_job_irq_handler(struct panthor_irq *pirq, u32 status)
 	}
 }
 
-static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *data)
+static irqreturn_t panthor_job_irq_raw_handler(int irq, void *data)
 {
-	return panthor_irq_default_threaded_handler(data, panthor_job_irq_handler);
+	struct panthor_irq *pirq = data;
+
+	if (!gpu_read(pirq->iomem, INT_STAT))
+		return IRQ_NONE;
+
+	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
+		if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)
+			return IRQ_NONE;
+
+		pirq->state = PANTHOR_IRQ_STATE_PROCESSING;
+	}
+
+	/* We can use INT_STAT here, because we didn't mask the IRQs. */
+	panthor_job_irq_handler(pirq, gpu_read(pirq->iomem, INT_STAT));
+
+	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
+		if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING)
+			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
+	}
+
+	return IRQ_HANDLED;
 }
 
 static int panthor_fw_start(struct panthor_device *ptdev)
@@ -1489,8 +1509,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
 
 	ret = panthor_irq_request(ptdev, &fw->irq, irq, 0,
 				  ptdev->iomem + JOB_INT_BASE, "job",
-				  panthor_irq_default_raw_handler,
-				  panthor_job_irq_threaded_handler);
+				  panthor_job_irq_raw_handler, NULL);
 	if (ret) {
 		drm_err(&ptdev->base, "failed to request job irq");
 		return ret;

-- 
2.54.0

