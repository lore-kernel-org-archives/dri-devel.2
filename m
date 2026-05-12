Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2058CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607AD10EA55;
	Tue, 12 May 2026 11:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LmqGYnrO";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8F010EA4C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778585867;
 bh=ykUgxo1kVcXSmPq13GWg/bbbz+Lg65xpoeO48LwbdwY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=LmqGYnrO9ZrcvMPxyt6O8tKN+TL9o8y1m6cnPlo/t1ZZDuS1mrGS38gu3cO1jTQY/
 18vNE7GPIW+UP8LhBl7yf5pfaE2hOA3sKytAlmIjVTEkeD5pFLG/11n4wUAP0HWNBZ
 B1onTTUVAs6t1ad33IhgpQphjcjEZPtiGsMPDTe6FRnGhILbMyraMbYyz2lA1A4X6t
 l2FDV0B0W3EAp1x2vagTrvlt5V1XSNUCNQACDDoAl85+1dpn+/uJgafNE021D6pcr6
 SnDlIKBg/zfY1xkcXMNRDQQJOmJSTkYiF+iLFn3mr7F1IB3VAchvbhgD7w/j/XZXlX
 CdWJmaTsHAA3g==
Received: from [192.168.1.38] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BC48817E38D1;
 Tue, 12 May 2026 13:37:46 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 12 May 2026 13:37:40 +0200
Subject: [PATCH v2 10/11] drm/panthor: Use the irqsave variant of spin_lock
 in panthor_gpu_irq_handler()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-panthor-signal-from-irq-v2-10-95c614a739cb@collabora.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778585861; l=1477;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=ykUgxo1kVcXSmPq13GWg/bbbz+Lg65xpoeO48LwbdwY=;
 b=Z7IC50GcDmkSA+6GtADkgYz1pW7Yc/LrUVVgAdrSldlJVbbBYOYZnMev6RG62bKoY0H/Scn3Q
 d2dMwqjS7//D78zQhOIv/BNf3LVoRQpwLfaTWjwd0dMzGuM0HAO6bzI
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

This is not a bug per-se, because this lock is never taken in an
interrupt context, but it's not consistent with the other users of this
lock. We're also planning on transitioning GPU event processing to
a hard handler. Again, this alone wouldn't justify using the IRQ-safe
variant, because then this _lock/unlock sequence would be in the
hard-IRQ path, where IRQs are already disabled, but let's do it anyway,
to keep things consistent.

While at it, transition to a guard() instead of a plain lock/unlock
sequence.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index d0be758ea3e1..b9c51f8a051d 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -110,12 +110,11 @@ static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
 	if (status & GPU_IRQ_PROTM_FAULT)
 		drm_warn(&ptdev->base, "GPU Fault in protected mode\n");
 
-	spin_lock(&ptdev->gpu->reqs_lock);
+	guard(spinlock_irqsave)(&ptdev->gpu->reqs_lock);
 	if (status & ptdev->gpu->pending_reqs) {
 		ptdev->gpu->pending_reqs &= ~status;
 		wake_up_all(&ptdev->gpu->reqs_acked);
 	}
-	spin_unlock(&ptdev->gpu->reqs_lock);
 }
 
 static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void *data)

-- 
2.54.0

