Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D18E7E350
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2105D10F43A;
	Fri,  3 Apr 2026 08:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=dancol.org header.i=@dancol.org header.b="Y7/BUZ6o";
	dkim-atps=neutral
X-Greylist: delayed 2149 seconds by postgrey-1.36 at gabe;
 Wed, 01 Apr 2026 02:44:51 UTC
Received: from dancol.org (dancol.org [96.126.100.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7F010EB50;
 Wed,  1 Apr 2026 02:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dancol.org; 
 s=x;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:To:From; 
 bh=9e7RQVAOjBjxxSPR5no5ag7Pa/vfgF7hX1+alac3HRQ=; b=Y7/BUZ6oXyUCgFlffwjsTLvwlO
 PT2u6prSXUcZwEW3T+FyXiA8impPgouWhBx9nIRHyUAAmKjH5MWViqsQuxqFUVMDSEA9YypkdCorK
 4BEIhoLCWMaOiFh20h2LT+FY2IEI1JV2wZwQ3cbcC98K9l04mtF/KpBbQKrp0uC0AZleW0htDlFKe
 qSjd5dZ/3zmJvCrbDR4AmqQ+g7UR9WiaWE0iUPascAlx0f2CuDlPlFgTUGCFxRz+i/jD8TGu/PmGW
 T1dN28EU61m8a00QM1pr1OQ20toeeudePcWQwI4wGBKwjdllE/AQmNXVDG+GQIqUtsK6lik+KDJ+U
 FlD8y7ag==;
Received: from 2603-900b-c400-2854-4cc1-9500-c07a-5906.inf6.spectrum.com
 ([2603:900b:c400:2854:4cc1:9500:c07a:5906]:58092 helo=localhost)
 by dancol.org with utf8esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <dancol@dancol.org>) id 1w7l0u-00000001Nk7-0VLT;
 Tue, 31 Mar 2026 22:09:00 -0400
From: Daniel Colascione <dancol@dancol.org>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Limit reclaim to avoid TTM desktop stutter under mem
 pressure
User-Agent: mu4e 1.14.0-pre1; emacs 31.0.50
Date: Tue, 31 Mar 2026 22:08:58 -0400
Message-ID: <87341fsa85.fsf@dancol.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

TTM seems to be too eager to kick off reclaim while kwin is drawing

I've noticed that in 7.0-rc6, and since at least 6.17, kwin_wayland
stalls in DRM ioctls to xe when the system is under memory pressure,
causing missed frames, cursor-movement stutter, and general
sluggishness. The root cause seems to be synchronous and asynchronous
reclaim in ttm_pool_alloc_page as TTM tries, and fails, to allocate
progressively lower-order pages in response to pool-cache misses when
allocating graphics buffers.

Memory is fragmented enough that the compaction fails (as I can see in
compact_fail and compact_stall in /proc/vmstat; extfrag says the normal
pool is unusable for large allocations too). Additionally, compaction
seems to be emptying the ttm pool, since page_pool in TTM debugfs
reports all the buckets are empty while I'm seeing the
kwin_wayland sluggishness.

In profiles, I see time dominated by copy_pages and clear_pages in the
TTM paging code. kswapd runs constantly despite the system as a whole
having plenty of free memory.

I can reproduce the problem on my 32GB-RAM X1C Gen 13 by booting with
kernelcore=8G (not needed, but makes the repro happen sooner), running a
find / >/dev/null (to fragment memory), and doing general web
browsing. The stalls seem self-perpetuating once it gets started; it
persists even after killing the find. I've noticed this stall in
ordinary use too, even without the kernelcore= zone tweak, but without
kernelcore, it usually takes a while (hours?) after boot for memory to
become fragmented enough that higher-order allocations fail.

The patch below fixes the issue for me. TBC, I'm not sure it's the
_right_ fix, but it works for me. I'm guessing that even if the approach
is right, a new module parameter isn't warranted.

With the patch below, when I set my new max_reclaim_order ttm module
parameter to zero, the kwin_wayland stalls under memory pressure
stop. (TBC, this setting inhibits sync or async reclaim except for
order-zero pages.)  TTM allocation occurs in latency-critical paths
(e.g. Wayland frame commit): do you think we _should_ reclaim here?

BTW, I also tried having xe pass a beneficial order of 9, but it didn't
help: we end up doing a lot of compaction work below this order anyway.

Signed-off-by: Daniel Colascione <dancol@dancol.org>

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index c0d95559197c..fd255914c0d3 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -115,9 +115,13 @@ struct ttm_pool_tt_restore {
 };
 
 static unsigned long page_pool_size;
+static unsigned int max_reclaim_order;
 
 MODULE_PARM_DESC(page_pool_size, "Number of pages in the WC/UC/DMA pool");
 module_param(page_pool_size, ulong, 0644);
+MODULE_PARM_DESC(max_reclaim_order,
+                "Maximum order that keeps upstream reclaim behavior");
+module_param(max_reclaim_order, uint, 0644);
 
 static atomic_long_t allocated_pages;
 
@@ -146,16 +150,14 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
         * Mapping pages directly into an userspace process and calling
         * put_page() on a TTM allocated page is illegal.
         */
-       if (order)
+       if (order) {
                gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
                        __GFP_THISNODE;
-
-       /*
-        * Do not add latency to the allocation path for allocations orders
-        * device tolds us do not bring them additional performance gains.
-        */
-       if (beneficial_order && order > beneficial_order)
-               gfp_flags &= ~__GFP_DIRECT_RECLAIM;
+               if (beneficial_order && order > beneficial_order)
+                       gfp_flags &= ~__GFP_DIRECT_RECLAIM;
+               if (order > max_reclaim_order)
+                       gfp_flags &= ~__GFP_RECLAIM;
+       }
 
        if (!ttm_pool_uses_dma_alloc(pool)) {
                p = alloc_pages_node(pool->nid, gfp_flags, order);
