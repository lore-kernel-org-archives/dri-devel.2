Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473D1CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E5310F1E3;
	Thu, 25 Jun 2026 09:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Mpb1V3jb";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B5310E1B8
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782380190;
 bh=ByXPHeUxTLvHTIsy8GQMZTZezTDoNQPmI6yOuDE2RoQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Mpb1V3jbOBw9iwXXQYpPI4zpsoNXQtwKkNCjp6Gz53SCuMD6TDWr7xQoSvAGvToSF
 jLPuS4eqrvbEeR1c3yF4AGWs0ue9VP9iLXOl8oTaq/DO8rornGe14nzenynR/Bc7jn
 NFwSRgtp7HqbDRi6EetAoIzC7D2KaudHAfbYovNFX5F9u9HxGisSFuvC79UslQmMHC
 7gfWb3iY+PLTxkQ1ILFqlTCsGgqhSMNqt8NzCQ60KlU69BLkB5IbnBIzaZSQxLPPJb
 r35v6clPbfprHyKQA1GKoqEvCi8thdN/z+GF7lv9fpbePJWbxkXdQFGEU11l6zmG0C
 jBmp/sJoOVCxw==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EF54417E120F;
 Thu, 25 Jun 2026 11:36:29 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 11:36:19 +0200
Subject: [PATCH v5 04/16] drm/panthor: Drop a needless check in
 panthor_fw_unplug()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-signal-from-irq-v5-4-8836a74e0ef9@collabora.com>
References: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
In-Reply-To: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782380187; l=921;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=ByXPHeUxTLvHTIsy8GQMZTZezTDoNQPmI6yOuDE2RoQ=;
 b=ffNf38kgNgrTRPSe5weRrAPcC7ScFUqT97hSXWRPSiWoDaFTG6m1dVTZUKA3LM44xPGccSIuE
 5wDF0C8/8sZBfh6VpZnY7wbaThUaJFNy6kO2txP6HnX36wXQExClqKp
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

panthor_fw_unplug() is only called if we at least managed to initialize
the IRQ, so it's safe to drop the "is IRQ initialized" check.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 986151681b24..4fbddb9e18c8 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1279,9 +1279,7 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
 
 	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev)) {
 		/* Make sure the IRQ handler cannot be called after that point. */
-		if (ptdev->fw->irq.irq)
-			panthor_job_irq_suspend(&ptdev->fw->irq);
-
+		panthor_job_irq_suspend(&ptdev->fw->irq);
 		panthor_fw_stop(ptdev);
 	}
 

-- 
2.54.0

