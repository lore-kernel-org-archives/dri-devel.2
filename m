Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F0ACDE006
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D434110E18B;
	Thu, 25 Jun 2026 07:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GS0nTua5";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEEE610E18B
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782373113;
 bh=3Ft9dGdmUtcV/N1tEFG7N6nAk5JOgANkCn64VS1VOCw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=GS0nTua5gwZlvDiNZri+QGXgeXY++Md8gywDciKlcxJECBjTJlIlHM/gWsz/6IN4L
 aQezd9Bxh9Ut4MEhDsvVLI9gyQXmRttyU8EUKVfjQNIfdxiiyw8uV3a0E6w84B+Xsm
 pKO0aP3BknU0IONuOhMeT0xsYPdl1FDOAHJGWv/yZfftZ41aaiOIy3dS/HwEomXfPw
 5dyeIR9xp2w890eEFACMGKD46ina8D9Y0qYPU+QpAr9UwMktAwWrtHul5phLBerofc
 UGyg9u4R33tbJ5zI9gIAjIRYwVYQN9BxfVdBPXXjCS6YdNuxjSr52Lixao0of5KO5K
 H450WKszPiM2w==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C32ED17E052F;
 Thu, 25 Jun 2026 09:38:32 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 09:38:11 +0200
Subject: [PATCH v4 01/14] drm/panthor: Fix panthor_pwr_unplug()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-signal-from-irq-v4-1-3d2908912afa@collabora.com>
References: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
In-Reply-To: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782373111; l=1195;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=3Ft9dGdmUtcV/N1tEFG7N6nAk5JOgANkCn64VS1VOCw=;
 b=TvfuyW2ufPUGm8sLpkRdFmy0tteQNUn3cB3egEhl39yfJU20hBgSCtcLfli9+Az9Q32DcA1de
 VXfXf09HFtgCAOATcjKR5gWCONZOfL19zNRJrPLIP8ogV7oMRBEwq0O
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

We can't call panthor_pwr_irq_suspend() if the device is suspended,
or this leads to a hang when the IOMEM region is accessed while the
clks are disabled. Do what other sub-components do and conditionally
call panthor_pwr_irq_suspend() if we know the PWR regbank block is
accessible.

Fixes: c27787f2b77f ("drm/panthor: Introduce panthor_pwr API and power control framework")
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_pwr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 7c7f424a1436..090362bd700b 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -453,7 +453,8 @@ void panthor_pwr_unplug(struct panthor_device *ptdev)
 		return;
 
 	/* Make sure the IRQ handler is not running after that point. */
-	panthor_pwr_irq_suspend(&ptdev->pwr->irq);
+	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
+		panthor_pwr_irq_suspend(&ptdev->pwr->irq);
 
 	/* Wake-up all waiters. */
 	spin_lock_irqsave(&ptdev->pwr->reqs_lock, flags);

-- 
2.54.0

