Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A2ACDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BCDF10E33C;
	Fri, 26 Jun 2026 08:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="kaawmade";
	dkim-atps=neutral
X-Greylist: delayed 439 seconds by postgrey-1.36 at gabe;
 Fri, 26 Jun 2026 08:20:46 UTC
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C432610E33C
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:20:46 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782461605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hVXcUv9YI3BwSeys0voxuca3R/WAQc1fgr2LF5ndO3g=;
 b=kaawmade3x1ug1rVE5qqbPvBZWAIBodU6Fjm8n8NxVmwo9ovpQ4lG4uXRUAV6z141Ye0nj
 NDtMxXO4Nj51000giv8+GJddZdxUdehXIwDB5/dAgEKN7j2dBvjRWx+3zIjCd9IHtNvxiF
 uIbvte+HGDm7T5da44HkHtn+WH7e0VU=
From: hongfu.li@linux.dev
To: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, dev@lankhorst.se,
 mripard@kernel.org, natalie.vock@gmx.de
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Hongfu Li <hongfu.li@linux.dev>
Subject: [PATCH] cgroup/dmem: Use size_t for try_charge() and uncharge() size
Date: Fri, 26 Jun 2026 16:12:31 +0800
Message-ID: <20260626081231.47464-1-hongfu.li@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

From: Hongfu Li <hongfu.li@linux.dev>

The charge APIs currently accept the allocation size as u64, but every
caller passes a size_t value derived from drm_gem_object::size.
Using u64 is unnecessary and, on 32-bit architectures, may lead to
truncation when the value is later cast to unsigned long for internal
page_counter functions.

Change the public function signatures to take size_t instead of u64.
Inside the implementation, pass the size directly to
page_counter_try_charge() and page_counter_uncharge(), which already
expect unsigned long.

Signed-off-by: Hongfu Li <hongfu.li@linux.dev>
---
 include/linux/cgroup_dmem.h | 8 ++++----
 kernel/cgroup/dmem.c        | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index dd4869f1d736..ed7440eb9c28 100644
--- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -17,10 +17,10 @@ struct dmem_cgroup_region;
 #if IS_ENABLED(CONFIG_CGROUP_DMEM)
 struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size, const char *name_fmt, ...) __printf(2,3);
 void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region);
-int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
+int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, size_t size,
 			   struct dmem_cgroup_pool_state **ret_pool,
 			   struct dmem_cgroup_pool_state **ret_limit_pool);
-void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size);
+void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, size_t size);
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
 				      bool ignore_low, bool *ret_hit_low);
@@ -36,7 +36,7 @@ dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
 static inline void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region)
 { }
 
-static inline int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
+static inline int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, size_t size,
 					 struct dmem_cgroup_pool_state **ret_pool,
 					 struct dmem_cgroup_pool_state **ret_limit_pool)
 {
@@ -48,7 +48,7 @@ static inline int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64
 	return 0;
 }
 
-static inline void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size)
+static inline void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, size_t size)
 { }
 
 static inline
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 4753a67d0f0f..38108536d2d6 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -619,7 +619,7 @@ get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
  * Must be called with the returned pool as argument,
  * and same @index and @size.
  */
-void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size)
+void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, size_t size)
 {
 	if (!pool)
 		return;
@@ -649,7 +649,7 @@ EXPORT_SYMBOL_GPL(dmem_cgroup_uncharge);
  *
  * Return: 0 on success, -EAGAIN on hitting a limit, or a negative errno on failure.
  */
-int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
+int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, size_t size,
 			  struct dmem_cgroup_pool_state **ret_pool,
 			  struct dmem_cgroup_pool_state **ret_limit_pool)
 {
-- 
2.54.0

