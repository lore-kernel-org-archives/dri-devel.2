Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F30CDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A0A10F299;
	Thu, 25 Jun 2026 12:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WGv3oOvj";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A25B110E1FA
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782391233;
 bh=8FQRBaZNq7IzG4werkwkDR5b324eM5qckDb+vhtZ8WE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WGv3oOvjPl4+pGv86VWSNAy06OShKJewULyiIzOdtrbviROsKSMuBdqkN8PmrDsnF
 5XlVbsR4UkNseiFMqjEq8W2rX5sSs/z45H33EOHi6LA5mDllMSDNLzPBuct2rwiNGP
 MSCIUBCAR6vb2eXkWTYUwEMiILRD+qJ8KbEAKJsumviROOGhDxX2tZgKG0ozv5iEE7
 zDtU+fLUyQsI2RFcZeCW786JbTl3RKutk2dMZsedEQqRfLClmIIqCnk2zLL2NZ6L5y
 /v3R3ayBYbjj59NUzaRMSWD+V4QWkybs4UapY7SOXsaqukXYS48n0+OCT4tITCC5bh
 NFCHgNOSFCPOg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E2E6C17E10FC;
 Thu, 25 Jun 2026 14:40:32 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 14:40:31 +0200
Subject: [PATCH 05/11] drm/panthor: Fix theoretical IOMEM access in
 suspended state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-misc-fixes-v1-5-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
In-Reply-To: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782391229; l=2117;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=8FQRBaZNq7IzG4werkwkDR5b324eM5qckDb+vhtZ8WE=;
 b=EVeWGGQR6QubyOrJS4vjd67iiditdRBtHSEfX6Sjysc5BuDjkUl6G9YQo+VqEWwRHLkY0zygQ
 CLBebdN76jqCKxCf0MGEnCkrE+71PaqWBGl0ErCxtslsK/tzPVceZ7A
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

