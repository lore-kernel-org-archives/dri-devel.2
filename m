Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA7FC5CFE7
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C075E10EB2E;
	Tue, 11 Aug 2026 10:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dtUQK+it";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CE4A10E2B8
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786443472;
 bh=tdKa3iEPlj3pDEW5mojDJ07XRew8XsVzU/fp1UTnZ+s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dtUQK+it7DhezXywi/idifHHMdch9D1kdNpnve/7HTapPAyjxs0ZuXEWkS4gqqQzS
 DTd5wFio21QUfg6Lqx6cpLeAdRR+vetHdohVB68jIbZx6XdgOpYHNaGc6yW/I4YkIA
 uc63wNR5NvtnmGeMVmeA4pYWdefXBPgwrmsQSjVdcNfQahMWZggt0FeOgOWSicl06P
 +kjh9N4CkAf648oPhnd3nkYdpFFo26cXexs9/ayV4XMiPIUJ1+AnXtN9m35zGhwyDA
 gKUXPhjxxUhQ0buLG9k+yELkM4QTWlrNZtWXdLNxufR8rnGrHUMs5NhkOmxSf5BGGY
 Bd9au4tXfEMqA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B2BC17E107E;
 Tue, 11 Aug 2026 12:17:52 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 12:17:44 +0200
Subject: [PATCH v2 10/17] drm/panthor: Check AS state before disabling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-unplug-fixes-v2-10-6b583e37f9ae@collabora.com>
References: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
In-Reply-To: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443466; l=1813;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=tdKa3iEPlj3pDEW5mojDJ07XRew8XsVzU/fp1UTnZ+s=;
 b=DL0wv/KpUhTY11HUkSoSQ0lr6Ag4Jnb3mHCpc/YqeDKuHesr6CS4z6SUnJr2alm65cl2LvAuz
 dQF3rqYQboaDeOMk+YDY5WV7DRbn+W5fGt8qr8Mle8MX7I+ka4qeTHb
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

Use TRANSTAB == 0 as a way to detect if an AS slot is idle. This
allows us to make panthor_mmu_as_disable() a NOP when it's called
after a SOFT_RESET, which will be needed for our unplug rework.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 1b401fd0d2d7..a48466788f4d 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -634,6 +634,10 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 slot,
 
 	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
 
+	/* The AS was disabled already, nothing to do. */
+	if (!gpu_read64(mmu->iomem, AS_TRANSTAB(slot)))
+		return 0;
+
 	panthor_mmu_irq_disable_events(&ptdev->mmu->irq,
 				       panthor_mmu_as_fault_mask(ptdev, slot));
 
@@ -656,11 +660,17 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 slot,
 	if (recycle_slot)
 		return 0;
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(slot), 0);
-	gpu_write64(mmu->iomem, AS_MEMATTR(slot), 0);
 	gpu_write64(mmu->iomem, AS_TRANSCFG(slot), AS_TRANSCFG_ADRMODE_UNMAPPED);
+	ret = as_send_cmd_and_wait(ptdev, slot, AS_COMMAND_UPDATE);
+	if (ret)
+		return ret;
 
-	return as_send_cmd_and_wait(ptdev, slot, AS_COMMAND_UPDATE);
+	/* We reset the other fields late to ensure that, if something fails,
+	 * the page table is considered active (TRANSTAB != NULL).
+	 */
+	gpu_write64(mmu->iomem, AS_MEMATTR(slot), 0);
+	gpu_write64(mmu->iomem, AS_TRANSTAB(slot), 0);
+	return 0;
 }
 
 static u32 panthor_mmu_fault_mask(struct panthor_device *ptdev, u32 value)

-- 
2.55.0

