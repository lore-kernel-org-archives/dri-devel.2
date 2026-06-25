Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805BACDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8493910F2A0;
	Thu, 25 Jun 2026 12:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FpOWn3Kf";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9429F10F29A
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782391235;
 bh=ByXPHeUxTLvHTIsy8GQMZTZezTDoNQPmI6yOuDE2RoQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FpOWn3KfrbGjxZbGWS2oGmL0NSno+rqDxWyAJE61i7Xd3F0jp8Tzl4ieNdqwTsKG6
 s8M8Jmk7FNf437jN5OqN1UZw8ZEbAOHCwB52lNffF8twbG4y/fDRjRLVtX+2FDeAcm
 PLA9eSCmLiiuZzhFOnfUF4OdJeMkpzgO3H07uzES5WlBOCqN120QsojrgqefuicLoO
 x2Z4ebPDOeDzqy+RjQVdiRho7W/MrTox4klAqh94z5KyF3ABCrQxUP/moHlJRA1Ptc
 nzx/c3oV/++lhVghUSyh3Vi/Lpr6/ILLNcYxsK0Ab2jzoyoSCpc0XIeY8EUbpc7gbi
 r8KlJB7U5zfdQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D714217E0C88;
 Thu, 25 Jun 2026 14:40:34 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 14:40:34 +0200
Subject: [PATCH 08/11] drm/panthor: Drop a needless check in
 panthor_fw_unplug()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-misc-fixes-v1-8-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
In-Reply-To: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782391229; l=921;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=ByXPHeUxTLvHTIsy8GQMZTZezTDoNQPmI6yOuDE2RoQ=;
 b=UWVnsI7K0mC9km3s9+c3xnOcLDs3gSmqkrcagWmkkCUQpQL5HGT3Z7z7YEB2lWTSI80Blhh1M
 Xwf/tx/Sg+UAahNgpwxWMtJp8ZdHPeRvJzAVtzZEywD2yr327746C3e
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

