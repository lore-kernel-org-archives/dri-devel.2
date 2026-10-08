Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9B1CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 11:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E9F10E7EB;
	Thu,  8 Oct 2026 11:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LW+GAElv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48BE210E7EB
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 11:56:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E419B41979;
 Thu,  8 Oct 2026 11:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA191C2BCF5;
 Thu,  8 Oct 2026 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791460571;
 bh=G6ARnNTARObbrTT7DPV97sjeI/BJutADNZnC5X5vdSc=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=LW+GAElvEGV9qBbBG/cvw3QlPrf8V7jQfBn9p/zK1LtGQBmeooSbzRABjpRs96+wh
 7bKb3YkgpeQEk6W32lk3M5tDwt44BeCTtLaKmoWzmqwfvo434zfr2YHuczZMnX7JIE
 4jBCPn+8gAUiMoTMOvYb4nqMPLwWKLN/ESj9e1nn7l9WABhesHQe2J3Eh7WqJxxFhG
 gy84xZmvellfuh9OsErXPFwxekg6rkMpUYHi06TbNp7uMOaVL07ROOzUP+pgMxtQ00
 hskdX2U8bhozonb4jgldpDYVBk1inKplBqOMTpnEKQzOkkLClDO6NNhn3FlogBaTJ+
 kDvJeOgn6dY0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 961E2CA6007;
 Thu,  8 Oct 2026 11:56:11 +0000 (UTC)
From: Lucas Frendorf via B4 Relay <devnull+lucasfrendorf.proton.me@kernel.org>
Date: Thu, 08 Oct 2026 13:55:20 +0200
Subject: [PATCH RESEND] drm/ttm: Skip GPU MM stats for DMA-allocated pool pages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ttm-gpu-stats-dma-v1-1-8660b659fe52@proton.me>
To: Arun Pravin <arunpravin.paneerselvam@amd.com>, 
 Natalie Vock <nat@pixelcluster.dev>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Christian Koenig <christian.koenig@amd.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 linux-kernel@vger.kernel.org, Matthew Auld <matthew.auld@intel.com>, 
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791460570; l=3732;
 i=lucasfrendorf@proton.me; s=20261008; h=from:subject:message-id;
 bh=hyaFv4vc1TDrPFFu8kZEtFpbp4jfnGBU2CeqvxC7h3U=;
 b=yn2Z9plYH7C+tt+85/t2791dD127a4PIX7UwSbGVY6GZij4lE0Le1s7UCgposXfKR6RBzT98o
 FySL0XcrJFAAhi+4K6w+vnA189H0S3CtH43QD+G3utJImcPl94iAFzN
X-Developer-Key: i=lucasfrendorf@proton.me; a=ed25519;
 pk=v8K8GS0xRvfhhVxjq0t7VICeqma8piHxgNSzSM4Uytg=
X-Endpoint-Received: by B4 Relay for lucasfrendorf@proton.me/20261008 with
 auth_id=1129
X-Original-From: Lucas Frendorf <lucasfrendorf@proton.me>
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
Reply-To: lucasfrendorf@proton.me
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Lucas Frendorf <lucasfrendorf@proton.me>

ttm_pool_alloc_page() and ttm_pool_free_page() account NR_GPU_ACTIVE
and NR_GPU_RECLAIM only for pages from the page allocator, but
ttm_pool_type_give() and ttm_pool_type_take() update them for every
page. Each DMA-allocated page that is given to a pool and later freed
from it therefore leaves NR_GPU_RECLAIM incremented and NR_GPU_ACTIVE
decremented.

DMA-allocating pools are used by amdgpu, radeon and nouveau when
drm_need_swiotlb() is true, and by vmwgfx in coherent mode. On an
amdgpu Rembrandt APU, GPUReclaim reached 20 GiB on a 30.6 GiB machine
after 2 days while the pool held 34 MiB, and GPUActive read 0 kB.

The imbalance was found with LLM assistance while investigating a
memory monitor that reported 95% use.

The allocation and free paths do not account DMA API memory. Skip the
give and take accounting for DMA-allocating pools as well.

Fixes: ae80122f3896 ("drm/ttm: use gpu mm stats to track gpu memory allocations. (v4)")
Link: https://github.com/AvengeMedia/dgop/issues/44
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Lucas Frendorf <lucasfrendorf@proton.me>
---
I noticed dgop, a memory monitor, reported 95% usage. An LLM found the
cause in the GPUReclaim accounting, wrote this patch and drafted its
changelog, which I reviewed and revised.

To reproduce, compare GPUReclaim in /proc/meminfo with the page total
in /sys/kernel/debug/dri/<pci-id>/ttm_page_pool on a device with a
DMA-allocating pool.

Tested on v7.2.9 with the patched ttm.ko: GPUReclaim stayed at 0 kB
through a glmark2 run on the 680M while its DMA pool held 298 MiB. The
RX 6800S, which uses the non-DMA pools, still raised and lowered
GPUReclaim normally. The patch builds with W=1 on v7.3-rc6.

Dave Airlie's memcg series (part 2 v2, patch 05/10) rewrites both
hunks and would need the same check.
---
 drivers/gpu/drm/ttm/ttm_pool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 1bf37023f..1f2d31c3e 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -341,8 +341,10 @@ static void ttm_pool_type_give(struct ttm_pool_type *pt, struct page *p)
 	rcu_read_unlock();
 
 	atomic_long_add(num_pages, &allocated_pages[nid]);
-	mod_lruvec_page_state(p, NR_GPU_ACTIVE, -num_pages);
-	mod_lruvec_page_state(p, NR_GPU_RECLAIM, num_pages);
+	if (!pt->pool || !ttm_pool_uses_dma_alloc(pt->pool)) {
+		mod_lruvec_page_state(p, NR_GPU_ACTIVE, -num_pages);
+		mod_lruvec_page_state(p, NR_GPU_RECLAIM, num_pages);
+	}
 }
 
 static enum lru_status take_one_from_lru(struct list_head *item,
@@ -367,8 +369,10 @@ static struct page *ttm_pool_type_take(struct ttm_pool_type *pt, int nid)
 	ret = list_lru_walk_node(&pt->pages, nid, take_one_from_lru, (void *)&p, &nr_to_walk);
 	if (ret == 1 && p) {
 		atomic_long_sub(1 << pt->order, &allocated_pages[nid]);
-		mod_lruvec_page_state(p, NR_GPU_ACTIVE, (1 << pt->order));
-		mod_lruvec_page_state(p, NR_GPU_RECLAIM, -(1 << pt->order));
+		if (!pt->pool || !ttm_pool_uses_dma_alloc(pt->pool)) {
+			mod_lruvec_page_state(p, NR_GPU_ACTIVE, (1 << pt->order));
+			mod_lruvec_page_state(p, NR_GPU_RECLAIM, -(1 << pt->order));
+		}
 	}
 	return p;
 }

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261008-ttm-gpu-stats-dma-9fc5e952a45b

Best regards,
--
Lucas Frendorf <lucasfrendorf@proton.me>
-- 
Lucas Frendorf <lucasfrendorf@proton.me>


