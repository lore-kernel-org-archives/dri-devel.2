Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BC6CA5FE5
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7851610E032;
	Fri,  2 Oct 2026 20:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="dud9nePJ";
	dkim-atps=neutral
Received: from smtpout4.mo538.mail-out.ovh.net
 (smtpout4.mo538.mail-out.ovh.net [51.210.91.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7AAB10E032
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 20:00:21 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hxKQC1CkHz6F5n;
 Fri,  2 Oct 2026 20:00:19 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <arunpravin.paneerselvam@amd.com>; Fri,  2 Oct 2026 20:00:18 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.118.90])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hxKQB6NbQz46XP; Fri,  2 Oct 2026 20:00:18 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.8])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 34A173E184A; 
 Fri,  2 Oct 2026 20:00:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005c3293042-4979-4507-bac1-2336cc359ec3,
 DC8B761EC6BD655BE6CB70D306B6091D09A22BEC) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
From: Natalie Vock <nat@pixelcluster.dev>
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ttm: Cut down overly verbose comments
Date: Fri,  2 Oct 2026 21:59:52 +0200
Message-ID: <20261002195952.18218-1-nat@pixelcluster.dev>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 959829674105987354
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEDQet6Ra/ynbDAiZxuGlqROqzhy7n2s5iQVsJq2Oewn+8tnWl1Eh55TCq4Vw36cpD+URcfQ2GMm6WJLikVpgGNbN3XSNNq7x/BWafM1+XAyWo3DqQkrBz/tLoVv7yzBGVxAihyiMwnsY5ayhmiydvy23GtM8KCv4vL0i2Scos0nvFLMis9k/AoDjGECEEqzWycmC6Dn/O1QNSKk4RkuE+kxQ9+/tdtJjbYjVbRKa4sGPP6zrLXNZ7xwRVmZTVUJ4/HtOCwHTeeGkNdM6X5DPhkr7A1VTUAKhF/GdWRZLs3V8kSR75GDVgoQbVOa1OmoplHvPYQuQuleSWTj8kj3lRhUcM6kqdz76//I4LnRVaqSJcZmeN65nBfHmXvijoBg7PWuJYS/grktGHByjDbNzQIDzOX1HDOzEywpHwm3allrf5gV+57rwEu757PogehJ59So3di7jjd6MGa1skN765AR+imjrWVcPDb1MmmKex6VlE3TE7HBOPQOwhh7HXJCjJ98TTyBmtOu4Akwy9wD8u/Q8deVvh9JLHpimPqQxyXvBLKrz+wAeH6fWP8ONauQbIKANujv/ydblD1FJ1ubcErpKFH4eLD88+oFCascoPSIkkoWmz+ZD6VaG3Ml1xCrifNOX/NrlBk1LK5LlIEgnD97tgTbRbpBzcaDqaq4g+3ug
DKIM-Signature: a=rsa-sha256; bh=aRwEpQexPywT6Rw/GTJWo+3nclDFaQKXuDGqCiCyIQ0=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1790971219; v=1;
 b=dud9nePJOpgcN+ZPTUrr4tCF7SjJfCLhVjElBjwTVyKYfVVHg2uCkvvX6LlKbcDE1HDUZMsW
 aLVxLON3Fwb2+bIc4wF5vafRQVULxu8JnLxCFt+3ftkKbHQgjdv8HtpxAQ4e/wKX9M6oqjISZWf
 mA3zuuOEjebKtYn+ZsavXWIuA0oYeNJYR/9sBKr3M0yb30G9WA+vWNFmJ4dCzDd9EoiVOusX6nZ
 YsW3IyQsFqAZVyUF4adv46Cs51vu2g5skjXigylPZEZumi6rsKtvwnsWWYxSDOxEPrYZxW6drwN
 oEhmEhZsKRC4xKuT4pV4wW+unIScsE3cugPQ+++xPe7Zg==
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

There's no need to explain every background detail behind the
implementation, and the excessive verbosity makes it almost a bit
annoying to read through.

Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---

I remember that there was some confusion about what the exact cgroup
semantics were and how they interacted with TTM, and I think I might've
gone this overboard with documenting literally everything in comments as
a misguided attempt to remove that confusion.

These comments even ended up sounding almost exactly like LLM slop, down
to details like phrasing and excessive use of dashes. That's somewhere
between impressive and disheartening if you consider that I actually
wrote every word in these comments by hand. Either way, even though it
wasn't generated by an LLM this time, the slop should still go.

---
 drivers/gpu/drm/ttm/ttm_bo.c | 56 +++++-------------------------------
 1 file changed, 7 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 53c68e29ebc21..8f1b1981dd43f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -532,14 +532,6 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
 					      force_space ? &alloc_state->limit_pool
 							  : NULL);
 		if (ret) {
-			/*
-			 * -EAGAIN means the charge failed, which we treat
-			 * like an allocation failure. Therefore, return an
-			 * error code indicating the allocation failed -
-			 * either -EBUSY if the allocation should be
-			 * retried with eviction, or -ENOSPC if there should
-			 * be no second attempt.
-			 */
 			if (!alloc_state->in_evict)
 				alloc_state->may_try_low = may_evict;
 			if (ret == -EAGAIN)
@@ -549,33 +541,9 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
 	}
 
 	/*
-	 * cgroup protection plays a special role in eviction.
-	 * Conceptually, protection of memory via the dmem cgroup controller
-	 * entitles the protected cgroup to use a certain amount of memory.
-	 * There are two types of protection - the 'low' limit is a
-	 * "best-effort" protection, whereas the 'min' limit provides a hard
-	 * guarantee that memory within the cgroup's allowance will not be
-	 * evicted under any circumstance.
-	 *
-	 * To faithfully model this concept in TTM, we also need to take cgroup
-	 * protection into account when allocating. When allocation in one
-	 * place fails, TTM will default to trying other places first before
-	 * evicting.
-	 * If the allocation is covered by dmem cgroup protection, however,
-	 * this prevents the allocation from using the memory it is "entitled"
-	 * to. To make sure unprotected allocations cannot push new protected
-	 * allocations out of places they are "entitled" to use, we should
-	 * evict buffers not covered by any cgroup protection, if this
-	 * allocation is covered by cgroup protection.
-	 *
-	 * Buffers covered by 'min' protection are a special case - the 'min'
-	 * limit is a stronger guarantee than 'low', and thus buffers protected
-	 * by 'low' but not 'min' should also be considered for eviction.
-	 * Buffers protected by 'min' will never be considered for eviction
-	 * anyway, so the regular eviction path should be triggered here.
-	 * Buffers protected by 'low' but not 'min' will take a special
-	 * eviction path that only evicts buffers covered by neither 'low' or
-	 * 'min' protections.
+	 * If allocation fails and we back off to some other domain, that's technically a kind
+	 * of eviction happening, so try harder to evict something if cgroup protections are
+	 * supposed to prevent evictions.
 	 */
 	if (!alloc_state->in_evict) {
 		may_evict |= dmem_cgroup_below_min(NULL, alloc_state->charge_pool);
@@ -634,28 +602,18 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
 
 	/*
 	 * If may_try_low is not set, then we're trying to evict unprotected
-	 * buffers in favor of a protected allocation for charge_pool. Explicitly skip
-	 * buffers belonging to the same cgroup here - that cgroup is definitely protected,
-	 * even though dmem_cgroup_state_evict_valuable would allow the eviction because a
-	 * cgroup is always allowed to evict from itself even if it is protected.
+	 * buffers in favor of a protected allocation for charge_pool, so evicting
+	 * from charge_pool itself makes no sense.
 	 */
 	if (!evict_walk->alloc_state->may_try_low &&
 			bo->resource->css == evict_walk->alloc_state->charge_pool)
 		return 0;
 
 	limit_pool = evict_walk->alloc_state->limit_pool;
+
 	/*
 	 * If there is no explicit limit pool, find the root of the shared subtree between
-	 * evictor and evictee. This is important so that recursive protection rules can
-	 * apply properly: Recursive protection distributes cgroup protection afforded
-	 * to a parent cgroup but not used explicitly by a child cgroup between all child
-	 * cgroups (see docs of effective_protection in mm/page_counter.c). However, when
-	 * direct siblings compete for memory, siblings that were explicitly protected
-	 * should get prioritized over siblings that weren't. This only happens correctly
-	 * when the root of the shared subtree is passed to
-	 * dmem_cgroup_state_evict_valuable. Otherwise, the effective-protection
-	 * calculation cannot distinguish direct siblings from unrelated subtrees and the
-	 * calculated protection ends up wrong.
+	 * evictor and evictee so cgroup recursive protection semantics apply properly.
 	 */
 	if (!limit_pool) {
 		ancestor = dmem_cgroup_get_common_ancestor(bo->resource->css,
-- 
2.55.0

