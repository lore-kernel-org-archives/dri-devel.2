Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD644FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2916B10EA24;
	Tue, 28 Apr 2026 07:31:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W4HvSzy9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC62010EA24;
 Tue, 28 Apr 2026 07:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777361513; x=1808897513;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xglVrOoG47NkSF6SOaAIKSNjwEuZJu1bGAlwDUSuOWU=;
 b=W4HvSzy9yIdMUUJxgRb+rz3rNYidL+yIQGprtEXjnK4Y8+BUybBwVFtg
 /orSuSeiQ6Sn756JQ+X+9EUdFQJvzr1yfFHC92U7OYLe8kYnHIP4D5v5n
 tFIzGKegozQUZYnbW7M7Xnqf2cRqPTpDXHA5Bsi1x8MlW/72WkvUX8xPi
 WqgFBH+09g3uAwpU/Im803gDAurKShXbH+79/8TWRGiuoXs2iGtXcRjFB
 0Thm3iMwxE9mP0z0UhVpIZSedxOeh2tKypcE1IMrgArohkcBmbBzq3Cpb
 32+aWNlovf5rNwB4RpwWSUzU9HNpGp1RcUxeH5AK8CpOQypBnHKEN6BAA g==;
X-CSE-ConnectionGUID: MI0c/iG3RtSKFroqNQ14jg==
X-CSE-MsgGUID: 5p8a5uX8Tdmj66Iwczm35Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="103722062"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="103722062"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:31:53 -0700
X-CSE-ConnectionGUID: NXBGumxGRbmzOGFjDeSCWQ==
X-CSE-MsgGUID: ViuuTdp6QFe705CMU9VqiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="230716284"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora)
 ([10.245.244.161])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:31:48 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>,
 =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
Date: Tue, 28 Apr 2026 09:31:13 +0200
Message-ID: <20260428073116.15687-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428073116.15687-1-thomas.hellstrom@linux.intel.com>
References: <20260428073116.15687-1-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Add an optional reclaim callback to struct dmem_cgroup_region. When
dmem.max is set below the current usage of a cgroup pool, the new limit
is applied immediately (so that concurrent allocations are throttled
while reclaim is in progress) and then the driver is asked to evict
memory to bring usage back below the limit.

Reclaim is attempted up to a bounded number of times. No error is
returned to userspace if usage remains above the limit after reclaim,
and a pending signal will abort the reclaim loop early. This matches
the behavior of memory.max in the memory cgroup controller.

Also honor O_NONBLOCK so that if that flag is set during the
max value write, no reclaim is initiated. The idea is to avoid
charging the reclaim cost to the writer of he max value.

v2:
- Write max before reclaim is attempted (Maarten)
- Let signals abort the reclaim without error (Maarten)
- If a new max value is written with the O_NONBLOCK flag,
  reclaim is not attempted (Maarten)
- Extract region from the pool parameter rather than
  passing it explicitly to set_resource_xxx().

Assisted-by: GitHub Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/linux/cgroup_dmem.h | 11 +++++
 kernel/cgroup/dmem.c        | 83 +++++++++++++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index dd4869f1d736..61520a431740 100644
--- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -26,6 +26,10 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      bool ignore_low, bool *ret_hit_low);
 
 void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
+void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
+				    int (*reclaim)(struct dmem_cgroup_pool_state *pool,
+						   u64 target_bytes, void *priv),
+				    void *priv);
 #else
 static inline __printf(2,3) struct dmem_cgroup_region *
 dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
@@ -62,5 +66,12 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
 { }
 
+static inline void
+dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
+			       int (*reclaim)(struct dmem_cgroup_pool_state *pool,
+					      u64 target_bytes, void *priv),
+			       void *priv)
+{ }
+
 #endif
 #endif	/* _CGROUP_DMEM_H */
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 1ab1fb47f271..56e698e2d1c9 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -51,6 +51,18 @@ struct dmem_cgroup_region {
 	 * No new pools should be added to the region afterwards.
 	 */
 	bool unregistered;
+
+	/**
+	 * @reclaim: Optional callback invoked when dmem.max is set below the
+	 * current usage of a pool. The driver should attempt to free at least
+	 * @target_bytes from @pool. May be called multiple times if usage
+	 * remains above the limit after returning.
+	 */
+	int (*reclaim)(struct dmem_cgroup_pool_state *pool, u64 target_bytes,
+		       void *priv);
+
+	/** @reclaim_priv: Private data passed to @reclaim. */
+	void *reclaim_priv;
 };
 
 struct dmemcg_state {
@@ -145,21 +157,46 @@ static void free_cg_pool(struct dmem_cgroup_pool_state *pool)
 }
 
 static void
-set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
+set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val, bool nonblock)
 {
 	page_counter_set_min(&pool->cnt, val);
 }
 
 static void
-set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
+set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val, bool nonblock)
 {
 	page_counter_set_low(&pool->cnt, val);
 }
 
 static void
-set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
+set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val, bool nonblock)
 {
-	page_counter_set_max(&pool->cnt, val);
+	struct dmem_cgroup_region *region = pool->region;
+
+	/*
+	 * Always update the limit, even if usage currently exceeds it.
+	 * Concurrent allocations will be throttled against the new limit
+	 * while reclaim is in progress.
+	 */
+	xchg(&pool->cnt.max, (unsigned long)val);
+
+	if (nonblock || !region->reclaim)
+		return;
+
+	for (int retries = 5; retries > 0; retries--) {
+		u64 usage = page_counter_read(&pool->cnt);
+
+		if (usage <= val)
+			break;
+
+		if (signal_pending(current))
+			break;
+
+		if (region->reclaim(pool, usage - val, region->reclaim_priv))
+			break;
+
+		cond_resched();
+	}
 }
 
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
@@ -184,9 +221,9 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
 
 static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
-	set_resource_min(rpool, 0);
-	set_resource_low(rpool, 0);
-	set_resource_max(rpool, PAGE_COUNTER_MAX);
+	set_resource_min(rpool, 0, false);
+	set_resource_low(rpool, 0, false);
+	set_resource_max(rpool, PAGE_COUNTER_MAX, false);
 }
 
 static void dmemcs_offline(struct cgroup_subsys_state *css)
@@ -568,6 +605,32 @@ void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_pool_state_put);
 
+/**
+ * dmem_cgroup_region_set_reclaim - Register a reclaim callback on a region.
+ * @region: The region to register the callback for.
+ * @reclaim: Callback to invoke when dmem.max is set below current usage.
+ *           Called with the pool that needs reclaiming and the number of
+ *           bytes to free. Returns 0 on progress, negative on failure.
+ * @priv: Opaque pointer passed back to @reclaim.
+ *
+ * When dmem.max is lowered below the current usage of a cgroup pool, the
+ * dmem controller will call @reclaim with a target number of bytes to free.
+ * After @reclaim returns the controller retries setting the limit; if usage
+ * is still too high it calls @reclaim again, up to a bounded retry count.
+ */
+void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
+				    int (*reclaim)(struct dmem_cgroup_pool_state *pool,
+						   u64 target_bytes, void *priv),
+				    void *priv)
+{
+	if (!region)
+		return;
+
+	region->reclaim = reclaim;
+	region->reclaim_priv = priv;
+}
+EXPORT_SYMBOL_GPL(dmem_cgroup_region_set_reclaim);
+
 static struct dmem_cgroup_pool_state *
 get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
 {
@@ -725,9 +788,10 @@ static int dmemcg_parse_limit(char *options, u64 *new_limit)
 
 static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off,
-				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
+				 void (*apply)(struct dmem_cgroup_pool_state *, u64, bool))
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
+	bool nonblock = of->file->f_flags & O_NONBLOCK;
 	int err = 0;
 
 	while (buf && !err) {
@@ -772,7 +836,8 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 		}
 
 		/* And commit */
-		apply(pool, new_limit);
+		apply(pool, new_limit, nonblock);
+
 		dmemcg_pool_put(pool);
 
 out_put:
-- 
2.53.0

