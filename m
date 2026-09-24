Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34027C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C66A10F4C5;
	Thu, 24 Sep 2026 12:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="QCEeOxDS";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C12E10F4C2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790253053;
 bh=wzmzkZ9ZhUiQxGJYR6sBbhtS0oVJuIIFllbIo4vfYrk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QCEeOxDSE2B7OCvO5L02ujAM50SAvZC7Y5F7DDk8gXsSPVucgh1HpIoRuDFCKGy0b
 OTjLNiV80VThcZNAKesM3mmNsplnMe3vPzpXzP+P6Ny55v59gOr7Uk8I6nwQt8wtXK
 g3trkxc9mP0gx+y6FhYEtlF4zqLPJZpS+eBHPw363cTQ3STGKj+Ejg/Qo3XIlyQESn
 i8SoR6Ff5u68gMBTshTZ/U7IdJajP0utnPCMRYrKrpq3QT5dHH7N1hCYitu7RxCWje
 5cYjqZwLHUs9xHTgEB1P0akhdumvSc/I3Uyid6JX1SC2Ik8dq/r8WGvCgfaLAgR2c9
 Ez8qZvh4OtsQQ==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9DE2017E0A68;
 Thu, 24 Sep 2026 14:30:52 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 24 Sep 2026 14:30:43 +0200
Subject: [PATCH 1/3] drm/panthor: Don't invalidate OTHER caches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-panthor-mmu-fixes-v1-1-e25f9b106466@collabora.com>
References: <20260924-panthor-mmu-fixes-v1-0-e25f9b106466@collabora.com>
In-Reply-To: <20260924-panthor-mmu-fixes-v1-0-e25f9b106466@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Akash Goel <akash.goel@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790253051; l=1715;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=wzmzkZ9ZhUiQxGJYR6sBbhtS0oVJuIIFllbIo4vfYrk=;
 b=LcVX7O2aDqNbkbo6BkeZhxzvSHttYQtYb4Mtxw5SCYJzC8T+XeH5Wq8dZ0D0dAsKQFz3arQpx
 vG4qiknSJkbCcyVGcfO0yyH45jQSaIODcKpNOd7foJbSh07PSfF0d+k
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

Don't invalidate the OTHER caches (AKA L1 read-only caches) since
this seems to trip out the flush-elimination logic on v13, and it's not
needed in practice (can't leak other context data because of TLB
invalidation or corrupt physical pages returned to the system because
it's a RO cache).

It's also worth noting that the downstream driver has been avoid
OTHER caches invalidation from the start, and that we were doing
the same until atomic page table update was introduced.

Fixes: 6e2d3b3e8589 ("drm/panthor: Add support for atomic page table updates")
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 9f63a048df61..7e98084b9a1e 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -634,7 +634,7 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 
 	/* Flush+invalidate RW caches, invalidate RO ones. */
 	ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
-				       CACHE_CLEAN | CACHE_INV, CACHE_INV);
+				       CACHE_CLEAN | CACHE_INV, 0);
 	if (ret)
 		return ret;
 
@@ -1841,8 +1841,7 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
 		 * range is narrow enough and the HW supports it.
 		 */
 		ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
-					       CACHE_CLEAN | CACHE_INV,
-					       CACHE_INV);
+					       CACHE_CLEAN | CACHE_INV, 0);
 
 		/* Unlock the region if the flush is effective. */
 		if (!ret)

-- 
2.55.0

