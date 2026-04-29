Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D959CCF9E3
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 09:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B9210EF1B;
	Wed, 29 Apr 2026 09:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="QAI7mA48";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D4210EEFE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777455539;
 bh=C6CmoxCJ94dFNPX2KUluUf+swmFBOWWsAAPz9g59ZmY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QAI7mA48RIceGm9SR24HZuL4X+8x8MzILC+GDxJrKoH1+qC5BPAZSAwGoG77i1ruX
 v92hmWq5x9foZQH+YjkjJoSdk7/zAaZLgsDh/9grRMO/uBPOoq9TjCpQvuKOZRN4bC
 QTvVB48Ui2cmgs0LK1ymlNnH2ogAtdVubEOeyGE7ouXZKx2vIBD77f3TOvpFgkbJ99
 9w/IsDSBOaljvPrw1HTf5mxKFPywNfsN6O1Zim784u2sBiTvKsIqKLobm++0JrCFm7
 lkfFMtqTOD2Yo5bVQyTqsFveIpA3s3BO96HL4WzexRKyDm8rsakY8Rv/GIvX6nEwTI
 oyIcoc9902HNw==
Received: from [100.64.0.11] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 38FC517E1582;
 Wed, 29 Apr 2026 11:38:59 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 29 Apr 2026 11:38:36 +0200
Subject: [PATCH 09/10] drm/panthor: Process FW events in IRQ context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-panthor-signal-from-irq-v1-9-4b92ae4142d2@collabora.com>
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
In-Reply-To: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777455534; l=2131;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=C6CmoxCJ94dFNPX2KUluUf+swmFBOWWsAAPz9g59ZmY=;
 b=vFDJN0g5xeVGO1Uc0HjlfFTk1xdt/8x7z4Vur+kCVMWc7Ca7BcYNRy/NpNXv9lH/A/r+GS8fx
 jO2l5UJD8sgCPrQQRXIXQR2hfB3v1tkPEOyvGxG2kfk1PjySM57BGyB
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
 drivers/gpu/drm/panthor/panthor_fw.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index f5e0ceca4130..05c632913359 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1087,9 +1087,38 @@ static void panthor_job_irq_handler(struct panthor_irq *pirq, u32 status)
 	}
 }
 
+static irqreturn_t panthor_job_irq_raw_handler(int irq, void *data)
+{
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
+	panthor_job_irq_handler(pirq, gpu_read(pirq->iomem, INT_RAWSTAT));
+
+	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
+		if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING)
+			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *data)
 {
-	return panthor_irq_default_threaded_handler(data, panthor_job_irq_handler);
+	struct panthor_irq *pirq = data;
+
+	/* We never return IRQ_WAKE_THREAD, so we're not supposed to be called. */
+	drm_WARN_ON_ONCE(&pirq->ptdev->base,
+			 "threaded IRQ handler should never be called.");
+	return IRQ_NONE;
 }
 
 static int panthor_fw_start(struct panthor_device *ptdev)
@@ -1489,7 +1518,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
 
 	ret = panthor_irq_request(ptdev, &fw->irq, irq, 0,
 				  ptdev->iomem + JOB_INT_BASE, "job",
-				  panthor_irq_default_raw_handler,
+				  panthor_job_irq_raw_handler,
 				  panthor_job_irq_threaded_handler);
 	if (ret) {
 		drm_err(&ptdev->base, "failed to request job irq");

-- 
2.53.0

