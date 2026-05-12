Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F6BCD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC05010EA53;
	Tue, 12 May 2026 11:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bOhyCQBm";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDAF710EA4C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778585867;
 bh=eYNYQB3l+VBREhCd2wuUuP8KC+bGL7PL32BpwOYm1dU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bOhyCQBmrLKPr3PV/MFYbDfhnYMIUjR961htAcHjEnYc2xFG3RNoeGSBg/Fbj5s7z
 O1XQTRXlNLow+QMPUyzojAvcknvqQoewz7uxSJvD3bY1WqsXmg2aoTgLAAUvdJisNb
 VczLu/Tf5597eo4QFqsw8F8MeOAO00pMwZhK1W2HdLMwAljPwxTTsx2XdHaF4jP45S
 iqW/fRtc3kq2rrJ5q/B66Q5J8/HXOOBRmd2g840vkUBQ/78OZXJhCgboWkrmW933lV
 2n0kEMYnlIEi4aCMv3p1A6ji1QM0vfnUSCEc0PgtMhGgrzoWEYEQsory6MHVIwVnTl
 wmOowQuhY+ayg==
Received: from [192.168.1.38] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4C2CF17E38D2;
 Tue, 12 May 2026 13:37:47 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 12 May 2026 13:37:41 +0200
Subject: [PATCH v2 11/11] drm/panthor: Process GPU events in IRQ context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-panthor-signal-from-irq-v2-11-95c614a739cb@collabora.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778585861; l=1950;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=eYNYQB3l+VBREhCd2wuUuP8KC+bGL7PL32BpwOYm1dU=;
 b=8euX/cJzU/5Metkp/Ucq0uYfwR8VcQTICfgHeqaXMe82p6jYtOMqzlfHCo+egzw4dFC+9+wAx
 Upe46X0y5JTAKFmqQGZQXF5xiahQqHBC1XrCzp74q3y24v5aeGm9I8T
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

The current panthor_gpu_irq_handler() logic is already IRQ-safe
(no sleep or sleeping locks, spinlocks taken with irqsave in other
contexts, etc), so let's toggle the switch and make it an hard IRQ
handler.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index b9c51f8a051d..04c8f23baf3f 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -86,10 +86,15 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 	gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
 }
 
-static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
+static irqreturn_t panthor_gpu_irq_raw_handler(int irq, void *data)
 {
+	struct panthor_irq *pirq = data;
 	struct panthor_device *ptdev = pirq->ptdev;
 	struct panthor_gpu *gpu = ptdev->gpu;
+	u32 status = gpu_read(gpu->irq.iomem, INT_STAT);
+
+	if (!status)
+		return IRQ_NONE;
 
 	gpu_write(gpu->irq.iomem, INT_CLEAR, status);
 
@@ -115,11 +120,8 @@ static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
 		ptdev->gpu->pending_reqs &= ~status;
 		wake_up_all(&ptdev->gpu->reqs_acked);
 	}
-}
 
-static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void *data)
-{
-	return panthor_irq_default_threaded_handler(data, panthor_gpu_irq_handler);
+	return IRQ_HANDLED;
 }
 
 /**
@@ -176,8 +178,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	ret = panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
 				  GPU_INTERRUPTS_MASK,
 				  ptdev->iomem + GPU_INT_BASE, "gpu",
-				  panthor_irq_default_raw_handler,
-				  panthor_gpu_irq_threaded_handler);
+				  panthor_gpu_irq_raw_handler, NULL);
 	if (ret)
 		return ret;
 

-- 
2.54.0

