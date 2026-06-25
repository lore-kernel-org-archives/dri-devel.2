Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A245BCDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D335410E1B2;
	Thu, 25 Jun 2026 09:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="AA8eF3iv";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 147AA10E1B2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782380188;
 bh=8FQRBaZNq7IzG4werkwkDR5b324eM5qckDb+vhtZ8WE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AA8eF3ivG97fcw+euLbVW4MBp7VMW/Kv3YmNTekwoEUXRdh3ZjZvO/d+8/i0026jB
 2yXArz3OPH+BxUeCXr3rXGF5I9bZ/oOH10LG+z1xOB+dNJFPZMIZDPfOEVvmkfs3Ij
 Q2l9jVjjPvHgsiPO7qLcLkxnfsIoAuLbCx/O1vWCF2Qfg91bcc4eHM535ldFn2djKq
 uzRtRppUEARD6aV5xc6aL2un0p+20o7gv2hYpkf9MI581+92lPKXOkFkKxz/mth2/7
 9wW7/bwlVKUZJWPTHA1N13dQ1dc4RxsQnpgUeHBppQfdSabHMEKbruLr9a+CARftrk
 88NqpEQeYGi9Q==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 31F2C17E00FD;
 Thu, 25 Jun 2026 11:36:28 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 11:36:16 +0200
Subject: [PATCH v5 01/16] drm/panthor: Fix theoretical IOMEM access in
 suspended state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-signal-from-irq-v5-1-8836a74e0ef9@collabora.com>
References: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
In-Reply-To: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782380187; l=2117;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=8FQRBaZNq7IzG4werkwkDR5b324eM5qckDb+vhtZ8WE=;
 b=a/wSkEogPudvX+JypNFdmwREigFFExylHCfeqYggUyf5SJQcU3rB7QuTxk4FxFXpfAX3SYFML
 oFNEvSAc4vADDVbNaJIRz7C5xZNQ3Il1wAc83nsw+6OFDei6MWAR5No
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

In theory, our hardirq handler can be called while the device (and
thus the panthor_irq) is suspended, because the IRQ line is shared.
In practice though, in all the designs we've seen, the line is only
shared within the GPU, and because sub-component suspend state is
consistent (all-suspended or all-resumed), we shouldn't end up with
an interrupt triggered while we're suspended.

Fix the problem anyway, if nothing else, for our sanity.

Fixes: 0b2d86670a84 ("drm/panthor: Rework panthor_irq::suspended into panthor_irq::state")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com?part=1
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 35679bfa1f3a..a39386bd6382 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -512,9 +512,6 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
 	struct panthor_irq *pirq = data;							\
 	enum panthor_irq_state old_state;							\
 												\
-	if (!gpu_read(pirq->iomem, INT_STAT))							\
-		return IRQ_NONE;								\
-												\
 	guard(spinlock_irqsave)(&pirq->mask_lock);						\
 	old_state = atomic_cmpxchg(&pirq->state,						\
 				   PANTHOR_IRQ_STATE_ACTIVE,					\
@@ -522,6 +519,13 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
 	if (old_state != PANTHOR_IRQ_STATE_ACTIVE)						\
 		return IRQ_NONE;								\
 												\
+	if (!gpu_read(pirq->iomem, INT_STAT)) {							\
+		atomic_cmpxchg(&pirq->state,							\
+			       PANTHOR_IRQ_STATE_PROCESSING,					\
+			       PANTHOR_IRQ_STATE_ACTIVE);					\
+		return IRQ_NONE;								\
+	}											\
+												\
 	gpu_write(pirq->iomem, INT_MASK, 0);							\
 	return IRQ_WAKE_THREAD;									\
 }												\

-- 
2.54.0

